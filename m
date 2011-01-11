Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2011 03:59:29 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:57094 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491758Ab1AKC7Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jan 2011 03:59:25 +0100
Received: by fxm19 with SMTP id 19so18908606fxm.36
        for <multiple recipients>; Mon, 10 Jan 2011 18:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=+lXDpJIVNrUFHBt9QlY7RIcPjuE2rhT7FzHJPX/PmOk=;
        b=s387Krt/Q8DdyWu0xhsLH4/2mTkn4/h7UGEz5+6Qb2sXJhKYSxJMjJKkOgW3mDcMeD
         oEwQr30pQn05rl4gCmM9xdN2XFll0/r3k9e9rLn6qmXJx41haR6Nc9/qrp4WDcKjoxx/
         vLYlGmgFpoC/bP4INXRbzEakgLjbao3EJwlDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=euBjbaOAbgUoAqNzzW9SX2VmYf6tZFEQN5nX7FB6HcwdPua6UHjgNfZgsJGNQP/gAq
         ysrmkSDsTHZmaztac96pgfEwBmnMOjO8p8cp6M+aX1HF+zor4G9A9/p7C+LhtOZh94xB
         YMfTmYhPz+8cBUEu/CHEKRu/G6jNg+LeNleRw=
Received: by 10.223.89.139 with SMTP id e11mr630536fam.69.1294714758459;
        Mon, 10 Jan 2011 18:59:18 -0800 (PST)
Received: from [192.168.100.100] (dslb-088-073-242-094.pools.arcor-ip.net [88.73.242.94])
        by mx.google.com with ESMTPS id y1sm7212670fak.15.2011.01.10.18.59.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 18:59:17 -0800 (PST)
Message-ID: <4D2BC787.20002@gmail.com>
Date:   Tue, 11 Jan 2011 03:59:19 +0100
From:   Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 06/10] MIPS: lantiq: add NOR flash support
References: <1294257379-417-1-git-send-email-blogic@openwrt.org> <1294257379-417-7-git-send-email-blogic@openwrt.org>
In-Reply-To: <1294257379-417-7-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.schwierzeck@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.schwierzeck@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi John,

the EBU doesn't allow unaligned read or write access thus Lantiq added 
this alignment hack directly in hardware. The addr^=2 is only needed 
during CFI probe because odd addresses are accessed. A simple solution 
is inside your patch.

The spin_lock_irqsave(&ebu_lock, flags); is actually not needed because 
the EBU does access arbitration and protection already in hardware.

Daniel

