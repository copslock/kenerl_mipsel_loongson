Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 13:39:13 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:47211 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992078AbdARMjAH9hVy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jan 2017 13:39:00 +0100
Subject: Re: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap
 is enabled
To:     Sebastien Decourriere <sebtx452@gmail.com>,
        linux-mtd@lists.infradead.org
References: <1484741452-27141-1-git-send-email-sebtx452@gmail.com>
Cc:     linux-mips@linux-mips.org
From:   John Crispin <john@phrozen.org>
Message-ID: <e5bb2245-a0d0-5b66-2c75-9af26c6ea846@phrozen.org>
Date:   Wed, 18 Jan 2017 13:38:58 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <1484741452-27141-1-git-send-email-sebtx452@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Hi Sebastien,

thanks, comments inline

On 18/01/2017 13:10, Sebastien Decourriere wrote:
> The purpose of this patch is to enable the software address endianness
> swapping only when the in SoC EBU endianness swapping is disabled.
> To perform this check, I look at Bit 30 of the EBU_CON_0 register.
> Actually, the driver expects that the in SoC swapping is disabled.
> This is the case with current bootloaders shuch as U-boot. But,
> 
> I have a router which uses a proprietary bootloader which keeps
> the in SoC swapping enabled. The SoC in this router is a vrx200 v1.2.
> In this SoC version, I can keep the in SoC swapping without any problem.
> 
> Signed-off-by: Sebastien Decourriere <sebtx452@gmail.com>
> ---
>  drivers/mtd/maps/lantiq-flash.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
> index c8febb3..a091efa 100644
> --- a/drivers/mtd/maps/lantiq-flash.c
> +++ b/drivers/mtd/maps/lantiq-flash.c
> @@ -151,6 +151,11 @@ ltq_mtd_probe(struct platform_device *pdev)
>  	ltq_mtd->map->copy_to = ltq_copy_to;
>  
>  	ltq_mtd->map->map_priv_1 = LTQ_NOR_PROBING;

this line should be dropped

> +	/* We swap the addresses only if the EBU endianness swap is disabled */
> +	if (ltq_ebu_r32(LTQ_EBU_BUSCON0) & BIT(30))

add a define for BIT(30) please and we should really check if this a
v1.2 or newer. if my memory is correct this was a silicon bug inside
v1.0 and v1.1

	John

> +		ltq_mtd->map[i].map_priv_1 = LTQ_NOR_NORMAL;
> +	else
> +		ltq_mtd->map[i].map_priv_1 = LTQ_NOR_PROBING;
>  	ltq_mtd->mtd = do_map_probe("cfi_probe", ltq_mtd->map);
>  	ltq_mtd->map->map_priv_1 = LTQ_NOR_NORMAL;
>  
> @@ -163,8 +168,11 @@ ltq_mtd_probe(struct platform_device *pdev)
>  	mtd_set_of_node(ltq_mtd->mtd, pdev->dev.of_node);
>  
>  	cfi = ltq_mtd->map->fldrv_priv;
> -	cfi->addr_unlock1 ^= 1;
> -	cfi->addr_unlock2 ^= 1;
> +	/* We swap the addresses only if the EBU endianness swap is disabled */
> +	if (!(ltq_ebu_r32(LTQ_EBU_BUSCON0) & BIT(30))) {
> +		cfi->addr_unlock1 ^= 1;
> +		cfi->addr_unlock2 ^= 1;
> +	}
>  
>  	err = mtd_device_register(ltq_mtd->mtd, NULL, 0);
>  	if (err) {
> 
