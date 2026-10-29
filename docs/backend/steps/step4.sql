-- 第 4 段：自检（应该返回 6 行，记录数都是 0）

select 'profiles' as 表名, count(*) as 记录数 from public.profiles
union all select 'lost',     count(*) from public.lost
union all select 'market',   count(*) from public.market
union all select 'wall',     count(*) from public.wall
union all select 'favs',     count(*) from public.favs
union all select 'accounts', count(*) from public.accounts;