On 01/05/2011 08:56 PM, John Crispin wrote:
> NOR flash is attached to the same EBU (External Bus Unit) as PCI. As described
> in the PCI patch, the EBU is a little obscure, resulting in the upper and lower
> 16 bit of the data on a 32 bit read are swapped. (essentially we have a addr^=2)
> This only happens on the read of data. In order to not have to high an impact
> on the read performance from the EBU we store all data on the flash with
> addr^=2. This allows us to do generic reads without having to do any swapping.
> For the write to now work we need to swizzle the the 0x2 bit of the addr.
> However this write swizzle needs to only happen when doing a CMD and not a DATA
> write.
>
> As the MTD layer currently makes no difference between a CMD and DATA read when
> using complex maps, the map driver does not know when the swizzle and when not
> to swizzle. The next patch in the series adds a hack to the MTD to workaround
> this problem. I am sending these 2 patches to the mtd list aswell. There are
> several ways to solve this generically in the mtd layer in a much better way.
> This will have minor impact on the actual map code provided in this patch.
>
> Signed-off-by: John Crispin<blogic@openwrt.org>
> Signed-off-by: Ralph Hempel<ralph.hempel@lantiq.com>
> Cc: David Woodhouse<dwmw2@infradead.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-mtd@lists.infradead.org
> ---
>   drivers/mtd/maps/Kconfig  |    7 ++
>   drivers/mtd/maps/Makefile |    1 +
>   drivers/mtd/maps/lantiq.c |  169 +++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 177 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/mtd/maps/lantiq.c
>
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index a0dd7bb..ca69a7f 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -260,6 +260,13 @@ config MTD_BCM963XX
>   	  Support for parsing CFE image tag and creating MTD partitions on
>   	  Broadcom BCM63xx boards.
>
> +config MTD_LANTIQ
> +	bool "Lantiq SoC NOR support"
> +	depends on LANTIQ&&  MTD_PARTITIONS
> +	help
> +	  Support for NOR flash chips on Lantiq SoC. The Chips are connected
> +	  to the SoCs EBU (External Bus Unit)
> +
>   config MTD_DILNETPC
>   	tristate "CFI Flash device mapped on DIL/Net PC"
>   	depends on X86&&  MTD_CONCAT&&  MTD_PARTITIONS&&  MTD_CFI_INTELEXT&&  BROKEN
> diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> index c7869c7..bb2ce2f 100644
> --- a/drivers/mtd/maps/Makefile
> +++ b/drivers/mtd/maps/Makefile
> @@ -59,3 +59,4 @@ obj-$(CONFIG_MTD_RBTX4939)	+= rbtx4939-flash.o
>   obj-$(CONFIG_MTD_VMU)		+= vmu-flash.o
>   obj-$(CONFIG_MTD_GPIO_ADDR)	+= gpio-addr-flash.o
>   obj-$(CONFIG_MTD_BCM963XX)	+= bcm963xx-flash.o
> +obj-$(CONFIG_MTD_LANTIQ)	+= lantiq.o
> diff --git a/drivers/mtd/maps/lantiq.c b/drivers/mtd/maps/lantiq.c
> new file mode 100644
> index 0000000..e5a361e
> --- /dev/null
> +++ b/drivers/mtd/maps/lantiq.c
> @@ -0,0 +1,169 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2004 Liu Peng Infineon IFAP DC COM CPE
> + *  Copyright (C) 2010 John Crispin<blogic@openwrt.org>
> + */
> +
> +#include<linux/module.h>
> +#include<linux/types.h>
> +#include<linux/kernel.h>
> +#include<linux/io.h>
> +#include<linux/init.h>
> +#include<linux/mtd/mtd.h>
> +#include<linux/mtd/map.h>
> +#include<linux/mtd/partitions.h>
> +#include<linux/mtd/cfi.h>
> +#include<linux/magic.h>
> +#include<linux/platform_device.h>
> +#include<linux/mtd/physmap.h>
> +
> +#include<lantiq_soc.h>
> +#include<lantiq_platform.h>
> +
static int ltq_probing = 0;

