# 后端接入操作手册

这份手册是写给「完全没接触过后端」的人看的。
每一步都写了**点哪里**、**看到什么算成功**、**失败了怎么办**。

代码部分我已经全部写完，你只需要做下面 6 步配置。

---

## 先看总览：一共 6 步

| 步骤 | 你要做的事 | 需要多久 | 卡住了看哪 |
|---|---|---|---|
| 1 | 注册 Supabase 账号，建一个项目 | 5 分钟 | 本文第 1 节 |
| 2 | 把建表脚本粘进去跑一遍 | 3 分钟 | 本文第 2 节 |
| 3 | 复制两个值（网址 + 密钥） | 2 分钟 | 本文第 3 节 |
| 4 | 把这两个值填进 `index.html` | 1 分钟 | 本文第 4 节 |
| 5 | 本地验证：换一个浏览器能看到同一条数据 | 3 分钟 | 本文第 5 节 |
| 6 | 推送到 GitHub，让别人也能访问 | 5 分钟 | 本文第 6 节 |

**总耗时约 20 分钟。** 做完第 5 步就能确认成功了，第 6 步只是让别人也能用。

---

## 第 1 步：注册 Supabase，建一个项目

Supabase 是一个托管数据库服务。它免费提供数据库、文件存储、登录系统，
**不需要你租服务器、不需要备案、不需要装任何软件**。

### 1.1 打开网站

浏览器访问：**https://supabase.com**

### 1.2 注册

1. 点右上角 **Start your project**
2. 选 **Continue with GitHub**（你已经有 GitHub 账号，直接用，省得记新密码）
3. 如果弹出授权页面，点 **Authorize**

### 1.3 新建项目

登录后进入控制台，点绿色的 **New project** 按钮。

会看到一个表单，填三样：

| 字段 | 填什么 |
|---|---|
| **Name** | `campusloop` |
| **Database Password** | 点右边的 **Generate a password**，然后**把生成的密码复制到记事本存好** |
| **Region** | 选 **Southeast Asia (Singapore)** 或 **Northeast Asia (Tokyo)**，这两个离国内最近，速度最快 |

> 那个数据库密码后面基本用不到（因为我们的代码走的是 API，不是直连数据库），
> 但**必须存下来**，万一以后要改结构会用到。丢了很麻烦。

填完点 **Create new project**，等 **1–2 分钟**（页面会显示进度条）。

**成功的标志**：自动进入项目面板，左边有一竖排图标（Table Editor、SQL Editor、Authentication…）。

---

## 第 2 步：建表（把脚本粘进去跑一遍）

### 2.1 打开 SQL 编辑器

在左侧边栏找 **SQL Editor**（图标像一个 `>_` 或代码符号）。
点进去，再点 **New query**。

### 2.2 粘贴脚本

1. 用记事本或 VS Code 打开项目里的 **`docs/backend/schema.sql`**
2. **全选**（Ctrl+A）、**复制**（Ctrl+C）
3. 回到浏览器，粘贴到 SQL Editor 的输入框里

### 2.3 执行

点右下角的 **Run** 按钮（或按 **Ctrl + Enter**）。

**成功的标志**：下方结果区显示 `Success. No rows returned`。

> `No rows returned` 是正常的 —— 建表本来就不会返回数据，不用管它。

### 2.4 自检（很重要，别跳过）

脚本最末尾有一段 `select` 语句。把它**单独选中**，再点一次 **Run**。

**成功的标志**：结果显示一个表格，**6 行**，每行的「记录数」都是 **0**：

```
表名        记录数
profiles      0
lost          0
market        0
wall          0
favs          0
accounts      0
```

看到这 6 行，说明 6 张表全建好了。

### 2.5 如果有报错

