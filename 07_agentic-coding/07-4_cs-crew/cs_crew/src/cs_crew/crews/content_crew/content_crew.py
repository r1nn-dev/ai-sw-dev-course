from crewai import Agent, Crew, Process, Task
from crewai.agents.agent_builder.base_agent import BaseAgent
from crewai.project import CrewBase, agent, crew, task


@CrewBase
class ContentCrew:
    """CS 상담 크루"""

    agents: list[BaseAgent]
    tasks: list[Task]

    agents_config = "config/agents.yaml"
    tasks_config = "config/tasks.yaml"

    @agent
    def cs_receptionist(self) -> Agent:
        # 고객 문의를 접수하고 유형을 분류하는 에이전트
        return Agent(
            config=self.agents_config["cs_receptionist"],  # type: ignore[index]
        )

    @agent
    def tech_support(self) -> Agent:
        # 기술적 문제를 전담하는 에이전트
        return Agent(
            config=self.agents_config["tech_support"],  # type: ignore[index]
        )

    @task
    def reception_task(self) -> Task:
        # 고객 메시지 접수 및 분류 태스크
        return Task(
            config=self.tasks_config["reception_task"],  # type: ignore[index]
        )

    @task
    def tech_support_task(self) -> Task:
        # 기술 문의 처리 태스크 (reception_task 결과를 이어받음)
        return Task(
            config=self.tasks_config["tech_support_task"],  # type: ignore[index]
        )

    @crew
    def crew(self) -> Crew:
        """CS 상담 크루 생성"""
        return Crew(
            agents=self.agents,
            tasks=self.tasks,
            process=Process.sequential,  # 접수 → 기술지원 순서로 실행
            verbose=True,
        )
