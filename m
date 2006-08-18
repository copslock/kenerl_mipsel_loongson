Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 03:52:23 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:63072 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037717AbWHRCwV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 03:52:21 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 18 Aug 2006 11:52:20 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 6D184201C0;
	Fri, 18 Aug 2006 11:52:14 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5A1B020041;
	Fri, 18 Aug 2006 11:52:14 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k7I2qDW0087402;
	Fri, 18 Aug 2006 11:52:13 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 18 Aug 2006 11:52:13 +0900 (JST)
Message-Id: <20060818.115213.108739385.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mfinfo[64] used by get_wchan()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44E475C8.5000105@innova-card.com>
References: <44E475C8.5000105@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 17 Aug 2006 15:57:28 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> This array was used to 'cache' some frame info about scheduler
> functions to speed up get_wchan(). This array was 1Ko size and
> was only used when CONFIG_KALLSYMS was set but declared for all
> configs.
> 
> Rather than make the array statement conditional, this patches
> removes this array and its uses. Indeed the common case doesn't
> seem to use this array and get_wchan() is not a critical path
> anyways.

It looks good basically, but a few fixes are required.

>  static int __init frame_info_init(void)
>  {
> -	int i;
> +	unsigned long size = 0;

You must pass some non-zero size even if CONFIG_KALLSYMS was not set.
Otherwise schedule_mfi will not be initialized as expected.  Actually,
this is not a problem of this patch, but we missed this point on
previous cleanups for the get_frame_info()...

> +unsigned long get_wchan(struct task_struct *task)
> +{
> +	unsigned long stack_page = (unsigned long)task_stack_page(task);

This should be done after "if (!task ..." check.

> +	unsigned long pc = 0;
> +#ifdef CONFIG_KALLSYMS
> +	unsigned long sp = task->thread.reg29;

Same.  And you missed one stack level.

	sp = task->thread.reg29 + schedule_mfi.frame_size;

> +#endif
> +
> +	if (!task || task == current || task->state == TASK_RUNNING)
> +		goto out;
> +	if (!stack_page)
> +		goto out;
> +
> +	pc = thread_saved_pc(task);
> +
> +#ifdef CONFIG_KALLSYMS
> +	while (in_sched_functions(pc))
> +		pc = unwind_stack(task, &sp, pc, 0);
> +#endif
> +
> +out:
> +	return pc;
> +}

Thanks for your work.

---
Atsushi Nemoto
