-- 第 2 段：收藏与账号（favs / accounts）

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
