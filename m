Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 14:20:23 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:56480 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833441Ab3AXNUSaeaCu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2013 14:20:18 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 39D2E25BAC1;
        Thu, 24 Jan 2013 14:20:13 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3vYwA9MFMz8h; Thu, 24 Jan 2013 14:20:13 +0100 (CET)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPSA id CCBAE25BABE;
        Thu, 24 Jan 2013 14:20:12 +0100 (CET)
Message-ID: <51013519.3010605@openwrt.org>
Date:   Thu, 24 Jan 2013 14:20:25 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 07/11] MIPS: ralink: adds OF code
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-8-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-8-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Antivirus: avast! (VPS 130124-0, 2013.01.24), Outbound message
X-Antivirus-Status: Clean
X-archive-position: 35538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.01.23. 13:05 keltezéssel, John Crispin írta:
> Until there is a generic MIPS way of handing the DTB over from bootloader to
> kernel we rely on a built in devicetrees. The OF code also remaps those register
> ranges that we use global in our drivers.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/of.c |  105 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 arch/mips/ralink/of.c
> 
> diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
> new file mode 100644
> index 0000000..02814b3
> --- /dev/null
> +++ b/arch/mips/ralink/of.c
> @@ -0,0 +1,105 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
> + * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/init.h>
> +#include <linux/of_fdt.h>
> +#include <linux/kernel.h>
> +#include <linux/bootmem.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/reboot.h>
> +#include <asm/bootinfo.h>
> +#include <asm/addrspace.h>
> +
> +#include "common.h"
> +
> +__iomem void *rt_sysc_membase;
> +__iomem void *rt_memc_membase;
> +
> +extern struct boot_param_header __dtb_start;
> +
> +void __init ralink_of_remap(void)
> +{
> +	struct resource res_sysc, res_memc;
> +	struct device_node *np_sysc =
> +			of_find_compatible_node(NULL, NULL, "ralink,sysc");
> +	struct device_node *np_memc =
> +			of_find_compatible_node(NULL, NULL, "ralink,memc");

If you would initialize these variables after the declaration part, you would
not have to break the lines.

> +
> +	if (!np_sysc || !np_memc)
> +		panic("Failed to load core nodes from devicetree");
> +
> +	if (of_address_to_resource(np_sysc, 0, &res_sysc) ||
> +			of_address_to_resource(np_memc, 0, &res_memc))
> +		panic("Failed to get core resources");
> +
> +	if ((request_mem_region(res_sysc.start, resource_size(&res_sysc),
> +				res_sysc.name) < 0) ||
> +		(request_mem_region(res_memc.start, resource_size(&res_memc),
> +				res_memc.name) < 0))
> +		pr_err("Failed to request core resources");

This also should be a panic to make it consistent with the others.

> +
> +	rt_sysc_membase = ioremap_nocache(res_sysc.start,
> +						resource_size(&res_sysc));
> +	rt_memc_membase = ioremap_nocache(res_memc.start,
> +						resource_size(&res_memc));
> +
> +	if (!rt_sysc_membase || !rt_memc_membase)
> +		panic("Failed to remap core resources");

It would worth it to introduce a helper routine which gets the node name and
returns with the remapped address. Then the helper should be used both for the
sysc and for memc nodes. That would make the code more readable and it would
reduce stack usage as well.

-Gabor
