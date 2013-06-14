Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 12:31:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60529 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825747Ab3FNKbniewH0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 12:31:43 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5EAVeuP017342;
        Fri, 14 Jun 2013 12:31:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5EAVcSx017341;
        Fri, 14 Jun 2013 12:31:38 +0200
Date:   Fri, 14 Jun 2013 12:31:37 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 1/3] MIPS: BCM63XX: Add SMP support to prom.c
Message-ID: <20130614103137.GA15775@linux-mips.org>
References: <1370273975-12373-1-git-send-email-jogo@openwrt.org>
 <1370273975-12373-2-git-send-email-jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370273975-12373-2-git-send-email-jogo@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Jun 03, 2013 at 05:39:33PM +0200, Jonas Gorski wrote:

> 
> This involves two changes to the BSP code:
> 
> 1) register_smp_ops() for BMIPS SMP
> 
> 2) The CPU1 boot vector on some of the BCM63xx platforms conflicts with
> the special interrupt vector (IV).  Move it to 0x8000_0380 at boot time,
> to resolve the conflict.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> [jogo@openwrt.org: moved SMP ops registration into ifdef guard]
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
>  arch/mips/bcm63xx/prom.c |   33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
> index fd69808..1209373 100644
> --- a/arch/mips/bcm63xx/prom.c
> +++ b/arch/mips/bcm63xx/prom.c
> @@ -8,7 +8,11 @@
>  
>  #include <linux/init.h>
>  #include <linux/bootmem.h>
> +#include <linux/smp.h>
>  #include <asm/bootinfo.h>
> +#include <asm/bmips.h>
> +#include <asm/smp-ops.h>
> +#include <asm/mipsregs.h>
>  #include <bcm63xx_board.h>
>  #include <bcm63xx_cpu.h>
>  #include <bcm63xx_io.h>
> @@ -52,6 +56,35 @@ void __init prom_init(void)
>  
>  	/* do low level board init */
>  	board_prom_init();
> +
> +#if defined(CONFIG_CPU_BMIPS4350) && defined(CONFIG_SMP)
> +	/* set up SMP */
> +	register_smp_ops(&bmips_smp_ops);

The call to register_smp_ops() can remain outside the #ifdef.  It's defined
as:

static inline void register_smp_ops(struct plat_smp_ops *ops)
{
}

so the compiler will completly discard it and the referenced SMP ops.

> +
> +	/*
> +	 * BCM6328 does not have its second CPU enabled, while BCM6358
> +	 * needs special handling for its shared TLB, so disable SMP for now.
> +	 */
> +	if (BCMCPU_IS_6328() || BCMCPU_IS_6358()) {
> +		bmips_smp_enabled = 0;
> +		return;
> +	}
> +
> +	/*
> +	 * The bootloader has set up the CPU1 reset vector at 0xa000_0200.
> +	 * This conflicts with the special interrupt vector (IV).
> +	 * The bootloader has also set up CPU1 to respond to the wrong
> +	 * IPI interrupt.
> +	 * Here we will start up CPU1 in the background and ask it to
> +	 * reconfigure itself then go back to sleep.
> +	 */
> +	memcpy((void *)0xa0000200, &bmips_smp_movevec, 0x20);
> +	__sync();
> +	set_c0_cause(C_SW0);
> +	cpumask_set_cpu(1, &bmips_booted_mask);
> +
> +	/* FIXME: we really should have some sort of hazard barrier here */

Any reason why the remainder of this code can't go into the smp_setup
method?  That then would entirely eleminate the <censored> ifdef.

  Ralf
