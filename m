Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2017 22:33:08 +0100 (CET)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:45700 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992183AbdAXVdAskHdH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2017 22:33:00 +0100
Received: from [IPv6:2003:86:280b:8100:4a51:b7ff:fed3:ec08] (p20030086280B81004A51B7FFFED3EC08.dip0.t-ipconnect.de [IPv6:2003:86:280b:8100:4a51:b7ff:fed3:ec08])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 237F010002C;
        Tue, 24 Jan 2017 22:33:00 +0100 (CET)
Subject: Re: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap
 is enabled
To:     Sebastien Decourriere <sebtx452@gmail.com>,
        linux-mtd@lists.infradead.org
References: <1484904834-14980-1-git-send-email-sebtx452@gmail.com>
Cc:     linux-mips@linux-mips.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <3304d64f-38aa-1a3c-0b5d-edb493abd61a@hauke-m.de>
Date:   Tue, 24 Jan 2017 22:32:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1484904834-14980-1-git-send-email-sebtx452@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 01/20/2017 10:33 AM, Sebastien Decourriere wrote:
> The purpose of this patch is to enable the software address endianness
> swapping only when the in SoC EBU endianness swapping is disabled.
> To perform this check, I look at Bit 30 of the EBU_CON_0 register.
> Actually, the driver expects that the in SoC swapping is disabled.
> This is the case with current bootloaders shuch as U-boot.
> 
> This applies only to vr9 (xrx200) rev 1.2 and ar10 (xrx300).
> 
> I have a router which uses a proprietary bootloader which keeps
> the in SoC swapping enabled. The SoC in this router is a vrx200 v1.2.
> In this SoC version, I can keep the in SoC swapping without any problem.
> 
> This patch replaces my previous broken patch.
> 
> Signed-off-by: Sebastien Decourriere <sebtx452@gmail.com>
> ---
>  .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |  1 +
>  drivers/mtd/maps/lantiq-flash.c                    | 29 +++++++++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> index 17b41bb..0ed0896 100644
> --- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> +++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> @@ -87,6 +87,7 @@ extern __iomem void *ltq_cgu_membase;
>  #define LTQ_EBU_PCC_ISTAT	0x00A0
>  #define LTQ_EBU_BUSCON1		0x0064
>  #define LTQ_EBU_ADDRSEL1	0x0024
> +#define EBU_FLASH_ENDIAN_SWAP	0x40000000
>  #define EBU_WRDIS		0x80000000
>  
>  /* WDT */
> diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
> index c8febb3..8d628d2 100644
> --- a/drivers/mtd/maps/lantiq-flash.c
> +++ b/drivers/mtd/maps/lantiq-flash.c
> @@ -113,6 +113,24 @@ ltq_mtd_probe(struct platform_device *pdev)
>  	struct ltq_mtd *ltq_mtd;
>  	struct cfi_private *cfi;
>  	int err;
> +	bool mtd_addr_swap = true;
> +
> +#ifdef CONFIG_SOC_TYPE_XWAY
> +	/* If SoC is vr9 rev 1.2 or ar10 and EBU endian swap
> +	 *  is enabled, we don't need to do software address swap
> +	 */
> +	if (ltq_ebu_r32(LTQ_EBU_BUSCON0) & EBU_FLASH_ENDIAN_SWAP) {
> +		switch (ltq_soc_type()) {

I would like to get rid of the calls to ltq_soc_type(). This list also
has to get extended for more recent SoCs which are not yet supported by
mainline kernel like xrx500 (GRX350/550), grx300/330.

This EBU register also does not exits on falcon, this SoC uses a
different EBU.

I would prefer to use a device tree option to activate this check and
only access LTQ_EBU_BUSCON0 when this property is set.

> +		case SOC_TYPE_VR9_2:
> +		case SOC_TYPE_AR10:
> +			mtd_addr_swap = false;
> +			break;
> +		default:
> +			mtd_addr_swap = true;
> +			break;
> +		}
> +	}
> +#endif
>  
>  	if (of_machine_is_compatible("lantiq,falcon") &&
>  			(ltq_boot_select() != BS_FLASH)) {
> @@ -150,7 +168,10 @@ ltq_mtd_probe(struct platform_device *pdev)
>  	ltq_mtd->map->copy_from = ltq_copy_from;
>  	ltq_mtd->map->copy_to = ltq_copy_to;
>  
> -	ltq_mtd->map->map_priv_1 = LTQ_NOR_PROBING;
> +	if (mtd_addr_swap)
> +		ltq_mtd->map->map_priv_1 = LTQ_NOR_PROBING;
> +	else
> +		ltq_mtd->map->map_priv_1 = LTQ_NOR_NORMAL;
>  	ltq_mtd->mtd = do_map_probe("cfi_probe", ltq_mtd->map);
>  	ltq_mtd->map->map_priv_1 = LTQ_NOR_NORMAL;
>  
> @@ -163,8 +184,10 @@ ltq_mtd_probe(struct platform_device *pdev)
>  	mtd_set_of_node(ltq_mtd->mtd, pdev->dev.of_node);
>  
>  	cfi = ltq_mtd->map->fldrv_priv;
> -	cfi->addr_unlock1 ^= 1;
> -	cfi->addr_unlock2 ^= 1;
> +	if (mtd_addr_swap) {
> +		cfi->addr_unlock1 ^= 1;
> +		cfi->addr_unlock2 ^= 1;
> +	}
>  
>  	err = mtd_device_register(ltq_mtd->mtd, NULL, 0);
>  	if (err) {
> 
