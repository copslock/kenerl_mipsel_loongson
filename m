Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 23:08:15 +0100 (BST)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:52195 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225242AbUJFWIL>; Wed, 6 Oct 2004 23:08:11 +0100
Received: from gateway.junsun.net (c-24-6-204-16.client.comcast.net[24.6.204.16])
          by comcast.net (sccrmhc13) with ESMTP
          id <2004100622080301600c595ae>; Wed, 6 Oct 2004 22:08:04 +0000
Received: from gateway.junsun.net (gateway [127.0.0.1])
	by gateway.junsun.net (8.12.8/8.12.8) with ESMTP id i96M9aTW021171;
	Wed, 6 Oct 2004 15:09:36 -0700
Received: (from jsun@localhost)
	by gateway.junsun.net (8.12.8/8.12.8/Submit) id i96M9akg021169;
	Wed, 6 Oct 2004 15:09:36 -0700
Date: Wed, 6 Oct 2004 15:09:36 -0700
From: Jun Sun <jsun@junsun.net>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: fpu_emulator can lose fpu on get_user/put_user
Message-ID: <20041006220936.GA21135@gateway.junsun.net>
References: <20041006.101920.126571873.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006.101920.126571873.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips

On Wed, Oct 06, 2004 at 10:19:20AM +0900, Atsushi Nemoto wrote:
> I found a potential problem in math emulation.  The math-emu uses
> put_user/get_user to fetch the instruction or to emulate load/store
> fp-regs.  The put_user/get_user can sleep then we can lose fpu
> ownership on it.  It it happened, subsequent restore_fp will cause CpU
> exception which not allowed in kernel.
> 
> Here is a quick fix.  Can be applied bath 2.4 and 2.6.  Could you apply?
> 

I don't feel good about this patch.  If emulator loses FPU ownership it should
get it back, not the caller of emulator.

Jun
 
> --- linux-mips/arch/mips/kernel/traps.c	Sat Aug 14 19:55:20 2004
> +++ linux/arch/mips/kernel/traps.c	Wed Oct  6 09:50:26 2004
> @@ -509,6 +509,10 @@
>  		/* Run the emulator */
>  		sig = fpu_emulator_cop1Handler (0, regs,
>  			&current->thread.fpu.soft);
> +		if (!is_fpu_owner()) {
> +			/* We might lose fpu in fpu_emulator. */
> +			own_fpu();
> +		}
>  
>  		/*
>  		 * We can't allow the emulated instruction to leave any of
> 
> 
> Also, there is another problem in the math-emu.  While math-emu is not
> reentrant, it will not work properly if a process lose ownership in
> the math-emu and another process uses the math-emu.  One possible fix
> is to save/restore ieee754_csr on get_user/put_user.  I will post a
> patch later.
> 
> ---
> Atsushi Nemoto
