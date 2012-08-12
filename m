Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Aug 2012 08:29:13 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:51470 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1902235Ab2HLG3J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Aug 2012 08:29:09 +0200
Message-ID: <50274CF9.2090402@phrozen.org>
Date:   Sun, 12 Aug 2012 08:28:09 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [Bug-fix] backtrace when HAVE_FUNCTION_TRACER is enable
References: <CADArhcB+N+D4fyVN20f0hu=vfPj1tsn5NHi0cjG4JJcKAhTkeQ@mail.gmail.com>        <CAD+V5YKZJHKONehvT+-GrKLP2+e0PiLiFTJWEojiDoNyLT3yGQ@mail.gmail.com> <CADArhcAN4renH1hFnhc14d+VMn2N+k0GsDpXevRFKd6UD=X=8Q@mail.gmail.com>
In-Reply-To: <CADArhcAN4renH1hFnhc14d+VMn2N+k0GsDpXevRFKd6UD=X=8Q@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Hi,

This patch is missing the Description and SoB line

John



On 09/08/12 19:16, Akhilesh Kumar wrote:
> yes Zhangin
> 
> please find the complete patch 
> ====================================================================
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
> @@ -306,6 +339,28 @@ static int get_frame_info(struct mips_frame_info *info)
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
> @@ -321,6 +376,18 @@ static int get_frame_info(struct mips_frame_info *info)
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
> ==================================================================== 
> 
> On Thu, Aug 9, 2012 at 9:41 PM, Wu Zhangjin <wuzhangjin@gmail.com
> <mailto:wuzhangjin@gmail.com>> wrote:
> 
>     Hi, Akhilesh
> 
>     Thanks very much for your work.
> 
>     Seems this patch has lost something, can you send a full one?
> 
>     Best Regards,
>     Wu Zhangjin
> 
>     On Thu, Aug 9, 2012 at 9:53 PM, Akhilesh Kumar
>     <akhilesh.lxr@gmail.com <mailto:akhilesh.lxr@gmail.com>> wrote:
>     > Hi Ralf,
>     >
>     >
>     > Sub:- Bug  unable to retrive backtrace when HAVE_FUNCTION_TRACER
>     is enable.
>     > I send this bug and bug fix long back, I am resending this patch
>     again for
>     > review.
>     >
>     > Please review below patch if you agree I will regenerate this
>     patch and with
>     > you.
>     >
>     > ====[ backtrace testing ]===========
>     > Testing a backtrace from process context.
>     > The following trace is a kernel self test and not a bug!
>     > Testing a backtrace.
>     > The following trace is a kernel self test and not a bug!
>     > Call Trace:
>     > [<80295134>] dump_stack+0x8/0x34
>     > [<c0946060>] backtrace_regression_test+0x60/0x94 [sisc_backtrcae]
>     > [<800004f0>] do_one_initcall+0xf0/0x1d0
>     > [<80060954>] sys_init_module+0x19c8/0x1c60
>     > [<8000a418>] stack_done+0x20/0x40
>     > output befor patch when HAVE_FUNCTION_TRACER is enable
>     > ---------------------------------------------------------------------
>     > #> insmod backtrace.ko
>     > ====[ backtrace testing ]===========
>     > Testing a backtrace from process context.
>     > The following trace is a kernel self test and not a bug!
>     > Testing a backtrace.
>     > The following trace is a kernel self test and not a bug!
>     > Call Trace:
>     > [<802e5164>] dump_stack+0x1c/0x50
>     > [<802e5164>] dump_stack+0x1c/0x50
>     > ====[ end of backtrace testing ]====
>     > ------------------------------------------------------
>     > above shows the wrong back trcae
>     > output after patch when HAVE_FUNCTION_TRACER is enable
>     > ----------------------------------------------------------------------
>     > ====[ backtrace testing ]===========
>     > Testing a backtrace from process context.
>     > The following trace is a kernel self test and not a bug!
>     > Testing a backtrace.
>     > The following trace is a kernel self test and not a bug!
>     > Call Trace:
>     > [<802eb1a4>] dump_stack+0x20/0x54
>     > [<c003405c>] backtrace_test_timer+0x5c/0x74 [sisc_backtrcae]
>     > [<c00340dc>] init_module+0x68/0xa0 [sisc_backtrcae]
>     > [<80000508>] do_one_initcall+0x108/0x1f0
>     > [<8006d4c4>] sys_init_module+0x1a10/0x1c74
>     > [<8000b038>] stack_done+0x20/0x40
>     > ------------------------------------------------------------------
>     > get_frame_info() is used to fetch the frame information from the
>     > function.
>     > However,
>     > 1. this function just considers the first stack adjustment for frame
>     > size.
>     > 2. On finding the save_lr instruction, it returns.
>     > It doesn't handle the ftrace condition.
>     > If Dynamic Frace "CONFIG_DYNAMIC_FTRACE" is enabled, the
>     instrumentation
>     > code is:
>     >  - jal <ftrace_caller>
>     >  - addiu sp,sp,-8
>     > Thus, the current Frame Size of function is increased by 8 for Ftrace.
>     > Signed-off-by: Akhilesh Kumar <akhilesh.lxr@gmail.com
>     <mailto:akhilesh.lxr@gmail.com>>
>     > ---
>     >  arch/mips/kernel/process.c |   67
>     > ++++++++++++++++++++++++++++++++++++++++++++
>     >  1 files changed, 67 insertions(+), 0 deletions(-)
>     > diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>     > index 7955409..df72738 100644
>     > --- a/arch/mips/kernel/process.c
>     > +++ b/arch/mips/kernel/process.c
>     > @@ -290,12 +290,45 @@  static inline int is_sp_move_ins(union
>     > mips_instruction *ip)
>     >   return 0;
>     >  }
>     > +#ifdef CONFIG_DYNAMIC_FTRACE
>     > +/*
>     > + * To create the jal <> instruction from mcount.
>     > + * taken from:
>     > + * - arch/mips/kernel/ftrace.c
>     > + */
>     > +#define ADDR_MASK 0x03ffffff    /*  op_code|addr : 31...26|25
>     ....0 */
>     > +#define JAL 0x0c000000      /* jump & link: ip --> ra, jump to
>     target */
>     > +#define INSN_JAL(addr)  \
>     > +      ((unsigned int)(JAL | (((addr) >> 2) & ADDR_MASK)))
>     > +
>     > +/*
>     > + * We assume jal <mcount>/<ftrace_caller> to be present in
>     > + * first JAL_MAX_OFFSET instructions.
>     > + * Increment this, if its otherwise
>     > + */
>     > +#define JAL_MAX_OFFSET 16U
>     > +#define MCOUNT_STACK_INST 0x27bdfff8 /* addiu   sp,sp,-8 */
>     > +
>     > +/*
>     > + * If Dynamic Ftrace is enabled, ftrace_caller is the trace function.
>     > + * Otherwise its - mcount
>     > + */
>     > +extern void  ftrace_caller(void);
>     > +#endif /* CONFIG_DYNAMIC_FTRACE */
>     > +
>     >  static int get_frame_info(struct mips_frame_info *info)
>     >  {
>     >   union mips_instruction *ip = info->func;
>     >   unsigned max_insns = info->func_size / sizeof(union
>     mips_instruction);
>     >   unsigned i;
>     > +#ifdef CONFIG_DYNAMIC_FTRACE
>     > + unsigned max_prolog_inst = max_insns;
>     > + int jal_found = 0;
>     > + /* instruction corresponding to jal <_mcount>/<ftrace_caller> */
>     > + int jal_mcount = 0;
>     > +#endif
>     > +
>     >   info->pc_offset = -1;
>     >   info->frame_size = 0;
> 
> 
