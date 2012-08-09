Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2012 15:53:41 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:61058 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903671Ab2HINxh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2012 15:53:37 +0200
Received: by pbbrq13 with SMTP id rq13so1038931pbb.36
        for <multiple recipients>; Thu, 09 Aug 2012 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=dcfOr4C1gfXUi4RUIPn+yQYoPISiK/diqu2xympr5Vg=;
        b=EP1ulofbQPHQ8Yh00tyKdi4wv+LdGP+odUh/j4NHRdw0hoe0vA5yjJgsdSUrpAHLqr
         lPmN221ArIAs0natnt82a5BeiSPmAnxCYl/CT+qh5tH4lMk1V9d56sazn0MP1jrAQCRm
         AzRwYts+tuMOJrQdFuLwNjH3y7S2nDGKG5LC2fDf0Dy33U/OwPieJ4xW3nJNvgTMlXbX
         wZLuLh4Vb9jT+CwPwarnoeQlP/xnqSx1iCFqFskRF7aAWz3ey2s+nJDe8RyeW9zKteup
         tXqx4E7mBqILxx5c77Ck76WtKx9M6g2IDjKlXawfS86gPQuaCmRY9wlcmymH4WeglClD
         l/Yg==
MIME-Version: 1.0
Received: by 10.68.212.161 with SMTP id nl1mr4437606pbc.84.1344520410371; Thu,
 09 Aug 2012 06:53:30 -0700 (PDT)
Received: by 10.67.14.106 with HTTP; Thu, 9 Aug 2012 06:53:30 -0700 (PDT)
Date:   Thu, 9 Aug 2012 19:23:30 +0530
Message-ID: <CADArhcB+N+D4fyVN20f0hu=vfPj1tsn5NHi0cjG4JJcKAhTkeQ@mail.gmail.com>
Subject: [Bug-fix] backtrace when HAVE_FUNCTION_TRACER is enable
From:   Akhilesh Kumar <akhilesh.lxr@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=e89a8ff1c89c74179f04c6d58d84
X-archive-position: 34074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akhilesh.lxr@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--e89a8ff1c89c74179f04c6d58d84
Content-Type: text/plain; charset=ISO-8859-1

Hi Ralf,


Sub:- Bug  unable to retrive backtrace when HAVE_FUNCTION_TRACER is enable.
I send this bug and bug fix long back, I am resending this patch again for
review.

Please review below patch if you agree I will regenerate this patch and
with you.

====[ backtrace testing ]===========
Testing a backtrace from process context.
The following trace is a kernel self test and not a bug!
Testing a backtrace.
The following trace is a kernel self test and not a bug!
Call Trace:
[<80295134>] dump_stack+0x8/0x34
[<c0946060>] backtrace_regression_test+0x60/0x94 [sisc_backtrcae]
[<800004f0>] do_one_initcall+0xf0/0x1d0
[<80060954>] sys_init_module+0x19c8/0x1c60
[<8000a418>] stack_done+0x20/0x40
output befor patch when HAVE_FUNCTION_TRACER is enable
---------------------------------------------------------------------
#> insmod backtrace.ko
====[ backtrace testing ]===========
Testing a backtrace from process context.
The following trace is a kernel self test and not a bug!
Testing a backtrace.
The following trace is a kernel self test and not a bug!
Call Trace:
[<802e5164>] dump_stack+0x1c/0x50
[<802e5164>] dump_stack+0x1c/0x50
====[ end of backtrace testing ]====
------------------------------------------------------
above shows the wrong back trcae
output after patch when HAVE_FUNCTION_TRACER is enable
----------------------------------------------------------------------
====[ backtrace testing ]===========
Testing a backtrace from process context.
The following trace is a kernel self test and not a bug!
Testing a backtrace.
The following trace is a kernel self test and not a bug!
Call Trace:
[<802eb1a4>] dump_stack+0x20/0x54
[<c003405c>] backtrace_test_timer+0x5c/0x74 [sisc_backtrcae]
[<c00340dc>] init_module+0x68/0xa0 [sisc_backtrcae]
[<80000508>] do_one_initcall+0x108/0x1f0
[<8006d4c4>] sys_init_module+0x1a10/0x1c74
[<8000b038>] stack_done+0x20/0x40
------------------------------------------------------------------
get_frame_info() is used to fetch the frame information from the
function.
However,
1. this function just considers the first stack adjustment for frame
size.
2. On finding the save_lr instruction, it returns.
It doesn't handle the ftrace condition.
If Dynamic Frace "CONFIG_DYNAMIC_FTRACE" is enabled, the instrumentation
code is:
 - jal <ftrace_caller>
 - addiu sp,sp,-8