| 报错内容 | 意思 | 怎么办 |
|---|---|---|
| `already exists` | 表已经存在 | 不用管，脚本里用了 `if not exists`，重复跑是安全的 |
| `permission denied` | 权限不足 | 确认你是用自己注册的账号登录的，不是别人的项目 |
| `syntax error at or near` | 复制时漏了内容 | 重新全选复制一遍，注意别只复制了一半 |
| `syntax error at or near "_"` 且 `LINE 1: _` | **编辑器里只有一个下划线**，根本不是脚本 | 见 2.6，改用分段执行 |

### 2.6 如果整段粘贴老是失败，改成分段执行

`docs/backend/steps/` 下面有 4 个拆分好的文件，**一次只跑一个**，
每跑完一个看到 `Success` 再跑下一个：

| 顺序 | 文件 | 内容 | 跑完的现象 |
|---|---|---|---|
| 1 | `step1.sql` | 用户资料 + 三张主表：profiles / lost / market / wall | `Success. No rows returned` |
| 2 | `step2.sql` | 收藏与账号：favs / accounts | `Success. No rows returned` |
| 3 | `step3.sql` | 索引 + 访问规则 | `Success. No rows returned` |
| 4 | `step4.sql` | 自检查询 | 返回 6 行，记录数都是 0 |

这 4 个文件拼起来和 `schema.sql` 是完全等价的（我校验过每一条语句）。

**为什么分段更稳**：

- 每段只有 8–68 行，复制时不容易被截断
- 报错时能立刻知道是哪一段出问题，不用重新跑全部
- 前面跑成功的部分不会因为后面报错而白费

**分段执行的正确操作**（每次都要这样做）：

1. 在 SQL Editor 里按 **Ctrl + A** 全选，按 **Delete** 清空
2. 打开对应文件，按 **Ctrl + A** 全选，按 **Ctrl + C** 复制
3. 回到编辑器，按 **Ctrl + V** 粘贴
4. **检查第一行**：应该是以 `--` 开头的注释文字。如果第一行只有一个字符，说明没粘进去
5. 点一下编辑器**空白处**取消选中（这一步很关键：有选中内容时，Supabase 只执行选中的那部分）
6. 点 **Run** 或按 **Ctrl + Enter**

---

## 第 3 步：复制两个值

代码需要知道「数据存在哪个项目里」，所以要填两个值。

### 3.1 找到 API 设置页

左侧边栏**最下面**点 **Project Settings**（齿轮图标），
然后在左侧菜单里点 **API**。

> 如果找不到，也可以直接看浏览器地址栏，把 `/project/xxxxx` 换成
> `/project/xxxxx/settings/api` 回车。

### 3.2 复制第一个值：Project URL

页面上有一块叫 **Project URL**，长得像：

```
https://abcdefghijklmnop.supabase.co
```

点右边的复制图标。

> **只复制到 `.supabase.co` 为止。** 如果你复制的地址后面还带着 `/rest/v1/`，
> 代码也能自动处理（已经做了容错），但填干净的最省事。

### 3.3 复制第二个值：公开 key

同一页往下滚，找到 **Project API keys**。

Supabase 有两代 key，你可能看到其中任意一种，**都能用**：

| 你看到的格式 | 是什么 | 用不用 |
|---|---|---|
| `sb_publishable_xxxxxxxx` | 新版公开 key | **用这个** |
| `eyJhbGciOiJIUzI1NiIs...`（很长一串）放在 `anon` / `public` 那一行 | 旧版公开 key | **也可以用** |
| `sb_secret_xxxxxxxx` | 新版机密 key | **绝对不要用** |
| `eyJ...` 放在 `service_role` / `secret` 那一行 | 旧版机密 key | **绝对不要用** |

判断标准只有一个：**名字里带 publishable / anon / public 的才是公开 key，其余一律不要碰。**

复制下来。如果旧版 key 被遮住，点右边的 **Reveal** 再复制。

### 3.4 先存到记事本

把这两个值先粘到记事本里，下一步要用：

