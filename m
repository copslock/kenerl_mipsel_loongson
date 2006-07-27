Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 15:34:34 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:30412 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8134016AbWG0OeW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Jul 2006 15:34:22 +0100
Received: by nf-out-0910.google.com with SMTP id q29so188316nfc
        for <linux-mips@linux-mips.org>; Thu, 27 Jul 2006 07:34:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ULbKCUXxxgj9z8m2p1yvkYXBU8eycm6j0S3p6LwPqon4DyJ6qEymIj2aN8XPw5as88fCCfHQC4KyYWiOJG6K+Klf8oRUoWYiXUL9VfPy/BaNO+fLF0ns9zxtglj4j5Tl5bgRybpqTMCKs2jUiI6vLWXzt7m+TlN+tg64U49TEt4=
Received: by 10.48.240.10 with SMTP id n10mr78861nfh;
        Thu, 27 Jul 2006 07:34:11 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id p43sm814927nfa.2006.07.27.07.34.10;
        Thu, 27 Jul 2006 07:34:11 -0700 (PDT)
Message-ID: <44C8CEA4.20000@innova-card.com>
Date:	Thu, 27 Jul 2006 16:33:08 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
References: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi ;)

Atsushi Nemoto wrote:
> Instead of dump all possible address in the stack, unwind the stack
> frame based on prologue code analysis, as like as get_chan() does.
> While the code analysis might fail for some reason, there is a new
> kernel option "raw_show_trace" to disable this feature.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 7ab67f7..8f1a5fe 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -281,7 +281,7 @@ static struct mips_frame_info {
>  } *schedule_frame, mfinfo[64];
>  static int mfinfo_num;
>  
> -static int __init get_frame_info(struct mips_frame_info *info)
> +static int get_frame_info(struct mips_frame_info *info)
>  {
>  	int i;
>  	void *func = info->func;
> @@ -329,12 +329,6 @@ #endif
>  				ip->i_format.simmediate / sizeof(long);
>  		}
>  	}
> -	if (info->pc_offset == -1 || info->frame_size == 0) {
> -		if (func == schedule)
> -			printk("Can't analyze prologue code at %p\n", func);
> -		info->pc_offset = -1;
> -		info->frame_size = 0;
> -	}
>  
>  	return 0;
>  }
> @@ -367,8 +361,17 @@ #else
>  	mfinfo[0].func = schedule;
>  	schedule_frame = &mfinfo[0];
>  #endif
> -	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++)
> -		get_frame_info(&mfinfo[i]);
> +	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++) {
> +		struct mips_frame_info *info = &mfinfo[i];
> +		get_frame_info(info);
> +		if (info->pc_offset < 0 || info->frame_size == 0) {
> +			if (info->func == schedule)

This can't happen since "schedule" is not a leaf function. Something I'm
missing here but I would have said:

			if (func != schedule)

instead, no ?

> +				printk("Can't analyze prologue code at %p\n",
> +				       info->func);
> +			info->pc_offset = -1;
> +			info->frame_size = 0;
> +		}
> +	}
>  
>  	mfinfo_num = i;
>  	return 0;
> @@ -437,3 +440,41 @@ #endif
>  	return pc;
>  }
>  
> +#ifdef CONFIG_KALLSYMS
> +/* used by show_frametrace() */
> +unsigned long unwind_stack(struct task_struct *task,
> +			   unsigned long **sp, unsigned long pc)
> +{
> +	unsigned long stack_page;
> +	struct mips_frame_info info;
> +	char *modname;
> +	char namebuf[KSYM_NAME_LEN + 1];
> +	unsigned long size, ofs;
> +
> +	stack_page = (unsigned long)task_stack_page(task);
> +	if (!stack_page)
> +		return 0;
> +
> +	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
> +		return 0;
> +	if (ofs == 0)
> +		return 0;
> +
> +	info.func = (void *)(pc - ofs);
> +	info.func_size = ofs;	/* analyze from start to ofs */
> +	get_frame_info(&info);
> +	if (info.pc_offset < 0 || !info.frame_size) {
> +		/* leaf? */

for leaf case, can't we simply do this test:

	if (info.pc_offset < 0) {

IOW, can a leaf function move sp ? I would say yes...

BTW why not let this logic inside get_frame_info() ? Hence this function
could return:

	if (info.frame_size && info.pc_offset > 0) /* nested */
		return 0;
	if (info.pc_offset < 0) /* leaf */
		return 1;
	/* prologue seems boggus... */
	printk("Can't analyze prologue code at %p\n", info->func);
	return -1;

> +		*sp += info.frame_size / sizeof(long);
> +		return 0;

why not returning:
		return regs->regs[31];

and removes the leaf detection logic in show_frametrace() ?

> +	}
> +	if ((unsigned long)*sp < stack_page ||
> +	    (unsigned long)*sp + info.frame_size / sizeof(long) >
> +	    stack_page + THREAD_SIZE - 32)
> +		return 0;
> +
> +	pc = (*sp)[info.pc_offset];
> +	*sp += info.frame_size / sizeof(long);
> +	return pc;

why not directly doing:

	return (*sp)[info.pc_offset];

and remove:

	pc = (*sp)[info.pc_offset];

> +}
> +#endif
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index c6f7046..bf36fcc 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -98,24 +98,53 @@ #endif
>  	printk("\n");
>  }
>  
> +#ifdef CONFIG_KALLSYMS
> +static int raw_show_trace;
> +static int __init set_raw_show_trace(char *str)
> +{
> +	raw_show_trace = 1;
> +	return 1;
> +}
> +__setup("raw_show_trace", set_raw_show_trace);
> +
> +extern unsigned long unwind_stack(struct task_struct *task,
> +				  unsigned long **sp, unsigned long pc);
> +static void show_frametrace(struct task_struct *task, struct pt_regs *regs)
> +{
> +	const int field = 2 * sizeof(unsigned long);
> +	unsigned long *stack = (long *)regs->regs[29];

why not calling that "sp" ?

> +	unsigned long pc = regs->cp0_epc;
> +	int top = 1;
> +
> +	if (raw_show_trace || !__kernel_text_address(pc)) {
> +		show_trace(stack);
> +		return;
> +	}
> +	printk("Call Trace:\n");
> +	while (__kernel_text_address(pc)) {
> +		printk(" [<%0*lx>] ", field, pc);
> +		print_symbol("%s\n", pc);
> +		pc = unwind_stack(task, &stack, pc);
> +		if (top && pc == 0)
> +			pc = regs->regs[31];	/* leaf? */
> +		top = 0;
> +	}
> +	printk("\n");
> +}
> +#else
> +#define show_frametrace(task, r) show_trace((long *)(r)->regs[29]);
> +#endif
> +
>  /*
>   * This routine abuses get_user()/put_user() to reference pointers
>   * with at least a bit of error checking ...
>   */
> -void show_stack(struct task_struct *task, unsigned long *sp)
> +static void show_stacktrace(struct task_struct *task, struct pt_regs *regs)
>  {
>  	const int field = 2 * sizeof(unsigned long);
>  	long stackdata;
>  	int i;
> -	unsigned long *stack;
> -
> -	if (!sp) {
> -		if (task && task != current)
> -			sp = (unsigned long *) task->thread.reg29;
> -		else
> -			sp = (unsigned long *) &sp;
> -	}
> -	stack = sp;
> +	unsigned long *sp = (unsigned long *)regs->regs[29];
>  
>  	printk("Stack :");
>  	i = 0;
> @@ -136,7 +165,44 @@ void show_stack(struct task_struct *task
>  		i++;
>  	}
>  	printk("\n");
> -	show_trace(stack);
> +	show_frametrace(task, regs);
> +}
> +
> +static noinline void dump_stack_top(struct pt_regs *regs)

