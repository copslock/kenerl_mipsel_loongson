Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 May 2012 04:34:58 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42062 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901173Ab2EECes (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 May 2012 04:34:48 +0200
Received: by pbbrq13 with SMTP id rq13so4857562pbb.36
        for <multiple recipients>; Fri, 04 May 2012 19:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3WUHQpWbs1HjdE4GKU91P5G6N6cMU8eGXmV2sUy3KNs=;
        b=PqRTpT3m1OmpXRQwvwzRFEAFj1BVsMra8uYqgYJaIa71HqSwCeIZ2RhLzPRRMBu/gk
         +1g7ynWcefuWm7dgclKxpz7yuDtd78NRooIchByLlJiGzM4AqL21RS5z4uGhJMEFyktj
         SmSDiujsHaCS8iuQf+jU2UGB10DE6UdSkDS8CGWlwkH52EltHJIIuR9XTGVDJ5ShgFor
         w8i/VUjBrkwTBU/xNopa2fSdLdCjQDX3on3jZs1LL+J0cS7WeAO9HadMaMnheQyQ8Q62
         o91k5bXdtbCWfBvzs5nF0Uek4mZMmdp7op1siKV6rby5krkUc3zslbzyeCbfnU1BVW6n
         AsVQ==
MIME-Version: 1.0
Received: by 10.68.220.134 with SMTP id pw6mr23804500pbc.149.1336185281291;
 Fri, 04 May 2012 19:34:41 -0700 (PDT)
Received: by 10.66.14.228 with HTTP; Fri, 4 May 2012 19:34:41 -0700 (PDT)
In-Reply-To: <CADArhcC6qnGh-yb5=zqctTVBV9AXRyvov+TsLqg_8agoxSk=7Q@mail.gmail.com>
References: <CADArhcC6qnGh-yb5=zqctTVBV9AXRyvov+TsLqg_8agoxSk=7Q@mail.gmail.com>
Date:   Sat, 5 May 2012 08:04:41 +0530
Message-ID: <CADArhcC_uFZvJuV110Z3TZziqZVcZHZUeLT9xGHR+mg89_ah=w@mail.gmail.com>
Subject: Re: [Bug-fix] Fix-the-backtrcae-problem-Ftrace is enable
From:   Akhilesh Kumar <akhilesh.lxr@gmail.com>
To:     ralf@linux-mips.org, paulmck@linux.vnet.ibm.com,
        fweisbec@gmail.com, paul.gortmaker@windriver.com,
        josh@joshtriplett.org, gergely@homejinni.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary=047d7b2e4f620ba56504bf40e181
X-archive-position: 33161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akhilesh.lxr@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--047d7b2e4f620ba56504bf40e181
Content-Type: multipart/alternative; boundary=047d7b2e4f620ba55f04bf40e17f

--047d7b2e4f620ba55f04bf40e17f
Content-Type: text/plain; charset=ISO-8859-1

>
> Hi Ralf,
>
> When ftrace is used, unwind_stack() is unable to retrieve the frame info
> and call-trace doesn't work. Please find the bug fix patch when
> HAVE_FUNCTION_TRACER is enable.
>
> Please comment.
>
>
>
>
> From 89004f88a1f8399be7a856b43b475f06c3d5bb30 Mon Sep 17 00:00:00 2001
> From:  Akhilesh Kumar <akhilesh.lxr@gmail.com>
> Date: Fri, 4 May 2012 18:52:46 +0530
> Subject: [PATCH 1/1] Patch fix the backtrcae  problem using unwind_stack())
> When ftrace is used, unwind_stack() is unable to retrieve the frame info
> and call-trace doesn't work.
>
> test module
> ----------------
> static struct timer_list backtrace_timer;
> static void backtrace_test_timer(unsigned long data)
> {
>         printk("Testing a backtrace from irq context.\n");
>         printk("The following trace is a kernel self test and not a
> bug!\n");
>         dump_stack();
> }
> static int backtrace_regression_test(void)
> {
>         printk("====[ backtrace testing ]===========\n");
>         printk("Testing a backtrace from process context.\n");
>         printk("The following trace is a kernel self test and not a
> bug!\n");
>         dump_stack();
>
>         init_timer(&backtrace_timer);
>         backtrace_timer.function = backtrace_test_timer;
>         mod_timer(&backtrace_timer, jiffies + 10);
>
>         msleep(10);
>         printk("====[ end of backtrace testing ]====\n");
>         return 0;
> }
> static void exitf(void)
> {
> }
> module_init(backtrace_regression_test);
> module_exit(exitf);
> MODULE_LICENSE("GPL");
> ---------------------------------------------------------------------
> out put when HAVE_FUNCTION_TRACER is disable
>
> ====[ backtrace testing ]===========
> Testing a backtrace from process context.
> The following trace is a kernel self test and not a bug!
> Testing a backtrace.
> The following trace is a kernel self test and not a bug!
> Call Trace:
> [<80295134>] dump_stack+0x8/0x34
> [<c0946060>] backtrace_regression_test+0x60/0x94 [sisc_backtrcae]
> [<800004f0>] do_one_initcall+0xf0/0x1d0
> [<80060954>] sys_init_module+0x19c8/0x1c60
> [<8000a418>] stack_done+0x20/0x40
>
> output befor patch when HAVE_FUNCTION_TRACER is enable
> ---------------------------------------------------------------------
> VDLinux#> insmod sisc_backtrcae.ko
> ====[ backtrace testing ]===========
> Testing a backtrace from process context.
> The following trace is a kernel self test and not a bug!
> Testing a backtrace.
> The following trace is a kernel self test and not a bug!
> Call Trace:
> [<802e5164>] dump_stack+0x1c/0x50
> [<802e5164>] dump_stack+0x1c/0x50
> ====[ end of backtrace testing ]====
> ------------------------------------------------------
> above shows the wrong back trcae
>
> output after patch when HAVE_FUNCTION_TRACER is enable
> ----------------------------------------------------------------------
> ====[ backtrace testing ]===========
> Testing a backtrace from process context.
> The following trace is a kernel self test and not a bug!
> Testing a backtrace.
> The following trace is a kernel self test and not a bug!
> Call Trace:
> [<802eb1a4>] dump_stack+0x20/0x54
> [<c003405c>] backtrace_test_timer+0x5c/0x74 [sisc_backtrcae]
> [<c00340dc>] init_module+0x68/0xa0 [sisc_backtrcae]
> [<80000508>] do_one_initcall+0x108/0x1f0
> [<8006d4c4>] sys_init_module+0x1a10/0x1c74
> [<8000b038>] stack_done+0x20/0x40
> ------------------------------------------------------------------
>
> get_frame_info() is used to fetch the frame information from the
> function.
> However,
> 1. this function just considers the first stack adjustment for frame
> size.
> 2. On finding the save_lr instruction, it returns.
> It doesn't handle the ftrace condition.
>
> If Dynamic Frace "CONFIG_DYNAMIC_FTRACE" is enabled, the instrumentation
> code is:
>  - jal <ftrace_caller>
>  - addiu sp,sp,-8
> Thus, the current Frame Size of function is increased by 8 for Ftrace.
>
> Signed-off-by: Akhilesh Kumar <akhilesh.lxr@gmail.com>
> Signed-off-by: Himanshu Maithani <hmaithani@gmail.com>
> ---
>  arch/mips/kernel/process.c |   67
> ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 67 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 7955409..df72738 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -290,12 +290,45 @@ static inline int is_sp_move_ins(union
> mips_instruction *ip)
>   return 0;
>  }
>
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +/*
> + * To create the jal <> instruction from mcount.
> + * taken from:
> + * - arch/mips/kernel/ftrace.c
> + */
> +#define ADDR_MASK 0x03ffffff    /*  op_code|addr : 31...26|25 ....0 */
> +#define JAL 0x0c000000      /* jump & link: ip --> ra, jump to target */
> +#define INSN_JAL(addr)  \
> +      ((unsigned int)(JAL | (((addr) >> 2) & ADDR_MASK)))
> +
> +/*
> + * We assume jal <mcount>/<ftrace_caller> to be present in
> + * first JAL_MAX_OFFSET instructions.
> + * Increment this, if its otherwise
> + */
> +#define JAL_MAX_OFFSET 16U
> +#define MCOUNT_STACK_INST 0x27bdfff8 /* addiu   sp,sp,-8 */
> +
> +/*
> + * If Dynamic Ftrace is enabled, ftrace_caller is the trace function.
> + * Otherwise its - mcount
> + */
> +extern void  ftrace_caller(void);
> +#endif /* CONFIG_DYNAMIC_FTRACE */
> +
>  static int get_frame_info(struct mips_frame_info *info)
>  {
>   union mips_instruction *ip = info->func;
>   unsigned max_insns = info->func_size / sizeof(union mips_instruction);
>   unsigned i;
>
> +#ifdef CONFIG_DYNAMIC_FTRACE
> + unsigned max_prolog_inst = max_insns;
> + int jal_found = 0;
> + /* instruction corresponding to jal <_mcount>/<ftrace_caller> */
> + int jal_mcount = 0;
> +#endif
> +
>   info->pc_offset = -1;
>   info->frame_size = 0;
>
> @@ -306,6 +339,28 @@ static int get_frame_info(struct mips_frame_info
> *info)
>    max_insns = 128U; /* unknown function size */
>   max_insns = min(128U, max_insns);
>
> +#ifdef CONFIG_DYNAMIC_FTRACE
> + max_prolog_inst = min(JAL_MAX_OFFSET, max_prolog_inst);
> + jal_mcount = INSN_JAL((unsigned)&ftrace_caller);
> +
> + for (i = 0; i < max_prolog_inst; i++, ip++) {
> +  if ((*(int *)ip == jal_mcount) ||
> +    /*
> +     * for dyn ftrace, the code initially has 0.
> +     * so we check whether the next instruction is
> +     * addiu   sp,sp,-8
> +     */
> +    (!(*(int *)ip) &&
> +     (*(int *)(ip + 1) == MCOUNT_STACK_INST))
> +     ) {
> +   jal_found = 1;
> +   break;
> +  }
> + }
> + /* restore the ip to start of function */
> + ip = info->func;
> +#endif
> +
>   for (i = 0; i < max_insns; i++, ip++) {
>
>    if (is_jal_jalr_jr_ins(ip))
> @@ -321,6 +376,18 @@ static int get_frame_info(struct mips_frame_info
> *info)
>     break;
>    }
>   }
> +#ifdef CONFIG_DYNAMIC_FTRACE
> + /*
> +  * to offset the effect of:
> +  * addiu   sp,sp,-8
> +  */
> + if (jal_found) {
> +  if (info->frame_size)
> +   info->frame_size += 8;
> +  if (info->pc_offset >= 0)
> +   info->pc_offset += 8 / sizeof(long);
> + }
> +#endif
>   if (info->frame_size && info->pc_offset >= 0) /* nested */
>    return 0;
>   if (info->pc_offset < 0) /* leaf */
> --
> 1.7.8.4
>
>

--047d7b2e4f620ba55f04bf40e17f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>Hi Ralf,=A0<=
/div><div>=A0</div><div>When ftrace is used, unwind_stack() is unable to re=
trieve the frame info</div>
<div>and call-trace doesn&#39;t work. Please find the bug fix patch when HA=
VE_FUNCTION_TRACER is enable.=A0</div><div><br></div><div>Please comment.</=
div><div><br></div><div>=A0</div><div>=A0</div><div>=A0=A0</div><div>From 8=
9004f88a1f8399be7a856b43b475f06c3d5bb30 Mon Sep 17 00:00:00 2001</div>
<div>From: =A0Akhilesh Kumar &lt;<a href=3D"mailto:akhilesh.lxr@gmail.com">=
akhilesh.lxr@gmail.com</a>&gt;</div><div>Date: Fri, 4 May 2012 18:52:46 +05=
30</div><div>Subject: [PATCH 1/1] Patch fix the backtrcae =A0problem using =
unwind_stack())</div>
<div>When ftrace is used, unwind_stack() is unable to retrieve the frame in=
fo</div><div>and call-trace doesn&#39;t work.</div><div><br></div><div>test=
 module</div><div>----------------</div><div>static struct timer_list backt=
