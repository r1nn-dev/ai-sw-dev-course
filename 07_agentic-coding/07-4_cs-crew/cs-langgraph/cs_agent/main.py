from cs_agent.agent import graph


def plot():
    """터미널에 ASCII 그래프를 출력하고, PNG 이미지를 graph.png로 저장한다."""
    print("\n[그래프 구조 - ASCII]\n")
    graph.get_graph().print_ascii()

    output_path = "graph.png"
    png_bytes = graph.get_graph().draw_mermaid_png()
    with open(output_path, "wb") as f:
        f.write(png_bytes)
    print(f"\n[그래프 이미지 저장 완료] → {output_path}\n")


def chat():
    print("=" * 60)
    print("CS 상담 챗봇을 시작합니다. (LangGraph)")
    print("종료하려면 '종료' 또는 'q'를 입력하세요.")
    print("=" * 60 + "\n")

    NODE_LABELS = {
        "receptionist":     "접수 담당자",
        "tech_support":     "기술 지원",
        "finalize_general": "일반 문의 처리",
    }
    # 각 노드가 읽는 state 키
    NODE_INPUTS = {
        "receptionist":     ["user_message"],
        "tech_support":     ["user_message"],
        "finalize_general": ["reception_result"],
    }

    def _truncate(text: str, limit: int = 60) -> str:
        return text if len(text) <= limit else text[:limit] + "..."

    while True:
        user_message = input("고객: ").strip()

        if not user_message:
            continue

        if user_message in ("종료", "q", "quit", "exit"):
            print("상담을 종료합니다.")
            break

        state: dict = {"user_message": user_message}
        final_response = ""

        for chunk in graph.stream({"user_message": user_message}, stream_mode="updates"):
            for node_name, updates in chunk.items():
                label = NODE_LABELS.get(node_name, node_name)
                input_keys = NODE_INPUTS.get(node_name, [])

                print(f"\n  ┌─ [{label}]")
                for key in input_keys:
                    print(f"  │  입력 {key}: {_truncate(state.get(key, ''))}")
                for key, val in updates.items():
                    print(f"  │  출력 {key}: {_truncate(val)}")
                print(f"  └─ 완료")

                state.update(updates)
                if "response" in updates:
                    final_response = updates["response"]

        print(f"\n상담원: {final_response}\n")
        print("-" * 60)


if __name__ == "__main__":
    chat()
