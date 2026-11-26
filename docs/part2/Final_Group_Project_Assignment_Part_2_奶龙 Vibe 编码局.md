# Final Group Project Assignment Part 2 — Report Update

**Project name** (same in the report and video; visible throughout the video): **CampusLoop**

**Registered group name / Group ID; registered member names / official IDs:**
奶龙 Vibe 编码局 / Group ID：奶龙 Vibe 编码局（AILab 上组名即编号）
张铖轩 26100164（组长 / coordinator）· 陈思峥 26100014 · 高斌雄 26100031 · 嵇翰林 26100048 · 马桢豪 26100096

**Route:** Self-proposed. No sponsored project is involved, so no original sponsored project name applies.

**Presentation video:** `Final_Group_Project_Assignment_Part_2_奶龙 Vibe 编码局_pitch.mp4`; 5 分钟以内; language: Chinese

---

## Updated project brief and progress

*AI ALLOWED: the five-row brief below is the proposal brief carried forward, followed by what actually changed. Row 3 is unchanged from Part 1 and was not rewritten.*

| Required item | Our proposal |
|---|---|
| **1. Project identity** | **CampusLoop** — one campus page where a student posts a found or lost item in under a minute, and another student finds it by searching instead of scrolling group chats. Route: **self-proposed** (not sponsored). No sponsor scope or permission applies. |
| **2. Customer and problem** | **Users.** Two sides of the same event. *The finder*: a student who picks up a card, a key or a bag in a classroom or canteen and has to decide within a minute what to do with it. *The loser*: a student who notices the item is gone, usually in the ten-minute break between classes, and has to decide where to look before the next class. A third, lower-frequency user: a student with textbooks or a dorm fridge to get rid of before the term ends.<br>**Context.** One campus; a few thousand students moving between buildings every 10 minutes.<br>**Job to be done.** "Get this back to the person who owns it" / "find my thing before I give up and buy a new one" / "get rid of this without shipping it across the city."<br>**Current difficulty (working assumptions — row 3 tests them).** Notices are scattered across class groups, dorm groups and club groups; a message is buried after a few dozen replies; nothing is searchable by item type or place; the official desk keeps items in a drawer with no public list, so the loser has to walk there and ask.<br>**Beneficiary / decision-maker / payer.** Beneficiary: the student who gets the item back and the student who stops storing someone else's bag. Decision-maker: the poster — one person, one action, no approval needed. **Payer: none.** This is a free campus service; it runs on free hosting tiers and the team pays nothing. No payment, inventory or transaction is involved. |
| **3. Evidence and uncertainty — NO AI records** | *Written from the team's own conversations, in November 2026. Reported in the participants' own terms; no wording was put into their mouths.*<br><br>**A. Completed discovery records** — two students, both interviewed in November 2026, anonymous codes only<br>**P1** · 2026-11 · 本校在读学生 · in-class · spoke 张铖轩<br>+ 认为失物招领这一块有用：东西丢了能有个地方搜，不用在群里翻<br>− 没有讲出自己最近一次丢东西的具体经过，所以目前是看法，不是发生过的事<br><br>**P2** · 2026-11 · 本校在读学生 · out-of-class · spoke 张铖轩<br>+ 认为二手网页有用<br>+ 判断二手需求集中在毕业季，平时不旺<br>− 这个时间判断是他对"别人什么时候需要"的预期，不是他数过的量<br><br>**B. What the findings changed in our idea**<br>· P2 说的"毕业季才旺"改了我们首页的排序：非毕业季不把二手放最前，免得首页长期堆着无人问津的旧帖<br>· 也把二手板块的推广时点挪到毕业季前，不再指望开学季自然起量<br><br>**C. Other checked sources and dates**<br>None beyond the two conversations above.<br><br>**D. Facts / inference / assumptions / remaining gaps**<br>· Fact (observed)：两位受访者都表示对应功能有用；其中一位认为二手需求集中在毕业季<br>· Inference (our reading)：失物招领是常年低频但真需要；二手是季节性高峰<br>· Assumption still untested：说"有用"是否等于真的会用；毕业季的实际发帖量有多大<br>· Remaining gap：两次都没有具体事件（什么时候丢的、怎么找的、找了多久）；两位都是学生，还没有"捡到东西的一方"的视角。下一步：让 P1 补讲一次最近的经历，并补 1 位宿管或值班室的人<br><br>**E. Team decision**<br>proceed。两块功能都有人认可，二手的时间点问题属于推广节奏，不改变 MVP 范围。 |
| **4. Alternatives and value** | **What people do now.** (a) Post in a WeChat/QQ class or dorm group and hope someone scrolls. (b) Walk to the dorm front desk or the property office and ask a person. (c) Put a note on the door. (d) For second-hand: 闲鱼 — which means shipping or meeting a stranger across the city; or a 表白墙/校园墙 post — anonymous, unstructured, gone in a day. (e) Give up: buy a replacement, or throw the found item away.<br>**Why switch.** The existing options are *broadcast* channels, not *lookup* channels. You can only find something if you happened to be reading at the right moment. CampusLoop turns the same information into something you can **query**: by keyword, by category, by place, sorted by time. It also removes the social cost — you do not have to add a stranger on WeChat, and you do not have to announce to 200 people that you lost your card.<br>**Cost of switching.** One sign-up (student ID + password, no email needed) and one form. If it fails, the group chats are still there — nothing is lost by trying. |
| **5. MVP scope** | **One narrow path — input → action → output.**<br>**Input.** A registered student posts a found item: title, category (7 types), place, date, description, up to 3 photos, contact. Photos are compressed in the browser to ≤900 px before upload.<br>**Action.** The record is written as one row to a shared hosted database table and merged into the public list for everyone, newest first.<br>**Output.** A *different* student opens the same URL on another device, types "校园卡" or taps 证件卡类, sees the post, taps 查看联系方式, and contacts the poster. That is the whole test of the product.<br>**Core features (kept).** Three boards: lost & found, second-hand, message wall. Search + category filter + sort; detail view with contact hidden until tapped; publish form with field validation; profile edit; own posts can be marked resolved/sold.<br>**Non-goals (explicitly out).** No real-time chat, no payment, no delivery, no admin/moderation console, no push notifications, no mobile app, **no connection to any university system** (we do not read or imitate the campus SSO — sign-up is our own student-ID + password account), no recommendation or matching algorithm in this version.<br>**Manual work we disclose.** We hand-seeded the demo rows (12 lost / 14 second-hand / 7 wall) so the first visitor does not see an empty page; during trials we created test accounts by hand and deleted test rows from the database console by hand.<br>**Checks.** Duplicate student ID rejected at sign-up; password stored as a hash, never plaintext; contact masked until tapped; every user-supplied string escaped before rendering; required fields blocked when empty; posting requires a signed-in session.<br>**Failure handling.** If the shared database is unreachable the page falls back to the device's local cache and shows a banner instead of going blank; an oversized photo is compressed rather than rejected; a failed submit keeps the draft and retries on the next save.<br>**How we will test it.** *Normal case:* post from device A, find it from device B without signing in. *Boundary case:* post with no photo and a maximum-length title; sign up with a student ID that already exists. Success signal and stop rule are set in Part 2 before trials.<br>**AI inside the product:** none. The product does not call an LLM; AI was used for coding and drafting only.<br>**Who owns what.** 张铖轩 — coordinator, schedule and submission, lost & found board. 陈思峥 — second-hand board, discovery group A. 高斌雄 — data layer and cloud schema, discovery group A. 嵇翰林 — sign-up and profile flow, discovery group B. 马桢豪 — mobile layout, test records, discovery group B.<br><br>**AI coaching evidence (AI REQUIRED — 视频表达训练)**<br>- Tool / model / date: AILab · 2026-11-25<br>- Authentic prompt (excerpt, what we actually typed): 「我们在准备一个 60 秒的课程项目提案视频，5 个人每人约 10 秒，每人都要出镜并说出自己的名字，不能念稿……请做三件事：1. 这一分钟最该让人记住的一句话是什么？现在的结构有没有偏离它？2. 指出哪一段是废话，该删或压缩。3. 五个人怎么交接才不显得生硬？」<br>- Feedback we received (excerpt): 「记忆点应是『从刷群到搜索』，不是『把三个功能放在一个网页里』。」「范围太大：二手交易、留言墙并不直接回答『失物信息搜不到』——这次可以保留三合一的定位，但只展开失物招领。」「证据重复：宿管的数字和同学的场景，要分别回答『问题有多常见』和『具体卡在哪里』。」<br>- One concrete change we made: 把成员 C 那段从「逐个报三个板块的功能」压成只讲一句「填表发布 → 别人按关键词搜到」；五个人改成用上一人留下的问题交接，不再说「下面请某某介绍」 |

