Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2012 19:17:13 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52314 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902233Ab2HIRRE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2012 19:17:04 +0200
Received: by pbbrq13 with SMTP id rq13so1315638pbb.36
        for <multiple recipients>; Thu, 09 Aug 2012 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/UxgkjcBimowHD03erl1dsewBThdVXdUC4C4LRlJ0tM=;
        b=IgrS8EexrHbS8UUWvfxwNu2b0pVfH1IUNbApQgZPmAPs5k7F0YI8tINiZ8UoGNRnyX
         Sxdd6PyBhoTkrV01V9bG1lX9myOCxPn3DxAR6evnV1p9gc2lccxxGCA0dj+t6P2n9H3V
         L2OjMGtG9p8J10w1+LFsJgmn6lKVTQ2hJRCRcZ/rsAND/fBo72/svaomvX4oA1BbtTvd
         ZiJ+GRXl6dmp8waH+DN+4CJTSgCMhcPJwN8NT7c4fw5CyGopZw3pbcJo+mQ80b9Wt3Nu
         N/KTSeu1HJId92vDBVmkMYzy9HVmyRWoDxdoKiA1g2N9z9PDiFV1f1uLBQVhh8yzWzd9
         xVyQ==
MIME-Version: 1.0
Received: by 10.68.217.226 with SMTP id pb2mr5537868pbc.105.1344532617320;
 Thu, 09 Aug 2012 10:16:57 -0700 (PDT)
Received: by 10.67.14.106 with HTTP; Thu, 9 Aug 2012 10:16:57 -0700 (PDT)
In-Reply-To: <CAD+V5YKZJHKONehvT+-GrKLP2+e0PiLiFTJWEojiDoNyLT3yGQ@mail.gmail.com>
References: <CADArhcB+N+D4fyVN20f0hu=vfPj1tsn5NHi0cjG4JJcKAhTkeQ@mail.gmail.com>
        <CAD+V5YKZJHKONehvT+-GrKLP2+e0PiLiFTJWEojiDoNyLT3yGQ@mail.gmail.com>
Date:   Thu, 9 Aug 2012 22:46:57 +0530
Message-ID: <CADArhcAN4renH1hFnhc14d+VMn2N+k0GsDpXevRFKd6UD=X=8Q@mail.gmail.com>
Subject: Re: [Bug-fix] backtrace when HAVE_FUNCTION_TRACER is enable
From:   Akhilesh Kumar <akhilesh.lxr@gmail.com>
To:     wuzhangjin@gmail.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=e89a8ff243250b582004c6d865e8
X-archive-position: 34085
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

--e89a8ff243250b582004c6d865e8
Content-Type: text/plain; charset=ISO-8859-1

yes Zhangin

please find the complete patch
====================================================================
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 7955409..df72738 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -290,12 +290,45 @@ static inline int is_sp_move_ins(union
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

@@ -306,6 +339,28 @@ static int get_frame_info(struct mips_frame_info *info)
   max_insns = 128U; /* unknown function size */
  max_insns = min(128U, max_insns);

+#ifdef CONFIG_DYNAMIC_FTRACE
+ max_prolog_inst = min(JAL_MAX_OFFSET, max_prolog_inst);
+ jal_mcount = INSN_JAL((unsigned)&ftrace_caller);
+
+ for (i = 0; i < max_prolog_inst; i++, ip++) {
+  if ((*(int *)ip == jal_mcount) ||
+    /*
+     * for dyn ftrace, the code initially has 0.
+     * so we check whether the next instruction is
+     * addiu   sp,sp,-8
+     */
+    (!(*(int *)ip) &&
+     (*(int *)(ip + 1) == MCOUNT_STACK_INST))
+     ) {
+   jal_found = 1;
+   break;
+  }
+ }
+ /* restore the ip to start of function */
+ ip = info->func;
+#endif
+
  for (i = 0; i < max_insns; i++, ip++) {

   if (is_jal_jalr_jr_ins(ip))
@@ -321,6 +376,18 @@ static int get_frame_info(struct mips_frame_info *info)
    break;
   }
  }