race_timer;</div>
<div>static void backtrace_test_timer(unsigned long data)</div><div>{</div>=
<div>=A0 =A0 =A0 =A0 printk(&quot;Testing a backtrace from irq context.\n&q=
uot;);</div><div>=A0 =A0 =A0 =A0 printk(&quot;The following trace is a kern=
el self test and not a</div>
<div>bug!\n&quot;);</div><div>=A0 =A0 =A0 =A0 dump_stack();</div><div>}</di=
v><div>static int backtrace_regression_test(void)</div><div>{</div><div>=A0=
 =A0 =A0 =A0 printk(&quot;=3D=3D=3D=3D[ backtrace testing ]=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D\n&quot;);</div><div>=A0 =A0 =A0 =A0 printk(&quot;Testing=
 a backtrace from process context.\n&quot;);</div>
<div>=A0 =A0 =A0 =A0 printk(&quot;The following trace is a kernel self test=
 and not a</div><div>bug!\n&quot;);</div><div>=A0 =A0 =A0 =A0 dump_stack();=
</div><div><br></div><div>=A0 =A0 =A0 =A0 init_timer(&amp;backtrace_timer);=
</div><div>=A0 =A0 =A0 =A0 backtrace_timer.function =3D backtrace_test_time=
r;</div>
<div>=A0 =A0 =A0 =A0 mod_timer(&amp;backtrace_timer, jiffies + 10);</div><d=
iv><br></div><div>=A0 =A0 =A0 =A0 msleep(10);</div><div>=A0 =A0 =A0 =A0 pri=
ntk(&quot;=3D=3D=3D=3D[ end of backtrace testing ]=3D=3D=3D=3D\n&quot;);</d=
iv><div>=A0 =A0 =A0 =A0 return 0;</div><div>
}</div><div>static void exitf(void)</div><div>{</div><div>}</div><div>modul=
e_init(backtrace_regression_test);</div><div>module_exit(exitf);</div><div>=
MODULE_LICENSE(&quot;GPL&quot;);</div><div>--------------------------------=
-------------------------------------</div>
<div>out put when HAVE_FUNCTION_TRACER is disable</div><div><br></div><div>=
=3D=3D=3D=3D[ backtrace testing ]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><di=
v>Testing a backtrace from process context.</div><div>The following trace i=
s a kernel self test and not a bug!</div>
<div>Testing a backtrace.</div><div>The following trace is a kernel self te=
st and not a bug!</div><div>Call Trace:</div><div>[&lt;80295134&gt;] dump_s=
tack+0x8/0x34</div><div>[&lt;c0946060&gt;] backtrace_regression_test+0x60/0=
x94 [sisc_backtrcae]</div>
<div>[&lt;800004f0&gt;] do_one_initcall+0xf0/0x1d0</div><div>[&lt;80060954&=
gt;] sys_init_module+0x19c8/0x1c60</div><div>[&lt;8000a418&gt;] stack_done+=
0x20/0x40</div><div><br></div><div>output befor patch when HAVE_FUNCTION_TR=
ACER is enable</div>
<div>---------------------------------------------------------------------<=
/div><div>VDLinux#&gt; insmod sisc_backtrcae.ko</div><div>=3D=3D=3D=3D[ bac=
ktrace testing ]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>Testing a backt=
race from process context.</div>
<div>The following trace is a kernel self test and not a bug!</div><div>Tes=
ting a backtrace.</div><div>The following trace is a kernel self test and n=
ot a bug!</div><div>Call Trace:</div><div>[&lt;802e5164&gt;] dump_stack+0x1=
c/0x50</div>
<div>[&lt;802e5164&gt;] dump_stack+0x1c/0x50</div><div>=3D=3D=3D=3D[ end of=
 backtrace testing ]=3D=3D=3D=3D</div><div>--------------------------------=
