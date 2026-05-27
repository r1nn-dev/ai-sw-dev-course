#!/usr/bin/env python
from pydantic import BaseModel

from crewai.flow import Flow, listen, start

from cs_crew.crews.content_crew.content_crew import ContentCrew


class CSState(BaseModel):
    user_message: str = ""  # 고객이 입력한 메시지
    response: str = ""      # 최종 답변


class CSFlow(Flow[CSState]):

    @start()
    def receive_message(self):
        print(f"\n[접수] 고객 메시지: {self.state.user_message}")

    @listen(receive_message)
    def process_message(self):
        # 크루에 고객 메시지를 전달하고 결과를 받음
        result = (
            ContentCrew()
            .crew()
            .kickoff(inputs={"user_message": self.state.user_message})
        )

        reception_output = result.tasks_output[0].raw
        tech_support_output = result.tasks_output[1].raw

        # [기술지원필요]가 없으면 접수 담당자 답변, 있으면 기술지원 답변 사용
        if "[기술지원필요]" not in reception_output:
            self.state.response = reception_output
        elif tech_support_output.strip() != "SKIP":
            self.state.response = tech_support_output
        else:
            self.state.response = reception_output

    @listen(process_message)
    def display_response(self):
        print(f"\n상담원: {self.state.response}\n")
        print("-" * 60)


def chat():
    print("=" * 60)
    print("CS 상담 챗봇을 시작합니다.")
    print("종료하려면 '종료' 또는 'q'를 입력하세요.")
    print("=" * 60 + "\n")

    while True:
        user_message = input("고객: ").strip()

        if not user_message:
            continue

        if user_message in ("종료", "q", "quit", "exit"):
            print("상담을 종료합니다.")
            break

        flow = CSFlow()
        flow.state.user_message = user_message
        flow.kickoff()


def kickoff():
    chat()


def plot():
    flow = CSFlow()
    flow.plot()


if __name__ == "__main__":
    chat()
