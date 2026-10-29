-- ============================================================
--  CampusLoop 云端数据库建表脚本
--  平台：Supabase（PostgreSQL）
--  用法：Supabase 控制台 → 左侧 SQL Editor → New query
--        → 把本文件全部内容粘进去 → 点 Run
--
--  设计原则：所有字段名与 index.html 里的 JS 对象完全一致，
--  这样前端数据可以直接写入、直接读出，不需要任何字段映射，
--  少一层转换就少一处出错的地方。
-- ============================================================


-- ------------------------------------------------------------
-- 1. profiles  用户资料
--    对应 JS 里的 DB.profiles[学号] = {name, dept, contact, bio}
-- ------------------------------------------------------------
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


-- ------------------------------------------------------------
-- 5. favs  收藏
--    对应 JS 里的 DB.favs[学号] = ['lost_xxx', 'mk_yyy']
--    这里拆成一行一条记录，方便按人查询
-- ------------------------------------------------------------
create table if not exists public.favs (
  sid          text not null,
  "itemId"     text not null,
  "createdAt"  bigint default 0,
  primary key (sid, "itemId")
);


-- ------------------------------------------------------------
-- 6. accounts  站内账号
--    对应 JS 里的 DB.accounts[学号]
--    没有这张表，换台设备就登不进来了。
--
--    注意：这里存的是密码哈希，而且任何人都读得到（演示级权限）。
--    对课程演示可接受，但正式上线必须换成平台自带的认证服务，
--    届时这张表可以整个删掉。
-- ------------------------------------------------------------
create table if not exists public.accounts (
  sid          text primary key,
  name         text default '',
  "pwdHash"    text not null,
  "createdAt"  bigint default 0
);


-- ------------------------------------------------------------
-- 索引：列表页都按时间倒序取，加这三个索引就够了
-- ------------------------------------------------------------
create index if not exists lost_created_idx   on public.lost   ("createdAt" desc);
create index if not exists market_created_idx on public.market ("createdAt" desc);
create index if not exists wall_created_idx   on public.wall   ("createdAt" desc);


-- ------------------------------------------------------------
-- 访问规则（Row Level Security）
--
-- 注意：下面这套规则是「演示级」的 —— 只要拿到项目密钥的人
-- 都能读、能写、能改。这对课程项目的几十位同学是可接受的，
-- 因为数据本身就是公开的校园信息，不涉及隐私。
--
-- 但请务必遵守两条：
--   1. 不要往这里存手机号、身份证号、住址
--   2. 正式对外上线前，必须改成「只能改自己发布的内容」
--      （那需要接入真实登录，属于下一阶段）
-- ------------------------------------------------------------
alter table public.profiles enable row level security;
alter table public.lost     enable row level security;
alter table public.market   enable row level security;
alter table public.wall     enable row level security;
alter table public.favs     enable row level security;
alter table public.accounts enable row level security;

drop policy if exists demo_access_profiles on public.profiles;
drop policy if exists demo_access_lost     on public.lost;
drop policy if exists demo_access_market   on public.market;
drop policy if exists demo_access_wall     on public.wall;
drop policy if exists demo_access_favs     on public.favs;
drop policy if exists demo_access_accounts on public.accounts;

create policy demo_access_profiles on public.profiles for all to anon, authenticated using (true) with check (true);
create policy demo_access_lost     on public.lost     for all to anon, authenticated using (true) with check (true);
create policy demo_access_market   on public.market   for all to anon, authenticated using (true) with check (true);
create policy demo_access_wall     on public.wall     for all to anon, authenticated using (true) with check (true);
create policy demo_access_favs     on public.favs     for all to anon, authenticated using (true) with check (true);
create policy demo_access_accounts on public.accounts for all to anon, authenticated using (true) with check (true);


-- ------------------------------------------------------------
-- 自检：跑完上面全部内容后，再单独执行下面这段
-- 应该返回 6 行，每行 count 都是 0
-- ------------------------------------------------------------
select 'profiles' as 表名, count(*) as 记录数 from public.profiles
union all select 'lost',     count(*) from public.lost
union all select 'market',   count(*) from public.market
union all select 'wall',     count(*) from public.wall
union all select 'favs',     count(*) from public.favs
union all select 'accounts', count(*) from public.accounts;