Thus, the current Frame Size of function is increased by 8 for Ftrace.
Signed-off-by: Akhilesh Kumar <akhilesh.lxr@gmail.com>
---
 arch/mips/kernel/process.c |   67
++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 7955409..df72738 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -290,12 +290,45 @@  static inline int is_sp_move_ins(union
mips_instruction *ip)
  return 0;
 }
+#ifdef CONFIG_DYNAMIC_FTRACE
+/*
+ * To create the jal <> instruction from mcount.
+ * taken from:
+ * - arch/mips/kernel/ftrace.c
+ */
+#define ADDR_MASK 0x03ffffff    /*  op_code|addr : 31...26|25 ....0 */
+#define JAL 0x0c000000      /* jump & link: ip --> ra, jump to target */
+#define INSN_JAL(addr)  \
+      ((unsigned int)(JAL | (((addr) >> 2) & ADDR_MASK)))
+
+/*
+ * We assume jal <mcount>/<ftrace_caller> to be present in
+ * first JAL_MAX_OFFSET instructions.
+ * Increment this, if its otherwise
+ */
+#define JAL_MAX_OFFSET 16U
+#define MCOUNT_STACK_INST 0x27bdfff8 /* addiu   sp,sp,-8 */
+
+/*
+ * If Dynamic Ftrace is enabled, ftrace_caller is the trace function.
+ * Otherwise its - mcount
+ */
+extern void  ftrace_caller(void);
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
 static int get_frame_info(struct mips_frame_info *info)
 {
  union mips_instruction *ip = info->func;
  unsigned max_insns = info->func_size / sizeof(union mips_instruction);
  unsigned i;
+#ifdef CONFIG_DYNAMIC_FTRACE
+ unsigned max_prolog_inst = max_insns;
+ int jal_found = 0;
+ /* instruction corresponding to jal <_mcount>/<ftrace_caller> */
+ int jal_mcount = 0;
+#endif
+
  info->pc_offset = -1;
  info->frame_size = 0;

--e89a8ff1c89c74179f04c6d58d84
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><span>Hi Ralf,</span></div>
<div><span></span><br>=A0</div><span></span>
<div><span>Sub:- Bug =A0unable to retrive=A0backtrace when <span>HAVE_FUNCT=
ION_TRACER is enable.</span><br></span></div>
<div><span>I send this bug and bug fix long back,=A0I am resending this pat=
ch again=A0for review. </span></div>
<div><span>=A0</span></div>
<div>Please review below patch if you agree I will regenerate this patch an=
d with you.</div>
<div><br>=3D=3D=3D=3D[ backtrace testing ]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>Testing a backtrace from process context.<br>The following trace is a k=
ernel self test and not a bug!<br>Testing a backtrace.<br>The following tra=
ce is a kernel self test and not a bug!<br>

Call Trace:<br>[&lt;80295134&gt;] dump_stack+0x8/0x34<br>[&lt;c0946060&gt;]=
 backtrace_regression_test+0x60/0x94 [sisc_backtrcae]<br>[&lt;800004f0&gt;]=
 do_one_initcall+0xf0/0x1d0<br>[&lt;80060954&gt;] sys_init_module+0x19c8/0x=
1c60<br>

[&lt;8000a418&gt;] stack_done+0x20/0x40</div>
<div>output befor patch when HAVE_FUNCTION_TRACER is enable<br>------------=
---------------------------------------------------------<br>#&gt; insmod b=
acktrace.ko<br>=3D=3D=3D=3D[ backtrace testing ]=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>Testing a backtrace from process context.<br>

The following trace is a kernel self test and not a bug!<br>Testing a backt=
race.<br>The following trace is a kernel self test and not a bug!<br>Call T=
race:<br>[&lt;802e5164&gt;] dump_stack+0x1c/0x50<br>[&lt;802e5164&gt;] dump=
_stack+0x1c/0x50<br>

=3D=3D=3D=3D[ end of backtrace testing ]=3D=3D=3D=3D<br>-------------------=
-----------------------------------<br>above shows the wrong back trcae</di=
v>
<div>output after patch when HAVE_FUNCTION_TRACER is enable<br>------------=
----------------------------------------------------------<br>=3D=3D=3D=3D[=
 backtrace testing ]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Testing a backtrac=
e from process context.<br>

The following trace is a kernel self test and not a bug!<br>Testing a backt=
race.<br>The following trace is a kernel self test and not a bug!<br>Call T=
race:<br>[&lt;802eb1a4&gt;] dump_stack+0x20/0x54<br>[&lt;c003405c&gt;] back=
trace_test_timer+0x5c/0x74 [sisc_backtrcae]<br>

[&lt;c00340dc&gt;] init_module+0x68/0xa0 [sisc_backtrcae]<br>[&lt;80000508&=
gt;] do_one_initcall+0x108/0x1f0<br>[&lt;8006d4c4&gt;] sys_init_module+0x1a=
10/0x1c74<br>[&lt;8000b038&gt;] stack_done+0x20/0x40<br>-------------------=
-----------------------------------------------</div>


<div>get_frame_info() is used to fetch the frame information from the<br>fu=
nction.<br>However,<br>1. this function just considers the first stack adju=
stment for frame<br>size.<br>2. On finding the save_lr instruction, it retu=
rns.<br>

It doesn&#39;t handle the ftrace condition.</div>
<div>If Dynamic Frace &quot;CONFIG_DYNAMIC_FTRACE&quot; is enabled, the ins=
trumentation<br>code is:<br>=A0- jal &lt;ftrace_caller&gt;<br>=A0- addiu sp=
,sp,-8<br>Thus, the current Frame Size of function is increased by 8 for Ft=
race.</div>


<div>Signed-off-by: Akhilesh Kumar &lt;<a href=3D"mailto:akhilesh.lxr@gmail=
.com" target=3D"_blank">akhilesh.lxr@gmail.com</a>&gt;</div>
<div>---<br>=A0arch/mips/kernel/process.c |=A0=A0 67<br>+++++++++++++++++++=
+++++++++++++++++++++++++<br>=A01 files changed, 67 insertions(+), 0 deleti=
ons(-)</div>
<div>diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c<b=
r>index 7955409..df72738 100644<br>--- a/arch/mips/kernel/process.c<br>+++ =
b/arch/mips/kernel/process.c<br>@@ -290,12 +290,45 @@=A0 static inline int =
is_sp_move_ins(union<br>

mips_instruction *ip)<br>=A0 return 0;<br>=A0}</div>
<div>+#ifdef CONFIG_DYNAMIC_FTRACE<br>+/*<br>+ * To create the jal &lt;&gt;=
 instruction from mcount.<br>+ * taken from:<br>+ * - arch/mips/kernel/ftra=
