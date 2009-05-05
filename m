Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2009 17:47:52 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11464 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022612AbZEEQrp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 May 2009 17:47:45 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a006d0c0000>; Tue, 05 May 2009 12:45:03 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 09:44:06 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 09:44:06 -0700
Message-ID: <4A006CD5.8080401@caviumnetworks.com>
Date:	Tue, 05 May 2009 09:44:05 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	David VomLehn <dvomlehn@cisco.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/3] mips:powertv: Base files for Cisco Powertv platform
 (resend)
References: <20090504225616.GA22321@cuplxvomd02.corp.sa.net>
In-Reply-To: <20090504225616.GA22321@cuplxvomd02.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2009 16:44:06.0270 (UTC) FILETIME=[B47381E0:01C9CDA0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:

> diff --git a/arch/mips/powertv/cevt-powertv.c b/arch/mips/powertv/cevt-powertv.c
[...]
> +static int mips_next_event(unsigned long delta,
> +	struct clock_event_device *evt)
> +{
> +	unsigned int cnt;
> +	int res;
> +
> +#ifdef CONFIG_MIPS_MT_SMTC
> +	{
> +	unsigned long flags, vpflags;
> +	local_irq_save(flags);
> +	vpflags = dvpe();
> +#endif
> +	cnt = read_c0_count();
> +	cnt += delta;
> +	write_c0_compare(cnt);
> +	res = ((int)(read_c0_count() - cnt) > 0) ? -ETIME : 0;
> +#ifdef CONFIG_MIPS_MT_SMTC
> +	evpe(vpflags);
> +	local_irq_restore(flags);
> +	}
> +#endif
> +	return res;

Does this cpu have MIPS_MT?  If not you could remove the #ifdef 
(actually you could remove it in any case).

[...]
> diff --git a/arch/mips/powertv/csrc-powertv.c b/arch/mips/powertv/csrc-powertv.c
> new file mode 100644
> index 0000000..c032660
> --- /dev/null
> +++ b/arch/mips/powertv/csrc-powertv.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright (C) 2008 Scientific-Atlanta, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +/*
> + * The file comes from kernel/csrc-r4k.c
> + */

Could you just use kernel/csrc-r4k.c, and move your mips_get_pll_freq() 
to a different file (init.c or time.c)?


> +#include <linux/clocksource.h>
> +#include <linux/init.h>
> +
> +#include <asm/time.h>			/* Not included in linux/time.h */
> +
> +#include <asm/mach-powertv/asic_regs.h>
> +#include "powertv-clock.h"
> +
> +/* MIPS PLL Register Definitions */
> +#define PLL_GET_M(x)		(((x) >> 8) & 0x000000FF)
> +#define PLL_GET_N(x)		(((x) >> 16) & 0x000000FF)
> +#define PLL_GET_P(x)		(((x) >> 24) & 0x00000007)
> +
> +/*
> + * returns:  Clock frequency in kHz
> + */
> +unsigned int __init mips_get_pll_freq(void)
> +{
> +	unsigned int pll_reg, m, n, p;
> +	unsigned int fin = 54000; /* Base frequency in kHz */
> +	unsigned int fout;
> +
> +	/* Read PLL register setting */
> +	pll_reg = asic_read(MIPS_PLL_SETUP);
> +	m = PLL_GET_M(pll_reg);
> +	n = PLL_GET_N(pll_reg);
> +	p = PLL_GET_P(pll_reg);
> +	pr_info("MIPS PLL Register:0x%x  M=%d  N=%d  P=%d\n", pll_reg, m, n, p);
> +
> +	/* Calculate clock frequency = (2 * N * 54MHz) / (M * (2**P)) */
> +	fout = ((2 * n * fin) / (m * (0x01 << p)));
> +
> +	pr_info("MIPS Clock Freq=%d kHz\n", fout);
> +
> +	return fout;
> +}
> +
> +static cycle_t c0_hpt_read(struct clocksource *cs)
> +{
> +	return read_c0_count();
> +}
> +
> +static struct clocksource clocksource_mips = {
> +	.name		= "powertv-counter",
> +	.read		= c0_hpt_read,
> +	.mask		= CLOCKSOURCE_MASK(32),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +void __init powertv_clocksource_init(void)
> +{
> +	unsigned int pll_freq = mips_get_pll_freq();
> +
> +	pr_info("CPU frequency %d.%02d MHz\n", pll_freq / 1000,
> +		(pll_freq % 1000) * 100 / 1000);
> +
> +	mips_hpt_frequency = pll_freq / 2 * 1000;
> +
> +	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
> +
> +	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
> +
> +	clocksource_register(&clocksource_mips);
> +}
