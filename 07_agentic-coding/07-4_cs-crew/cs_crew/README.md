# CS Crew

CrewAI 기반 CS(고객 상담) 자동화 프로젝트입니다.
고객 문의를 접수·분류하고, 기술 문제는 전문 에이전트가 처리하는 멀티 에이전트 시스템입니다.

## 설치

Python 3.10 이상 3.14 미만이 필요합니다. 패키지 관리는 [UV](https://docs.astral.sh/uv/)를 사용합니다.

uv가 없다면 먼저 설치합니다:

```bash
pip install uv
```

프로젝트 디렉토리에서 의존성을 설치합니다:

```bash
crewai install
```

## 설정

`.env` 파일에 필요한 환경 변수를 설정합니다.

| 파일 | 역할 |
|------|------|
| `src/cs_crew/crews/content_crew/config/agents.yaml` | 에이전트 역할·목표·배경 정의 |
| `src/cs_crew/crews/content_crew/config/tasks.yaml` | 태스크 지시·기대 결과 정의 |
| `src/cs_crew/crews/content_crew/content_crew.py` | YAML과 Python 객체 매핑 |
| `src/cs_crew/main.py` | Flow 및 챗 루프 제어 |

## 실행

```bash
crewai run
```

실행하면 챗 방식으로 고객 상담을 시작합니다. `종료` 또는 `q`를 입력하면 종료됩니다.

## 에이전트 구성

| 에이전트 | 역할 |
|----------|------|
| `cs_receptionist` | 고객 문의 접수 및 유형 분류 (일반 불만 직접 처리 / 기술 문제 라우팅) |
| `tech_support` | 소프트웨어·하드웨어·네트워크 등 기술 문의 전담 처리 |

## 처리 흐름

```
고객 입력
    ↓
cs_receptionist (접수·분류)
    ├─ 일반 문의 → 직접 답변
    └─ 기술 문제 → [기술지원필요] 태그
                        ↓
                  tech_support (기술 답변)
```

## 참고 자료

- [CrewAI 공식 문서](https://docs.crewai.com)
- [GitHub 저장소](https://github.com/joaomdmoura/crewai)
- [Discord 커뮤니티](https://discord.com/invite/X4JWnZnxPb)
