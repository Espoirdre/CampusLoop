# Part 1 提交清单 · 距截止 51 小时

> 截止：**2026-11-26（周四）17:00**（北京时间）
> 交到：GBU AILab → Week 09 小组作业
> 组：奶龙 Vibe 编码局 · 5 人

---

## 一、要交什么（只有两样）

| # | 文件 | 现在状态 | 谁最后负责 |
|---|---|---|---|
| 1 | `Final_Group_Project_Assignment_Part_1_【GroupID】.md` | **已写好**，第 3 行留空等访谈 | 张铖轩 |
| 2 | `Final_Group_Project_Assignment_Part_1_奶龙 Vibe 编码局.mp4` | **素材已备好**，需要你们录 | 张铖轩 |

**不用交**：代码、MVP、PPT、单独的提案幻灯片。作业原文明确写了 26 号不交这些。

---

## 二、我已经做完的部分

| 产物 | 位置 | 说明 |
|---|---|---|
| 提案报告 | `docs/part1/Final_Group_Project_Assignment_Part_1_GroupID.md` | 官方五行模板，第 1/2/4/5 行已写完 |
| 访谈工具包 | `docs/part1/discovery-kit.md` | 两套问题 + 记录表 + 知情话术 |
| 视频分镜 | `docs/part1/video-plan.md` | 59 秒时间表，每人 10 秒，只给要点不给台词 |
| 标题帧 | `docs/part1/video/title-frame.png` | 1920×1080，项目名+组名+5 人姓名 |
| 项目名角标 | `docs/part1/video/project-label.png` | 透明底，贴在视频右下角全程显示 |
| MVP 交付目录 | `final_project_mvp/` | index.html + assets + README（setup/run/test/known limits），无 .git、无密钥 |

---

## 三、只有你们能做的 5 件事

**分工见 `task-assignment.md`。** ②③④ 分给了不同的人，可以同时进行，不用排队。

### ① 查 Group ID（10 分钟）

去 AILab 团队页看官方编号（可能是 `G07` 这种，不是学号）。拿到后：

```bash
cd "D:/学习资料/Vibecoding实战/小组作业/docs/part1"
mv Final_Group_Project_Assignment_Part_1_GroupID.md Final_Group_Project_Assignment_Part_1_GXX.md
```

同时把报告第一段里的 `【待填：官方 Group ID，保留前导零】` 改掉。

### ② 做 2 个访谈（各 1 小时，其中至少 1 位不是本班）

**一个人去，不组队**（凑两个人的时间最容易卡住）。

- **陈思峥** → 宿管 / 楼管 / 值班室，填 `handoff/P1-record.md`
- **嵇翰林** → 非本班同学，填 `handoff/P2-record.md`

谈完当场填，把卡片内容原样发群。**11/25 12:00 硬截止，晚到不收。**

### ③ 填报告第 3 行（1 小时）

拿到两张卡后，按 `row3-worksheet.md` 的 A–E 五项合并进报告第 3 行。**这一行不能由 AI 写**，作业标的是 NO AI。

### ④ 做 AI 教练环节（20 分钟，作业要求 AI REQUIRED）

**马桢豪**做：打开 `handoff/ai-evidence.md`，里面有整段可复制的 prompt，发到 AILab，看完反馈后**真的改一处**，把四行证据填好发群。**11/24 22:00 前**。

### ⑤ 录视频（1–2 小时）

按 `video-plan.md` 拍。5 个人同框，一人 10 秒，**不要念稿，不要放产品录屏**。

---

## 四、剩下 2 天怎么排

> 现在 11/24 13:41，距截止 51 小时。**详细分工见 `task-assignment.md`**，这里只列关键节点。