> +static map_word
> +ltq_read16(struct map_info *map, unsigned long adr)
> +{
> +	unsigned long flags;
> +	map_word temp;
> +	spin_lock_irqsave(&ebu_lock, flags);
	if (ltq_probing)
		adr ^= 2;
> +	temp.x[0] = *((__u16 *)(map->virt + adr));
> +	spin_unlock_irqrestore(&ebu_lock, flags);
> +	return temp;
> +}
> +
> +static void
> +ltq_write16(struct map_info *map, map_word d, unsigned long adr)
> +{
> +	unsigned long flags;
> +	spin_lock_irqsave(&ebu_lock, flags);
	if (ltq_probing)
		adr ^= 2;
> +	*((__u16 *)(map->virt + adr)) = d.x[0];
> +	spin_unlock_irqrestore(&ebu_lock, flags);
> +}
> +
> +void
> +ltq_copy_from(struct map_info *map, void *to,
> +	unsigned long from, ssize_t len)
> +{
> +	unsigned char *p;
> +	unsigned char *to_8;
> +	unsigned long flags;
> +	spin_lock_irqsave(&ebu_lock, flags);
> +	from = (unsigned long)(from + map->virt);
> +	p = (unsigned char *) from;
> +	to_8 = (unsigned char *) to;
> +	while (len--)
> +		*to_8++ = *p++;
> +	spin_unlock_irqrestore(&ebu_lock, flags);
> +}
> +
> +void
> +ltq_copy_to(struct map_info *map, unsigned long to,
> +	const void *from, ssize_t len)
> +{
> +	unsigned char *p =  (unsigned char *)from;
> +	unsigned char *to_8;
> +	unsigned long flags;
> +	spin_lock_irqsave(&ebu_lock, flags);
> +	to += (unsigned long) map->virt;
> +	to_8 = (unsigned char *)to;
> +	while (len--)
> +		*p++ = *to_8++;
> +	spin_unlock_irqrestore(&ebu_lock, flags);
> +}
> +
> +static const char * const part_probe_types[] = {
> +	"cmdlinepart", NULL };
> +
> +static struct map_info ltq_map = {
> +	.name = "ltq_nor",
> +	.bankwidth = 2,
> +	.read = ltq_read16,
> +	.write = ltq_write16,
> +	.copy_from = ltq_copy_from,
> +	.copy_to = ltq_copy_to,
> +};
> +
> +static int
> +ltq_mtd_probe(struct platform_device *pdev)
> +{
> +	struct physmap_flash_data *ltq_mtd_data =
> +		(struct physmap_flash_data *) dev_get_platdata(&pdev->dev);
> +	struct mtd_info *ltq_mtd = NULL;
> +	struct mtd_partition *parts = NULL;
> +	struct resource *res = 0;
> +	int nr_parts = 0;
> +
> +#ifdef CONFIG_SOC_TYPE_XWAY
> +	ltq_w32(ltq_r32(LTQ_EBU_BUSCON0)&  ~EBU_WRDIS, LTQ_EBU_BUSCON0);
> +#endif
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to get memory resource");
> +		return -ENOENT;
> +	}
> +	res = request_mem_region(res->start, resource_size(res),
> +		dev_name(&pdev->dev));
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to request mem resource");
> +		return -EBUSY;
> +	}
> +
> +	ltq_map.phys = res->start;
> +	ltq_map.size = resource_size(res);
> +	ltq_map.virt = ioremap_nocache(ltq_map.phys, ltq_map.size);
> +
> +	if (!ltq_map.virt) {
> +		dev_err(&pdev->dev, "failed to ioremap!\n");
> +		return -EIO;
> +	}
> +
	ltq_probing = 1;
> +	ltq_mtd = (struct mtd_info *) do_map_probe("cfi_probe",&ltq_map);
	ltq_probing = 0;
> +	if (!ltq_mtd) {
> +		iounmap(ltq_map.virt);
> +		dev_err(&pdev->dev, "probing failed\n");
> +		return -ENXIO;
> +	}
> +
> +	ltq_mtd->owner = THIS_MODULE;
> +
> +	nr_parts = parse_mtd_partitions(ltq_mtd, part_probe_types,&parts, 0);
> +	if (nr_parts>  0) {
> +		dev_info(&pdev->dev,
> +			"using %d partitions from cmdline", nr_parts);
> +	} else {
> +		nr_parts = ltq_mtd_data->nr_parts;
> +		parts = ltq_mtd_data->parts;
> +	}
> +
> +	add_mtd_partitions(ltq_mtd, parts, nr_parts);
> +	return 0;
> +}
> +
> +static struct platform_driver ltq_mtd_driver = {
> +	.probe = ltq_mtd_probe,
> +	.driver = {
> +		.name = "ltq_nor",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +int __init
> +init_ltq_mtd(void)
> +{
> +	int ret = platform_driver_register(&ltq_mtd_driver);
> +	if (ret)
> +		printk(KERN_INFO "ltq_nor: error registering platfom driver");
> +	return ret;
> +}
> +
> +module_init(init_ltq_mtd);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("John Crispin<blogic@openwrt.org>");
> +MODULE_DESCRIPTION("Lantiq SoC NOR");
