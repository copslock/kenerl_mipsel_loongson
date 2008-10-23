Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 18:39:17 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:25655 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22232599AbYJWRjK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2008 18:39:10 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id F39313ECC; Thu, 23 Oct 2008 10:39:05 -0700 (PDT)
Message-ID: <4900B6A8.30705@ru.mvista.com>
Date:	Thu, 23 Oct 2008 21:38:48 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4938 SoC EBUS controller ATA mode.
> It has custom set_pio_mode and some hacks for big endian.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

> diff --git a/drivers/ide/mips/tx4938ide.c b/drivers/ide/mips/tx4938ide.c
> new file mode 100644
> index 0000000..fa660f9
> --- /dev/null
> +++ b/drivers/ide/mips/tx4938ide.c
> @@ -0,0 +1,310 @@
> +/*
> + * TX4938 internal IDE driver
> + * Based on tx4939ide.c.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * (C) Copyright TOSHIBA CORPORATION 2005-2007
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/ide.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <asm/txx9/tx4938.h>
> +
> +static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
> +				 unsigned int gbus_clock,
> +				 u8 pio)
> +{
> +	struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
> +	u64 cr = __raw_readq(&tx4938_ebuscptr->cr[ebus_ch]);
> +	unsigned int sp = (cr >> 4) & 3;
> +	unsigned int clock = gbus_clock / (4 - sp);
> +	unsigned int cycle = 1000000000 / clock;

    Hm, couldn't all these values be calculated only once?

> +	unsigned int wt, shwt;
> +
> +	/* Minimum DIOx- active time */
> +	wt = DIV_ROUND_UP(t->act8b, cycle) - 2;
> +	/* IORDY setup time: 35ns */
> +	wt = max(wt, DIV_ROUND_UP(35, cycle));

    Same comment about calculating only once...

> +	/* actual wait-cycle is max(wt & ~1, 1) */
> +	if (wt > 2 && (wt & 1))
> +		wt++;
> +	wt &= ~1;
> +	/* Address-valid to DIOR/DIOW setup */

    It's really address valid to -CSx assertion and -CSx to -DIOx assertion
setup time, and contrarywise, -DIOx to -CSx release and -CSx release to 
address invalid hold time, so it actualy applies 4 times and so constitutes 
-DIOx recovery time. It's worth to check if the minimum cycle time is reached 
with the setup time -- for PIO mode 0, minimum setup is 70 ns, multiplying 
that by 4 gives 280 ns recovery and adding 290 ns active time gives 570 ns 
cycle while the minimum is 600 ns.  Luckily, PIO0 seems the only problematic 
mode as I doubt that EBUS controller can do back-to-back IDE reads/writes 
keeping address and/or -CSx asserted in-between amounting to recovery time 
being only 2x/3x setup times -- in the worst, 2x case PIO mode 3 would also 
have too little cycle/recovery time...

> +	shwt = DIV_ROUND_UP(t->setup, cycle);
> +
> +	pr_debug("tx4938ide: ebus %d, bus cycle %dns, WT %d, SHWT %d\n",
> +		 ebus_ch, cycle, wt, shwt);
> +
> +	__raw_writeq((cr & ~(0x3f007ull)) | (wt << 12) | shwt,
> +		     &tx4938_ebuscptr->cr[ebus_ch]);

    Unneeded parens around the numeric constant.

> +static int __init tx4938ide_probe(struct platform_device *pdev)
> +{
[...]
> +	mapbase = (unsigned long)devm_ioremap(&pdev->dev, res->start,
> +					      res->end - res->start + 1);

    Calling devm_ioremap() on the whole 128 KB region wasn't such a great idea 
perhaps...

> +	ret = ide_host_add(&d, hws, &host);
> +	if (ret)
> +		return ret;
> +	platform_set_drvdata(pdev, host);
> +	return 0;

    I'd suggest shorter:

	if (!ret)
		platform_set_drvdata(pdev, host);
	return ret;

MBR, Sergei
