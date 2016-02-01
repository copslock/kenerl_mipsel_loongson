Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 13:26:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26615 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011171AbcBAM0uGQ8Cl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 13:26:50 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 37FC1FA4A2083;
        Mon,  1 Feb 2016 12:26:41 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Mon, 1 Feb 2016
 12:26:43 +0000
Date:   Mon, 1 Feb 2016 12:26:42 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Jeffrey Merkey <jeffmerkey@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, <linux.mdb@gmail.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 21/31] Add debugger entry points for MIPS
In-Reply-To: <1454010437-29265-1-git-send-email-jeffmerkey@gmail.com>
Message-ID: <alpine.DEB.2.00.1602011150380.15885@tp.orcam.me.uk>
References: <1454010437-29265-1-git-send-email-jeffmerkey@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Thu, 28 Jan 2016, Jeffrey Merkey wrote:

> This patch series adds an export which can be set by system debuggers to
> direct the hard lockup and soft lockup detector to trigger a breakpoint
> exception and enter a debugger if one is active.  It is assumed that if
> someone sets this variable, then an breakpoint handler of some sort will
> be actively loaded or registered via the notify die handler chain.
> 
> This addition is extremely useful for debugging hard and soft lockups
> real time and quickly from a console debugger.

 What's the intended use case for this hook and what do you call a console 
debugger?

 I'm asking because from the debugging perspective the Linux kernel is a 
bare metal application and for such the BREAK instruction is not the usual 
choice on the MIPS target.  This instruction is normally used for userland 
debugging, it traps to the kernel and is handled there.  Furthermore there 
are a few other applications of this instruction defined as a part of the 
MIPS ABI, also handled by the kernel, determined by the breakpoint code 
embedded with the instruction word, e.g. to trap integer division errors.  
See arch/mips/include/uapi/asm/break.h for the codes defined so far.

 All this means the trap may not be appropriate for debugging the kernel 
itself as you don't want to intercept it or the system won't run 
correctly.  You'd have to hook into the kernel itself to intercept it too.

 But if you do have a working debug environment already set up around this 
arrangement, then it might be fine after all.  In that case I think using 
a non-zero breakpoint code would make sense though, as 0 is often treated 
as a random (spurious) trap (it was used by IRIX though).  Or do you 
detect it by the symbol name somehow?

 I've got a couple of further notes on the patch itself below.

> diff --git a/arch/mips/include/asm/kdebug.h b/arch/mips/include/asm/kdebug.h
> index 8e3d08e..af5999e 100644
> --- a/arch/mips/include/asm/kdebug.h
> +++ b/arch/mips/include/asm/kdebug.h
> @@ -16,4 +16,16 @@ enum die_val {
>  	DIE_UPROBE_XOL,
>  };
>  
> +
> +void arch_breakpoint(void)
> +{
> +	__asm__ __volatile__(
> +		".globl breakinst\n\t"

 Please keep formatting consistent -- the rest of code below uses `\t' as 
the separator, so use it here as well.  We don't have an established 
inline assembly formatting style, so please just keep your chosen one 
consistent.

> +		".set\tnoreorder\n\t"
> +		"nop\n"
> +		"breakinst:\tbreak\n\t"
> +		"nop\n\t"
> +		".set\treorder");
> +}
> +
>  #endif /* _ASM_MIPS_KDEBUG_H */

 Why do you need these NOPs around the breakpoint?  You also need to mark 
`breakinst' as a function symbol (`.aent' might do) or otherwise you'll 
get garbled disassembly if this is built as microMIPS code.

  Maciej
