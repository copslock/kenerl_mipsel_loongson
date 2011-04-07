Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2011 16:07:42 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:53394 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491061Ab1DGOHh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2011 16:07:37 +0200
Received: by wwb17 with SMTP id 17so2726518wwb.24
        for <multiple recipients>; Thu, 07 Apr 2011 07:07:32 -0700 (PDT)
Received: by 10.216.191.208 with SMTP id g58mr865724wen.85.1302185251913;
        Thu, 07 Apr 2011 07:07:31 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id d6sm854006wer.2.2011.04.07.07.07.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 07:07:29 -0700 (PDT)
Message-ID: <4D9DC4B7.2080706@mvista.com>
Date:   Thu, 07 Apr 2011 18:05:43 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH V8] MIPS: lantiq: add NOR flash support
References: <1302013192-8854-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1302013192-8854-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

John Crispin wrote:

> This patch adds the driver/map for NOR devices attached to the SoC via the
> External Bus Unit (EBU).

> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-mtd@lists.infradead.org

> diff --git a/drivers/mtd/maps/lantiq.c b/drivers/mtd/maps/lantiq.c
> new file mode 100644
> index 0000000..4f8c320
> --- /dev/null
> +++ b/drivers/mtd/maps/lantiq.c
> @@ -0,0 +1,197 @@
[...]
> +/* 
> + * The NOR flash is connected to the same external bus unit (EBU) as PCI.
> + * To make PCI work we need to enable the endianess swapping for the address

    s/endianess/endianness/

> + * written to the EBU. This endianess swapping works for PCI correctly but

    Here too.

> + * fails for attached NOR devices. To workaround this we need to use a complex
> + * map. The workaround involves swapping all addresses whilste probing the chip.

    s/whilste/whilst/

> + * Once probing is complete we stop swapping the addresses but swizzle the
> + * unlock addresses to ensure that access to the NOR device works correctly.
> + */
> +
> +enum ltq_nor_state {
> +	LTQ_NOR_PROBING,
> +	LTQ_NOR_NORMAL
> +};
> +
> +static char ltq_map_name[] = "ltq_nor";
> +
> +static map_word
> +ltq_read16(struct map_info *map, unsigned long adr)
> +{
> +	unsigned long flags;
> +	map_word temp;
> +
> +	if (map->map_priv_1 == LTQ_NOR_PROBING)
> +		adr ^= 2;
> +	spin_lock_irqsave(&ebu_lock, flags);
> +	temp.x[0] = *((__u16 *)(map->virt + adr));

    Too many parens; the most external ones are not necessary.
    And why not just 'u16'?

> +	spin_unlock_irqrestore(&ebu_lock, flags);
> +	return temp;
> +}
> +
> +static void
> +ltq_write16(struct map_info *map, map_word d, unsigned long adr)
> +{
> +	unsigned long flags;
> +
> +	if (map->map_priv_1 == LTQ_NOR_PROBING)
> +		adr ^= 2;
> +	spin_lock_irqsave(&ebu_lock, flags);
> +	*((__u16 *)(map->virt + adr)) = d.x[0];

    Same here.

> +	spin_unlock_irqrestore(&ebu_lock, flags);
> +}
> +
> +/*
> + * The following 2 functions copy data between iomem and a cached memory
> + * section. As memcpy() makes use of pre-fetching we cannot use it here.
> + * The normal alternative of using memcpy_{to,from}io also makes use of
> + * memcpy() on MIPS so it is not applicable either. We are therefore stuck
> + * with having to use our own loop.
> + */
> +static void
> +ltq_copy_from(struct map_info *map, void *to,
> +	unsigned long from, ssize_t len)
> +{
> +	unsigned char *f = (unsigned char *) (map->virt + from);
> +	unsigned char *t = (unsigned char *) to;

    I think you should either always put a space between the type and value 
being cast or not -- you do both. :-)

> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ebu_lock, flags);
> +	while (len--)
> +		*t++ = *f++;

    I'm still not sure: you've implemented only 16-bit single read/write, yet 
you copy byte-by-byte? Does the byte access really work?

> +	spin_unlock_irqrestore(&ebu_lock, flags);
> +}
> +
[...]
> +static int __init
> +ltq_mtd_probe(struct platform_device *pdev)
> +{
> +	struct physmap_flash_data *ltq_mtd_data = dev_get_platdata(&pdev->dev);
> +	struct mtd_info *ltq_mtd = NULL;
> +	struct mtd_partition *parts = NULL;
> +	struct resource *res;
> +	int nr_parts = 0;
> +	struct cfi_private *cfi;
> +	struct map_info *ltq_map;
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
> +	ltq_map = kzalloc(sizeof(struct map_info), GFP_KERNEL);
> +	ltq_map->phys = res->start;
> +	ltq_map->size = resource_size(res);
> +	ltq_map->virt = devm_ioremap_nocache(&pdev->dev, ltq_map->phys,
> +					ltq_map->size);
> +	if (!ltq_map->virt) {
> +		kfree(ltq_map);

   You should do error cleanup in one places, using *goto* to jump to that code, 
to avoid duplicating the same code.

> +		dev_err(&pdev->dev, "failed to ioremap!\n");
> +		return -EIO;

    Rather -ENOMEM.

[...]
> +int __init
> +init_ltq_mtd(void)
> +{
> +	int ret = platform_driver_probe(&ltq_mtd_driver, ltq_mtd_probe);
> +
> +	if (ret)
> +		pr_err("ltq_nor: error registering platfom driver");

    s/platfom/platform/

> +	return ret;
> +}
> +
> +module_init(init_ltq_mtd);

    How about module_exit()?

WBR, Sergei
