Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2004 20:43:51 +0100 (BST)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:63146 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225357AbUJHTnq>; Fri, 8 Oct 2004 20:43:46 +0100
Received: from gateway.junsun.net (c-24-6-204-16.client.comcast.net[24.6.204.16])
          by comcast.net (sccrmhc13) with ESMTP
          id <2004100819433601600c0r4ae>; Fri, 8 Oct 2004 19:43:37 +0000
Received: from gateway.junsun.net (gateway [127.0.0.1])
	by gateway.junsun.net (8.12.8/8.12.8) with ESMTP id i98JjFTW032156;
	Fri, 8 Oct 2004 12:45:15 -0700
Received: (from jsun@localhost)
	by gateway.junsun.net (8.12.8/8.12.8/Submit) id i98JjEbg032154;
	Fri, 8 Oct 2004 12:45:14 -0700
Date: Fri, 8 Oct 2004 12:45:14 -0700
From: Jun Sun <jsun@junsun.net>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: fpu_emulator can lose fpu on get_user/put_user
Message-ID: <20041008194514.GB31533@gateway.junsun.net>
References: <20041006.101920.126571873.nemoto@toshiba-tops.co.jp> <20041006220936.GA21135@gateway.junsun.net> <20041007.101558.126571743.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007.101558.126571743.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips

On Thu, Oct 07, 2004 at 10:15:58AM +0900, Atsushi Nemoto wrote:
> >>>>> On Wed, 6 Oct 2004 15:09:36 -0700, Jun Sun <jsun@junsun.net> said:
> >> I found a potential problem in math emulation.  The math-emu uses
> >> put_user/get_user to fetch the instruction or to emulate load/store
> >> fp-regs.  The put_user/get_user can sleep then we can lose fpu
> >> ownership on it.  It it happened, subsequent restore_fp will cause
> >> CpU exception which not allowed in kernel.
> 
> jsun> I don't feel good about this patch.  If emulator loses FPU
> jsun> ownership it should get it back, not the caller of emulator.
> 
> Hmm... Inserting following 2 lines after each get_user, put_user (and
> do_dsemulret, mips_dsemul, cond_resched) in cp1emu.c is better?
> 
> 	if (!is_fpu_owner())
> 		own_fpu();
> 
> Actually, FPU might be lost in get_user, so get_user should get it
> back?  I don't think so.  Similarly, getting it back by the caller of
> emulator is not so bad, I think.  Maintenance of FPU ownership is not
> emulator's work, isn't it?
> 

This problem is apparently bigger than I thought.

The FPU context is treated as a "half-way" process context in that
it is saved when a process is switched out and only restored on demand
when process uses FPU again.

Since only user code is allowed to use FPU, current kernel assumes 
restoring FPU registers must be triggered by user code.

Preemption in the middle FPU manipulation in kernel can cause trouble to above
assumptions but we can avoid it by using proper disable_preemption and
enable_preemption.

Now we basically face another trouble, i.e., put_user/get_user.

Maybe the easy way out is to allow FPU trap in kernel.  What do you
think?  The idea sounds dangerous but seems to be OK for the suitations
we are discussing here.

The other approach is basically your fix.  That is, if we are in the middle
of a block FPU manipulations, we ensure we have consistent FPU state
after each operation that could potentially switch the current process out.

As to where should we put the "if (....) own_fpu()", I think it should be
put right after the operation we could be switched out, i.e., get_user()/
put_user() in this case.

BTW, it is safe to disable preemption before calling anything functions
that could potentially block or switch current process out.

Jun