This sounds weird, you're actually dumping v0, ra, and sp, no ?
If so "dump_stack_top" seems not be appropriate, does it ?

> +{
> +	__asm__ __volatile__(
> +		"1: la $2, 1b\n\t"
> +#ifdef CONFIG_64BIT
> +		"sd $2, %0\n\t"
> +		"sd $29, %1\n\t"
> +		"sd $31, %2\n\t"
> +#else
> +		"sw $2, %0\n\t"
> +		"sw $29, %1\n\t"
> +		"sw $31, %2\n\t"
> +#endif
> +		: "=m" (regs->cp0_epc),
> +		"=m" (regs->regs[29]), "=m" (regs->regs[31])
> +		: : "memory");
> +}
> +
> +void show_stack(struct task_struct *task, unsigned long *sp)
> +{
> +	struct pt_regs regs;
> +	if (sp) {
> +		regs.regs[29] = (unsigned long)sp;
> +		regs.regs[31] = 0;
> +		regs.cp0_epc = 0;
> +	} else {
> +		if (task && task != current) {
> +			regs.regs[29] = task->thread.reg29;
> +			regs.regs[31] = 0;
> +			regs.cp0_epc = task->thread.reg31;
> +		} else {
> +			dump_stack_top(&regs);
> +		}
> +	}
> +	show_stacktrace(task, &regs);
>  }
>  
>  /*
> @@ -146,6 +212,14 @@ void dump_stack(void)
>  {
>  	unsigned long stack;
>  
> +#ifdef CONFIG_KALLSYMS
> +	if (!raw_show_trace) {
> +		struct pt_regs regs;
> +		dump_stack_top(&regs);
> +		show_frametrace(current, &regs);
> +		return;
> +	}
> +#endif
>  	show_trace(&stack);
>  }
>  
> @@ -265,7 +339,7 @@ void show_registers(struct pt_regs *regs
>  	print_modules();
>  	printk("Process %s (pid: %d, threadinfo=%p, task=%p)\n",
>  	        current->comm, current->pid, current_thread_info(), current);
> -	show_stack(current, (long *) regs->regs[29]);
> +	show_stacktrace(current, regs);
>  	show_code((unsigned int *) regs->cp0_epc);
>  	printk("\n");
>  }
> 
> 
