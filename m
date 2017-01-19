Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2017 00:50:51 +0100 (CET)
Received: from mga04.intel.com ([192.55.52.120]:45331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993910AbdASXuoI9ikS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jan 2017 00:50:44 +0100
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP; 19 Jan 2017 15:50:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,256,1477983600"; 
   d="scan'208";a="215473946"
Received: from irsmsx106.ger.corp.intel.com ([163.33.3.31])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jan 2017 15:50:40 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.112]) by
 IRSMSX106.ger.corp.intel.com ([169.254.8.197]) with mapi id 14.03.0248.002;
 Thu, 19 Jan 2017 23:50:40 +0000
From:   "Langer, Thomas" <thomas.langer@intel.com>
To:     Sebastien Decourriere <sebtx452@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness
 swap is enabled
Thread-Topic: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness
 swap is enabled
Thread-Index: AQHScjvq6G8Bb2pm102U3YvjlpsRaKFAWHWw
Date:   Thu, 19 Jan 2017 23:50:39 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1E6E2999@IRSMSX101.ger.corp.intel.com>
References: <1484820415-12439-1-git-send-email-sebtx452@gmail.com>
In-Reply-To: <1484820415-12439-1-git-send-email-sebtx452@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <thomas.langer@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.langer@intel.com
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

Hello Sebastien,

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
> mips.org] On Behalf Of Sebastien Decourriere
> Sent: Thursday, January 19, 2017 11:07 AM
> To: linux-mtd@lists.infradead.org
> Cc: linux-mips@linux-mips.org; Sebastien Decourriere <sebtx452@gmail.com>
> Subject: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap
> is enabled
> 
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
>  drivers/mtd/maps/lantiq-flash.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-
> flash.c
> index c8febb3..1cbbdcb 100644
> --- a/drivers/mtd/maps/lantiq-flash.c
> +++ b/drivers/mtd/maps/lantiq-flash.c
> @@ -38,6 +38,8 @@ enum {
>  	LTQ_NOR_NORMAL
>  };
> 
> +#define EBU_ENDIAN_SWAP		BIT(30)
> +
>  struct ltq_mtd {
>  	struct resource *res;
>  	struct mtd_info *mtd;
> @@ -113,6 +115,20 @@ ltq_mtd_probe(struct platform_device *pdev)
>  	struct ltq_mtd *ltq_mtd;
>  	struct cfi_private *cfi;
>  	int err;
> +	bool mtd_addr_swap;
> +
> +	/* If SoC is vr9 >= 1.2 or ar10 and EBU endian swap
> +	   is enabled, we don't need to do software address swap */
> +	if ( ltq_ebu_r32(LTQ_EBU_BUSCON0) & EBU_ENDIAN_SWAP ) {

This register does not exist for all Lantiq SoCs, even the definition
is only in "arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h", but
not in "arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h"

Please add at least a compile check for the define.

> +		switch (ltq_soc_type()) {
> +			case SOC_TYPE_VR9_2 :
> +			case SOC_TYPE_AR10 :
> +				mtd_addr_swap = false;
> +				break;
> +			default :
> +				mtd_addr_swap = true;
Missing break

> +		}
> +	} else mtd_addr_swap = true;

Has this been checked with checkpatch.pl?
This line results in message "ERROR: trailing statements should be on next line",
some other warning about spaces are also in this patch.

> 
>  	if (of_machine_is_compatible("lantiq,falcon") &&
>  			(ltq_boot_select() != BS_FLASH)) {
> @@ -150,7 +166,10 @@ ltq_mtd_probe(struct platform_device *pdev)
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
> @@ -163,8 +182,10 @@ ltq_mtd_probe(struct platform_device *pdev)
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
> --
> 2.1.4
> 

Regards,
Thomas
