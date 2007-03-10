Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2007 12:37:32 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:17898 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021824AbXCJMha (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Mar 2007 12:37:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2ACZYuo000571;
	Sat, 10 Mar 2007 12:35:34 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2ACZXd7000570;
	Sat, 10 Mar 2007 12:35:33 GMT
Date:	Sat, 10 Mar 2007 12:35:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Allow CpU exception in kernel partially
Message-ID: <20070310123533.GB516@linux-mips.org>
References: <20070310.012811.108982622.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070310.012811.108982622.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 10, 2007 at 01:28:11AM +0900, Atsushi Nemoto wrote:

> The save_fp_context()/restore_fp_context() might sleep on accessing
> user stack and therefore might lose FPU ownership in middle of them.
> Also we should not disable preempt around these functions.  This patch
> files this problem by allowing CpU exception in kernel partially.
> 
> * Introduce TIF_ALLOW_FP_IN_KERNEL thread flag.  If the flag was set,
>   CpU exception handler enables CU1 bit in interrupted kernel context
>   and returns without enabling interrupt (preempt) to make sure keep
>   FPU ownership until resume.
> * Introduce enable_fp_in_kernel() and disable_fp_in_kernel().  While
>   we might lost FPU ownership in middle of CP0_STATUS manipulation
>   (for example local_irq_disable()), we can not assume CU1 bit always
>   reflects TIF_USEDFPU.  Therefore enable_fp_in_kernel() must drop CU1
>   bit if TIF_USEDFPU was cleared.
> * The resume() function must drop CU1 bit in CP0_STATUS which are to
>   be saved.

Applied as well.  Thanks,

  Ralf