+#ifdef CONFIG_DYNAMIC_FTRACE
+ /*
+  * to offset the effect of:
+  * addiu   sp,sp,-8
+  */
+ if (jal_found) {
+  if (info->frame_size)
+   info->frame_size += 8;
+  if (info->pc_offset >= 0)
+   info->pc_offset += 8 / sizeof(long);
+ }
+#endif
  if (info->frame_size && info->pc_offset >= 0) /* nested */
   return 0;
  if (info->pc_offset < 0) /* leaf */
-- 
1.7.8.4

====================================================================

On Thu, Aug 9, 2012 at 9:41 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:

> Hi, Akhilesh
>
> Thanks very much for your work.
>
> Seems this patch has lost something, can you send a full one?
>
> Best Regards,
> Wu Zhangjin
>
> On Thu, Aug 9, 2012 at 9:53 PM, Akhilesh Kumar <akhilesh.lxr@gmail.com>
> wrote:
> > Hi Ralf,
> >
> >
> > Sub:- Bug  unable to retrive backtrace when HAVE_FUNCTION_TRACER is
> enable.
> > I send this bug and bug fix long back, I am resending this patch again
> for
> > review.
> >
> > Please review below patch if you agree I will regenerate this patch and
> with
> > you.
> >
> > ====[ backtrace testing ]===========
> > Testing a backtrace from process context.
> > The following trace is a kernel self test and not a bug!
> > Testing a backtrace.
> > The following trace is a kernel self test and not a bug!
> > Call Trace:
> > [<80295134>] dump_stack+0x8/0x34
> > [<c0946060>] backtrace_regression_test+0x60/0x94 [sisc_backtrcae]
> > [<800004f0>] do_one_initcall+0xf0/0x1d0
> > [<80060954>] sys_init_module+0x19c8/0x1c60
> > [<8000a418>] stack_done+0x20/0x40
> > output befor patch when HAVE_FUNCTION_TRACER is enable
> > ---------------------------------------------------------------------
> > #> insmod backtrace.ko
> > ====[ backtrace testing ]===========
> > Testing a backtrace from process context.
> > The following trace is a kernel self test and not a bug!
> > Testing a backtrace.
> > The following trace is a kernel self test and not a bug!
> > Call Trace:
> > [<802e5164>] dump_stack+0x1c/0x50
> > [<802e5164>] dump_stack+0x1c/0x50
> > ====[ end of backtrace testing ]====
> > ------------------------------------------------------
> > above shows the wrong back trcae
> > output after patch when HAVE_FUNCTION_TRACER is enable
> > ----------------------------------------------------------------------
> > ====[ backtrace testing ]===========
> > Testing a backtrace from process context.
> > The following trace is a kernel self test and not a bug!
> > Testing a backtrace.
> > The following trace is a kernel self test and not a bug!
> > Call Trace:
> > [<802eb1a4>] dump_stack+0x20/0x54
> > [<c003405c>] backtrace_test_timer+0x5c/0x74 [sisc_backtrcae]
> > [<c00340dc>] init_module+0x68/0xa0 [sisc_backtrcae]
> > [<80000508>] do_one_initcall+0x108/0x1f0
> > [<8006d4c4>] sys_init_module+0x1a10/0x1c74
> > [<8000b038>] stack_done+0x20/0x40
> > ------------------------------------------------------------------
> > get_frame_info() is used to fetch the frame information from the
> > function.
> > However,
> > 1. this function just considers the first stack adjustment for frame
> > size.
> > 2. On finding the save_lr instruction, it returns.
> > It doesn't handle the ftrace condition.
> > If Dynamic Frace "CONFIG_DYNAMIC_FTRACE" is enabled, the instrumentation
> > code is:
> >  - jal <ftrace_caller>
> >  - addiu sp,sp,-8
> > Thus, the current Frame Size of function is increased by 8 for Ftrace.
> > Signed-off-by: Akhilesh Kumar <akhilesh.lxr@gmail.com>
> > ---
> >  arch/mips/kernel/process.c |   67
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 67 insertions(+), 0 deletions(-)
> > diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> > index 7955409..df72738 100644
> > --- a/arch/mips/kernel/process.c
> > +++ b/arch/mips/kernel/process.c
> > @@ -290,12 +290,45 @@  static inline int is_sp_move_ins(union
> > mips_instruction *ip)
> >   return 0;
> >  }
> > +#ifdef CONFIG_DYNAMIC_FTRACE
> > +/*
> > + * To create the jal <> instruction from mcount.
> > + * taken from:
> > + * - arch/mips/kernel/ftrace.c
> > + */
> > +#define ADDR_MASK 0x03ffffff    /*  op_code|addr : 31...26|25 ....0 */
> > +#define JAL 0x0c000000      /* jump & link: ip --> ra, jump to target */
> > +#define INSN_JAL(addr)  \
> > +      ((unsigned int)(JAL | (((addr) >> 2) & ADDR_MASK)))
> > +
> > +/*
> > + * We assume jal <mcount>/<ftrace_caller> to be present in
> > + * first JAL_MAX_OFFSET instructions.
> > + * Increment this, if its otherwise
> > + */
> > +#define JAL_MAX_OFFSET 16U
> > +#define MCOUNT_STACK_INST 0x27bdfff8 /* addiu   sp,sp,-8 */
> > +
> > +/*
> > + * If Dynamic Ftrace is enabled, ftrace_caller is the trace function.
> > + * Otherwise its - mcount
> > + */
> > +extern void  ftrace_caller(void);
> > +#endif /* CONFIG_DYNAMIC_FTRACE */
> > +
> >  static int get_frame_info(struct mips_frame_info *info)
> >  {
> >   union mips_instruction *ip = info->func;
> >   unsigned max_insns = info->func_size / sizeof(union mips_instruction);
> >   unsigned i;
> > +#ifdef CONFIG_DYNAMIC_FTRACE
> > + unsigned max_prolog_inst = max_insns;
> > + int jal_found = 0;
> > + /* instruction corresponding to jal <_mcount>/<ftrace_caller> */
> > + int jal_mcount = 0;
> > +#endif
> > +
> >   info->pc_offset = -1;
> >   info->frame_size = 0;
>

--e89a8ff243250b582004c6d865e8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

yes Zhangin<div><br></div><div>please find the=A0complete=A0patch=A0</div><=
div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div><div=
>diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c</div>
<div>index 7955409..df72738 100644</div><div>--- a/arch/mips/kernel/process=
.c</div><div>+++ b/arch/mips/kernel/process.c</div><div>@@ -290,12 +290,45 =
@@ static inline int is_sp_move_ins(union</div><div>mips_instruction *ip)</=
div>
<div>=A0 return 0;</div><div>=A0}</div><div><br></div><div>+#ifdef CONFIG_D=
YNAMIC_FTRACE</div><div>+/*</div><div>+ * To create the jal &lt;&gt; instru=
ction from mcount.</div><div>+ * taken from:</div><div>+ * - arch/mips/kern=
el/ftrace.c</div>
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
ruction);</div><div>=A0 unsigned i;</div><div><br></div><div>+#ifdef CONFIG=
_DYNAMIC_FTRACE</div>
<div>+ unsigned max_prolog_inst =3D max_insns;</div><div>+ int jal_found =
=3D 0;</div><div>+ /* instruction corresponding to jal &lt;_mcount&gt;/&lt;=
ftrace_caller&gt; */</div><div>+ int jal_mcount =3D 0;</div><div>+#endif</d=
iv><div>
+</div><div>=A0 info-&gt;pc_offset =3D -1;</div><div>=A0 info-&gt;frame_siz=
e =3D 0;</div><div><br></div><div>@@ -306,6 +339,28 @@ static int get_frame=
_info(struct mips_frame_info *info)</div><div>=A0 =A0max_insns =3D 128U; /*=
 unknown function size */</div>