----------------------</div><div>above shows the wrong back trcae</div><div=
><br></div><div>
output after patch when HAVE_FUNCTION_TRACER is enable</div><div>----------=
------------------------------------------------------------</div><div>=3D=
=3D=3D=3D[ backtrace testing ]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>T=
esting a backtrace from process context.</div>
<div>The following trace is a kernel self test and not a bug!</div><div>Tes=
ting a backtrace.</div><div>The following trace is a kernel self test and n=
ot a bug!</div><div>Call Trace:</div><div>[&lt;802eb1a4&gt;] dump_stack+0x2=
0/0x54</div>
<div>[&lt;c003405c&gt;] backtrace_test_timer+0x5c/0x74 [sisc_backtrcae]</di=
v><div>[&lt;c00340dc&gt;] init_module+0x68/0xa0 [sisc_backtrcae]</div><div>=
[&lt;80000508&gt;] do_one_initcall+0x108/0x1f0</div><div>[&lt;8006d4c4&gt;]=
 sys_init_module+0x1a10/0x1c74</div>
<div>[&lt;8000b038&gt;] stack_done+0x20/0x40</div><div>--------------------=
----------------------------------------------</div><div><br></div><div>get=
_frame_info() is used to fetch the frame information from the</div><div>
function.</div><div>However,</div><div>1. this function just considers the =
first stack adjustment for frame</div><div>size.</div><div>2. On finding th=
e save_lr instruction, it returns.</div><div>It doesn&#39;t handle the ftra=
ce condition.</div>
<div><br></div><div>If Dynamic Frace &quot;CONFIG_DYNAMIC_FTRACE&quot; is e=
nabled, the instrumentation code is:</div><div>=A0- jal &lt;ftrace_caller&g=
t;</div><div>=A0- addiu sp,sp,-8</div><div>Thus, the current Frame Size of =
function is increased by 8 for Ftrace.</div>
<div><br></div><div>Signed-off-by: Akhilesh Kumar &lt;<a href=3D"mailto:akh=
ilesh.lxr@gmail.com">akhilesh.lxr@gmail.com</a>&gt;</div><div>Signed-off-by=
: Himanshu Maithani &lt;<a href=3D"mailto:hmaithani@gmail.com">hmaithani@gm=
ail.com</a>&gt;</div>
<div>---</div><div>=A0arch/mips/kernel/process.c | =A0 67 +++++++++++++++++=
+++++++++++++++++++++++++++</div><div>=A01 files changed, 67 insertions(+),=
 0 deletions(-)</div><div><br></div><div>diff --git a/arch/mips/kernel/proc=