```
URL  = https://xxxxxxxxxxxx.supabase.co
KEY  = eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIs...
```

---

## 第 4 步：填进 index.html

> **当前状态：已完成并通过真实连接验证。**
> 这一节留作记录，以后换项目、换 key、或想退回单机模式时照做即可。

### 4.1 找到要改的地方

用 VS Code 打开项目的 **`index.html`**，按 **Ctrl + F** 搜索：

```
CLOUD_CONFIG
```

会定位到大概第 2576 行的这一段：

```js
var CLOUD_CONFIG = {
  url: '',   // 例：https://abcdefghijkl.supabase.co
  key: ''    // 例：eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
};
```

### 4.2 把两个值填进去

改成这样（**保留单引号，不要有空格**）：

```js
var CLOUD_CONFIG = {
  url: 'https://xxxxxxxxxxxx.supabase.co',
  key: 'sb_publishable_xxxxxxxxxxxxxxxxxxxx'
};
```

如果用的是旧版 JWT key，第二行就长这样：

```js
  key: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIs...'
```

### 4.3 三个常见错误

| 错误写法 | 后果 | 正确做法 |
|---|---|---|
| `url: 'xxxx.supabase.co'` | 少了 `https://`，请求失败 | 完整写 `https://xxxx.supabase.co` |
| `key: ''` 忘了填 | 还是单机模式 | 一定要填上 |
| 复制时多了空格或换行 | 请求 401 报错 | 删掉首尾空白，保持一行 |

保存文件（Ctrl+S）。

> 填完之后，整个页面会自动从「单机模式」切到「共享模式」，
> 首页那句提示也会从「发布的内容保存在你自己的浏览器里」
> 变成「云端同步已开启」。**这就是填对了的第一个标志。**

---

## 第 5 步：验证（这一步一定要做）

### 5.1 第一次打开

双击 `index.html`，注册一个账号（学号随便编 10 位数字，昵称至少 2 个字）。

**成功的标志**：首页顶部那句说明变成了 **「云端同步已开启：站内内容所有同学共享」**。

### 5.2 发一条内容

点右上角 **发布**，随便发一条失物招领，标题写「测试1」。

### 5.3 换一个「干净的浏览器」打开

按 **Ctrl + Shift + N** 打开无痕窗口（这是一个完全没有缓存的环境，等于一台新手机），
把 `index.html` 拖进去。

**成功的标志**：**不用登录就能看到刚才那条「测试1」**。

> 如果能看到，说明数据真的存到云端了。这是整个改造最关键的验证点。

### 5.4 最后一道检查（可选但强烈建议）

回到 Supabase 网页 → 左侧 **Table Editor** → 点 **lost** 表。

**成功的标志**：能看到刚才那条记录，`title` 字段是「测试1」。

---

## 第 6 步：让别人能访问

到了这一步，数据已经共享了，但别人还得先拿到你的 `index.html` 文件才行。
要让别人**打开一个网址就能用**，需要把页面部署到公网。

### 方案 A：用现有的 GitHub Pages（推荐，你已经有了）

你的项目已经在 `https://github.com/Espoirdre/CampusLoop`，
而且已经开了 Pages，所以只要把改动推上去就行。

在项目文件夹里打开终端（或 Git Bash），依次执行：

```bash
git add -A
git commit -m "接入云端数据层，支持多人共享"
git push
```

等 1–2 分钟，访问：

**https://espoirdre.github.io/CampusLoop/**

**成功的标志**：页面能打开，且顶部显示「云端同步已开启」。

> 如果打不开，是本机 hosts 屏蔽了 github.io。
> 运行桌面上的 `fix-github-hosts.cmd`（右键 → 以管理员身份运行），
> 或者临时改用方案 B。

### 方案 B：Vercel（国内访问更快，不需要 Git）

