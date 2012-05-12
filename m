Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 May 2012 02:47:52 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:51777 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903696Ab2ELArp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 May 2012 02:47:45 +0200
Received: by dadm1 with SMTP id m1so4260398dad.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 17:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=EMGukB/G7gOd2p+260Tna7IpqRU0D4pywL4CBIqz2MQ=;
        b=AlpKoyiETtsK2aUQHtcNZhAa4YHfR/PL23SWmIfD77TsdPxXmV/vhHcGATEKyGKNCw
         xrwd5P+9rQIoekdGRBx1HgS880iuv3dimcBZqkBBmCC4XI1zIKDWfvaV45DUWEwJ+sxA
         meXhb+NRdCg2HdkMjxBnUJ+z6NtbcoA4UL0sp3bl5F/Q5cnev82AhsYIc0pFsxygXL7d
         3rPmiMlSSAzf3lmrdaL/uno5W0H73RRi93rjJ9VwztKfqE9F0CHq0iqzeujfPW40qJy1
         8e/riG6fo0psUq4/eWlr8RttrKLhuRu/NohtwvCiGKK7yWTEH8GrHvAKnJWhlRqv1UuL
         JkCg==
Received: by 10.68.224.196 with SMTP id re4mr320327pbc.111.1336783658023;
        Fri, 11 May 2012 17:47:38 -0700 (PDT)
