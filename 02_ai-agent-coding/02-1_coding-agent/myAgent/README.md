# 02-exam

uv를 사용하여 생성된 프로젝트입니다.

## 에디터 가상환경(Interpreter) 설정 가이드 (VS Code 기준)

uv로 관리되는 프로젝트는 기본적으로 `.venv` 폴더에 파이썬 가상환경이 생성됩니다. 에디터가 올바른 파이썬 가상환경을 인식하게 하려면 다음 단계를 따라주세요.

### 1. 가상환경 생성 확인
프로젝트 루트에서 패키지를 설치하거나 명시적으로 가상환경을 만들면 `.venv` 폴더가 생성됩니다.
```bash
uv venv
```

### 2. 인터프리터 선택 (Command Palette)
1. **VS Code 실행 후** `Ctrl + Shift + P` (Windows/Linux) 또는 `Cmd + Shift + P` (macOS)를 눌러서 커맨드 팔레트를 엽니다.
2. **`Python: Select Interpreter`**를 검색하고 클릭합니다.

### 3. 가상환경 경로 지정
- 목록에서 프로젝트 내의 `('.venv': uv)` 가상환경을 찾아 선택합니다.
- 만약 자동으로 목록에 나타나지 않는다면 `Enter interpreter path...` -> `Find...` 를 클릭한 뒤, 다음 경로의 파이썬 실행 파일을 직접 선택해 주세요.
  - **Windows:** `.venv\Scripts\python.exe`
  - **macOS/Linux:** `.venv/bin/python`

설정이 완료되면 에디터에서 해당 가상환경을 기반으로 자동 완성 및 코드 분석이 활성화됩니다.