ess.c b/arch/mips/kernel/process.c</div>
<div>index 7955409..df72738 100644</div><div>--- a/arch/mips/kernel/process=
.c</div><div>+++ b/arch/mips/kernel/process.c</div><div>@@ -290,12 +290,45 =
@@ static inline int is_sp_move_ins(union mips_instruction *ip)</div><div>
=A0 return 0;</div><div>=A0}</div><div>=A0</div><div>+#ifdef CONFIG_DYNAMIC=
_FTRACE</div><div>+/*</div><div>+ * To create the jal &lt;&gt; instruction =
from mcount.</div><div>+ * taken from:</div><div>+ * - arch/mips/kernel/ftr=
ace.c</div>
<div>+ */</div><div>+#define ADDR_MASK 0x03ffffff =A0 =A0/* =A0op_code|addr=
 : 31...26|25 ....0 */</div><div>+#define JAL 0x0c000000 =A0 =A0 =A0/* jump=
 &amp; link: ip --&gt; ra, jump to target */</div><div>+#define INSN_JAL(ad=
dr) =A0\</div>
<div>+ =A0 =A0 =A0((unsigned int)(JAL | (((addr) &gt;&gt; 2) &amp; ADDR_MAS=
K)))</div><div>+</div><div>+/*</div><div>+ * We assume jal &lt;mcount&gt;/&=
lt;ftrace_caller&gt; to be present in</div><div>+ * first JAL_MAX_OFFSET in=
structions.</div>
<div>+ * Increment this, if its otherwise</div><div>+ */</div><div>+#define=
 JAL_MAX_OFFSET 16U</div><div>+#define MCOUNT_STACK_INST 0x27bdfff8 /* addi=
