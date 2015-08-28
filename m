Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2015 04:00:22 +0200 (CEST)
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:43320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007623AbbH1CAUa0RKj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2015 04:00:20 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 726EF12BA13;
        Fri, 28 Aug 2015 02:00:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fish05_1f92bbe37cb0c
X-Filterd-Recvd-Size: 3482
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2015 02:00:16 +0000 (UTC)
Message-ID: <1440727215.11525.122.camel@perches.com>
Subject: Re: [PATCH] MIPS: BCM63XX: Use pr_* instead of printk
From:   Joe Perches <joe@perches.com>
To:     Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Nicolas Schichan <nschichan@freebox.fr>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Aug 2015 19:00:15 -0700
In-Reply-To: <1440725410-2082-1-git-send-email-gregory.0xf0@gmail.com>
References: <1440725410-2082-1-git-send-email-gregory.0xf0@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Thu, 2015-08-27 at 18:30 -0700, Gregory Fong wrote:
>

If you ever do more of these, here are a few trivial style notes:

> diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c

> +#define pr_fmt(fmt) "board_bcm963xx: " fmt

Using:

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

is more common

> @@ -740,7 +741,7 @@ int bcm63xx_get_fallback_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
>  		memcpy(out, &bcm63xx_sprom, sizeof(struct ssb_sprom));
>  		return 0;
>  	} else {
> -		printk(KERN_ERR PFX "unable to fill SPROM for given bustype.\n");
> +		pr_err("unable to fill SPROM for given bustype.\n");

The periods at the end of logging lines are generally
superfluous and can be removed.

> @@ -808,7 +809,7 @@ void __init board_prom_init(void)
>  		char name[17];
>  		memcpy(name, board_name, 16);
>  		name[16] = 0;
> -		printk(KERN_ERR PFX "unknown bcm963xx board: %s\n",
> +		pr_err("unknown bcm963xx board: %s\n",
>  		       name);

It's nicer to unwrap lines where appropriate:

		pr_err("unknown bcm963xx board: %s\n", name);

> diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
[]
> @@ -376,10 +376,10 @@ void __init bcm63xx_cpu_init(void)
>  	bcm63xx_cpu_freq = detect_cpu_clock();
>  	bcm63xx_memory_size = detect_memory_size();
>  
> -	printk(KERN_INFO "Detected Broadcom 0x%04x CPU revision %02x\n",
> +	pr_info("Detected Broadcom 0x%04x CPU revision %02x\n",
>  	       bcm63xx_cpu_id, bcm63xx_cpu_rev);

It's nicer to reflow alignment for the entire statement to
keep the subsequent line arguments at the open parenthesis:

	pr_info("Detected Broadcom 0x%04x CPU revision %02x\n",
 		bcm63xx_cpu_id, bcm63xx_cpu_rev);

> +	pr_info("CPU frequency is %u MHz\n",
>  	       bcm63xx_cpu_freq / 1000000);

	pr_info("CPU frequency is %u MHz\n", bcm63xx_cpu_freq / 1000000);

etc...

> diff --git a/arch/mips/bcm63xx/timer.c b/arch/mips/bcm63xx/timer.c
[]
> @@ -195,7 +195,7 @@ int bcm63xx_timer_init(void)
>  	irq = bcm63xx_get_irq_number(IRQ_TIMER);
>  	ret = request_irq(irq, timer_interrupt, 0, "bcm63xx_timer", NULL);
>  	if (ret) {
> -		printk(KERN_ERR "bcm63xx_timer: failed to register irq\n");
> +		pr_err("bcm63xx_timer: failed to register irq\n");

It's sometimes nicer to change embedded function names
to use "%s: ", __func__

		pr_err("%s: failed to register irq\n", __func__);
