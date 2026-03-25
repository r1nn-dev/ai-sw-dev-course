import ollama
import json
import os

HISTORY_FILE = "chat_history.json"

SYSTEM_PROMPT = """당신은 유용한 AI 어시스턴트이자 시스템 파일에 접근할 수 있는 강력한 에이전트입니다.
사용자의 요청(예: 파일 읽기, 쓰기, 수정, 목록 보기)을 해결해야 할 경우, 스스로 판단하여 아래 도구 중 하나를 선택하고 반드시 아래의 JSON 형식으로만 먼저 응답해야 합니다. "할 수 없습니다"와 같은 거절을 하지 말고 적극적으로 도구를 사용하세요.

[사용 가능한 도구]
1. read_file: 파일의 전체 내용을 읽어옵니다.
2. write_file: 파일에 새로운 내용을 씁니다. (기존 내용 덮어쓰기)
3. modify_file: 기존 파일 끝에 내용을 추가합니다.
4. list_files: 특정 디렉토리(폴더) 내의 파일 목록을 확인합니다.

도구를 사용할 필요가 있을 때는 반드시 아래 JSON 구조만 출력하세요:
{
  "action": "도구이름(read_file, write_file, modify_file, list_files 중 택1)",
  "filepath": "대상 파일이나 디렉토리의 절대/상대 경로",
  "content": "입력할 텍스트 (read_file이나 list_files인 경우 비워둠)"
}

당신이 위 형식의 JSON 응답을 반환하면, 시스템은 도구를 실행한 결과(Observation)를 당신에게 반환해 줄 것입니다.
충분한 정보를 얻었거나 도구를 사용할 필요가 없다면, JSON 형식을 제외한 '일반 텍스트'로 사용자에게 최종 답변을 제공하세요."""

# --- 도구(Tools) 함수 정의 ---
def read_file(filepath):
    try:
        if not os.path.exists(filepath):
            return f"오류: {filepath} 파일이 존재하지 않습니다."
        with open(filepath, 'r', encoding='utf-8') as f:
            return f.read()
    except Exception as e:
        return f"파일 읽기 오류: {e}"

def write_file(filepath, content):
    try:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return f"파일 {filepath} 에 성공적으로 내용을 작성했습니다."
    except Exception as e:
        return f"파일 쓰기 오류: {e}"

def modify_file(filepath, content):
    try:
        with open(filepath, 'a', encoding='utf-8') as f:
            f.write(content)
        return f"파일 {filepath} 끝에 성공적으로 내용을 추가(수정)했습니다."
    except Exception as e:
        return f"파일 수정 오류: {e}"

def list_files(directory):
    try:
        if not directory:
            directory = "."
        if not os.path.exists(directory):
            return f"오류: {directory} 경로가 존재하지 않습니다."
        if not os.path.isdir(directory):
            return f"오류: {directory}은(는) 디렉터리가 아닙니다."
        
        files = os.listdir(directory)
        return f"디렉터리 '{directory}'의 파일 목록:\n" + "\n".join(files)
    except Exception as e:
        return f"파일 목록 조회 오류: {e}"

def execute_tool(action_data):
    action = action_data.get("action")
    filepath = action_data.get("filepath", "")
    content = action_data.get("content", "")
    
    if action == "read_file":
        return read_file(filepath)
    elif action == "write_file":
        return write_file(filepath, content)
    elif action == "modify_file":
        return modify_file(filepath, content)
    elif action == "list_files":
        return list_files(filepath)
    else:
        return f"알 수 없는 도구 액션입니다: {action}"
# --- 도구 함수 끝 ---

def load_history():
    if os.path.exists(HISTORY_FILE):
        try:
            with open(HISTORY_FILE, 'r', encoding='utf-8') as f:
                return json.load(f)
        except Exception as e:
            print(f"[경고] 대화 기록을 불러오는 데 실패했습니다: {e}")
    return None

