Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Oct 2004 11:13:17 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:32784
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224919AbUJLKNM>; Tue, 12 Oct 2004 11:13:12 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 12 Oct 2004 10:13:10 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id EF4EB239E3B; Tue, 12 Oct 2004 19:12:59 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i9CACx3i003479;
	Tue, 12 Oct 2004 19:12:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 12 Oct 2004 19:11:54 +0900 (JST)
Message-Id: <20041012.191154.90115222.nemoto@toshiba-tops.co.jp>
To: jsun@junsun.net
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: fpu_emulator can lose fpu on get_user/put_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041011165424.GA28667@gateway.junsun.net>
References: <20041008194514.GB31533@gateway.junsun.net>
	<20041009.233810.74756865.anemo@mba.ocn.ne.jp>
	<20041011165424.GA28667@gateway.junsun.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 11 Oct 2004 09:54:24 -0700, Jun Sun <jsun@junsun.net> said:
jsun> I actually don't see which approach is more "simple and robust".

jsun> In terms of being simple, allowing kernel mode FPU trap is
jsun> definitely simpler.

jsun> If you can't find any pitfalls of this approach it is actually
jsun> robust.  The new FPU code is already greatly simplified.  It is
jsun> possible kernel FPU trap is not that evil anymore (assuming
jsun> kernel continues voluntarily not using FPU).

Hmm... OK, I agree enabling FPU trap in kernel seems simple.  I tried
it today but it did not work unfortunately.  Just modifying a
following line in traps.c was not enough.

	die_if_kernel("do_cpu invoked from kernel context!", regs);

One point I found is do_cpu() must enable CU1 bit in pt_regs also.
Another problem is that resume(), own_fpu() and lose_fpu() manipulate
CU1 bit in only first level kernel stack (KSTK_STATUS(current)).
current->thread.cp0_status may be manipulated also.  Modifying
resume() looks too dangerous to me.

Anyway, in math-emu case, we should call lose_fpu() BEFORE running the
emulator.  Since the emulator never use real FPU, we naturally call
own_fpu() AFTER the returning from the emulator.  It's simple.
Enabling kernel FPU trap is not needed.


>> It is safe?  get_user/put_user will fail if preempt disabled.  Excerpt
>> from do_page_fault:
>> 
>> 	/*
>> 	 * If we're in an interrupt or have no user
>> 	 * context, we must not take the fault..
>> 	 */
>> 	if (in_atomic() || !mm)
>> 		goto bad_area_nosemaphore;

jsun> It should be safe.  This might be a bug in kernel.  I bet
jsun> in_atomic() is "in_interrupt()" in older version of the code,
jsun> which seems to be the correct code.  When you diable preemption
jsun> you still have a process context.

But many archs have above check in do_page_fault() long time (since
2.5.32 at i386).  Are these all broken?


jsun> BTW, have you thought about possibly the third approach, which
jsun> is to somehow isolate the code segment where get_user/put_user
jsun> could cause page faults and then make sure all FPU manipulations
jsun> will succeed?

I took this approach to fix sigcontext problem.  Please look at
signal.c in my patch.

Thank you for quick comments.

---
Atsushi Nemoto