ce.c<br>+ */<br>+#define ADDR_MASK 0x03ffffff=A0=A0=A0 /*=A0 op_code|addr :=
 31...26|25 ....0 */<br>

+#define JAL 0x0c000000=A0=A0=A0=A0=A0 /* jump &amp; link: ip --&gt; ra, ju=
mp to target */<br>+#define INSN_JAL(addr)=A0 \<br>+=A0=A0=A0=A0=A0 ((unsig=
ned int)(JAL | (((addr) &gt;&gt; 2) &amp; ADDR_MASK)))<br>+<br>+/*<br>+ * W=
e assume jal &lt;mcount&gt;/&lt;ftrace_caller&gt; to be present in<br>

+ * first JAL_MAX_OFFSET instructions.<br>+ * Increment this, if its otherw=
ise<br>+ */<br>+#define JAL_MAX_OFFSET 16U<br>+#define MCOUNT_STACK_INST 0x=
27bdfff8 /* addiu=A0=A0 sp,sp,-8 */<br>+<br>+/*<br>+ * If Dynamic Ftrace is=
 enabled, ftrace_caller is the trace function.<br>

+ * Otherwise its - mcount<br>+ */<br>+extern void=A0 ftrace_caller(void);<=
br>+#endif /* CONFIG_DYNAMIC_FTRACE */<br>+<br>=A0static int get_frame_info=
(struct mips_frame_info *info)<br>=A0{<br>=A0 union mips_instruction *ip =
=3D info-&gt;func;<br>

=A0 unsigned max_insns =3D info-&gt;func_size / sizeof(union mips_instructi=
on);<br>=A0 unsigned i;</div>
<div>+#ifdef CONFIG_DYNAMIC_FTRACE<br>+ unsigned max_prolog_inst =3D max_in=
sns;<br>+ int jal_found =3D 0;<br>+ /* instruction corresponding to jal &lt=
;_mcount&gt;/&lt;ftrace_caller&gt; */<br>+ int jal_mcount =3D 0;<br>+#endif=
<br>

+<br>=A0 info-&gt;pc_offset =3D -1;<br>=A0 info-&gt;frame_size =3D 0;</div>

--e89a8ff1c89c74179f04c6d58d84--
