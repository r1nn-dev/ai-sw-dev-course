import ollama
import json
import tools

# System Prompt 정의
SYSTEM_PROMPT = """
당신은 나무위키 검색 및 로컬 파일 관리 권한을 가진 유능한 AI 어시스턴트입니다.
사용자의 요청을 해결하기 위해 필요한 경우 아래 도구들을 호출할 수 있습니다.

[사용 가능한 도구]
1. search_namuwiki(keyword): 나무위키에서 해당 키워드를 검색하여 본문 일부(500자)를 가져옵니다.
2. read_file(path): 지정된 경로의 텍스트 파일을 읽어옵니다.
3. write_file(path, content): 지정된 경로에 새로운 파일(또는 덮어쓰기)을 생성하고 내용을 씁니다.
4. edit_file(path, old_text, new_text): 파일 내의 old_text를 new_text로 수정합니다.
5. delete_file(path): 지정된 경로의 파일을 삭제합니다.

[호출 형식]
도구가 필요할 때 반드시 아래의 JSON 형식 한 줄로만 응답하세요. 다른 설명은 덧붙이지 마십시오.
[TOOL_CALL] {"tool": "도구이름", "args": {"인자명": "값"}}

예시:
[TOOL_CALL] {"tool": "search_namuwiki", "args": {"keyword": "파이썬"}}

[결과 처리]
도구 호출 후에는 시스템이 실행 결과를 제공합니다.
중요 사항:
1. 사용자의 요청이 여러 단계(예: "검색해서 파일로 저장해")를 포함한다면, 모든 단계가 끝날 때까지 멈추지 말고 필요한 도구를 계속 호출하십시오.
2. 모든 결과 파일은 `results/` 폴더 내에 저장 및 관리됩니다. 파일명만 입력하면 자동으로 해당 폴더에 저장됩니다.
3. 결과 내용 앞에 붙는 태그나 안내 문구는 무시하고, 실제 데이터 내용만 활용하십시오.
4. 최종 답변이나 파일 저장 시에는 절대로 [TOOL_CALL] 이나 [TOOL_RESULT] 같은 태그를 포함하지 마세요.
"""

def execute_tool(tool_name, args):
    """tools.py의 실제 함수와 프롬프트상의 도구 이름을 매핑하여 실행합니다."""
    try:
        if tool_name == "search_namuwiki":
            return tools.search_namu(args.get("keyword"))
        elif tool_name == "read_file":
            return tools.read_file(args.get("path"))
        elif tool_name == "write_file":
            return tools.write_file(args.get("path"), args.get("content"))
        elif tool_name == "edit_file":
            # tools.py의 modify_file(filepath, old_content, new_content) 매핑
            return tools.modify_file(
                args.get("path"), 
                args.get("old_text"), 
                args.get("new_text")
            )
        elif tool_name == "delete_file":
            return tools.delete_file(args.get("path"))
        else:
            return f"에러: 알 수 없는 도구 '{tool_name}'"
    except Exception as e:
        return f"도구 실행 중 예외 발생: {e}"

def main():
    model = "qwen2.5-coder:7b"
    # 시작 시 시스템 프롬프트 주입
    messages = [{"role": "system", "content": SYSTEM_PROMPT}]
    
    print(f"=== Ollama Tool Agent ({model}) ===")
    print("종료하려면 'exit'를 입력하세요.\n")
    
    while True:
        try:
            user_input = input("You: ")
            
            if user_input.strip().lower() == "exit":
                print("에이전트를 종료합니다.")
                break
                
            if not user_input.strip():
                continue
                
            messages.append({"role": "user", "content": user_input})
            
            # 도구 호출이 끝날 때까지 반복하는 루프
            while True:
                # 도구 호출 파싱을 위해 스트리밍 없이 응답을 받습니다.
                response = ollama.chat(model=model, messages=messages)
                assistant_response = response['message']['content']
                
                # 도구 호출 감지
                if "[TOOL_CALL]" in assistant_response:
                    try:
                        # [TOOL_CALL] 이후의 JSON 부분 추출
                        json_part = assistant_response.split("[TOOL_CALL]")[1].strip()
                        tool_call = json.loads(json_part)
                        
                        tool_name = tool_call.get("tool")
                        args = tool_call.get("args", {})
                        
                        print(f"\n🛠️  [도구 호출] {tool_name}({args})")
                        
                        # 도구 실행
                        result = execute_tool(tool_name, args)
                        
                        # 결과 출력 (너무 길면 생략)
                        display_result = (result[:150] + '...') if len(result) > 150 else result
                        print(f"📥 [도구 결과] {display_result}\n")
                        
                        # 히스토리에 도구 호출과 결과를 추가하여 다시 LLM에게 전달
                        messages.append({"role": "assistant", "content": assistant_response})
                        messages.append({
                            "role": "user", 
                            "content": f"SYSTEM: 도구 실행이 완료되었습니다. 아래는 실행 데이터입니다. 사용자의 원래 요청 중 아직 수행하지 않은 단계(예: 파일 저장 등)가 있다면 계속 진행하세요. 남은 작업이 없다면 최종 답변을 하세요.\n\n데이터: {result}"
                        })
                        
                        # 루프를 돌며 다음 단계를 LLM에게 물어봄
                        continue
                        
                    except (json.JSONDecodeError, IndexError) as e:
                        error_msg = f"도구 호출 형식이 잘못되었습니다: {e}"
                        print(f"❌ {error_msg}")
                        messages.append({"role": "user", "content": f"[TOOL_RESULT] {error_msg}"})
                        continue
                
                else:
                    # 도구 호출이 없는 최종 응답인 경우
                    print(f"AI: {assistant_response}\n")
                    messages.append({"role": "assistant", "content": assistant_response})
                    break
                    
        except KeyboardInterrupt:
            print("\n중단되었습니다.")
            break
        except Exception as e:
            print(f"\n시스템 오류 발생: {e}\n")

if __name__ == "__main__":
    main()
