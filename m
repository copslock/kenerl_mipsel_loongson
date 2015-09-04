Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Sep 2015 20:52:49 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27013587AbbIDSwrPEf3E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Sep 2015 20:52:47 +0200
Date:   Fri, 4 Sep 2015 19:52:47 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Yousong Zhou <yszhou4tech@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, Chen Jie <chenj@lemote.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: UAPI: Fix unrecognized opcode WSBH/DSBH/DSHD when
 using MIPS16.
In-Reply-To: <1441273665-15601-1-git-send-email-yszhou4tech@gmail.com>
Message-ID: <alpine.LFD.2.20.1509041924220.10227@eddie.linux-mips.org>
References: <1441273665-15601-1-git-send-email-yszhou4tech@gmail.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Thu, 3 Sep 2015, Yousong Zhou wrote:

> The nomips16 has to be added both as function attribute and assembler
> directive.
> 
> When only function attribute is specified, the compiler will inline the
> function with -Os optimization.  The generated assembly code cannot be
> correctly assembled because ISA mode switch has to be done through jump
> instruction.

 This can't be true.  The compiler does not intepret the contents of an 
inline asm and therefore cannot decide whether to inline a function 
containing one or not based on the lone presence or the absence of an 
assembly directive within.

> When only ".set nomips16" directive is used, the generated assembly code
> will use MIPS32 code for the inline assembly template and MIPS16 for the
> function return.  The compiled binary is invalid:
> 
>     00403100 <__arch_swab16>:
>       403100:   7c0410a0    wsbh    v0,a0
>       403104:   e820ea31    swc2    $0,-5583(at)
> 
> while correct code should be:
> 
>     00402650 <__arch_swab16>:
>       402650:   7c0410a0    wsbh    v0,a0
>       402654:   03e00008    jr  ra
>       402658:   3042ffff    andi    v0,v0,0xffff

 It looks to me you're papering something over here -- when you use a 
`.set nomips16' directive the assembler will happily switch your 
instruction set in the middle of an instruction stream.  Consequently if 
this function is (for whatever reason; it should not really) inlined in 
MIPS16 code, then you'll get a MIPS32 instruction in the middle, which 
will obviously be interpreted differently in the MIPS16 execution mode and 
is therefore surely a recipe for disaster.

 How did you test your change and made the conclusion quoted with your 
patch description?

> Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
> ---
>  arch/mips/include/uapi/asm/swab.h |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
> index 8f2d184..c4ddc4f 100644
> --- a/arch/mips/include/uapi/asm/swab.h
> +++ b/arch/mips/include/uapi/asm/swab.h
> @@ -16,11 +16,13 @@
>  #if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||		\
>      defined(_MIPS_ARCH_LOONGSON3A)
>  
> -static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
> +static inline __attribute__((nomips16)) __attribute_const__
> +		__u16 __arch_swab16(__u16 x)
>  {
>  	__asm__(
>  	"	.set	push			\n"
>  	"	.set	arch=mips32r2		\n"
> +	"	.set	nomips16		\n"
>  	"	wsbh	%0, %1			\n"
>  	"	.set	pop			\n"
>  	: "=r" (x)

 So setting aside the correctness issues discussed above, for MIPS16 code 
this has to be put out of line by the compiler, with all the usual 
overhead of a function call, causing a performance loss rather than a gain 
expected here.  Especially as switching the ISA mode requires draining the 
whole pipeline so that subsequent instructions are interpreted in the new 
execution mode.  This is expensive in performance terms.

 I'm fairly sure simply disabling these asms (#ifndef __mips16) and 
letting the compiler generate the right mask and shift operations from 
plain C code will be cheaper in performance terms and possibly cheaper in 
code size as well, especially in otherwise leaf functions where an extra 
function call will according to the ABI clobber temporaries.  So I suggest 
going in that direction instead.

 So this is a NAK really.

  Maciej
