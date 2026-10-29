-- 第 1 段：用户资料 + 三张主表（profiles / lost / market / wall）

create table if not exists public.profiles (
  sid          text primary key,        -- 学号，同时作为唯一标识
  name         text default '',         -- 昵称
  dept         text default '',         -- 院系
  contact      text default '',         -- 常用联系方式
  bio          text default ''          -- 个人简介
);


-- ------------------------------------------------------------
-- 2. lost  失物招领
--    对应 JS 里的 DB.lost 数组
-- ------------------------------------------------------------
create table if not exists public.lost (
  id           text primary key,        -- 形如 lost_1698765432_ab12
  type         text,                    -- 'lost' 我丢了 / 'found' 我捡到
  title        text,
  cat          text,                    -- 分类
  place        text,                    -- 地点
  "happenedAt" text,                    -- 日期字符串，如 2026-10-27
  "desc"       text,                    -- 详细描述（desc 是 SQL 关键字，必须带引号）
  images       jsonb default '[]'::jsonb,
  contact      text,
  "user"       jsonb,                   -- {name, sid, color}
  "createdAt"  bigint default 0,        -- 毫秒时间戳，和 JS 的 Date.now() 一致
  status       text default 'open',     -- 'open' 待认领 / 'returned' 已归还
  views        int  default 0
);


-- ------------------------------------------------------------
-- 3. market  二手市场
--    对应 JS 里的 DB.market 数组
-- ------------------------------------------------------------
create table if not exists public.market (
  id          text primary key,
  title       text,
  price       numeric default 0,
  "oldPrice"  numeric default 0,
  cond        text,                     -- 成色
  cat         text,
  trade       text,                     -- 交易方式
  "desc"      text,
  images      jsonb default '[]'::jsonb,
  contact     text,
  "user"      jsonb,
  "createdAt" bigint default 0,
  status      text default 'onsale',    -- 'onsale' / 'reserved' / 'sold'
  views       int  default 0,
  wants       jsonb default '[]'::jsonb -- 想要的人数列表
);


-- ------------------------------------------------------------
-- 4. wall  留言墙
--    对应 JS 里的 DB.wall 数组
-- ------------------------------------------------------------
create table if not exists public.wall (
  id          text primary key,
  "text"      text,                     -- 留言正文（text 是类型名，加引号更稳）
  color       text,                     -- 便签颜色
  "user"      jsonb,
  "createdAt" bigint default 0,
  likes       jsonb default '[]'::jsonb,
  replies     jsonb default '[]'::jsonb
);