def save_history(messages):
    try:
        with open(HISTORY_FILE, 'w', encoding='utf-8') as f:
            json.dump(messages, f, ensure_ascii=False, indent=2)
    except Exception as e:
        print(f"\n[경고] 대화 기록을 저장하는 데 실패했습니다: {e}")

def main():
    print("Ollama Agent 터미널 채팅에 오신 것을 환영합니다! ('exit' 종료, 'clear' 초기화)")
    model_name = input("사용할 모델 이름을 입력해주세요 [기본값: llama3]: ").strip()
    if not model_name:
        model_name = "llama3"
        
    print(f"\n[{model_name}] 모델과 (Agent 모드) 채팅을 시작합니다.\n")
    
    messages = load_history()
    if messages:
        print("이전 대화 기록을 불러왔습니다.\n")
    else:
        messages = [{'role': 'system', 'content': SYSTEM_PROMPT}]
    
    while True:
        try:
            user_input = input("You: ").strip()
            if user_input.lower() in ['exit', 'quit']:
                print("채팅을 종료합니다.")
                break
                
            if user_input.lower() == 'clear':
                messages = [{'role': 'system', 'content': SYSTEM_PROMPT}]
                save_history(messages)
                print("대화 기록이 초기화되었습니다.\n")
                continue
                
            if not user_input:
                continue
                
            messages.append({'role': 'user', 'content': user_input})
            
            # --- Agent 대화 루프 ---
            while True:
                print("AI: ", end="", flush=True)
                stream = ollama.chat(
                    model=model_name,
                    messages=messages,
                    stream=True,
                )
                
                assistant_reply = ""
                for chunk in stream:
                    content = chunk['message']['content']
                    print(content, end="", flush=True)
                    assistant_reply += content
                print()
                
                messages.append({'role': 'assistant', 'content': assistant_reply})
                
                # 응답에서 JSON 파싱 시도하여 도구 호출인지 판단
                start_idx = assistant_reply.find('{')
                end_idx = assistant_reply.rfind('}')
                
                is_tool_called = False
                if start_idx != -1 and end_idx != -1 and start_idx < end_idx:
                    json_str = assistant_reply[start_idx:end_idx+1]
                    try:
                        action_data = json.loads(json_str)
                        if "action" in action_data and action_data["action"] in ["read_file", "write_file", "modify_file", "list_files"]:
                            is_tool_called = True
                            
                            filepath = action_data.get('filepath', '')
                            print(f"\n🛠️  [에이전트 실행 중] 도구 호출: {action_data['action']} -> {filepath}")
                            
                            # 파이썬 도구 함수 실제 실행
                            result = execute_tool(action_data)
                            print(f"📄 [결과 (Observation)]\n{str(result)[:100]}...\n")
                            
                            observation_msg = f"도구 실행 결과 (Observation):\n{result}\n이제 이것을 바탕으로 최종 답변을 제공하거나 필요한 경우 다른 도구를 추가로 호출하세요."
                            messages.append({'role': 'user', 'content': observation_msg})
                            
                            # 다시 AI 응답을 받기 위해 continue (루프 지속)
                    except json.JSONDecodeError:
                        pass
                
                # 도구를 호출하지 않았다면 최종 사용자-응답으로 간주하고 루프 탈출
                if not is_tool_called:
                    save_history(messages)
                    break
            
        except ollama.ResponseError as e:
            print(f"\n[Ollama 에러]: {e.error}")
            print(f"'{model_name}' 모델이 설치되어 있는지 확인해주세요. (예: ollama run {model_name})")
            if messages and messages[-1]['role'] == 'user':
                messages.pop()
                save_history(messages)
            break
        except KeyboardInterrupt:
            print("\n채팅을 종료합니다.")
            break
        except Exception as e:
            print(f"\n[오류 발생]: {e}")
            if messages and messages[-1]['role'] == 'user':
                messages.pop()
                save_history(messages)

if __name__ == "__main__":
    main()
