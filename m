Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2011 14:46:36 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:43437 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491122Ab1DAMqd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Apr 2011 14:46:33 +0200
Received: by wyb28 with SMTP id 28so3547546wyb.36
        for <multiple recipients>; Fri, 01 Apr 2011 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=adrQ7VSquVD7fKJy7I1e8SFfnrVcUecTf9xdcWlkFJo=;
        b=PIh3I+8o+y4gtcvVguCeoed/G92uEzfJZoDhba4fRtjF7aPA3UyTRSK6VUGp5nX5eJ
         2MgESkUi1uUdVRULa6dDa9T271Vmm+Kg1iAtmt+wsTjYELBbEA39O38vTgdo2kX6paTC
         cDAufyIx3YYNmTbLVRT+15CugnIbUFQHefa/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=x9AW3YANkbWm8jPOZ63A23cGLhCPZ2bnX2E26BpV89YY66Gp3vPVYMsFOxGdi2oGei
         zYsSH+MLce1zD96hJMYMNLQ+LyCdq/UAPhDRCEAIbJRamD7NJa1Z1moWWqXjR2uJmYi5
         7j0GYSJQaj1sndUZf/mg76eyWU5Ir8A3V163Q=
Received: by 10.216.69.196 with SMTP id n46mr497475wed.30.1301661986715;
        Fri, 01 Apr 2011 05:46:26 -0700 (PDT)
Received: from ?IPv6:::1? (shutemov.name [188.40.19.243])
        by mx.google.com with ESMTPS id c54sm981526wer.30.2011.04.01.05.46.17
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 05:46:18 -0700 (PDT)
Subject: Re: [PATCH V5 06/10] MIPS: lantiq: add NOR flash support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1301470076-17279-7-git-send-email-blogic@openwrt.org>
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org>
         <1301470076-17279-7-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 01 Apr 2011 15:43:52 +0300
Message-ID: <1301661832.2789.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Content-Transfer-Encoding: 8bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

just few minor things.

On Wed, 2011-03-30 at 09:27 +0200, John Crispin wrote:
> +/* the NOR flash is connected to the same external bus unit (EBU) as PCI.
> + * To make PCI work we need to enable the endianess swapping of the addr
> + * written to the EBU. this however has some limitations and breaks when
> + * using NOR. it does not really matter if the onflash data is in a swapped
> + * order, however cfi sequences also fail. to workaround this we need to use
> + * a complex map. We essentially software swap all addresses during probe
> + * and then swizzle the unlock addresses.
> + */

Would be nice to clean-up the comment a little bit and use capital
letters at the start of the sentences. Also, I think the style for
multi-line comments is:

/*
 * bla
 * bla
 */


> +static void
> +ltq_copy_from(struct map_info *map, void *to,
> +	unsigned long from, ssize_t len)
> +{
> +	unsigned char *f = (unsigned char *) (map->virt + from);
> +	unsigned char *t = (unsigned char *) to;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ebu_lock, flags);
> +	while (len--)
> +		*t++ = *f++;
> +	spin_unlock_irqrestore(&ebu_lock, flags);

Can you use memcpy here instead?

> +}
> +
> +static void
> +ltq_copy_to(struct map_info *map, unsigned long to,
> +	const void *from, ssize_t len)
> +{
> +	unsigned char *f = (unsigned char *) from;
> +	unsigned char *t = (unsigned char *) (map->virt + to);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ebu_lock, flags);
> +	while (len--)
> +		*t++ = *f++;

Can you use memcpy here instead?

> +	spin_unlock_irqrestore(&ebu_lock, flags);
> +}
> +
> +static const char const *part_probe_types[] = {
> +	"cmdlinepart", NULL };

This can be one-liner, no need to make 2  lines.

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
> +static int __init
> +ltq_mtd_probe(struct platform_device *pdev)
> +{
> +	struct physmap_flash_data *ltq_mtd_data =
> +		dev_get_platdata(&pdev->dev);

This can be one line - it takes only 79 characters.

> +	struct mtd_info *ltq_mtd = NULL;
> +	struct mtd_partition *parts = NULL;
> +	struct resource *res = 0;
You do not need this initialization.

> +	int nr_parts = 0;
> +	struct cfi_private *cfi;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to get memory resource");
> +		return -ENOENT;
> +	}
> +	res = devm_request_mem_region(&pdev->dev, res->start,
> +		resource_size(res), dev_name(&pdev->dev));
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to request mem resource");
> +		return -EBUSY;
> +	}
> +
> +	ltq_map.phys = res->start;
> +	ltq_map.size = resource_size(res);
> +	ltq_map.virt = devm_ioremap_nocache(&pdev->dev, ltq_map.phys,
> +					ltq_map.size);
> +	if (!ltq_map.virt) {
> +		dev_err(&pdev->dev, "failed to ioremap!\n");
> +		return -EIO;
> +	}
> +
> +	ltq_mtd_probing = 1;
> +	ltq_mtd = do_map_probe("cfi_probe", &ltq_map);
> +	ltq_mtd_probing = 0;
> +	if (!ltq_mtd) {
> +		iounmap(ltq_map.virt);
> +		dev_err(&pdev->dev, "probing failed\n");
> +		return -ENXIO;
> +	}
> +	ltq_mtd->owner = THIS_MODULE;
> +
> +	cfi = ltq_map.fldrv_priv;
> +	cfi->addr_unlock1 ^= 1;
> +	cfi->addr_unlock2 ^= 1;
> +
> +	nr_parts = parse_mtd_partitions(ltq_mtd, part_probe_types, &parts, 0);
> +	if (nr_parts > 0) {
> +		dev_info(&pdev->dev,
> +			"using %d partitions from cmdline", nr_parts);
> +	} else {
> +		nr_parts = ltq_mtd_data->nr_parts;
> +		parts = ltq_mtd_data->parts;
> +	}
> +
> +	add_mtd_partitions(ltq_mtd, parts, nr_parts);

This function may return an error.

> +	return 0;
> +}
> +
> +static struct platform_driver ltq_mtd_driver = {
> +	.driver = {
> +		.name = "ltq_nor",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +int __init
> +init_ltq_mtd(void)
> +{
> +	int ret = platform_driver_probe(&ltq_mtd_driver, ltq_mtd_probe);
> +
> +	if (ret)
> +		printk(KERN_INFO "ltq_nor: error registering platfom driver");

I think errors should be printed with KERN_ERR level. Anyway, use
pr_err() here instead pleas.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
