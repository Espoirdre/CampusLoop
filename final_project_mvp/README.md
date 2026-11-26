# CampusLoop — `final_project_mvp/`

A campus noticeboard for three things that keep getting lost: **found items, second-hand items, and short public messages.** One student posts; another student searches and finds it. Plain HTML + CSS + JavaScript in a single file, with an optional shared database so two different devices see the same posts.

Group: **奶龙 Vibe 编码局** · Course: Building Agentic AI Products with Vibe Coding

---

## 1. What is in this folder

```
final_project_mvp/
├── index.html            the whole application (HTML + CSS + JS, no build step)
├── assets/               15 images: item photos used by the demo rows + logo
├── backend/
│   ├── schema.sql        full database schema (for reference)
│   └── steps/            the same schema split into 4 files that can be run one at a time
└── README.md             this file
```

There are **no dependencies, no package manager, no build step and no server code**. The folder is the product.

---

## 2. Requirements

| Need | Detail |
|---|---|
| A browser | Edge, Chrome, Firefox or Safari, updated within the last two years |
| For local mode | Nothing else. No internet needed |
| For shared mode | A free Supabase project (10 minutes to create) — see §4.2 |
| Local server (optional) | Python 3 if you want to serve over `http://` instead of opening the file |

---

## 3. Run it — local mode (30 seconds, no setup)

1. Double-click `index.html`, or drag it into a browser window.
2. On the entry screen choose **注册新账号** and fill the form:
   - student ID: any 10 digits, e.g. `2026000001`
   - nickname: **at least 2 characters** (one character is rejected)
   - password: at least 6 characters
3. You land on the home page. Click **发布**, fill the form, submit.

Data is stored in this browser's `localStorage`. Refreshing keeps it; another device or another browser will not see it.

> Opening the file directly **always** runs in local mode, by design. Browsers block cross-origin requests from `file://`, so the app skips the network instead of showing an error. Shared mode needs `http(s)` — see §4.2.

---

## 4. Run it — shared mode (two devices, one dataset)

Shared mode turns on automatically when two values are filled in near the top of `index.html`:

```js
var CLOUD_CONFIG = {
  url: '',   // e.g. https://abcdefghijkl.supabase.co
  key: ''    // e.g. sb_publishable_xxxxxxxxxxxx
};
```

Leave them empty and nothing changes — the app stays local. There is no separate switch to flip.

### 4.1 Create the database

1. Sign up at <https://supabase.com> and create a project. Choose the **Singapore** region.
2. Open **SQL Editor** in the left sidebar.
3. Run the four files in `backend/steps/` **in order** (`step1` → `step4`). Paste one file, click **Run**, wait for `Success. No rows returned`, then the next.
   - `step1` creates `profiles`, `lost`, `market`, `wall`
   - `step2` creates `favs`, `accounts`
   - `step3` creates indexes and access rules (a "potentially destructive" warning appears because of the `drop policy if exists` lines — that only replaces rules, it does not touch data; click **Run**)
   - `step4` is a self-check: it should return 6 rows, every count `0`

### 4.2 Fill in the two values

1. In Supabase go to **Project Settings → API**.
2. Copy **Project URL** and the **publishable / anon** key.
3. Paste them into `CLOUD_CONFIG` in `index.html`, keeping the single quotes:

```js
var CLOUD_CONFIG = {
  url: 'https://abcdefghijkl.supabase.co',
  key: 'sb_publishable_xxxxxxxxxxxx'
};
```

> Do **not** use the `service_role` / secret key. That one bypasses every rule and must never be put in a web page.

### 4.3 Serve it over http

```bash
# from the folder that contains final_project_mvp
python -m http.server 8000
# then open http://127.0.0.1:8000/final_project_mvp/index.html
```

Any static host works the same way (GitHub Pages, Vercel, Cloudflare Pages). No server-side code is required.

### 4.4 Check that it worked

Open the page in two different browsers (or one normal window + one private window). Register an account in window A, publish a lost-item post, then open the same URL in window B **without signing in** and search for it. If B sees it, shared mode is working. The home-page note under the masthead also switches from **「演示版：发布的内容保存在你自己的浏览器里，换设备或清理缓存后看不到。」** to **「云端同步已开启：站内内容所有同学共享，换设备打开也能看到。」** — that line is the quickest way to tell which mode is active.

---

## 5. Demo route — the task to give a trial participant

This is the exact route used in the customer trials. It takes about 90 seconds.

**Say this to the participant (Chinese):**

> 假设你昨天在二教上完课，把一把黑色折叠伞落在教室了，今天想找回来。用这个网站做一遍你会做的事，边做边说出你在想什么。我不会提示你点哪里，卡住了也没关系。

**What the route exercises:**

| Step | Expected path through the UI |
|---|---|
| 1 | Entry screen → 登录已有账号 (or 注册新账号 if new) |
| 2 | Home → 失物招领 |
| 3 | Search box: type a keyword, or pick a category (证件卡类 / 电子产品 / …) |
| 4 | Open a result → detail dialog → **查看联系方式** |
| 5 | Optional: publish their own 寻物启事 |

**What to observe and record:** where the eyes go first; whether the search box is found without help; which category name they look for; whether they read the masked contact as "hidden" or as "missing"; how long until they either find a match or give up.

> Set the success signal and the stop rule **before** the trial, and write them into the Part 2 report. Do not decide afterwards.

---

## 6. Test instructions

