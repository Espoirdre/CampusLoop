-- 第 3 段：索引与访问规则

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
