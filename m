Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 09:48:40 +0200 (CEST)
Received: from gateway09.websitewelcome.com ([67.18.22.68]:60191 "HELO
        gateway09.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491860Ab0EEHsg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 09:48:36 +0200
Received: (qmail 28273 invoked from network); 5 May 2010 07:51:41 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway09.websitewelcome.com with SMTP; 5 May 2010 07:51:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=ivs9+/MjjRlRpsrIqOouE/nJo4KqLSYY24vrCebp35qVVNzmYpW6IYDwVxcqoaP1YIsMOeRrAWdFMdVsI0jkN7M94LVXw9NijClTLUS6S6VupBUJeurJJykjqiGPje7v;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:4411 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O9ZLK-0006IL-9s; Wed, 05 May 2010 02:48:30 -0500
Message-ID: <4BE122D1.3000609@paralogos.com>
Date:   Wed, 05 May 2010 00:48:33 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable
 by ctc1
References: <E1O9VoP-0001Zl-Qw@localhost>
In-Reply-To: <E1O9VoP-0001Zl-Qw@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

I'm glad to hear that the patch is functional.  It was pretty clear that
it would solve your problem, but I was concerned that the inability to
write the Cause bits was done as a way around some other problem. 
Someone went to a certain amount of trouble to not accept them as
inputs, in violation of spec.  I just looked back, and the bug was
introduced as part of a patch of Ralf's from April 2005 entitled "Fix
Preemption and SMP problems in the FP emulator".  It's unlikely that
overriding CTC semantics actually fixed any underlying problems, but it
may have masked symptoms of problems that we can only hope have been
fixed in the mean time. Anyone run this patch on an FPUless SMP?   Oh,
for a 34Kf with a bunch of TCs! ;o)

Shane McDonald wrote:
> In the FPU emulator code of the MIPS, the Cause bits of the FCSR
> register are not currently writeable by the ctc1 instruction.
> In odd corner cases, this can cause problems.  For example,
> a case existed where a divide-by-zero exception was generated
> by the FPU, and the signal handler attempted to restore the FPU
> registers to their state before the exception occurred.  In this
> particular setup, writing the old value to the FCSR register
> would cause another divide-by-zero exception to occur immediately.
> The solution is to change the ctc1 instruction emulator code to
> allow the Cause bits of the FCSR register to be writeable.
> This is the behaviour of the hardware that the code is emulating.
>
> This problem was found by Shane McDonald, but the credit for the
> fix goes to Kevin Kissell.  In Kevin's words:
>
> I submit that the bug is indeed in that ctc_op:  case of the emulator.  The
> Cause bits (17:12) are supposed to be writable by that instruction, but the
> CTC1 emulation won't let them be updated by the instruction.  I think that
> actually if you just completely removed lines 387-388 [...]
> things would work a good deal better.  At least, it would be a more accurate
> emulation of the architecturally defined FPU.  If I wanted to be really,
> really pedantic (which I sometimes do), I'd also protect the reserved bits
> that aren't necessarily writable.
>
> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
> ---
>  arch/mips/math-emu/cp1emu.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
> index 8f2f8e9..c756fd9 100644
> --- a/arch/mips/math-emu/cp1emu.c
> +++ b/arch/mips/math-emu/cp1emu.c
> @@ -384,10 +384,11 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
>  					(void *) (xcp->cp0_epc),
>  					MIPSInst_RT(ir), value);
>  #endif
> -				value &= (FPU_CSR_FLUSH | FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
> -				ctx->fcr31 &= ~(FPU_CSR_FLUSH | FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
> -				/* convert to ieee library modes */
> -				ctx->fcr31 |= (value & ~0x3) | ieee_rm[value & 0x3];
> +
> +				/* Don't write reserved bits,
> +				   and convert to ieee library modes */
> +				ctx->fcr31 = (value & ~0x1c0003) |
> +						ieee_rm[value & 0x3];
>  			}
>  			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
>  				return SIGFPE;
>   
