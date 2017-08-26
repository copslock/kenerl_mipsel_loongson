Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Aug 2017 12:46:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33584 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993869AbdHZKqoerf47 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 Aug 2017 12:46:44 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7QAkgnb008692;
        Sat, 26 Aug 2017 12:46:42 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7QAkg5P008691;
        Sat, 26 Aug 2017 12:46:42 +0200
Date:   Sat, 26 Aug 2017 12:46:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
Subject: Re: [PATCH v4 5/8] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Message-ID: <20170826104642.GE7433@linux-mips.org>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1503061833-26563-6-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503061833-26563-6-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59809
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

On Fri, Aug 18, 2017 at 03:08:57PM +0200, Aleksandar Markovic wrote:

(trimmed the cc list a bit by a number of people who probably couldn't
care less.)

> Provide amendments to the Mips generic platform framework so that
                            ^^^^
"MIPS" to keep the trademark lawyers happy.

> +CONFIG_STAGING=y

Sure you want to enable Greg's haunted house?

I haven't checked if it's actually needed but as a general rule leave it
disabled unless you have to.

> diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
> index 56b3ea5..14931f2 100644
> --- a/arch/mips/generic/Makefile
> +++ b/arch/mips/generic/Makefile
> @@ -14,4 +14,5 @@ obj-y += proc.o
>  
>  obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
>  obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
> +obj-$(CONFIG_VIRT_BOARD_RANCHU)	+= board-ranchu.o
>  obj-$(CONFIG_KEXEC)			+= kexec.o
> diff --git a/arch/mips/generic/board-ranchu.c b/arch/mips/generic/board-ranchu.c
> new file mode 100644
> index 0000000..500874d
> --- /dev/null
> +++ b/arch/mips/generic/board-ranchu.c
> @@ -0,0 +1,78 @@
> +/*
> + * Copyright (C) 2017 Imagination Technologies Ltd.
> + * Author: Miodrag Dinic <miodrag.dinic@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/of_address.h>
> +
> +#include <asm/machine.h>
> +#include <asm/time.h>

You're using u64 / uint64_t below, so you need to #include <linux/types.h>
rather than playing the include lottery.

> +#define GOLDFISH_TIMER_LOW		0x00
> +#define GOLDFISH_TIMER_HIGH		0x04
> +
> +static __init uint64_t read_rtc_time(void __iomem *base)

The remainder of this file is using u64.  While the ISO C types are
acceptable these days, please try to be consistent in use of types.

> +{
> +	u64 time_low;
> +	u64 time_high;
> +
> +	time_low = readl(base + GOLDFISH_TIMER_LOW);
> +	time_high = readl(base + GOLDFISH_TIMER_HIGH);
> +
> +	return (time_high << 32) | time_low;
> +}

GCC used to generate pretty bad code from source like this.  I haven't
checked if it has improved but generally you want to avoid extending
data to 64 bit types for as long as possible, something like:

{
	u32 high, low;

	low = readl(base + GOLDFISH_TIMER_LOW);
	high = readl(base + GOLDFISH_TIMER_HIGH);

	return ((u64)high << 32) | low;
}

> +static __init unsigned int ranchu_measure_hpt_freq(void)
> +{
> +	u64 rtc_start, rtc_current, rtc_delta;
> +	unsigned int start, count;
> +	struct device_node *np;
> +	void __iomem *rtc_base;
> +
> +	np = of_find_compatible_node(NULL, NULL, "google,goldfish-rtc");
> +	if (!np)
> +		panic("%s(): Failed to find 'google,goldfish-rtc' dt node!",
> +		      __func__);
> +
> +	rtc_base = of_iomap(np, 0);
> +	if (!rtc_base)
> +		panic("%s(): Failed to ioremap Goldfish RTC base!", __func__);
> +
> +	/*
> +	 * poll the nanosecond resolution RTC for 1 second
> +	 * to calibrate the CPU frequency
> +	 */
> +	rtc_start = read_rtc_time(rtc_base);
> +	start = read_c0_count();
> +
> +	do {
> +		rtc_current = read_rtc_time(rtc_base);
> +		rtc_delta = rtc_current - rtc_start;
> +	} while (rtc_delta < NSEC_PER_SEC);
> +
> +	count = read_c0_count() - start;
> +
> +	count += 5000;	/* round */
> +	count -= count % 10000;
> +
> +	return count;
> +}
> +
> +static const struct of_device_id ranchu_of_match[];
> +
> +MIPS_MACHINE(ranchu) = {
> +	.matches = ranchu_of_match,
> +	.measure_hpt_freq = ranchu_measure_hpt_freq,
> +};
> +
> +static const struct of_device_id ranchu_of_match[] = {
> +	{
> +		.compatible = "mti,ranchu",
> +		.data = &__mips_mach_ranchu,
> +	},
> +};
> -- 
> 2.7.4
> 
