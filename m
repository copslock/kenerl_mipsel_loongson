Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 15:55:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:13771 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8126927AbWGaOzB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2006 15:55:01 +0100
Received: from localhost (p3075-ipad208funabasi.chiba.ocn.ne.jp [60.43.104.75])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BC1C18626; Mon, 31 Jul 2006 23:54:53 +0900 (JST)
Date:	Mon, 31 Jul 2006 23:56:26 +0900 (JST)
Message-Id: <20060731.235626.86888625.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis (take 2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44CDC657.9090403@innova-card.com>
References: <20060729.232720.108740310.anemo@mba.ocn.ne.jp>
	<44CDC657.9090403@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 31 Jul 2006 10:59:03 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> my comments included with this patch...(you can find the plain patch
> at the end of this email)
> 
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 8709a46..3bb4d47 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -365,15 +365,15 @@ #else
>  	mfinfo[0].func = schedule;
>  	schedule_frame = &mfinfo[0];
>  #endif
> -	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++) {
> -		struct mips_frame_info *info = &mfinfo[i];
> -		if (get_frame_info(info)) {
> -			/* leaf or unknown */
> -			if (info->func == schedule)
> -				printk("Can't analyze prologue code at %p\n",
> -				       info->func);
> -		}
> -	}
> +	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++)
> +		get_frame_info(mfinfo + i);
> +
> +	/*
> +	 * Without schedule() frame info, result given by
> +	 * thread_saved_pc() and get_wchan() are not reliable.
> +	 */
> +	if (schedule_frame->pc_offset < 0)
> +		printk("Can't analyze schedule() prologue at %p\n", schedule);
> 
> >>>>>>>>>>>>>
> I just put the test out of the loop and add a comment.
> <<<<<<<<<<<<<

Looks good.

> @@ -466,18 +467,21 @@ unsigned long unwind_stack(struct task_s
>  
>  	info.func = (void *)(pc - ofs);
>  	info.func_size = ofs;	/* analyze from start to ofs */
> -	if (get_frame_info(&info)) {
> -		/* leaf or unknown */
> -		*sp += info.frame_size / sizeof(long);
> +	rv = get_frame_info(&info);
> +	if (rv < 0)
>  		return 0;
> -	}
> +
>  	if ((unsigned long)*sp < stack_page ||
>  	    (unsigned long)*sp + info.frame_size / sizeof(long) >
>  	    stack_page + THREAD_SIZE - 32)
>  		return 0;
>  
> -	pc = (*sp)[info.pc_offset];
> +	if (rv)		/* leaf */
> +		pc = regs->regs[31];
> +	else		/* nested */
> +		pc = (*sp)[info.pc_offset];
> +
>  	*sp += info.frame_size / sizeof(long);
> -	return pc;
> +	return __kernel_text_address(pc) ? pc : 0;
> 
> >>>>>>>>>>>>>
> I pass regs to unwind_stack(), that simplify the caller because
> it needn't to deal with leaf or nested case. Simply test for pc
> is 0.
> <<<<<<<<<<<<<

It seems a bit fragile.  The regs->regs[31] can be used for top of
stack, but we should consider that get_frame_info() might return wrong
result (again, get_frame_info() is not perfect).  If get_frame_info()
returned 0 on middle level of the stack, taking regs->regs[31] leads
wrong trace.  Maybe you can use NULL value as regs for non-toplevel.

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 7aa9dfc..bbd1cf9 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -73,13 +73,8 @@ void (*board_nmi_handler_setup)(void);
>  void (*board_ejtag_handler_setup)(void);
>  void (*board_bind_eic_interrupt)(int irq, int regset);
>  
> -/*
> - * These constant is for searching for possible module text segments.
> - * MODULE_RANGE is a guess of how much space is likely to be vmalloced.
> - */
> -#define MODULE_RANGE (8*1024*1024)
> 
> >>>>>>>>>>>>>
> seems to be unused now...
> <<<<<<<<<<<<<

This is irrelevant.  It would be better to make another patch.

> -static void show_trace(unsigned long *stack)
> +static void show_trace(unsigned long *sp)
>  {
>  	const int field = 2 * sizeof(unsigned long);
>  	unsigned long addr;
> @@ -88,8 +83,8 @@ static void show_trace(unsigned long *st
>  #ifdef CONFIG_KALLSYMS
>  	printk("\n");
>  #endif
> -	while (!kstack_end(stack)) {
> -		addr = *stack++;
> +	while (!kstack_end(sp)) {
> +		addr = *sp++;
> 
> >>>>>>>>>>>>>
> now show_trace calls sp sp. (nothing is too late)
> <<<<<<<<<<<<<

I feel "stack" is better than "sp" in this case, but do not object to
this change.

> @@ -107,32 +102,27 @@ static int __init set_raw_show_trace(cha
>  }
>  __setup("raw_show_trace", set_raw_show_trace);
>  
> -extern unsigned long unwind_stack(struct task_struct *task,
> -				  unsigned long **sp, unsigned long pc);
> -static void show_frametrace(struct task_struct *task, struct pt_regs *regs)
> +extern unsigned long unwind_stack(struct task_struct *task, unsigned long **sp,
> +				  unsigned long pc, struct pt_regs *regs);
> +
> +static void show_backtrace(struct task_struct *task, struct pt_regs *regs)
> 
> >>>>>>>>>>>>>
> Just renamed show_stacktrace() into show_backtrace(). I think we
> usually use the latter no ?
> <<<<<<<<<<<<<

No objection.

>  {
> -	const int field = 2 * sizeof(unsigned long);
> -	unsigned long *stack = (long *)regs->regs[29];
> +	unsigned long *sp = (long *)regs->regs[29];
>  	unsigned long pc = regs->cp0_epc;
> -	int top = 1;
>  
>  	if (raw_show_trace || !__kernel_text_address(pc)) {
> -		show_trace(stack);
> +		show_trace(sp);
>  		return;
>  	}
>  	printk("Call Trace:\n");
> -	while (__kernel_text_address(pc)) {
> -		printk(" [<%0*lx>] ", field, pc);
> +	do {
> +		printk(" [<%0*lx>] ", 2*sizeof(unsigned long), pc);
>  		print_symbol("%s\n", pc);
> -		pc = unwind_stack(task, &stack, pc);
> -		if (top && pc == 0)
> -			pc = regs->regs[31];	/* leaf? */
> -		top = 0;
> -	}
> +	} while ((pc = unwind_stack(task, &sp, pc, regs)));
> 
> >>>>>>>>>>>>>
> Now don't deal with leaf case since unwind_stack() does it for us.
> <<<<<<<<<<<<<

As I wrote above, passing "regs" for all level seems not appropriate.

---
Atsushi Nemoto