| 时间 | 做什么 | 谁 |
|---|---|---|
| **11/24 今晚 22:00** | 查 Group ID、改文件名和报告头；AI 证据卡发群；拍摄时间确认 | 张铖轩 / 马桢豪 / 高斌雄 |
| **11/25 上午** | 两个访谈（各自独立，不用组队） | 陈思峥 / 嵇翰林 |
| **11/25 12:00** | 两张记录卡发群，**硬截止** | 陈思峥 / 嵇翰林 |
| **11/25 14:00** | 拍视频，20 分钟，全员在场 | 全员 |
| **11/25 18:00** | 合并第 3 行与第 5 行证据 | 张铖轩 |
| **11/25 22:00** | 出 `_v1.mp4`，全员过一遍 | 高斌雄 |
| **11/26 09:00** | 跑自查，占位符归零 | 张铖轩 |
| **11/26 14:00** | 提交，留 3 小时缓冲 | 张铖轩 |

---

## 五、提交前逐项自查

在 `docs/part1` 目录下跑：

```bash
# 1. 还有没有漏填的占位符（必须是 0）
grep -o "【待填" Final_Group_Project_Assignment_Part_1_*.md | wc -l

# 2. 五行表格是否都在
grep -c "^| \*\*[1-5]\." Final_Group_Project_Assignment_Part_1_*.md

# 3. 视频时长是否 ≤60 秒（用 ffprobe，装了才有）
ffprobe -v error -show_entries format=duration -of csv=p=0 "Final_Group_Project_Assignment_Part_1_奶龙 Vibe 编码局.mp4"
```

**人工检查（对着视频看一遍）：**

- [ ] 第 1 条命令返回 `0`
- [ ] 第 2 条命令返回 `5`
- [ ] 视频 ≤ 60 秒
- [ ] 开头有标题帧，含项目名 + 组名 + 5 人姓名
- [ ] 5 人都出镜、都说话、都说了自己名字
- [ ] 全程能看到 CampusLoop 角标
- [ ] 没有产品录屏 / PPT / 宣传片
- [ ] 报告里的成员姓名与视频里说的**完全一致**
- [ ] 第 5 行末尾的分工表与实际情况一致（我按 5 人各写了一条，不合适就改）
- [ ] 报告第 3 行有 2 位被访者，且至少 1 位标了 `out-of-class`
- [ ] 报告里没有任何真实姓名、微信、电话、学号（除组员自己的学号）
- [ ] 文件名正确：`Final_Group_Project_Assignment_Part_1_<GroupID>.md` 和 `..._奶龙 Vibe 编码局.mp4`

---

## 六、几个会被退件的坑

| 坑 | 为什么会退 |
|---|---|
| 第 3 行是 AI 写的 | 作业标了 NO AI，且发现编造证据比不交更严重 |
| 只访谈了本班同学 | "at least one person who is not enrolled in this class" 不满足 |
| 视频里放了网页录屏 | Part 1 明确禁止产品演示，演示属于 Part 2 |
| 有人在视频里没说名字 | 硬性要求，缺一个就不合格 |
| 报告和视频里的项目名不一致 | 要求 "same project name in the report and video" |
| 视频超 60 秒 | 上限是硬上限，包括标题帧 |
| 文件名用了学号而不是 Group ID | 提交系统按 `<GroupID>` 找文件 |

---

## 七、关于中文文件名

作业要的是 `<GroupName>`，你们的注册名是 `奶龙 Vibe 编码局`，所以文件名里带中文和空格是**符合要求的**。

如果 AILab 上传时因为中文名报错，改成 `NailongVibeCodingBureau` 再传，并在报告的组名那一行注明。不要改成一个看不懂的缩写。

---

## 八、两件维护上的小事

**① 改了 `index.html` 要同步到交付目录**，否则两个版本会不一致：

```bash
cd "D:/学习资料/Vibecoding实战/小组作业"
cp index.html final_project_mvp/index.html
```

**② 标题帧要改名字时**，改 `docs/part1/video/title-frame.html` 里的文字，再重新截图。组名或成员有变动就重跑一次，不要直接改 PNG。