u =A0 sp,sp,-8 */</div><div>+</div><div>+/*</div><div>+ * If Dynamic Ftrace=
 is enabled, ftrace_caller is the trace function.</div>
<div>+ * Otherwise its - mcount</div><div>+ */</div><div>+extern void =A0ft=
race_caller(void);</div><div>+#endif /* CONFIG_DYNAMIC_FTRACE */</div><div>=
+</div><div>=A0static int get_frame_info(struct mips_frame_info *info)</div=
>
<div>=A0{</div><div>=A0 union mips_instruction *ip =3D info-&gt;func;</div>=
<div>=A0 unsigned max_insns =3D info-&gt;func_size / sizeof(union mips_inst=
ruction);</div><div>=A0 unsigned i;</div><div>=A0</div><div>+#ifdef CONFIG_=
DYNAMIC_FTRACE</div>
<div>+ unsigned max_prolog_inst =3D max_insns;</div><div>+ int jal_found =
=3D 0;</div><div>+ /* instruction corresponding to jal &lt;_mcount&gt;/&lt;=
ftrace_caller&gt; */</div><div>+ int jal_mcount =3D 0;</div><div>+#endif</d=
iv><div>
+</div><div>=A0 info-&gt;pc_offset =3D -1;</div><div>=A0 info-&gt;frame_siz=
e =3D 0;</div><div>=A0</div><div>@@ -306,6 +339,28 @@ static int get_frame_=
info(struct mips_frame_info *info)</div><div>=A0 =A0max_insns =3D 128U; /* =
unknown function size */</div>
<div>=A0 max_insns =3D min(128U, max_insns);</div><div>=A0</div><div>+#ifde=
f CONFIG_DYNAMIC_FTRACE</div><div>+ max_prolog_inst =3D min(JAL_MAX_OFFSET,=
 max_prolog_inst);</div><div>+ jal_mcount =3D INSN_JAL((unsigned)&amp;ftrac=
e_caller);</div>
<div>+</div><div>+ for (i =3D 0; i &lt; max_prolog_inst; i++, ip++) {</div>=
<div>+ =A0if ((*(int *)ip =3D=3D jal_mcount) ||</div><div>+ =A0 =A0/*</div>=
<div>+ =A0 =A0 * for dyn ftrace, the code initially has 0.</div><div>+ =A0 =
=A0 * so we check whether the next instruction is</div>
<div>+ =A0 =A0 * addiu =A0 sp,sp,-8</div><div>+ =A0 =A0 */</div><div>+ =A0 =
=A0(!(*(int *)ip) &amp;&amp;</div><div>+ =A0 =A0 (*(int *)(ip + 1) =3D=3D M=
COUNT_STACK_INST))</div><div>+ =A0 =A0 ) {</div><div>+ =A0 jal_found =3D 1;=
</div><div>+ =A0 break;</div>
<div>+ =A0}</div><div>+ }</div><div>+ /* restore the ip to start of functio=
n */</div><div>+ ip =3D info-&gt;func;</div><div>+#endif</div><div>+</div><=
div>=A0 for (i =3D 0; i &lt; max_insns; i++, ip++) {</div><div>=A0</div><di=
v>=A0 =A0if (is_jal_jalr_jr_ins(ip))</div>
<div>@@ -321,6 +376,18 @@ static int get_frame_info(struct mips_frame_info =
*info)</div><div>=A0 =A0 break;</div><div>=A0 =A0}</div><div>=A0 }</div><di=
v>+#ifdef CONFIG_DYNAMIC_FTRACE</div><div>+ /*</div><div>+ =A0* to offset t=
he effect of:</div>
<div>+ =A0* addiu =A0 sp,sp,-8</div><div>+ =A0*/</div><div>+ if (jal_found)=
 {</div><div>+ =A0if (info-&gt;frame_size)</div><div>+ =A0 info-&gt;frame_s=
ize +=3D 8;</div><div>+ =A0if (info-&gt;pc_offset &gt;=3D 0)</div><div>+ =
=A0 info-&gt;pc_offset +=3D 8 / sizeof(long);</div>
<div>+ }</div><div>+#endif</div><div>=A0 if (info-&gt;frame_size &amp;&amp;=
 info-&gt;pc_offset &gt;=3D 0) /* nested */</div><div>=A0 =A0return 0;</div=
><div>=A0 if (info-&gt;pc_offset &lt; 0) /* leaf */</div><div>--=A0</div><d=
iv>1.7.8.4</div>
<div><br></div>
</blockquote></div><br>

--047d7b2e4f620ba55f04bf40e17f--
--047d7b2e4f620ba56504bf40e181
Content-Type: application/octet-stream; 
	name="0001-Patch-fix-the-backtrcae-problem-using-unwind_stack.patch"
Content-Disposition: attachment; 
	filename="0001-Patch-fix-the-backtrcae-problem-using-unwind_stack.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h1u26ni81

