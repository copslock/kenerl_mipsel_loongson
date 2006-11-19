Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2006 13:51:32 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:38085 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038590AbWKSNv1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2006 13:51:27 +0000
Received: from localhost (p2074-ipad202funabasi.chiba.ocn.ne.jp [222.146.73.74])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 25F0EA6A4; Sun, 19 Nov 2006 22:51:22 +0900 (JST)
Date:	Sun, 19 Nov 2006 22:54:03 +0900 (JST)
Message-Id: <20061119.225403.93019610.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] rewrite restore_fp_context/save_fp_context
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061118.232717.07456069.anemo@mba.ocn.ne.jp>
References: <20061114174608.GA5740@linux-mips.org>
	<20061116.001725.75185058.anemo@mba.ocn.ne.jp>
	<20061118.232717.07456069.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 18 Nov 2006 23:27:17 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> So, we still should very careful to using fp instruction in kernel
> even if the instruction did not change the fpu state.  The last part
> of setup_sigcontext() should become something like this:
> 
> 	err |= __put_user(!!used_math(), &sc->sc_used_math);
> 
> 	/*
> 	 * Save FPU state to signal context.  Signal handler will "inherit"
> 	 * current FPU state.
> 	 */
> 	if (used_math()) {
> 		preempt_disable();
> 		if (!is_fpu_owner()) {
> 			own_fpu();
> 			restore_fp(current);
> 		}
> 		preempt_enable();
> 		err |= save_fp_context(sc);
> 	}
> 	return err;

Unfortunately, still this is not safe.  preempt_enable() might call
local_irq_enable() so it might lose fpu ownership without clearing CU1
bit...

So something like this ugly check should be needed.

 		preempt_disable();
 		if (!is_fpu_owner()) {
 			own_fpu();
 			restore_fp(current);
 		}
 		preempt_enable();
		/* make sure CU1 and FPU ownership are consistent */
		if (!__is_fpu_owner() && (read_c0_status() & ST0_CU1))
			__disable_fpu();
 		err |= save_fp_context(sc);
