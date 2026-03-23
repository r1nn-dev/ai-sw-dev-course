# LLM
- LLM 모델은 AI Agent의 핵심 엔진.
- 주어진 문맥(Context)을 바탕으로 다음 단어(토큰, Token)를 예측하는 확률 모델
  - `P(token | 질문)`
  - `P(token | 이전 문맥)`

## 1. LLM의 학습 단계
1. Self-supervised Pretraining (자기지도 사전학습)
   - 텍스트 자체에서 다음 토큰을 정답으로 삼아 스스로 학습하는 Self-supervised 방식
   - 정답과 예측의 오차(Loss)를 측정한 뒤, 가중치(weight) 조정하고 바로 다음 예측으로 넘어간다.
   - 방대한 데이터를 통해 이 과정을 반복하며 언어, 지식, 코드 패턴 등을 학습한다.
2. Supervised Fine-tuning (지도 파인튜닝)
   - 질문-답변 쌍으로 구성된 레이블(Label) 데이터를 통해 응답 방식을 추가로 학습시킨다.
3. Preference Tuning / Alignment (선호도 조정 / 정렬)
   - 동일한 질문에 대해 여러 답변을 생성한 뒤, 사람이 선호도를 평가하여 데이터를 구축한다.
4. Reasoning Models (추론 모델)

## 2. LLM Prompting - 프롬프트 기법
- Zero-shot prompting
  - 아무런 정보를 주지 않는 프롬프트 기법
  - 모델이 사전학습된 지식만으로 답변을 생성한다.
- K-shot(few-shot) prompting
  - K개의 예제(입력-출력 쌍)를 함께 제공하여 답변 형식과 방향을 안내하는 방식
  - 예제가 많을수록 모델이 의도를 더 정확히 파악한다.
- Chain-of-Thought (CoT) Prompting (사고 사슬 프롬프팅)
  - 답변만 요구하는 것이 아니라, 추론 단계를 명시적으로 거치도록 유도하는 기법
  - 여러 논리 단계를 거쳐야 하는 문제에 특히 효과적이다.
  - 모델이 중간 추론 과정을 명시하게 되므로, 오류 발생 위치를 파악하기도 쉬워진다.
  ```
  # Zero-shot CoT 예시
  "단계별로 생각해보자 (Let's think step-by-step)"
  ```
- Self-consistency Prompting (자기 일관성 프롬프팅)
  - LLM이 동일한 질문에 대해 여러 번 독립적으로 추론(Reasoning)을 수행하게 한 뒤, 가장 많이 등장한 답변을 최종 답으로 선택하는 방식

## 3. Best Practices
- 명확하게 작성해야 한다.
- 페르소나(Persona)를 사용한다.
- 요구사항을 구체적으로 작성한다.
- 작업을 단계별로 나눈다.
