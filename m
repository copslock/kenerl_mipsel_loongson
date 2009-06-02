Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 13:52:30 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34532 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022035AbZFBMwX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 13:52:23 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n52Cq0pB022353;
	Tue, 2 Jun 2009 13:52:00 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n52CpxUH022351;
	Tue, 2 Jun 2009 13:51:59 +0100
Date:	Tue, 2 Jun 2009 13:51:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, openwrt-devel@lists.openwrt.org
Subject: Re: [PATCH 08/10] add TI AR7 support
Message-ID: <20090602125159.GC11488@linux-mips.org>
References: <200906011402.05768.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200906011402.05768.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 01, 2009 at 02:02:05PM +0200, Florian Fainelli wrote:

> Subject: [PATCH 08/10] add TI AR7 support

This should be 7/9 I assume?

> +	if (base / (*prediv) * (*mul) / (*postdiv) != target) {

There should be a tax on excessive use of parenthesis ;-)

> +		approximate(base, target, prediv, postdiv, mul);
> +		tmp_freq = base / (*prediv) * (*mul) / (*postdiv);

More taxes!

> +
> +	writel(((prediv - 1) << PREDIV_SHIFT) | (postdiv - 1), &clock->ctrl);
> +	mdelay(1);
> +	writel(4, &clock->pll);
> +	while (readl(&clock->pll) & PLL_STATUS)
> +		;
> +	writel(((mul - 1) << MUL_SHIFT) | (0xff << 3) | 0x0e, &clock->pll);
> +	mdelay(75);

These calls to mdelay seem to be done very early before BogoMIPS has been
calibrated?

> +	printk(KERN_INFO "Clocks: Setting USB clock\n");
> +	usb_base = ar7_bus_clock;
> +	calculate(usb_base, TNETD7200_DEF_USB_CLK, &usb_prediv,
> +		&usb_postdiv, &usb_mul);
> +	tnetd7200_set_clock(usb_base, &clocks->usb,
> +		usb_prediv, usb_postdiv, -1, usb_mul,
> +		TNETD7200_DEF_USB_CLK);
> +
> +	#warning FIXME
> +	ar7_dsp_clock = ar7_cpu_clock;

Fix it :-)

> +void __init ar7_init_clocks(void)
> +{
> +	switch (ar7_chip_id()) {
> +	case AR7_CHIP_7100:
> +#warning FIXME: Check if the new 7200 clock init works for 7100

Fix it again, Toni.

> diff --git a/arch/mips/ar7/memory.c b/arch/mips/ar7/memory.c
> new file mode 100644
> index 0000000..e8522a1
> --- /dev/null
> +++ b/arch/mips/ar7/memory.c
> @@ -0,0 +1,74 @@
> +/*
> + * Based on arch/mips/mm/init.c
> + * Copyright (C) 1994 - 2000 Ralf Baechle
> + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> + * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.

Somehow this file has no similarity to arch/mips/mm/init.c so I think
somebody else should claim the (C).

> --- /dev/null
> +++ b/arch/mips/ar7/platform.c
> @@ -0,0 +1,543 @@
> +/*
> + * Copyright (C) 2006,2007 Felix Fietkau <nbd@openwrt.org>
> + * Copyright (C) 2006,2007 Eugene Konev <ejka@openwrt.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#include <linux/autoconf.h>

Do not include <linux/autoconf.h>.

> +static struct platform_device vlynq_high = {
> +	.id = 1,
> +	.name = "vlynq",
> +	.dev.platform_data = &vlynq_high_data,
> +	.resource = vlynq_high_res,
> +	.num_resources = ARRAY_SIZE(vlynq_high_res),
> +};
> +
> +
> +/* This is proper way to define uart ports, but they are then detected
> + * as xscale and, obviously, don't work...
> + */
> +#if !defined(CONFIG_SERIAL_8250)

Can you elaborate?

> +static inline unsigned char char2hex(char h)
> +{
> +	switch (h) {
> +	case '0': case '1': case '2': case '3': case '4':
> +	case '5': case '6': case '7': case '8': case '9':
> +		return h - '0';
> +	case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
> +		return h - 'A' + 10;
> +	case 'a': case 'b': case 'c': case 'd': case 'e': case 'f':
> +		return h - 'a' + 10;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static void cpmac_get_mac(int instance, unsigned char *dev_addr)
> +{
> +	int i;
> +	char name[5], default_mac[] = "00:00:00:12:34:56", *mac;

If you don't have a MAC address, either use random_ether_addr() or don't
bring up the network interface at all.  Multiple interfaces with the same
MAC can cause chaos on a network to better avoid that.

> +struct psp_env_chunk {
> +	u8 num;
> +	u8 ctrl;
> +	u16 csum;
> +	u8 len;
> +	char data[11];
> +} __attribute__ ((packed));

Afair historic versions of this code were totally polluted with
__attribute__((packed)).  Thanks for cleaning that.

Btw - Linux coding style: No space between __attribute__ and ((packed)).

> +#include <asm/reboot.h>

You get a false warning from checkpatch.pl here.  Which probably means
either we should teach checkpatch.pl to check if <linux/reboot.h> is
actually including <asm/reboot.h> or rename <asm/reboot.h> to something
which would also help to avoid confusion.

> +++ b/arch/mips/include/asm/mach-ar7/spaces.h

You can cut down this header file to something like:

/* Copyright blurb */
#ifndef _ASM_AR7_SPACES_H
#define _ASM_AR7_SPACES_H

/*
 * This handles the memory map.
 * We handle pages at KSEG0 for kernels with 32 bit address space.
 */
#define PAGE_OFFSET		0x94000000UL
#define PHYS_OFFSET		0x14000000UL

#include <asm/mach-generic/spaces.h>

#endif /* __ASM_AR7_SPACES_H */

  Ralf
