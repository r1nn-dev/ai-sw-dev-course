# LLM Prompting Techniques 
- 개요
  - LLM의 작동 원리와 프롬프팅 기법 실습.
  - 다양한 프롬프트 기법(Zero-shot, Few-shot, Chain-of-Thought 등)을 실제 AI 모델에 적용하고, 그 결과를 비교 분석한다.

# 실습 1: 프롬프팅 기법 비교
문제:
```
Python으로 사용자 입력을 받아 해당 숫자가 소수(Prime Number)인지 판별하고, 
1부터 해당 숫자까지의 모든 소수를 리스트로 출력하는 프로그램을 작성하세요.
```
적용할 프롬프팅 기법:
1. Zero-shot Prompting: 아무런 예시 없이 위 문제를 그대로 전달
2. Few-shot Prompting: 유사한 코드 예시를 1~2개 포함하여 전달
3. Chain-of-Thought Prompting: 
    - "단계별로 생각해보자"
    - 풀이 과정
## 결과? 풀이? 
### Zero-shot Prompting 
### Few-shot Prompting 
### Chain-of-Thought Prompting 

   
# 실습 2: System Prompt 설계
문제:
'''
- 시나리오 A: "Python 코드 리뷰 전문가" - 코드의 버그, 성능 개선점, 가독성을 분석하는 AI
- 시나리오 B: "REST API 설계 컨설턴트" - API 엔드포인트 설계를 도와주는 AI
- 시나리오 C: 자유 주제 (본인이 필요한 AI 페르소나 설정)
'''
## 분석
System Prompt 전문 (최소 5줄 이상)
```

```
User Prompt 3개
```

```
System Prompt 없이 동일한 질문을 했을 때와의 결과 차이를 비교 분석

# 실습 3: Best Practices 적용
나쁜 프롬프트 예시:
```
"쇼핑몰 만들어줘"
```
## 분석
위 프롬프트의 문제점
- 
-
-
Best Practices를 적용한 구조화된 프롬프트
```

```
결과 비교
