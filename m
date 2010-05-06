Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 13:18:27 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:36082 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492263Ab0EFLSW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 13:18:22 +0200
Received: by wyi11 with SMTP id 11so197491wyi.36
        for <multiple recipients>; Thu, 06 May 2010 04:18:15 -0700 (PDT)
Received: by 10.227.143.149 with SMTP id v21mr4048077wbu.125.1273144695280;
        Thu, 06 May 2010 04:18:15 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-77-53-176.pppoe.mtu-net.ru [91.77.53.176])
        by mx.google.com with ESMTPS id x34sm1182403wbd.22.2010.05.06.04.18.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 04:18:14 -0700 (PDT)
Message-ID: <4BE2A54D.3020602@mvista.com>
Date:   Thu, 06 May 2010 15:17:33 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>
CC:     anemo@mba.ocn.ne.jp, kevink@paralogos.com,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2] MIPS FPU emulator: allow Cause bits of FCSR to be
 writeable by ctc1
References: <E1O9ttX-0002M5-Ku@localhost>
In-Reply-To: <E1O9ttX-0002M5-Ku@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

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
> v2: Replaced an ugly magic number with a constant for the reserved
> bits of the FPU CSR.
>
>  arch/mips/include/asm/mipsregs.h |    6 ++++++
>  arch/mips/math-emu/cp1emu.c      |    9 +++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 49382d5..1b17a21 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -135,6 +135,12 @@
>  #define FPU_CSR_COND7   0x80000000      /* $fcc7 */
>  
>  /*
> + * Bits 18 - 20 of the FPU Status Register will be read as 0,
> + * and should be written as zero.
> +*/
> +#define FPU_CSR_RSVD	0x001c0000
> +
> +/*
>   * X the exception cause indicator
>   * E the exception enable
>   * S the sticky/flag bit
> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
> index 8f2f8e9..ebecec6 100644
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
>   

   According to CodingStyle, the preferred style of multi-line comments is:

/*
 * bla
 * bla
 */

WBR, Sergei
