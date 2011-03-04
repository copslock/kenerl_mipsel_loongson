Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2011 13:42:46 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:39443 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491784Ab1CDMmn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2011 13:42:43 +0100
Received: by bwz1 with SMTP id 1so2113140bwz.36
        for <multiple recipients>; Fri, 04 Mar 2011 04:42:36 -0800 (PST)
Received: by 10.204.48.33 with SMTP id p33mr510497bkf.153.1299242555856;
        Fri, 04 Mar 2011 04:42:35 -0800 (PST)
Received: from [192.168.2.2] ([91.79.86.215])
        by mx.google.com with ESMTPS id x6sm1522166bkv.0.2011.03.04.04.42.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Mar 2011 04:42:34 -0800 (PST)
Message-ID: <4D70DDEA.2050308@mvista.com>
Date:   Fri, 04 Mar 2011 15:41:14 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH V3 06/10] MIPS: lantiq: add NOR flash support
References: <1299146626-17428-1-git-send-email-blogic@openwrt.org> <1299146626-17428-7-git-send-email-blogic@openwrt.org>
In-Reply-To: <1299146626-17428-7-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 03-03-2011 13:03, John Crispin wrote:

> NOR flash is attached to the same EBU (External Bus Unit) as PCI. As described
> in the PCI patch, the EBU is a little buggy, resulting in the upper and lower
> 16 bit of the data on a 32 bit read are swapped. (essentially we have a addr^=2)

    "Are" not needed.

> To work around this we do a addr^=2 during the probe. Once probed we adapt
> cfi->addr_unlock1 and cfi->addr_unlock2 to represent the endianess bug.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Signed-off-by: Ralph Hempel<ralph.hempel@lantiq.com>
> Cc: David Woodhouse<dwmw2@infradead.org>
> Cc: Daniel Schwierzeck<daniel.schwierzeck@googlemail.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-mtd@lists.infradead.org
[...]

> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index 5d37d31..587468e 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -260,6 +260,13 @@ config MTD_BCM963XX
>  	  Support for parsing CFE image tag and creating MTD partitions on
>  	  Broadcom BCM63xx boards.
>
> +config MTD_LANTIQ
> +	bool "Lantiq SoC NOR support"
> +	depends on LANTIQ && MTD_PARTITIONS

    Maybe you should select MTD_PARTITIONS instead?

[...]
> diff --git a/drivers/mtd/maps/lantiq.c b/drivers/mtd/maps/lantiq.c
> new file mode 100644
> index 0000000..674be0a
> --- /dev/null
> +++ b/drivers/mtd/maps/lantiq.c
> @@ -0,0 +1,190 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2004 Liu Peng Infineon IFAP DC COM CPE
> + *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
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
> +#include<linux/platform_device.h>
> +#include<linux/mtd/physmap.h>
> +
> +#include<lantiq_soc.h>
> +#include<lantiq_platform.h>
> +
> +/* the NOR flash is connected to the same external bus unit (EBU) as PCI

    Period at end of statment missing?

> + * to make PCI work we need to enable the endianess swapping of the addr
> + * written to the EBU. this however has some limitations and breaks when
> + * using NOR. it does not really matter if the onflash data is in a swapped
> + * order, however cfi sequences also fail. to workaround this we need to use
> + * a complex map. We essentially software swap all addresses during probe
> + * and then swizzle the unlock addresses.
> + */
> +static int ltq_mtd_probing;
> +
> +static map_word
> +ltq_read16(struct map_info *map, unsigned long adr)
> +{
> +	unsigned long flags;
> +
> +	map_word temp;

    Empty line should be here, not above.

> +	if (ltq_mtd_probing)
> +		adr ^= 2;
> +	spin_lock_irqsave(&ebu_lock, flags);
> +	temp.x[0] = *((__u16 *)(map->virt + adr));
> +	spin_unlock_irqrestore(&ebu_lock, flags);

    Hm, what does this lock gain, if the read is atomic anyway?

> +void
> +ltq_copy_from(struct map_info *map, void *to,
 > +	unsigned long from, ssize_t len)

    Shouldn't it be static?

> +{
> +	unsigned char *p;
> +	unsigned char *to_8;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ebu_lock, flags);
> +	from = (unsigned long) (map->virt + from);

    Why not:

	from += (unsigned long) map->virt;

like you do in ltq_copy_to()?

> +	p = (unsigned char *) from;

    Could be done in initializer, like in ltq_copy_to().

> +	to_8 = (unsigned char *) to;
> +	while (len--)
> +		*to_8++ = *p++;

    BTW, you could use memcpy_fromio().

> +	spin_unlock_irqrestore(&ebu_lock, flags);
> +}
> +
> +void
> +ltq_copy_to(struct map_info *map, unsigned long to,
> +	const void *from, ssize_t len)

    Shouldn't it be static?

> +{
> +	unsigned char *p =  (unsigned char *)from;
> +	unsigned char *to_8;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ebu_lock, flags);
> +	to += (unsigned long) map->virt;
> +	to_8 = (unsigned char *)to;
> +	while (len--)
> +		*p++ = *to_8++;

    I think you have this backwards. It should be:

		*to_8++ = *p++;

    BTW, you could use memcpy_toio().

> +	spin_unlock_irqrestore(&ebu_lock, flags);
> +}
[...]
> +static int
> +ltq_mtd_probe(struct platform_device *pdev)
> +{
> +	struct physmap_flash_data *ltq_mtd_data =
> +		(struct physmap_flash_data *) dev_get_platdata(&pdev->dev);

    Cast from 'void *' is automatic -- no need for explicit one.

> +#ifdef CONFIG_SOC_TYPE_XWAY
> +	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
> +#endif

    Hm, can't you do this in the platform code?

> +	ltq_map.phys = res->start;
> +	ltq_map.size = resource_size(res);
> +	ltq_map.virt = devm_ioremap_nocache(&pdev->dev, ltq_map.phys,
> +		ltq_map.size);

    Hm, could you indent the last line more to the right?

> +	if (!ltq_map.virt) {
> +		dev_err(&pdev->dev, "failed to ioremap!\n");
> +		return -EIO;
> +	}
> +
> +	ltq_mtd_probing = 1;
> +	ltq_mtd = (struct mtd_info *) do_map_probe("cfi_probe",&ltq_map);

    do_map_probe() already returns that type, why cast to it?

> +	ltq_mtd_probing = 0;
> +	if (!ltq_mtd) {
> +		iounmap(ltq_map.virt);
> +		dev_err(&pdev->dev, "probing failed\n");
> +		return -ENXIO;
> +	}
> +	ltq_mtd->owner = THIS_MODULE;
> +
> +	cfi = (struct cfi_private *)ltq_map.fldrv_priv;

    Cast from 'void *' is automatic -- no need for explicit one.

> +int __init
> +init_ltq_mtd(void)
> +{
> +	int ret = platform_driver_register(&ltq_mtd_driver);

    Use platform_driver_probe() instead, as the device is not a hotplug one. 
Then ltq_mtd_probe() can become '__init'.

WBR, Sergei
