-- 1. stores (가게 정보)
CREATE TABLE IF NOT EXISTS stores (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    description TEXT,
    phone VARCHAR(20),
    address TEXT,
    latitude DECIMAL(10, 7),
    longitude DECIMAL(10, 7),
    business_hours VARCHAR(100),
    image_url TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 2. users (사용자)
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    name VARCHAR(50),
    provider VARCHAR(20) NOT NULL,
    provider_id VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(provider, provider_id)
);

-- 3. store_interactions (상호작용 기록)
CREATE TABLE IF NOT EXISTS store_interactions (
    id SERIAL PRIMARY KEY,
    store_id INTEGER NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
    interaction_type VARCHAR(20) NOT NULL CHECK (interaction_type IN ('view', 'like')),
    user_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    user_ip VARCHAR(45),
    created_at TIMESTAMP DEFAULT NOW()
);

-- 4. store_popularity (인기도 점수 캐시)
CREATE TABLE IF NOT EXISTS store_popularity (
    store_id INTEGER PRIMARY KEY REFERENCES stores(id) ON DELETE CASCADE,
    view_count INTEGER DEFAULT 0,
    like_count INTEGER DEFAULT 0,
    popularity_score DECIMAL(10, 2) DEFAULT 0,
    trending_score DECIMAL(10, 2) DEFAULT 0,
    updated_at TIMESTAMP DEFAULT NOW()
);

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_store_interactions_store ON store_interactions(store_id);
CREATE INDEX IF NOT EXISTS idx_store_interactions_type ON store_interactions(interaction_type);
CREATE INDEX IF NOT EXISTS idx_store_interactions_created ON store_interactions(created_at);
CREATE INDEX IF NOT EXISTS idx_store_popularity_score ON store_popularity(popularity_score DESC);
CREATE INDEX IF NOT EXISTS idx_stores_category ON stores(category);

-- 테이블 확인
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;