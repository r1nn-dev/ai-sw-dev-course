# ollama-namu-agent

이 프로젝트는 `uv`를 사용하여 생성되었습니다.

## 가상환경 설정 및 에디터에서 선택하는 방법 (VS Code 기준)

`uv`가 생성한 `.venv` 가상환경을 에디터에서 인식하고 사용하도록 설정해야 합니다.

1. **에디터 열기**: VS Code에서 `ollama-namu-agent` 폴더를 엽니다.
2. **명령 팔레트 열기**: `Ctrl + Shift + P` (Mac: `Cmd + Shift + P`)를 눌러 명령 팔레트를 실행합니다.
3. **인터프리터 선택**: `Python: Select Interpreter`를 검색하고 선택합니다.
4. **가상환경 경로 지정**: 
   - 목록에 `./.venv` (또는 `.venv`)가 보이면 선택합니다.
   - 만약 보이지 않는다면 `Enter interpreter path...` (인터프리터 경로 입력...)를 클릭한 후 `Find...` (찾기...) 메뉴를 선택합니다.
   - 프로젝트 안의 `.venv/Scripts/python.exe` (Mac/Linux는 `.venv/bin/python`) 파일을 찾아 선택합니다.
5. **터미널 재시작**: VS Code 터미널(`Ctrl + \``)을 새로 열어 `(.venv)`가 프롬프트 앞에 표시되는지 확인합니다.

이제 `main.py`나 `tools.py`에서 코드를 작성할 때 가상환경에 설치된 패키지를 정상적으로 인식합니다.
