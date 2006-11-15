Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2006 15:14:56 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:26823 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038917AbWKOPOu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Nov 2006 15:14:50 +0000
Received: from localhost (p6123-ipad25funabasi.chiba.ocn.ne.jp [220.104.84.123])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0972BBA89; Thu, 16 Nov 2006 00:14:47 +0900 (JST)
Date:	Thu, 16 Nov 2006 00:17:25 +0900 (JST)
Message-Id: <20061116.001725.75185058.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] rewrite restore_fp_context/save_fp_context
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061114174608.GA5740@linux-mips.org>
	<20041012.191154.90115222.nemoto@toshiba-tops.co.jp>
References: <20060620.003746.78731943.anemo@mba.ocn.ne.jp>
	<20060829.225631.41630441.anemo@mba.ocn.ne.jp>
	<20061114174608.GA5740@linux-mips.org>
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
X-archive-position: 13207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 14 Nov 2006 17:46:08 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> So with this patch applied the context will be copied around twice, first
> save the fp registers to memory then copied from memory to userspace and
> as the result the non-preemptible kernel will suffer from fixing the
> preemptible ...

Yes, it is true if the signaled process owned FPU at the time.  I
thought in many case the signaled process does not own FPU, but I
might be too optimistic indeed.

> To me it looks like the real problem that setup_sigcontext and
> restore_sigcontext need to disable preemption.  And the reason for that
> is probably that 87d54649f67d8ffe0a8d8176de8c210a6c4bb4a7 around 2.6.9
> took the wrong.  The better fix would probably have been to allow
> at least some fp instructions from kernel mode.  The sole reason for
> the die_if_kernel() call is to tell people attempting to put FPU code
> into the kernel that they're screwing up.

Hmm.  Two yeas ago I tried this approach to fix fpu-emulator issues
and gave up :) It was a bit complex more than it looked.  Here is
excerption:

On Tue, 12 Oct 2004 19:11:54 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> jsun> In terms of being simple, allowing kernel mode FPU trap is
> jsun> definitely simpler.
> 
> jsun> If you can't find any pitfalls of this approach it is actually
> jsun> robust.  The new FPU code is already greatly simplified.  It is
> jsun> possible kernel FPU trap is not that evil anymore (assuming
> jsun> kernel continues voluntarily not using FPU).
> 
> Hmm... OK, I agree enabling FPU trap in kernel seems simple.  I tried
> it today but it did not work unfortunately.  Just modifying a
> following line in traps.c was not enough.
> 
> 	die_if_kernel("do_cpu invoked from kernel context!", regs);
> 
> One point I found is do_cpu() must enable CU1 bit in pt_regs also.
> Another problem is that resume(), own_fpu() and lose_fpu() manipulate
> CU1 bit in only first level kernel stack (KSTK_STATUS(current)).
> current->thread.cp0_status may be manipulated also.  Modifying
> resume() looks too dangerous to me.

But it might be a good time to try again.  Do you think modifying
resume() etc. is OK?

---
Atsushi Nemoto
