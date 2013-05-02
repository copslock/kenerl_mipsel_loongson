Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 23:04:27 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:43083 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835069Ab3EBVEXHxir0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 May 2013 23:04:23 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1UY0fs-0007nA-VE; Thu, 02 May 2013 23:04:21 +0200
Date:   Thu, 2 May 2013 23:04:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH] MIPS: Enable interrupts before WAIT instruction.
In-Reply-To: <1367527692-25809-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <alpine.LFD.2.02.1305022303510.2891@ionos>
References: <CA+55aFwDGyHOzu=Qh7SJOBK6QvAwAh7pMDL6LfMUE=AW_kapAw@mail.gmail.com> <1367527692-25809-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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



On Thu, 2 May 2013, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> As noted by Thomas Gleixner:
> 
>    commit cdbedc61c8 (mips: Use generic idle loop) broke MIPS as I did
>    not realize that MIPS wants to invoke the wait instructions with
>    interrupts enabled.
> 
> Instead of enabling interrupts in arch_cpu_idle() as Thomas' initial
> patch does, we follow Linus' suggestion of doing it in the assembly
> code to prevent the compiler from rearranging things.

Yeah, that looks way more sane.

 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Reported-by: EunBong Song <eunb.song@samsung.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jonas Gorski <jogo@openwrt.org>
> ---
> 
> This is only very lightly tested, we need more testing before
> declaring it the definitive fix.
> 
>  arch/mips/kernel/genex.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index ecb347c..57cda9a 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -132,12 +132,13 @@ LEAF(r4k_wait)
>  	.set	noreorder
>  	/* start of rollback region */
>  	LONG_L	t0, TI_FLAGS($28)
> -	nop
>  	andi	t0, _TIF_NEED_RESCHED
>  	bnez	t0, 1f
>  	 nop
> -	nop
> -	nop
> +	/* Enable interrupts so WAIT will complete */
> +	mfc0	t0, CP0_STATUS
> +	ori	t0, ST0_IE
> +	mtc0	t0, CP0_STATUS
>  	.set	mips3
>  	wait
>  	/* end of rollback region (the region size must be power of two) */
> -- 
> 1.7.11.7
> 
> 