Received: from localhost (S0106b0487adb560b.cg.shawcable.net. [68.146.86.184])
        by mx.google.com with ESMTPS id pd3sm14295249pbc.53.2012.05.11.17.47.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 17:47:36 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id F0C653E0791; Fri, 11 May 2012 18:47:35 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 02/14] OF: MIPS: lantiq: implement OF support
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
In-Reply-To: <1336133919-26525-2-git-send-email-blogic@openwrt.org>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org> <1336133919-26525-2-git-send-email-blogic@openwrt.org>
Date:   Fri, 11 May 2012 18:47:35 -0600
Message-Id: <20120512004735.F0C653E0791@localhost>
X-Gm-Message-State: ALoCoQnFyMmuG5YWTWW3iUfKWy4Cfgt7pAVb5SeNma/caOQ4mXipYFZ2JOLBWfPTYvDYIcgDWKij
X-archive-position: 33284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri,  4 May 2012 14:18:27 +0200, John Crispin <blogic@openwrt.org> wrote:
> Activate USE_OF, add a sample DTS file and convert the core soc code to OF.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> ---
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index cd56892..413ed53 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/export.h>
>  #include <linux/clk.h>
> +#include <linux/of_platform.h>
>  #include <asm/bootinfo.h>
>  #include <asm/time.h>
>  
> @@ -16,13 +17,15 @@
>  #include "prom.h"
>  #include "clk.h"
>  
> -static struct ltq_soc_info soc_info;
> +/* access to the ebu needs to be locked between different drivers */
> +DEFINE_SPINLOCK(ebu_lock);
> +EXPORT_SYMBOL_GPL(ebu_lock);
>  
> -unsigned int ltq_get_cpu_ver(void)
> -{
> -	return soc_info.rev;
> -}
> -EXPORT_SYMBOL(ltq_get_cpu_ver);
> +/*
> + * this struct is filled by the soc specific detection code and holds
> + * information about the specific soc type, revision and name
> + */
> +static struct ltq_soc_info soc_info;
>  
>  unsigned int ltq_get_soc_type(void)
>  {
> @@ -57,16 +60,28 @@ static void __init prom_init_cmdline(void)
>  	}
>  }
>  
> -void __init prom_init(void)
> +void __init plat_mem_setup(void)
>  {
> -	struct clk *clk;
> +	ioport_resource.start = IOPORT_RESOURCE_START;
> +	ioport_resource.end = IOPORT_RESOURCE_END;
> +	iomem_resource.start = IOMEM_RESOURCE_START;
> +	iomem_resource.end = IOMEM_RESOURCE_END;
> +
> +	set_io_port_base((unsigned long) KSEG1);
> +
> +	/*
> +	 * Load the builtin devicetree. This causes the chosen node to be
> +	 * parsed resulting in our memory appearing
> +	 */
> +	__dt_setup_arch(&__dtb_start);
> +}
>  
> +void __init prom_init(void)
> +{
> +	/* call the soc specific detetcion code and get it to fill soc_info */
>  	ltq_soc_detect(&soc_info);
> -	clk_init();
> -	clk = clk_get(0, "cpu");
> -	snprintf(soc_info.sys_type, LTQ_SYS_TYPE_LEN - 1, "%s rev1.%d",
> -		soc_info.name, soc_info.rev);
> -	clk_put(clk);
> +	snprintf(soc_info.sys_type, LTQ_SYS_TYPE_LEN - 1, "%s rev %s",
> +		soc_info.name, soc_info.rev_type);
>  	soc_info.sys_type[LTQ_SYS_TYPE_LEN - 1] = '\0';
>  	pr_info("SoC: %s\n", soc_info.sys_type);
>  	prom_init_cmdline();
> @@ -76,3 +91,19 @@ void __init prom_init(void)
>  		panic("failed to register_vsmp_smp_ops()");
>  #endif
>  }
> +
> +int __init plat_of_setup(void)
> +{
> +	static struct of_device_id of_ids[3];
> +
> +	if (!of_have_populated_dt())
> +		panic("device tree not present");
> +
> +	strncpy(of_ids[0].compatible, soc_info.compatible,
> +		sizeof(of_ids[0].compatible));
> +	strncpy(of_ids[1].compatible, "simple-bus",
> +		sizeof(of_ids[1].compatible));

?!?  That's rather weird.  Why not simply a static of_device_id table
and add all possible compatible values to it which in this case is
"simple-bus" and whatever values are possible for soc_info.compatible?

> +	return of_platform_bus_probe(NULL, of_ids, NULL);

of_platform_bus_probe() is deprecated.  Use of_platform_populate()
instead.  The semantics make more sense on that one.

g.
> +}
> +
> +arch_initcall(plat_of_setup);
> diff --git a/arch/mips/lantiq/prom.h b/arch/mips/lantiq/prom.h
> index f7c2a79..a3fa1a2 100644
> --- a/arch/mips/lantiq/prom.h
> +++ b/arch/mips/lantiq/prom.h
> @@ -26,4 +26,6 @@ struct ltq_soc_info {
>  extern void ltq_soc_detect(struct ltq_soc_info *i);
>  extern void ltq_soc_init(void);
>  
> +extern struct boot_param_header __dtb_start;
> +
>  #endif
> diff --git a/arch/mips/lantiq/setup.c b/arch/mips/lantiq/setup.c
> deleted file mode 100644
> index f1c605a..0000000
> --- a/arch/mips/lantiq/setup.c
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -/*
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License version 2 as published
> - *  by the Free Software Foundation.
> - *
> - * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/export.h>
> -#include <linux/io.h>
> -#include <linux/ioport.h>
> -#include <asm/bootinfo.h>
> -
> -#include <lantiq_soc.h>
> -
> -#include "prom.h"
> -
> -void __init plat_mem_setup(void)
> -{
> -	/* assume 16M as default incase uboot fails to pass proper ramsize */
> -	unsigned long memsize = 16;
> -	char **envp = (char **) KSEG1ADDR(fw_arg2);
> -
> -	ioport_resource.start = IOPORT_RESOURCE_START;
> -	ioport_resource.end = IOPORT_RESOURCE_END;
> -	iomem_resource.start = IOMEM_RESOURCE_START;
> -	iomem_resource.end = IOMEM_RESOURCE_END;
> -
> -	set_io_port_base((unsigned long) KSEG1);
> -
> -	while (*envp) {
> -		char *e = (char *)KSEG1ADDR(*envp);
> -		if (!strncmp(e, "memsize=", 8)) {
> -			e += 8;
> -			if (strict_strtoul(e, 0, &memsize))
> -				pr_warn("bad memsize specified\n");
> -		}
> -		envp++;
> -	}
> -	memsize *= 1024 * 1024;
> -	add_memory_region(0x00000000, memsize, BOOT_MEM_RAM);
> -}
> diff --git a/arch/mips/lantiq/xway/ebu.c b/arch/mips/lantiq/xway/ebu.c
> index 862e3e8..419b47b 100644
> --- a/arch/mips/lantiq/xway/ebu.c
> +++ b/arch/mips/lantiq/xway/ebu.c
> @@ -14,10 +14,6 @@
>  
>  #include <lantiq_soc.h>
>  
> -/* all access to the ebu must be locked */
> -DEFINE_SPINLOCK(ebu_lock);
> -EXPORT_SYMBOL_GPL(ebu_lock);
> -
>  static struct resource ltq_ebu_resource = {
>  	.name	= "ebu",
>  	.start	= LTQ_EBU_BASE_ADDR,
> diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
> index 3327211..22c55f7 100644
> --- a/arch/mips/lantiq/xway/reset.c
> +++ b/arch/mips/lantiq/xway/reset.c
> @@ -37,13 +37,6 @@
>  #define RCU_BOOT_SEL_SHIFT	26
>  #define RCU_BOOT_SEL_MASK	0x7
>  
> -static struct resource ltq_rcu_resource = {
> -	.name   = "rcu",
> -	.start  = LTQ_RCU_BASE_ADDR,
> -	.end    = LTQ_RCU_BASE_ADDR + LTQ_RCU_SIZE - 1,
> -	.flags  = IORESOURCE_MEM,
> -};
> -
>  /* remapped base addr of the reset control unit */
>  static void __iomem *ltq_rcu_membase;
>  
> @@ -91,17 +84,21 @@ static void ltq_machine_power_off(void)
>  
>  static int __init mips_reboot_setup(void)
>  {
> -	/* insert and request the memory region */
> -	if (insert_resource(&iomem_resource, &ltq_rcu_resource) < 0)
> -		panic("Failed to insert rcu memory");
> +	struct resource res;
> +	struct device_node *np =
> +		of_find_compatible_node(NULL, NULL, "lantiq,rcu-xway");
> +
> +	/* check if all the reset register range is available */
> +	if (!np)
> +		panic("Failed to load reset resources from devicetree");
> +
> +	if (of_address_to_resource(np, 0, &res))
> +		panic("Failed to get rcu memory range");
>  
> -	if (request_mem_region(ltq_rcu_resource.start,
> -			resource_size(&ltq_rcu_resource), "rcu") < 0)
> -		panic("Failed to request rcu memory");
> +	if (request_mem_region(res.start, resource_size(&res), res.name) < 0)
> +		pr_err("Failed to request rcu memory");
>  
> -	/* remap rcu register range */
> -	ltq_rcu_membase = ioremap_nocache(ltq_rcu_resource.start,
> -				resource_size(&ltq_rcu_resource));
> +	ltq_rcu_membase = ioremap_nocache(res.start, resource_size(&res));
>  	if (!ltq_rcu_membase)
>  		panic("Failed to remap core memory");
>  
> -- 
> 1.7.9.1
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