All of the following were run against the packaged copy and are the behaviour to expect.

### 6.1 Normal case

| # | Action | Expected result |
|---|---|---|
| 1 | Register with a new 10-digit ID, 2+ character nickname, 6+ character password | Lands on the home page, logged in |
| 2 | 发布 → fill title / description / contact / place → submit | The post appears first in the list; count increases by 1 |
| 3 | Refresh the page | Still logged in; the post is still there |
| 4 | In shared mode, open the same URL in a second, unrelated browser | The post is visible **without signing in** |
| 5 | Click 查看联系方式 on any post | Contact reveals and can be copied |

### 6.2 Boundary and failure cases

| # | Action | Expected result |
|---|---|---|
| 1 | Register with a 1-character nickname | Blocked, inline message **"昵称至少 2 个字"** |
| 2 | Register with a student ID that already exists | Blocked, **"该学号已经注册过了，请返回上一步选择「登录已有账号」"** |
| 3 | Log in with the right ID and a wrong password | **"密码不正确，请再试一次"**, stays on the password step |
| 4 | Publish with an empty title or empty description | Submit blocked, the dialog stays open with a toast **"请填写物品名称"** (or the matching field message); no row is written |
| 5 | Search for a keyword that matches nothing | An explicit empty state, not a blank list |
| 6 | Point `CLOUD_CONFIG.url` at a host that does not resolve | The page still opens on local cache; a toast reads **"云端连接失败，当前显示的是本机缓存"**; no blank screen and no uncaught error |
| 7 | Upload a very large photo | Compressed in the browser to ≤900 px, JPEG q0.72, before it is stored |

### 6.3 Reset to a clean state

- Local mode: clear site data for the page (DevTools → Application → Clear site data), or run `localStorage.removeItem('campusloop_v1')` in the console.
- Shared mode: in the Supabase SQL editor, `delete from public.lost; delete from public.market; delete from public.wall; delete from public.accounts; delete from public.profiles; delete from public.favs;`
- The 12 / 14 / 7 demo rows are re-seeded automatically the first time the app opens against an **empty** database.

---

## 7. Known limits

Stated plainly, because they matter more than the feature list.

1. **The password hash is not real security.** `hashPwd()` is a 32-bit string hash written for a course demo, not bcrypt/Argon2. It is fast to brute-force, and the `accounts` table is readable by anyone holding the publishable key. **This build must not hold real student passwords.** A production version should move to Supabase Auth (or any server-side auth) and never send the password to the client-side code.
2. **No moderation.** Anyone with an account can post anything. There is no report button, no admin view, no rate limit and no word filter.
3. **Editing and deleting are only restricted by the UI.** The database access rules allow any holder of the public key to insert, update and delete. Acceptable for a course demo with a handful of known testers; not acceptable for an open campus deployment.
4. **Photos are stored as base64 inside the database row**, not in object storage. Each compressed photo is roughly 80–150 KB. At a few hundred posts the table grows to tens of megabytes and list loading slows down. The fix is an object-storage bucket plus a URL column — deliberately out of scope for this MVP.
5. **No real-time updates.** A second device sees new posts only after a refresh. There is no websocket, no polling and no push notification.
6. **The whole dataset is fetched at once.** `Cloud.loadAll()` pulls every row of the three content tables on page load. Fine below a few thousand rows; needs pagination before that.
7. **Search is a plain substring match** over title, description and place. No fuzzy match, no pinyin, no typo tolerance, no synonym handling. "一卡通" and "校园卡" are different queries.
8. **Contact details are masked in the UI but stored in plaintext.** Hiding them is a UI decision, not a privacy guarantee.
9. **The free database tier sleeps.** After about a week without traffic the project pauses; the first request after that may fail. Wake it (open the project once) before any demo.
10. **`file://` never uses the shared database.** By design — see §3.
11. **No accessibility pass.** Keyboard focus works in the main flows, but the detail dialog does not trap focus and the colour contrast of secondary text has not been measured against WCAG.

---

## 8. Data model

Six tables. Column names match the JavaScript object fields exactly, so no mapping layer is needed.

| Table | Holds | Key |
|---|---|---|
| `lost` | lost-and-found posts (both 寻物 and 招领) | `id` |
| `market` | second-hand listings | `id` |
| `wall` | message-wall notes, with likes and replies as JSON | `id` |
| `profiles` | nickname, department, contact, bio | `sid` (student ID) |
| `favs` | one row per saved item | `sid` + `itemId` |
| `accounts` | student ID, nickname, password hash | `sid` |

`images`, `user`, `likes`, `replies` and `wants` are `jsonb` columns. `backend/schema.sql` is the authoritative definition.

---

## 9. Technology choices, in one line each

- **Single HTML file, no framework** — the whole app is one artifact that a grader can open without installing anything; the cost is that the file is large (~210 KB) and there is no component reuse.
- **`localStorage` mirror in front of the network** — the page paints immediately from cache even when the network is slow or down, and degrades to a usable single-device app instead of an error screen.
- **Incremental sync instead of whole-dataset writes** — `saveDB()` diffs against a snapshot and submits only the rows that changed, so two people posting at the same time do not overwrite each other.
- **Supabase (hosted Postgres + REST)** — no server code to write, maintain or secure, and the free tier covers this scale. The cost is that access rules live in SQL and are easy to get wrong.
- **No LLM inside the product** — the customer need is lookup, not generation. AI was used for coding and drafting only.
