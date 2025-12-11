from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

app = FastAPI(
    title="EasyFin V2.0 API (Mock)",
    description="자산 통합 & 라이브 금융 콘텐츠 서비스 MVP용 Mock API",
    version="0.1.0",
)

# CORS 허용 (로컬에서 index.html 띄울 때 편하게)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# -----------------------------
# 데이터 모델
# -----------------------------

class LoginRequest(BaseModel):
    email: str
    password: str

class LoginResponse(BaseModel):
    user_id: int
    nickname: str

class AssetSummary(BaseModel):
    total_amount: int
    currency: str
    breakdown: dict  # 예: {"예금": 30000000, "주식": 20000000}

class Account(BaseModel):
    id: int
    type: str
    name: str
    balance: int
    institution: str

class MarketItem(BaseModel):
    id: int
    category: str  # 공모주, ETF, 채권, 리츠
    name: str
    code: str
    description: str
    risk_level: str
    expected_yield: Optional[float] = None

class LiveStream(BaseModel):
    id: int
    title: str
    status: str   # ongoing, upcoming, replay
    host: str
    start_time: datetime

class CommunityPost(BaseModel):
    id: int
    author: str
    category: str
    title: str
    content: str
    created_at: datetime

class NewPost(BaseModel):
    author: str
    category: str
    title: str
    content: str

class Profile(BaseModel):
    user_id: int
    nickname: str
    email: str
    following_experts: List[str]
    linked_institutions: List[str]

# -----------------------------
# Mock 데이터
# -----------------------------

MOCK_USER = {
    "email": "demo@easyfin.app",
    "password": "1234",
    "user_id": 1,
    "nickname": "지현"
}

MOCK_ASSET_SUMMARY = AssetSummary(
    total_amount=85000000,
    currency="KRW",
    breakdown={
        "예금": 30000000,
        "주식": 25000000,
        "ETF": 15000000,
        "채권": 10000000,
        "현금": 5000000,
    }
)

MOCK_ACCOUNTS = [
    Account(id=1, type="예금", name="급여통장", balance=12000000, institution="KB국민은행"),
    Account(id=2, type="주식", name="국내주식", balance=18000000, institution="토스증권"),
    Account(id=3, type="ETF", name="S&P500 ETF", balance=15000000, institution="미래에셋증권"),
    Account(id=4, type="채권", name="국채 3년", balance=10000000, institution="NH투자증권"),
]

MOCK_MARKET_ITEMS = [
    MarketItem(
        id=1, category="공모주", name="에임드바이오",
        code="0009K", description="ADC 기반 항암제 바이오 기업", 
        risk_level="높음", expected_yield=12.5
    ),
    MarketItem(
        id=2, category="ETF", name="KODEX 미국S&P500",
        code="069500", description="미국 S&P500 지수를 추종하는 ETF",
        risk_level="중간", expected_yield=6.2
    ),
    MarketItem(
        id=3, category="채권", name="국채 3년",
        code="KR3Y", description="안정적인 국내 만기 3년 국채",
        risk_level="낮음", expected_yield=3.1
    ),
    MarketItem(
        id=4, category="리츠", name="○○ 리츠",
        code="REIT01", description="오피스/상가 중심 리츠 상품",
        risk_level="중간", expected_yield=5.0
    ),
]

MOCK_LIVE = [
    LiveStream(
        id=1,
        title="오늘의 공모주 브리핑",
        status="ongoing",
        host="김공모",
        start_time=datetime(2025, 12, 8, 19, 0)
    ),
    LiveStream(
        id=2,
        title="초보자를 위한 ETF 입문",
        status="upcoming",
        host="이ETF",
        start_time=datetime(2025, 12, 9, 20, 0)
    ),
    LiveStream(
        id=3,
        title="미국 S&P500 전략 다시보기",
        status="replay",
        host="박인덱스",
        start_time=datetime(2025, 12, 1, 20, 0)
    ),
]

MOCK_POSTS: List[CommunityPost] = [
    CommunityPost(
        id=1,
        author="지현",
        category="공모주",
        title="이번 주 공모주 어떻게 보세요?",
        content="에임드바이오 청약 고민 중입니다. 의견 부탁드려요.",
        created_at=datetime(2025, 12, 8, 10, 0)
    ),
    CommunityPost(
        id=2,
        author="인덱스러버",
        category="ETF",
        title="S&P500 장기투자 전략 공유",
        content="3년 이상 들고 가면서 분할매수 하는 전략입니다.",
        created_at=datetime(2025, 12, 7, 22, 30)
    ),
]

# -----------------------------
# 엔드포인트
# -----------------------------

@app.post("/auth/login", response_model=LoginResponse)
def login(payload: LoginRequest):
    if payload.email == MOCK_USER["email"] and payload.password == MOCK_USER["password"]:
        return LoginResponse(user_id=MOCK_USER["user_id"], nickname=MOCK_USER["nickname"])
    raise HTTPException(status_code=401, detail="이메일 또는 비밀번호가 올바르지 않습니다.")

@app.get("/assets/summary", response_model=AssetSummary)
def get_asset_summary():
    return MOCK_ASSET_SUMMARY

@app.get("/assets/accounts", response_model=List[Account])
def get_accounts():
    return MOCK_ACCOUNTS

@app.get("/market/items", response_model=List[MarketItem])
def get_market_items(category: Optional[str] = None):
    if category:
        return [m for m in MOCK_MARKET_ITEMS if m.category == category]
    return MOCK_MARKET_ITEMS

@app.get("/live/streams", response_model=List[LiveStream])
def get_live_streams(status: Optional[str] = None):
    if status:
        return [l for l in MOCK_LIVE if l.status == status]
    return MOCK_LIVE

@app.get("/community/posts", response_model=List[CommunityPost])
def list_posts(category: Optional[str] = None):
    if category:
        return [p for p in MOCK_POSTS if p.category == category]
    return sorted(MOCK_POSTS, key=lambda p: p.created_at, reverse=True)

@app.post("/community/posts", response_model=CommunityPost)
def create_post(new_post: NewPost):
    new_id = max(p.id for p in MOCK_POSTS) + 1 if MOCK_POSTS else 1
    post = CommunityPost(
        id=new_id,
        author=new_post.author,
        category=new_post.category,
        title=new_post.title,
        content=new_post.content,
        created_at=datetime.utcnow()
    )
    MOCK_POSTS.append(post)
    return post

@app.get("/me/profile", response_model=Profile)
def get_profile():
    return Profile(
        user_id=MOCK_USER["user_id"],
        nickname=MOCK_USER["nickname"],
        email=MOCK_USER["email"],
        following_experts=["이ETF", "박인덱스"],
        linked_institutions=["KB국민은행", "토스증권", "미래에셋증권"]
    )