<div>=A0 max_insns =3D min(128U, max_insns);</div><div><br></div><div>+#ifd=
ef CONFIG_DYNAMIC_FTRACE</div><div>+ max_prolog_inst =3D min(JAL_MAX_OFFSET=
, max_prolog_inst);</div><div>+ jal_mcount =3D INSN_JAL((unsigned)&amp;ftra=
ce_caller);</div>
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
div>=A0 for (i =3D 0; i &lt; max_insns; i++, ip++) {</div><div><br></div><d=
iv>=A0 =A0if (is_jal_jalr_jr_ins(ip))</div>
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
</div><div><br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=A0<br><br><div class=3D"gmail_quote">On Thu, Aug 9, 2012 at 9:41 PM,=
 Wu Zhangjin <span dir=3D"ltr">&lt;<a href=3D"mailto:wuzhangjin@gmail.com" =
target=3D"_blank">wuzhangjin@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi, Akhilesh<br>
<br>
Thanks very much for your work.<br>
<br>
Seems this patch has lost something, can you send a full one?<br>
<br>
Best Regards,<br>
Wu Zhangjin<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On Thu, Aug 9, 2012 at 9:53 PM, Akhilesh Kumar &lt;<a href=3D"mailto:akhile=
sh.lxr@gmail.com">akhilesh.lxr@gmail.com</a>&gt; wrote:<br>
&gt; Hi Ralf,<br>
&gt;<br>
&gt;<br>
&gt; Sub:- Bug =A0unable to retrive backtrace when HAVE_FUNCTION_TRACER is =
enable.<br>
&gt; I send this bug and bug fix long back, I am resending this patch again=
 for<br>
&gt; review.<br>
&gt;<br>
&gt; Please review below patch if you agree I will regenerate this patch an=
d with<br>
&gt; you.<br>
&gt;<br>
&gt; =3D=3D=3D=3D[ backtrace testing ]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; Testing a backtrace from process context.<br>
&gt; The following trace is a kernel self test and not a bug!<br>
&gt; Testing a backtrace.<br>
&gt; The following trace is a kernel self test and not a bug!<br>
&gt; Call Trace:<br>
&gt; [&lt;80295134&gt;] dump_stack+0x8/0x34<br>
&gt; [&lt;c0946060&gt;] backtrace_regression_test+0x60/0x94 [sisc_backtrcae=
]<br>
&gt; [&lt;800004f0&gt;] do_one_initcall+0xf0/0x1d0<br>
&gt; [&lt;80060954&gt;] sys_init_module+0x19c8/0x1c60<br>
&gt; [&lt;8000a418&gt;] stack_done+0x20/0x40<br>
&gt; output befor patch when HAVE_FUNCTION_TRACER is enable<br>
&gt; ---------------------------------------------------------------------<=
br>
&gt; #&gt; insmod backtrace.ko<br>
&gt; =3D=3D=3D=3D[ backtrace testing ]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; Testing a backtrace from process context.<br>
&gt; The following trace is a kernel self test and not a bug!<br>
&gt; Testing a backtrace.<br>
&gt; The following trace is a kernel self test and not a bug!<br>
&gt; Call Trace:<br>
&gt; [&lt;802e5164&gt;] dump_stack+0x1c/0x50<br>
&gt; [&lt;802e5164&gt;] dump_stack+0x1c/0x50<br>
&gt; =3D=3D=3D=3D[ end of backtrace testing ]=3D=3D=3D=3D<br>
&gt; ------------------------------------------------------<br>
&gt; above shows the wrong back trcae<br>
&gt; output after patch when HAVE_FUNCTION_TRACER is enable<br>
&gt; ----------------------------------------------------------------------=
<br>
&gt; =3D=3D=3D=3D[ backtrace testing ]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; Testing a backtrace from process context.<br>
&gt; The following trace is a kernel self test and not a bug!<br>
&gt; Testing a backtrace.<br>
&gt; The following trace is a kernel self test and not a bug!<br>
&gt; Call Trace:<br>
&gt; [&lt;802eb1a4&gt;] dump_stack+0x20/0x54<br>
&gt; [&lt;c003405c&gt;] backtrace_test_timer+0x5c/0x74 [sisc_backtrcae]<br>
&gt; [&lt;c00340dc&gt;] init_module+0x68/0xa0 [sisc_backtrcae]<br>
&gt; [&lt;80000508&gt;] do_one_initcall+0x108/0x1f0<br>
&gt; [&lt;8006d4c4&gt;] sys_init_module+0x1a10/0x1c74<br>
&gt; [&lt;8000b038&gt;] stack_done+0x20/0x40<br>
&gt; ------------------------------------------------------------------<br>
&gt; get_frame_info() is used to fetch the frame information from the<br>
&gt; function.<br>
&gt; However,<br>
&gt; 1. this function just considers the first stack adjustment for frame<b=
r>
&gt; size.<br>
&gt; 2. On finding the save_lr instruction, it returns.<br>
&gt; It doesn&#39;t handle the ftrace condition.<br>
&gt; If Dynamic Frace &quot;CONFIG_DYNAMIC_FTRACE&quot; is enabled, the ins=
trumentation<br>
&gt; code is:<br>
&gt; =A0- jal &lt;ftrace_caller&gt;<br>
&gt; =A0- addiu sp,sp,-8<br>
&gt; Thus, the current Frame Size of function is increased by 8 for Ftrace.=
<br>
&gt; Signed-off-by: Akhilesh Kumar &lt;<a href=3D"mailto:akhilesh.lxr@gmail=
.com">akhilesh.lxr@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0arch/mips/kernel/process.c | =A0 67<br>
&gt; ++++++++++++++++++++++++++++++++++++++++++++<br>
&gt; =A01 files changed, 67 insertions(+), 0 deletions(-)<br>
&gt; diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c<b=
r>
&gt; index 7955409..df72738 100644<br>
&gt; --- a/arch/mips/kernel/process.c<br>
&gt; +++ b/arch/mips/kernel/process.c<br>
&gt; @@ -290,12 +290,45 @@ =A0static inline int is_sp_move_ins(union<br>
&gt; mips_instruction *ip)<br>
&gt; =A0 return 0;<br>
&gt; =A0}<br>
&gt; +#ifdef CONFIG_DYNAMIC_FTRACE<br>
&gt; +/*<br>
&gt; + * To create the jal &lt;&gt; instruction from mcount.<br>
&gt; + * taken from:<br>
&gt; + * - arch/mips/kernel/ftrace.c<br>
&gt; + */<br>
&gt; +#define ADDR_MASK 0x03ffffff =A0 =A0/* =A0op_code|addr : 31...26|25 .=
...0 */<br>
&gt; +#define JAL 0x0c000000 =A0 =A0 =A0/* jump &amp; link: ip --&gt; ra, j=
ump to target */<br>
&gt; +#define INSN_JAL(addr) =A0\<br>
&gt; + =A0 =A0 =A0((unsigned int)(JAL | (((addr) &gt;&gt; 2) &amp; ADDR_MAS=
K)))<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * We assume jal &lt;mcount&gt;/&lt;ftrace_caller&gt; to be present i=
n<br>
&gt; + * first JAL_MAX_OFFSET instructions.<br>
&gt; + * Increment this, if its otherwise<br>
&gt; + */<br>
&gt; +#define JAL_MAX_OFFSET 16U<br>
&gt; +#define MCOUNT_STACK_INST 0x27bdfff8 /* addiu =A0 sp,sp,-8 */<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * If Dynamic Ftrace is enabled, ftrace_caller is the trace function.=
<br>
&gt; + * Otherwise its - mcount<br>
&gt; + */<br>
&gt; +extern void =A0ftrace_caller(void);<br>
&gt; +#endif /* CONFIG_DYNAMIC_FTRACE */<br>
&gt; +<br>
&gt; =A0static int get_frame_info(struct mips_frame_info *info)<br>
&gt; =A0{<br>
&gt; =A0 union mips_instruction *ip =3D info-&gt;func;<br>
&gt; =A0 unsigned max_insns =3D info-&gt;func_size / sizeof(union mips_inst=
ruction);<br>
&gt; =A0 unsigned i;<br>
&gt; +#ifdef CONFIG_DYNAMIC_FTRACE<br>
&gt; + unsigned max_prolog_inst =3D max_insns;<br>
&gt; + int jal_found =3D 0;<br>
&gt; + /* instruction corresponding to jal &lt;_mcount&gt;/&lt;ftrace_calle=
r&gt; */<br>
&gt; + int jal_mcount =3D 0;<br>
&gt; +#endif<br>
&gt; +<br>
&gt; =A0 info-&gt;pc_offset =3D -1;<br>
&gt; =A0 info-&gt;frame_size =3D 0;<br>
</div></div></blockquote></div><br></div>

--e89a8ff243250b582004c6d865e8--