1. 访问 **https://vercel.com**，用 GitHub 登录
2. 点 **Add New** → **Project**
3. 找到 `CampusLoop` 仓库，点 **Import**
4. 什么都不要改，直接点 **Deploy**
5. 等 30 秒，会给你一个 `https://campusloop-xxx.vercel.app` 的网址

**注意**：Vercel 部署的页面，`index.html` 里的 `CLOUD_CONFIG` 必须是**已经填好的版本**，
否则线上还是单机模式。

### 怎么把网址发给同学

直接把网址发到班级群，说清楚两件事：

1. 用手机浏览器打开（微信内打开也可以，但微信里可能会屏蔽，建议「在浏览器中打开」）
2. 第一次用需要注册：随便编一个 10 位学号 + 至少 6 位密码，昵称至少 2 个字

---

## 常见问题

### Q1：打开页面一片空白 / 一直转圈

按 **F12** 打开开发者工具，看 **Console**（控制台）标签页有没有红字。

| 红字内容 | 原因 | 解决 |
|---|---|---|
| `Failed to fetch` | 网址填错 / 网络不通 | 检查 `url` 是不是完整的 `https://xxx.supabase.co` |
| `401 Unauthorized` | 密钥填错 | 重新复制 `anon` key，注意别带空格 |
| `relation "public.lost" does not exist` | 表没建成功 | 回到第 2 步，重新跑一遍 SQL |
| `new row violates row-level security policy` | 权限规则没建 | SQL 脚本里 `create policy` 那几段没跑成功，重新跑 |

### Q2：数据能共享了，但很慢

Supabase 的服务器在新加坡/东京，国内访问一般 200–800ms。
第一次打开会慢一点（要拉全部数据），之后就快了。

如果实在慢，可以把 Region 换成更近的，但要重建项目、重新跑 SQL。

### Q3：过几天再打开，报错了

**免费项目长时间没人访问会被自动暂停**（大约一周）。
到 Supabase 控制台，项目卡片上会显示 `Paused`，点 **Restore** 等一两分钟就能恢复。

**演示前一天，务必先自己打开一次，把项目唤醒。**

### Q4：怎么清空所有数据，重新演示

Supabase 控制台 → **Table Editor** → 选中表 → 全选行 → 删除。
6 张表都要清。

清完之后，第一个打开页面的人会看到示例数据（系统会自动推一份上去）。

如果不想让示例数据再被推上去，把 `index.html` 里的：

```js
var PUSH_SEED_TO_CLOUD = true;
```

改成 `false`。

### Q5：这个方案安全吗？能直接对外发布吗

**不能。** 现在的权限规则是「演示级」的：

- 任何拿到页面的人，都能读写全部数据（包括删除别人的帖子）
- 账号表里存着密码哈希，虽然看不懂，但能读到

对课程项目、几十个同学使用是可接受的，因为数据本身就是公开的校园信息。

**正式上线前必须做的三件事**（属于下一阶段，现在不用管）：

1. 改用 Supabase 自带的认证（Auth），删掉 `accounts` 表
2. 把权限规则收紧成「只能改自己发布的内容」
3. 图片改存文件存储，不要塞进数据库

---

## 我改了什么（给你自己看的）

如果你想知道代码里动了哪里，一共四个地方：

| 位置 | 作用 |
|---|---|
| `CLOUD_CONFIG` 常量 | 存网址和密钥，留空就是单机模式 |
| `Cloud` 对象 | 封装了「拉全量 / 批量写 / 批量删」三个动作 |
| `syncToCloud()` + `diffList()` | 比对快照，**只提交这次改动的记录**，避免两个人同时发布会互相覆盖 |
| `initDB()` | 有云端配置就先拉云端，没有就走原来的 localStorage |

**原来的单机逻辑一行没删**，只要 `CLOUD_CONFIG` 是空的，行为和以前完全一样。
所以就算后端搞砸了，把两个值清空，页面立刻退回单机模式，作业照样能交。