**What changed since the proposal**

- **Product — narrower than promised, not wider.** The shared-database mode was built and verified end to end against a live hosted database in November: a post created in one browser appeared in a second, unrelated browser. That database was then removed, so **the submitted build runs in local mode only**. Two devices do not share data, and we claim no public deployment.
- **Scope — nothing was added.** The three boards, search, filters, detail view and publish form are the same set described in row 5. No feature was added after the proposal.
- **Evidence — no new discovery.** Row 3 is carried forward unchanged. The only customer evidence we hold is still the two conversations recorded there.
- **Decision — continue.** The need was not contradicted by anything we learned; what we lack is trial evidence, not scope. That is what the next section reports.

---

## MVP, customer trials and final presentation evidence

### 1. What runs

One file, no build step, no dependencies, no server. Open `final_project_mvp/index.html` in a browser and it works offline; data is stored in that browser's `localStorage`.

**Opening and running route** (also in `final_project_mvp/README.md` §3):

1. Double-click `final_project_mvp/index.html`
2. 注册新账号 — student ID: any 10 digits; nickname: at least 2 characters; password: at least 6 characters
3. Home → 失物招领 → type a keyword in the search box, or pick a category
4. Open a result → 查看联系方式
5. 发布 → fill the form → submit

### 2. Test design, fixed before any trial

