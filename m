Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 00:32:38 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:52254 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822681Ab3EVWcdrspeh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 00:32:33 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 0613B5A6FAE;
        Thu, 23 May 2013 01:32:33 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id pOaekSc83evF; Thu, 23 May 2013 01:32:28 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with SMTP id 4A2AE5BC006;
        Thu, 23 May 2013 01:32:26 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Thu, 23 May 2013 01:32:25 +0300
Date:   Thu, 23 May 2013 01:32:25 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH] MIPS: Enable interrupts before WAIT instruction.
Message-ID: <20130522223225.GH31836@blackmetal.musicnaut.iki.fi>
References: <CA+55aFwDGyHOzu=Qh7SJOBK6QvAwAh7pMDL6LfMUE=AW_kapAw@mail.gmail.com>
 <1367527692-25809-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1367527692-25809-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Thu, May 02, 2013 at 01:48:12PM -0700, David Daney wrote:
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
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Reported-by: EunBong Song <eunb.song@samsung.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jonas Gorski <jogo@openwrt.org>
> ---
> 
> This is only very lightly tested, we need more testing before
> declaring it the definitive fix.

I wonder what is the status of this patch? Or is there some alternative
fix?

I have Octeon+ board that hangs during 3.10-rc2 boot in spawn_ksoftirqd()
without this. Also, this patch does not apply cleanly to 3.10-rc2
anymore...

A.

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
