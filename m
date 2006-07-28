Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 16:43:28 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:34813 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133772AbWG1PnR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Jul 2006 16:43:17 +0100
Received: from localhost (p7008-ipad205funabasi.chiba.ocn.ne.jp [222.146.102.8])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6935BB530; Sat, 29 Jul 2006 00:43:12 +0900 (JST)
Date:	Sat, 29 Jul 2006 00:44:42 +0900 (JST)
Message-Id: <20060729.004442.96686266.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com>
	<44C8CEA4.20000@innova-card.com>
References: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>
	<44C8CEA4.20000@innova-card.com>
	<cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com>
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
X-archive-position: 12109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Hi, Franck.  Thank you for detailed review.

On Thu, 27 Jul 2006 16:33:08 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > +		if (info->pc_offset < 0 || info->frame_size == 0) {
> > +			if (info->func == schedule)
> 
> This can't happen since "schedule" is not a leaf function. Something I'm
> missing here but I would have said:
> 
> 			if (func != schedule)
> 
> instead, no ?

This "if (info->func == schedule)" condition is originally in current
get_frame_info().  And it was added to report "Can't analyze" message
only for schedule() function.  This is because we can get at least
somewhat worth results for thread_saved_pc() and get_wchan() if the
frame information for the schedule() could be analyzed.  The frame
information for other functions just make get_wchan()'s result better.

> > +	if (info.pc_offset < 0 || !info.frame_size) {
> > +		/* leaf? */
> 
> for leaf case, can't we simply do this test:
> 
> 	if (info.pc_offset < 0) {
> 
> IOW, can a leaf function move sp ? I would say yes...

Normally, we can omit "!info.frame_size".  But as I wrote in other
mail, I think it is hard to make perfect get_frame_info().  We should
handle any wired result from get_frame_info().

> BTW why not let this logic inside get_frame_info() ? Hence this function
> could return:
> 
> 	if (info.frame_size && info.pc_offset > 0) /* nested */
> 		return 0;
> 	if (info.pc_offset < 0) /* leaf */
> 		return 1;
> 	/* prologue seems boggus... */
> 	printk("Can't analyze prologue code at %p\n", info->func);
> 	return -1;

Indeed.  I'll make new patch.  But I think put printk() in
get_frame_info() not good because now I want to use it for
show_trace().  I don't want to see the "Can't analyze" message in oops
log.

> > +		*sp += info.frame_size / sizeof(long);
> > +		return 0;
> 
> why not returning:
> 		return regs->regs[31];
> 
> and removes the leaf detection logic in show_frametrace() ?

Because unwind_stack() does not have "regs" argument.  The RA
information is only needed for leaf (i.e. top on stack trace) and
unwind_stack() is used for any level of stack, so I think it is better
to handle the leaf case in show_frametrace().

> > +	pc = (*sp)[info.pc_offset];
> > +	*sp += info.frame_size / sizeof(long);
> > +	return pc;
> 
> why not directly doing:
> 
> 	return (*sp)[info.pc_offset];
> 
> and remove:
> 
> 	pc = (*sp)[info.pc_offset];

This is wrong.  The *sp must be modified before return.

> > +	unsigned long *stack = (long *)regs->regs[29];
> 
> why not calling that "sp" ?

Just because show_trace() named it "stack" :-)

---
Atsushi Nemoto