*NO AI — agreed by the team before the first trial, not written after seeing results.*

**Success signal.** At least 2 of the trial participants, **without any hint from us**, reach a matching record through the search box within 2 minutes, and can say in their own words what the page is for.

**Result that would force a revision or a stop.** If 2 participants both try to *publish* first while looking for something, or both say they would still ask in the group chat instead, we stop adding features and rebuild the entry screen so that searching is the first thing on it. If that rebuild also fails, we report the need as unsupported rather than keep polishing.

### 3. Customer trial records — NO AI

*Filled by the team after each trial. Anonymous codes only; no names, contact details or recordings.*

| Date | Code | In / out of class | Task given | Help we gave | What we observed | What they said |
|---|---|---|---|---|---|---|
| 【待填】 | U1 | 【in / out】 | 假设你昨天在二教上完课，把一把黑色折叠伞落在教室了，今天想找回来。用这个网站做一遍你会做的事，边做边说出你在想什么。 | 【待填：无 / 指了一下搜索框 / …】 | 【待填：先点了哪里、卡在哪、用了多久】 | 【待填：原话】 |
| 【待填】 | U2 | **out-of-class** | 同上 | 【待填】 | 【待填】 | 【待填】 |

### 4. Boundary and failure case — NO AI

| Case | What we did | Expected | Observed |
|---|---|---|---|
| 【待填：例 昵称只填一个字】 | 【待填】 | 【待填：被拦下，提示「昵称至少 2 个字」】 | 【待填】 |

### 5. One focused improvement and recheck

*AI ALLOWED — but only after §3 and §4 exist. Do not fill this in before the trials.*

【待填：改了哪一处、改之前观察到什么、改完同一条路径复测的结果】

### 6. Team decision — NO AI

【待填：continue / revise / change direction + 一句理由 + 还不知道什么 + 下一次测什么】

### 7. AI coaching evidence — AI REQUIRED (presentation)

*用于 5 分钟 Demo 视频的表达训练，与 Part 1 的一分钟教练分开记录。*

- Tool / model / date: 【待填：例 AILab · 模型名 · 2026-12-__】
- Authentic prompt (excerpt, what we actually typed): 【待填：2–4 行原话】
- Feedback we received (excerpt): 【待填：2–4 行】
- One concrete change we made: 【待填：具体动作】

### 8. Final package

| Item | State |
|---|---|
| `Final_Group_Project_Assignment_Part_2_奶龙 Vibe 编码局.md` | this file |
| `final_project_mvp/` | index.html + assets + README (setup, run/test, known limits) + optional `backend/` SQL for the shared mode |
| `Final_Group_Project_Assignment_Part_2_奶龙 Vibe 编码局_pitch.mp4` | 【待填：时长】 |

---

## Contributions and disclosure — NO AI final record

*Each member writes their own line. No AI drafting, no translation.*

- 张铖轩 26100164 — 【待填】
- 陈思峥 26100014 — 【待填】
- 高斌雄 26100031 — 【待填】
- 嵇翰林 26100048 — 【待填】
- 马桢豪 26100096 — 【待填】

**Disclosure.** AI was used for coding, debugging, drafting and structuring this report. Every claim about a participant or a test in §3–§6 is written by the team from its own notes. No AI generated, translated or polished the NO AI sections.

---

## What I learned

*Each member writes their own named summary. NO AI. English preferred, Chinese accepted.*

**张铖轩 26100164**
【待填】

**陈思峥 26100014**
【待填】

**高斌雄 26100031**
【待填】

**嵇翰林 26100048**
【待填】

**马桢豪 26100096**
【待填】