RnJvbSA4OTAwNGY4OGExZjgzOTliZTdhODU2YjQzYjQ3NWYwNmMzZDViYjMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAgQWtoaWxlc2ggS3VtYXIgPGFraGlsZXNoLmx4ckBnbWFpbC5j
b20+CkRhdGU6IEZyaSwgNCBNYXkgMjAxMiAxODo1Mjo0NiArMDUzMApTdWJqZWN0OiBbUEFUQ0gg
MS8xXSBQYXRjaCBmaXggdGhlIGJhY2t0cmNhZSAgcHJvYmxlbSB1c2luZyB1bndpbmRfc3RhY2so
KSkKCldoZW4gZnRyYWNlIGlzIHVzZWQsIHVud2luZF9zdGFjaygpIGlzIHVuYWJsZSB0byByZXRy
aWV2ZSB0aGUgZnJhbWUgaW5mbwphbmQgY2FsbC10cmFjZSBkb2Vzbid0IHdvcmsuCgp0ZXN0IG1v
ZHVsZQotLS0tLS0tLS0tLS0tLS0tCnN0YXRpYyBzdHJ1Y3QgdGltZXJfbGlzdCBiYWNrdHJhY2Vf
dGltZXI7CnN0YXRpYyB2b2lkIGJhY2t0cmFjZV90ZXN0X3RpbWVyKHVuc2lnbmVkIGxvbmcgZGF0
YSkKewogICAgICAgIHByaW50aygiVGVzdGluZyBhIGJhY2t0cmFjZSBmcm9tIGlycSBjb250ZXh0
LlxuIik7CiAgICAgICAgcHJpbnRrKCJUaGUgZm9sbG93aW5nIHRyYWNlIGlzIGEga2VybmVsIHNl
bGYgdGVzdCBhbmQgbm90IGEKYnVnIVxuIik7CiAgICAgICAgZHVtcF9zdGFjaygpOwp9CnN0YXRp
YyBpbnQgYmFja3RyYWNlX3JlZ3Jlc3Npb25fdGVzdCh2b2lkKQp7CiAgICAgICAgcHJpbnRrKCI9
PT09WyBiYWNrdHJhY2UgdGVzdGluZyBdPT09PT09PT09PT1cbiIpOwogICAgICAgIHByaW50aygi
VGVzdGluZyBhIGJhY2t0cmFjZSBmcm9tIHByb2Nlc3MgY29udGV4dC5cbiIpOwogICAgICAgIHBy
aW50aygiVGhlIGZvbGxvd2luZyB0cmFjZSBpcyBhIGtlcm5lbCBzZWxmIHRlc3QgYW5kIG5vdCBh
CmJ1ZyFcbiIpOwogICAgICAgIGR1bXBfc3RhY2soKTsKCiAgICAgICAgaW5pdF90aW1lcigmYmFj
a3RyYWNlX3RpbWVyKTsKICAgICAgICBiYWNrdHJhY2VfdGltZXIuZnVuY3Rpb24gPSBiYWNrdHJh
Y2VfdGVzdF90aW1lcjsKICAgICAgICBtb2RfdGltZXIoJmJhY2t0cmFjZV90aW1lciwgamlmZmll
cyArIDEwKTsKCiAgICAgICAgbXNsZWVwKDEwKTsKICAgICAgICBwcmludGsoIj09PT1bIGVuZCBv
ZiBiYWNrdHJhY2UgdGVzdGluZyBdPT09PVxuIik7CiAgICAgICAgcmV0dXJuIDA7Cn0Kc3RhdGlj
IHZvaWQgZXhpdGYodm9pZCkKewp9Cm1vZHVsZV9pbml0KGJhY2t0cmFjZV9yZWdyZXNzaW9uX3Rl
c3QpOwptb2R1bGVfZXhpdChleGl0Zik7Ck1PRFVMRV9MSUNFTlNFKCJHUEwiKTsKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCm91dCBwdXQgd2hlbiBIQVZFX0ZVTkNUSU9OX1RSQUNFUiBpcyBkaXNhYmxlCgo9PT09WyBi
YWNrdHJhY2UgdGVzdGluZyBdPT09PT09PT09PT0KVGVzdGluZyBhIGJhY2t0cmFjZSBmcm9tIHBy
b2Nlc3MgY29udGV4dC4KVGhlIGZvbGxvd2luZyB0cmFjZSBpcyBhIGtlcm5lbCBzZWxmIHRlc3Qg
YW5kIG5vdCBhIGJ1ZyEKVGVzdGluZyBhIGJhY2t0cmFjZS4KVGhlIGZvbGxvd2luZyB0cmFjZSBp
cyBhIGtlcm5lbCBzZWxmIHRlc3QgYW5kIG5vdCBhIGJ1ZyEKQ2FsbCBUcmFjZToKWzw4MDI5NTEz
ND5dIGR1bXBfc3RhY2srMHg4LzB4MzQKWzxjMDk0NjA2MD5dIGJhY2t0cmFjZV9yZWdyZXNzaW9u
X3Rlc3QrMHg2MC8weDk0IFtzaXNjX2JhY2t0cmNhZV0KWzw4MDAwMDRmMD5dIGRvX29uZV9pbml0
Y2FsbCsweGYwLzB4MWQwCls8ODAwNjA5NTQ+XSBzeXNfaW5pdF9tb2R1bGUrMHgxOWM4LzB4MWM2
MApbPDgwMDBhNDE4Pl0gc3RhY2tfZG9uZSsweDIwLzB4NDAKCm91dHB1dCBiZWZvciBwYXRjaCB3
aGVuIEhBVkVfRlVOQ1RJT05fVFJBQ0VSIGlzIGVuYWJsZQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVkRMaW51eCM+
IGluc21vZCBzaXNjX2JhY2t0cmNhZS5rbwo9PT09WyBiYWNrdHJhY2UgdGVzdGluZyBdPT09PT09
PT09PT0KVGVzdGluZyBhIGJhY2t0cmFjZSBmcm9tIHByb2Nlc3MgY29udGV4dC4KVGhlIGZvbGxv
d2luZyB0cmFjZSBpcyBhIGtlcm5lbCBzZWxmIHRlc3QgYW5kIG5vdCBhIGJ1ZyEKVGVzdGluZyBh
IGJhY2t0cmFjZS4KVGhlIGZvbGxvd2luZyB0cmFjZSBpcyBhIGtlcm5lbCBzZWxmIHRlc3QgYW5k
IG5vdCBhIGJ1ZyEKQ2FsbCBUcmFjZToKWzw4MDJlNTE2ND5dIGR1bXBfc3RhY2srMHgxYy8weDUw
Cls8ODAyZTUxNjQ+XSBkdW1wX3N0YWNrKzB4MWMvMHg1MAo9PT09WyBlbmQgb2YgYmFja3RyYWNl
IHRlc3RpbmcgXT09PT0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCmFib3ZlIHNob3dzIHRoZSB3cm9uZyBiYWNrIHRyY2FlCgpvdXRwdXQgYWZ0
ZXIgcGF0Y2ggd2hlbiBIQVZFX0ZVTkNUSU9OX1RSQUNFUiBpcyBlbmFibGUKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo9PT09WyBiYWNrdHJhY2UgdGVzdGluZyBdPT09PT09PT09PT0KVGVzdGluZyBhIGJhY2t0cmFj
ZSBmcm9tIHByb2Nlc3MgY29udGV4dC4KVGhlIGZvbGxvd2luZyB0cmFjZSBpcyBhIGtlcm5lbCBz
ZWxmIHRlc3QgYW5kIG5vdCBhIGJ1ZyEKVGVzdGluZyBhIGJhY2t0cmFjZS4KVGhlIGZvbGxvd2lu
ZyB0cmFjZSBpcyBhIGtlcm5lbCBzZWxmIHRlc3QgYW5kIG5vdCBhIGJ1ZyEKQ2FsbCBUcmFjZToK
Wzw4MDJlYjFhND5dIGR1bXBfc3RhY2srMHgyMC8weDU0Cls8YzAwMzQwNWM+XSBiYWNrdHJhY2Vf
dGVzdF90aW1lcisweDVjLzB4NzQgW3Npc2NfYmFja3RyY2FlXQpbPGMwMDM0MGRjPl0gaW5pdF9t
b2R1bGUrMHg2OC8weGEwIFtzaXNjX2JhY2t0cmNhZV0KWzw4MDAwMDUwOD5dIGRvX29uZV9pbml0
Y2FsbCsweDEwOC8weDFmMApbPDgwMDZkNGM0Pl0gc3lzX2luaXRfbW9kdWxlKzB4MWExMC8weDFj
NzQKWzw4MDAwYjAzOD5dIHN0YWNrX2RvbmUrMHgyMC8weDQwCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKZ2V0X2ZyYW1l
X2luZm8oKSBpcyB1c2VkIHRvIGZldGNoIHRoZSBmcmFtZSBpbmZvcm1hdGlvbiBmcm9tIHRoZQpm
dW5jdGlvbi4KSG93ZXZlciwKMS4gdGhpcyBmdW5jdGlvbiBqdXN0IGNvbnNpZGVycyB0aGUgZmly
c3Qgc3RhY2sgYWRqdXN0bWVudCBmb3IgZnJhbWUKc2l6ZS4KMi4gT24gZmluZGluZyB0aGUgc2F2
ZV9sciBpbnN0cnVjdGlvbiwgaXQgcmV0dXJucy4KSXQgZG9lc24ndCBoYW5kbGUgdGhlIGZ0cmFj
ZSBjb25kaXRpb24uCgpJZiBEeW5hbWljIEZyYWNlICJDT05GSUdfRFlOQU1JQ19GVFJBQ0UiIGlz
IGVuYWJsZWQsIHRoZSBpbnN0cnVtZW50YXRpb24gY29kZSBpczoKIC0gamFsIDxmdHJhY2VfY2Fs
bGVyPgogLSBhZGRpdSBzcCxzcCwtOApUaHVzLCB0aGUgY3VycmVudCBGcmFtZSBTaXplIG9mIGZ1
bmN0aW9uIGlzIGluY3JlYXNlZCBieSA4IGZvciBGdHJhY2UuCgpTaWduZWQtb2ZmLWJ5OiBBa2hp
bGVzaCBLdW1hciA8YWtoaWxlc2gubHhyQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogSGltYW5z
aHUgTWFpdGhhbmkgPGhtYWl0aGFuaUBnbWFpbC5jb20+Ci0tLQogYXJjaC9taXBzL2tlcm5lbC9w
cm9jZXNzLmMgfCAgIDY3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCiAxIGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvYXJjaC9taXBzL2tlcm5lbC9wcm9jZXNzLmMgYi9hcmNoL21pcHMva2VybmVs
L3Byb2Nlc3MuYwppbmRleCA3OTU1NDA5Li5kZjcyNzM4IDEwMDY0NAotLS0gYS9hcmNoL21pcHMv
a2VybmVsL3Byb2Nlc3MuYworKysgYi9hcmNoL21pcHMva2VybmVsL3Byb2Nlc3MuYwpAQCAtMjkw
LDEyICsyOTAsNDUgQEAgc3RhdGljIGlubGluZSBpbnQgaXNfc3BfbW92ZV9pbnModW5pb24gbWlw
c19pbnN0cnVjdGlvbiAqaXApCiAJcmV0dXJuIDA7CiB9CiAKKyNpZmRlZiBDT05GSUdfRFlOQU1J
Q19GVFJBQ0UKKy8qCisgKiBUbyBjcmVhdGUgdGhlIGphbCA8PiBpbnN0cnVjdGlvbiBmcm9tIG1j
b3VudC4KKyAqIHRha2VuIGZyb206CisgKiAtIGFyY2gvbWlwcy9rZXJuZWwvZnRyYWNlLmMKKyAq
LworI2RlZmluZSBBRERSX01BU0sgMHgwM2ZmZmZmZiAgICAvKiAgb3BfY29kZXxhZGRyIDogMzEu
Li4yNnwyNSAuLi4uMCAqLworI2RlZmluZSBKQUwgMHgwYzAwMDAwMCAgICAgIC8qIGp1bXAgJiBs
aW5rOiBpcCAtLT4gcmEsIGp1bXAgdG8gdGFyZ2V0ICovCisjZGVmaW5lIElOU05fSkFMKGFkZHIp
ICBcCisJCSAgICAoKHVuc2lnbmVkIGludCkoSkFMIHwgKCgoYWRkcikgPj4gMikgJiBBRERSX01B
U0spKSkKKworLyoKKyAqIFdlIGFzc3VtZSBqYWwgPG1jb3VudD4vPGZ0cmFjZV9jYWxsZXI+IHRv
IGJlIHByZXNlbnQgaW4KKyAqIGZpcnN0IEpBTF9NQVhfT0ZGU0VUIGluc3RydWN0aW9ucy4KKyAq
IEluY3JlbWVudCB0aGlzLCBpZiBpdHMgb3RoZXJ3aXNlCisgKi8KKyNkZWZpbmUgSkFMX01BWF9P
RkZTRVQgMTZVCisjZGVmaW5lIE1DT1VOVF9TVEFDS19JTlNUIDB4MjdiZGZmZjggLyogYWRkaXUg
ICBzcCxzcCwtOCAqLworCisvKgorICogSWYgRHluYW1pYyBGdHJhY2UgaXMgZW5hYmxlZCwgZnRy
YWNlX2NhbGxlciBpcyB0aGUgdHJhY2UgZnVuY3Rpb24uCisgKiBPdGhlcndpc2UgaXRzIC0gbWNv
dW50CisgKi8KK2V4dGVybiB2b2lkICBmdHJhY2VfY2FsbGVyKHZvaWQpOworI2VuZGlmIC8qIENP
TkZJR19EWU5BTUlDX0ZUUkFDRSAqLworCiBzdGF0aWMgaW50IGdldF9mcmFtZV9pbmZvKHN0cnVj
dCBtaXBzX2ZyYW1lX2luZm8gKmluZm8pCiB7CiAJdW5pb24gbWlwc19pbnN0cnVjdGlvbiAqaXAg
PSBpbmZvLT5mdW5jOwogCXVuc2lnbmVkIG1heF9pbnNucyA9IGluZm8tPmZ1bmNfc2l6ZSAvIHNp
emVvZih1bmlvbiBtaXBzX2luc3RydWN0aW9uKTsKIAl1bnNpZ25lZCBpOwogCisjaWZkZWYgQ09O
RklHX0RZTkFNSUNfRlRSQUNFCisJdW5zaWduZWQgbWF4X3Byb2xvZ19pbnN0ID0gbWF4X2luc25z
OworCWludCBqYWxfZm91bmQgPSAwOworCS8qIGluc3RydWN0aW9uIGNvcnJlc3BvbmRpbmcgdG8g
amFsIDxfbWNvdW50Pi88ZnRyYWNlX2NhbGxlcj4gKi8KKwlpbnQgamFsX21jb3VudCA9IDA7Cisj
ZW5kaWYKKwogCWluZm8tPnBjX29mZnNldCA9IC0xOwogCWluZm8tPmZyYW1lX3NpemUgPSAwOwog
CkBAIC0zMDYsNiArMzM5LDI4IEBAIHN0YXRpYyBpbnQgZ2V0X2ZyYW1lX2luZm8oc3RydWN0IG1p
cHNfZnJhbWVfaW5mbyAqaW5mbykKIAkJbWF4X2luc25zID0gMTI4VTsJLyogdW5rbm93biBmdW5j
dGlvbiBzaXplICovCiAJbWF4X2luc25zID0gbWluKDEyOFUsIG1heF9pbnNucyk7CiAKKyNpZmRl
ZiBDT05GSUdfRFlOQU1JQ19GVFJBQ0UKKwltYXhfcHJvbG9nX2luc3QgPSBtaW4oSkFMX01BWF9P
RkZTRVQsIG1heF9wcm9sb2dfaW5zdCk7CisJamFsX21jb3VudCA9IElOU05fSkFMKCh1bnNpZ25l
ZCkmZnRyYWNlX2NhbGxlcik7CisKKwlmb3IgKGkgPSAwOyBpIDwgbWF4X3Byb2xvZ19pbnN0OyBp
KyssIGlwKyspIHsKKwkJaWYgKCgqKGludCAqKWlwID09IGphbF9tY291bnQpIHx8CisJCQkJLyoK
KwkJCQkgKiBmb3IgZHluIGZ0cmFjZSwgdGhlIGNvZGUgaW5pdGlhbGx5IGhhcyAwLgorCQkJCSAq
IHNvIHdlIGNoZWNrIHdoZXRoZXIgdGhlIG5leHQgaW5zdHJ1Y3Rpb24gaXMKKwkJCQkgKiBhZGRp
dSAgIHNwLHNwLC04CisJCQkJICovCisJCQkJKCEoKihpbnQgKilpcCkgJiYKKwkJCQkgKCooaW50
ICopKGlwICsgMSkgPT0gTUNPVU5UX1NUQUNLX0lOU1QpKQorCQkgICApIHsKKwkJCWphbF9mb3Vu
ZCA9IDE7CisJCQlicmVhazsKKwkJfQorCX0KKwkvKiByZXN0b3JlIHRoZSBpcCB0byBzdGFydCBv
ZiBmdW5jdGlvbiAqLworCWlwID0gaW5mby0+ZnVuYzsKKyNlbmRpZgorCiAJZm9yIChpID0gMDsg
aSA8IG1heF9pbnNuczsgaSsrLCBpcCsrKSB7CiAKIAkJaWYgKGlzX2phbF9qYWxyX2pyX2lucyhp
cCkpCkBAIC0zMjEsNiArMzc2LDE4IEBAIHN0YXRpYyBpbnQgZ2V0X2ZyYW1lX2luZm8oc3RydWN0
IG1pcHNfZnJhbWVfaW5mbyAqaW5mbykKIAkJCWJyZWFrOwogCQl9CiAJfQorI2lmZGVmIENPTkZJ
R19EWU5BTUlDX0ZUUkFDRQorCS8qCisJICogdG8gb2Zmc2V0IHRoZSBlZmZlY3Qgb2Y6CisJICog
YWRkaXUgICBzcCxzcCwtOAorCSAqLworCWlmIChqYWxfZm91bmQpIHsKKwkJaWYgKGluZm8tPmZy
YW1lX3NpemUpCisJCQlpbmZvLT5mcmFtZV9zaXplICs9IDg7CisJCWlmIChpbmZvLT5wY19vZmZz
ZXQgPj0gMCkKKwkJCWluZm8tPnBjX29mZnNldCArPSA4IC8gc2l6ZW9mKGxvbmcpOworCX0KKyNl
bmRpZgogCWlmIChpbmZvLT5mcmFtZV9zaXplICYmIGluZm8tPnBjX29mZnNldCA+PSAwKSAvKiBu
ZXN0ZWQgKi8KIAkJcmV0dXJuIDA7CiAJaWYgKGluZm8tPnBjX29mZnNldCA8IDApIC8qIGxlYWYg
Ki8KLS0gCjEuNy44LjQKCg==
--047d7b2e4f620ba56504bf40e181--
