Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 11:50:40 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:58873 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009207AbcATKuaGzaBs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jan 2016 11:50:30 +0100
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::1000])
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <aurelien@aurel32.net>)
        id 1aLqLN-0003i3-0B; Wed, 20 Jan 2016 11:50:29 +0100
Received: from aurel32 by ohm.aurel32.net with local (Exim 4.86)
        (envelope-from <aurelien@aurel32.net>)
        id 1aLqLM-0007CY-LR; Wed, 20 Jan 2016 11:50:28 +0100
Date:   Wed, 20 Jan 2016 11:50:28 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 37/48] MIPS: math-emu: Correct delay-slot exception
 propagation
Message-ID: <20160120105028.GA27361@aurel32.net>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
 <alpine.LFD.2.11.1504031834270.21028@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1504031834270.21028@eddie.linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi,

On 2015-04-03 23:26, Maciej W. Rozycki wrote:
> Restore EPC at the branch whose delay slot is emulated if the delay-slot 
> instruction signals.  This is so that code in `fpu_emulator_cop1Handler' 
> does not see EPC having advanced and mistakenly successfully resume 
> userland execution from the location at the branch target in that case.
> Restoring EPC guarantees an immediate exit from the emulation loop and 
> if EPC hasn't advanced at all since entering the loop, also issuing the 
> signal reported by the delay-slot instruction.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---

Unfortunately this patch broke the case where the delay slot contains a
NOP instruction. In practice this causes a lot of code to now fails with
a SIGILL. For example the following code, extracted from R, reports a
SIGILL address 0x76f29670.

=> 0x76f29670:  ldc1    $f2,40(s8)
   0x76f29674:  ldc1    $f0,40(s8)
   0x76f29678:  add.d   $f0,$f2,$f0
   0x76f2967c:  sdc1    $f0,40(s8)
   0x76f29680:  ldc1    $f2,40(s8)
   0x76f29684:  ldc1    $f0,80(s8)
   0x76f29688:  add.d   $f0,$f2,$f0
   0x76f2968c:  sdc1    $f0,96(s8)
   0x76f29690:  ldc1    $f2,96(s8)
   0x76f29694:  ldc1    $f0,40(s8)
   0x76f29698:  sub.d   $f0,$f2,$f0
   0x76f2969c:  sdc1    $f0,112(s8)
   0x76f296a0:  ldc1    $f2,112(s8)
   0x76f296a4:  ldc1    $f0,80(s8)
   0x76f296a8:  sub.d   $f2,$f2,$f0
   0x76f296ac:  ldc1    $f0,144(s8)
   0x76f296b0:  c.eq.d  $f2,$f0
   0x76f296b4:  bc1t    0x76f29670
   0x76f296b8:  nop

The issues lies in the following part of the patch:

> --- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:57.493218000 +0100
> +++ linux/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:57.710224000 +0100
> @@ -1192,16 +1208,24 @@ static int cop1Emulate(struct pt_regs *x
>  						if (cpu_has_mips_4_5_r)
>  							goto emul;
>  
> -						return SIGILL;
> +						goto bc_sigill;
>  					}
>  					break;
> +
> +				bc_sigill:
> +					xcp->cp0_epc = bcpc;
> +					return SIGILL;
>  				}
>  
>  				/*
>  				 * Single step the non-cp1
>  				 * instruction in the dslot
>  				 */
> -				return mips_dsemul(xcp, ir, contpc);
> +				sig = mips_dsemul(xcp, ir, contpc);
> +				if (sig)
> +					xcp->cp0_epc = bcpc;
> +				/* SIGILL forces out of the emulation loop.  */
> +				return sig ? sig : SIGILL;

This assumes we should get out of the emulation loop if the returned
value is 0. However this value is used to signal the instruction has
been emulated in case of a NOP.

>  			} else if (likely) {	/* branch not taken */
>  				/*
>  				 * branch likely nullifies
> Index: linux/arch/mips/math-emu/dsemul.c
> ===================================================================
> --- linux.orig/arch/mips/math-emu/dsemul.c	2015-04-02 20:27:57.133225000 +0100
> +++ linux/arch/mips/math-emu/dsemul.c	2015-04-02 20:27:57.713219000 +0100
> @@ -96,7 +96,7 @@ int mips_dsemul(struct pt_regs *regs, mi
>  
>  	flush_cache_sigtramp((unsigned long)&fr->emul);
>  
> -	return SIGILL;		/* force out of emulation loop */
> +	return 0;

With this change there is no way to distinguish the NOP case and the
normal instruction case anymore.


An easy workaround to the issue (with performance impact though) is to
get rid of the NOP special case in dsemul.c

diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index cbb36c1..c6e3901 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -35,7 +35,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 {
 	struct emuframe __user *fr;
 	int err;
-
+#if 0
 	if ((get_isa16_mode(regs->cp0_epc) && ((ir >> 16) == MM_NOP16)) ||
 		(ir == 0)) {
 		/* NOP is easy */
@@ -43,7 +43,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 		clear_delay_slot(regs);
 		return 0;
 	}
-
+#endif
 	pr_debug("dsemul %lx %lx\n", regs->cp0_epc, cpc);
 
 	/*

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
