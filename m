Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 21:26:04 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:36891 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903404Ab2FTTZ6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2012 21:25:58 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5KJPqGx001691;
        Wed, 20 Jun 2012 20:25:53 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5KJPqOc001670;
        Wed, 20 Jun 2012 20:25:52 +0100
Date:   Wed, 20 Jun 2012 20:25:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, zhzhl555@gmail.com
Subject: Re: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
Message-ID: <20120620192551.GC29446@linux-mips.org>
References: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com>
 <1339757617-2187-3-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1339757617-2187-3-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33747
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Jun 15, 2012 at 06:53:35PM +0800, Kelvin Cheung wrote:

> +#include <linux/clk.h>

> +static LIST_HEAD(clocks);
> +static DEFINE_MUTEX(clocks_mutex);
> +
> +struct clk *clk_get(struct device *dev, const char *name)
> +{
> +	struct clk *c;
> +	struct clk *ret = NULL;
> +
> +	mutex_lock(&clocks_mutex);
> +	list_for_each_entry(c, &clocks, node) {
> +		if (!strcmp(c->name, name)) {
> +			ret = c;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&clocks_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(clk_get);

This redefines a function that already is declared in <linux/clk.h> and
defined in drivers/clk/clkdev.c.  Why?

> +int clk_register(struct clk *clk)
> +{
> +	mutex_lock(&clocks_mutex);
> +	list_add(&clk->node, &clocks);
> +	if (clk->ops->init)
> +		clk->ops->init(clk);
> +	mutex_unlock(&clocks_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_register);

Same here.

> diff --git a/arch/mips/loongson1/common/prom.c b/arch/mips/loongson1/common/prom.c
> new file mode 100644
> index 0000000..1f8e49f
> --- /dev/null
> +++ b/arch/mips/loongson1/common/prom.c
> @@ -0,0 +1,87 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * Modified from arch/mips/pnx833x/common/prom.c.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/serial_reg.h>
> +#include <asm/bootinfo.h>
> +
> +#include <loongson1.h>
> +#include <prom.h>
> +
> +int prom_argc;
> +char **prom_argv, **prom_envp;
> +unsigned long memsize, highmemsize;
> +
> +char *prom_getenv(char *envname)
> +{
> +	char **env = prom_envp;
> +	int i;
> +
> +	i = strlen(envname);
> +
> +	while (*env) {
> +		if (strncmp(envname, *env, i) == 0 && *(*env+i) == '=')
> +			return *env + i + 1;
> +		env++;
> +	}
> +
> +	return 0;
> +}
[...]

Please take a look at sjhill's firmware cleanup patchset which is going to
remove a fair chunk of duplication of firmware related code.

This is just a heads up; you need to do nothing because that patchset is not
applied yet.)

> +const char *get_system_type(void)
> +{
> +	unsigned int processor_id = (&current_cpu_data)->processor_id;
> +
> +	switch (processor_id & PRID_REV_MASK) {
> +	case PRID_REV_LOONGSON1B:
> +		return "LOONGSON LS1B";
> +	default:
> +		return "LOONGSON (unknown)";
> +	}
> +}

You probably should return a string identifying the system, not the SOC
being used.  So this function should probably go to board.c.

> diff --git a/arch/mips/loongson1/ls1b/board.c b/arch/mips/loongson1/ls1b/board.c
> new file mode 100644
> index 0000000..1ec350d
> --- /dev/null
> +++ b/arch/mips/loongson1/ls1b/board.c
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <platform.h>
> +
> +#include <linux/serial_8250.h>
> +#include <loongson1.h>
> +
> +static struct platform_device *ls1b_platform_devices[] __initdata = {
> +	&ls1x_uart_device,
> +#if IS_ENABLED(CONFIG_STMMAC_ETH)
> +	&ls1x_eth0_device,
> +#endif
> +#if IS_ENABLED(CONFIG_USB_EHCI_HCD)
> +	&ls1x_ehci_device,
> +#endif
> +#if IS_ENABLED(CONFIG_RTC_DRV_LOONGSON1)
> +	&ls1x_rtc_device,
> +#endif
> +};

Don't ifdef the platform devices.  The platform devices should always
be registered if a system actually has the underlying hardware.  If the
driver has been compiled or not does not matter.

And the final plug - take a look at FDT for a future revision of this
code :)

  Ralf
