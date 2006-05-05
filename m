Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2006 17:07:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57300 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133502AbWEEQH2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2006 17:07:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k45G7RB1012383;
	Fri, 5 May 2006 17:07:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k45G7QCY012382;
	Fri, 5 May 2006 17:07:26 +0100
Date:	Fri, 5 May 2006 17:07:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Zhan, Rongkai" <rongkai.zhan@windriver.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Wind River 4KC PPMC Eval Board Support
Message-ID: <20060505160726.GA9309@linux-mips.org>
References: <6A3254532ACD7A42805B4E1BFD18080EB307A0@ism-mail01.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A3254532ACD7A42805B4E1BFD18080EB307A0@ism-mail01.corp.ad.wrs.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 05, 2006 at 05:42:04PM +0200, Zhan, Rongkai wrote:

> Here is a patch to add the support for Wind River 4KC PPMC Evaluation
> board, which is based on the GT64120 bridge chip.

Standard problem: This patch has line-wrapped lines so can't be applied ...

> 1970-01-01 08:00:00.000000000 +0800
> +++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/int-handler.S
> 2006-05-05 16:38:12.000000000 +0800
> @@ -0,0 +1,37 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General
> Public
> + * License.  See the file "COPYING" in the main directory of this
> archive
> + * for more details.
> + *
> + * Copyright (C) 1995, 1996, 1997, 2003 by Ralf Baechle
> + * Copyright (C) Wind River System Inc. Rongkai.Zhan
> <rongkai.zhan@windriver.com>
> + */
> +#include <asm/asm.h>
> +#include <asm/mipsregs.h>
> +#include <asm/addrspace.h>
> +#include <asm/regdef.h>
> +#include <asm/stackframe.h>
> +
> +	.align	5
> +	.set	noat
> +NESTED(handle_IRQ, PT_SIZE, sp)
> +	SAVE_ALL
> +	CLI				# Important: mark KERNEL mode !
> +
> +	mfc0	t0, CP0_CAUSE		# get pending interrupts
> +	mfc0	t1, CP0_STATUS		# get enabled interrupts
> +	and	t0, t0, t1		# get allowed interrupts
> +	andi	t0, t0, 0xFF00
> +	beqz	t0, 1f
> +
> +	move	a0, sp			# Prepare 'struct pt_regs *regs'
> pointer
> +	jal	do_wrppmc_IRQ
> +	nop
> +	j	ret_from_irq
> +	nop
> +
> +	/* wrong alarm or masked ... */
> +1:	j	spurious_interrupt
> +	nop
> +END(handle_IRQ)

Changeset e4ac58afdfac792c0583af30dbd9eae53e24c78b rewrites all interrupt
handlers from assembler to C, so your patche does no longer work.  Can you
create a patch against the master branch, please?

> +	printk(KERN_NOTICE "You can safely turn off the power\n");

This looks sooo windowsy ;-)

  Ralf
