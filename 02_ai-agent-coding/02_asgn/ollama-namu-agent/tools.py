import os
import requests
from bs4 import BeautifulSoup

RESULTS_DIR = "results"
os.makedirs(RESULTS_DIR, exist_ok=True)

def get_safe_path(filepath: str) -> str:
    """경로가 지정되지 않은 파일명만 올 경우 자동으로 results 폴더 내 경로로 매핑합니다."""
    # 이미 results/ 로 시작하거나 절대경로인 경우는 제외 (간대히 체크)
    if not filepath.startswith(RESULTS_DIR + os.sep) and not filepath.startswith(RESULTS_DIR + "/"):
        # 파일명만 추출하여 results 폴더와 결합
        return os.path.join(RESULTS_DIR, os.path.basename(filepath))
    return filepath

def read_file(filepath: str) -> str:
    """지정된 경로의 파일을 읽어서 내용을 반환합니다. (기본 results 폴더)"""
    try:
        path = get_safe_path(filepath)
        with open(path, 'r', encoding='utf-8') as f:
            return f.read()
    except Exception as e:
        return f"파일 읽기 에러 (경로: {filepath}): {e}"

def write_file(filepath: str, content: str) -> str:
    """지정된 경로에 파일을 새로 생성하거나 완전히 덮어씁니다. (기본 results 폴더)"""
    try:
        path = get_safe_path(filepath)
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        return f"성공적으로 {path} 파일을 작성했습니다."
    except Exception as e:
        return f"파일 쓰기 에러 (경로: {filepath}): {e}"

def modify_file(filepath: str, old_content: str, new_content: str) -> str:
    """기존 내용 중 old_content를 new_content로 변경하여 수정합니다. (기본 results 폴더)"""
    try:
        path = get_safe_path(filepath)
        if not os.path.exists(path):
            return f"에러 발생: '{path}' 파일이 존재하지 않습니다."
            
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        if old_content and old_content not in content:
            return f"에러 발생: 바꾸려는 대상 내용(old_content)을 파일 내에서 찾을 수 없습니다."
            
        updated_content = content.replace(old_content, new_content)
        
        with open(path, 'w', encoding='utf-8') as f:
            f.write(updated_content)
            
        return f"성공적으로 {path} 파일의 내용을 수정했습니다."
    except Exception as e:
        return f"파일 수정 에러 (경로: {filepath}): {e}"

def delete_file(filepath: str) -> str:
    """지정된 경로의 파일을 삭제합니다. (기본 results 폴더)"""
    try:
        path = get_safe_path(filepath)
        if os.path.exists(path):
            os.remove(path)
            return f"성공적으로 {path} 파일을 삭제했습니다."
        else:
            return f"에러 발생: '{path}' 파일이 존재하지 않아 삭제할 수 없습니다."
    except Exception as e:
        return f"파일 삭제 에러 (경로: {filepath}): {e}"

def search_namu(keyword: str) -> str:

    """나무위키에서 키워드를 검색하여 본문 텍스트의 앞 500자를 반환합니다."""
    try:
        url = f"https://namu.wiki/w/{keyword}"
        # 더 실제 브라우저와 유사한 헤더 사용
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
            "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
            "Referer": "https://www.google.com/"
        }
        
        response = requests.get(url, headers=headers, timeout=10)
        
        if response.status_code == 404:
            return f"에러: '{keyword}'에 대한 검색 결과가 없습니다."
        
        response.raise_for_status()
        
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # 불필요한 요소 제거
        for element in soup(["script", "style", "nav", "footer", "header"]):
            element.decompose()

        # 나무위키의 실제 본문은 보통 'article' 태그나 특정 클래스 내부에 있습니다.
        content_area = soup.find('article')
        if not content_area:
            content_area = soup.find('div', class_='v-22-1') # 예비용
            
        if content_area:
            text = content_area.get_text(separator=' ', strip=True)
        else:
            text = soup.get_text(separator=' ', strip=True)
        
        # 앞 500자만 반환
        return text[:500]
        
    except requests.exceptions.RequestException as e:
        return f"네트워크 에러: {e}"
    except Exception as e:
        return f"검색 에러: {e}"


