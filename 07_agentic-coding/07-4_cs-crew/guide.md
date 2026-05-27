# Guide

## VS Code 확장 설치

### Jupyter

Jupyter 노트북을 VS Code에서 실행하기 위한 공식 확장입니다.

**방법 1 — VS Code에서 직접 설치**

1. VS Code 실행
2. 확장(Extensions) 탭 열기 (`Ctrl+Shift+X` / `Cmd+Shift+X`)
3. `ms-toolsai.jupyter` 검색 후 설치

**방법 2 — 명령어로 설치**

```bash
code --install-extension ms-toolsai.jupyter
```

> 마켓플레이스: https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter

---

## UV 설치

[uv](https://github.com/astral-sh/uv)는 Rust로 작성된 초고속 Python 패키지 매니저입니다.

### macOS / Linux

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

또는 wget 사용:

```bash
wget -qO- https://astral.sh/uv/install.sh | sh
```

### Windows (PowerShell)

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### pip / pipx로 설치

```bash
pip install uv
# 또는
pipx install uv
```

### 설치 확인

```bash
uv --version
```

---

## UV 필수 명령어

### 프로젝트 관리

| 명령어 | 설명 |
|--------|------|
| `uv init <프로젝트명>` | 새 프로젝트 초기화 |
| `uv add <패키지>` | 패키지 추가 (의존성 등록 + 설치) |
| `uv remove <패키지>` | 패키지 제거 |
| `uv sync` | lockfile 기준으로 환경 동기화 |
| `uv lock` | lockfile 갱신 |
| `uv run <명령어>` | 프로젝트 환경 안에서 명령 실행 |

```bash
uv init my-project
cd my-project

uv add requests
uv remove requests

uv sync
uv run python main.py
```

### 가상환경 (venv)

| 명령어 | 설명 |
|--------|------|
| `uv venv` | 현재 디렉토리에 `.venv` 생성 |
| `uv venv --python 3.12` | 특정 Python 버전으로 venv 생성 |

```bash
uv venv
source .venv/bin/activate   # macOS/Linux
.venv\Scripts\activate      # Windows
```

### Python 버전 관리

| 명령어 | 설명 |
|--------|------|
| `uv python list` | 설치 가능한 Python 버전 목록 |
| `uv python install 3.12` | 특정 Python 버전 설치 |

```bash
uv python install 3.12 3.13
uv python list
```

### CLI 도구 설치 (tool)

`uv tool`은 CLI 도구를 격리된 환경에 설치해 전역 명령어로 쓸 수 있게 합니다. `pipx`와 동일한 역할입니다.

| 명령어 | 설명 |
|--------|------|
| `uv tool install <패키지>` | CLI 도구 전역 설치 |
| `uv tool list` | 설치된 도구 목록 |
| `uv tool uninstall <패키지>` | 도구 제거 |

#### CrewAI 설치

```bash
uv tool install crewai-cli
```

> 공식 문서는 `uv tool install crewai`라고 안내하지만, 실제로는 CLI 실행 파일이 `crewai-cli` 패키지에 있으므로 위 명령어를 사용해야 합니다.

설치 확인:

```bash
crewai --version
uv tool list
```

---

### 패키지 관리 (pip 호환)

| 명령어 | 설명 |
|--------|------|
| `uv pip install <패키지>` | 패키지 설치 |
| `uv pip uninstall <패키지>` | 패키지 제거 |
| `uv pip list` | 설치된 패키지 목록 |
| `uv pip freeze` | 설치된 패키지를 requirements 형식으로 출력 |
| `uv pip install -r requirements.txt` | requirements.txt로 일괄 설치 |

```bash
uv pip install flask
uv pip install -r requirements.txt
uv pip list
```
