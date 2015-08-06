Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 09:08:22 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:34580 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010899AbbHFHIRq-6rk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 09:08:17 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NSN001QWFTK9Y40@mailout3.w1.samsung.com>; Thu,
 06 Aug 2015 08:08:08 +0100 (BST)
X-AuditID: cbfec7f5-f794b6d000001495-a9-55c307d8fb41
Received: from eusync2.samsung.com ( [203.254.199.212])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 2B.FE.05269.8D703C55; Thu,
 6 Aug 2015 08:08:08 +0100 (BST)
Received: from [0.0.0.0] ([106.116.37.23])
 by eusync2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NSN0015TFTB5H30@eusync2.samsung.com>; Thu,
 06 Aug 2015 08:08:08 +0100 (BST)
Message-id: <55C307D4.1020209@samsung.com>
Date:   Thu, 06 Aug 2015 16:08:04 +0900
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.8.0
MIME-version: 1.0
To:     Shawn Lin <shawn.lin@rock-chips.com>, jh80.chung@samsung.com,
        ulf.hansson@linaro.org
Cc:     heiko@sntech.de, dianders@chromium.org, Vineet.Gupta1@synopsys.com,
        Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/9] mmc: dw_mmc: Add external dma interface support
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843491-23853-1-git-send-email-shawn.lin@rock-chips.com>
In-reply-to: <1438843491-23853-1-git-send-email-shawn.lin@rock-chips.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xK7o32A+HGpy8ymLRfPUpu8X8I+dY
        Lc4uO8hm8ePpPRaL/49es1rc+NXGarHkyUN2i9cvDC36H79mttj0+BqrxeVdc9gsJkydxG5x
        5H8/o8WnB/+ZLWac38dkcfsyr8Xu6+cYLS7tUbG482Q9q8XxteEWja/WMls8OTqF2UHMo6W5
        h81jdsNFFo+ds+6yezyeu5Hdo2fnGUaPTas62TzuXNvD5nF05Vomj81L6j3+ztrP4tG3ZRWj
        x/Zr85g9tuz/zOjxeZNcAF8Ul01Kak5mWWqRvl0CV8aSFR1sBRPUKw6/+8DawDhZvouRk0NC
        wETizsaXLBC2mMSFe+vZuhi5OIQEljJKXP0xjx3C+cIo8X7SMeYuRg4OXgEtiU+vCkAaWARU
        JfY+6wFrZhMwlti8fAkbiC0qECGxfPVJRhCbV0BQ4sfke2A1IgJREoe/PQJbwCxwnUXiyfO7
        YAlhAX+Jg5sPMUEsa2eUmH3kPlg3p4CnxI59l8EWMwvoSdy/qAUSZhaQl9i85i3zBEaBWUh2
        zEKomoWkagEj8ypG0dTS5ILipPRcI73ixNzi0rx0veT83E2MkFj+uoNx6TGrQ4wCHIxKPLwW
        6w+FCrEmlhVX5h5ilOBgVhLh3XoBKMSbklhZlVqUH19UmpNafIhRmoNFSZx35q73IUIC6Ykl
        qdmpqQWpRTBZJg5OqQZGEfejNsusXgivElCbnRW57BP3iupZTW0qhkIV7Jc5LltYT3c/o+Gp
        OdMoIDfO/xjr+T9RcQ/iPmywO7hjhaTajIoMX+8/C4sff/3wxbc49HTpy2OtTJZv07gCu3Wm
        xui0/lqm2nLgresW1rsOl+fI3Xq3U18msyTl3WG2Ler8MkrLte6kiZgrsRRnJBpqMRcVJwIA
        8kzrY+ECAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

On 06.08.2015 15:44, Shawn Lin wrote:
> DesignWare MMC Controller can supports two types of DMA
> mode: external dma and internal dma. We get a RK312x platform
> integrated dw_mmc and ARM pl330 dma controller. This patch add
> edmac ops to support these platforms. I've tested it on RK312x
> platform with edmac mode and RK3288 platform with idmac mode.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v4:
> - remove "host->trans_mode" and use "host->use_dma" to indicate
>   transfer mode.
> - remove all bt-bindings' changes since we don't need new properities.
> - check transfer mode at runtime by reading HCON reg
> - spilt defconfig changes for each sub-architecture
> - fix the title of cover letter

How did you fixed the title? It is still empty :)
	Subject: [RFC PATCH v4 0/9]

> - reuse some code for reducing code size
> 
> Changes in v3:
> - choose transfer mode at runtime
> - remove all CONFIG_MMC_DW_IDMAC config option
> - add supports-idmac property for some platforms
> 
> Changes in v2:
> - Fix typo of dev_info msg
> - remove unused dmach from declaration of dw_mci_dma_slave
> 
>  drivers/mmc/host/Kconfig        |  11 +-
>  drivers/mmc/host/dw_mmc-pltfm.c |   2 +
>  drivers/mmc/host/dw_mmc.c       | 258 ++++++++++++++++++++++++++++++++--------
>  include/linux/mmc/dw_mmc.h      |  27 ++++-
>  4 files changed, 232 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 6a0f9c7..a86c0eb 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -607,15 +607,7 @@ config MMC_DW
>  	help
>  	  This selects support for the Synopsys DesignWare Mobile Storage IP
>  	  block, this provides host support for SD and MMC interfaces, in both
> -	  PIO and external DMA modes.
> -
> -config MMC_DW_IDMAC
> -	bool "Internal DMAC interface"
> -	depends on MMC_DW
> -	help
> -	  This selects support for the internal DMAC block within the Synopsys
> -	  Designware Mobile Storage IP block. This disables the external DMA
> -	  interface.
> +	  PIO, internal DMA mode and external DMA modes.
>  
>  config MMC_DW_PLTFM
>  	tristate "Synopsys Designware MCI Support as platform device"
> @@ -644,7 +636,6 @@ config MMC_DW_K3
>  	tristate "K3 specific extensions for Synopsys DW Memory Card Interface"
>  	depends on MMC_DW
>  	select MMC_DW_PLTFM
> -	select MMC_DW_IDMAC
>  	help
>  	  This selects support for Hisilicon K3 SoC specific extensions to the
>  	  Synopsys DesignWare Memory Card Interface driver. Select this option
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index ec6dbcd..7e1d13b 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -59,6 +59,8 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
>  	host->pdata = pdev->dev.platform_data;
>  
>  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	/* Get registers' physical base address */
> +	host->phy_regs = (void *)(regs->start);
>  	host->regs = devm_ioremap_resource(&pdev->dev, regs);
>  	if (IS_ERR(host->regs))
>  		return PTR_ERR(host->regs);
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 40e9d8e..5d6cdff 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -56,7 +56,7 @@
>  #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
>  #define DW_MCI_FREQ_MIN	400000		/* unit: HZ */
>  
> -#ifdef CONFIG_MMC_DW_IDMAC
> +
>  #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
>  				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
>  				 SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_INT_RI | \
> @@ -99,7 +99,6 @@ struct idmac_desc {
>  
>  	__le32		des3;	/* buffer 2 physical address */
>  };
> -#endif /* CONFIG_MMC_DW_IDMAC */
>  
>  static bool dw_mci_reset(struct dw_mci *host);
>  static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
> @@ -403,7 +402,6 @@ static int dw_mci_get_dma_dir(struct mmc_data *data)
>  		return DMA_FROM_DEVICE;
>  }
>  
> -#ifdef CONFIG_MMC_DW_IDMAC
>  static void dw_mci_dma_cleanup(struct dw_mci *host)
>  {
>  	struct mmc_data *data = host->data;
> @@ -441,12 +439,21 @@ static void dw_mci_idmac_stop_dma(struct dw_mci *host)
>  	mci_writel(host, BMOD, temp);
>  }
>  
> -static void dw_mci_idmac_complete_dma(struct dw_mci *host)
> +static void dw_mci_dmac_complete_dma(void *arg)
>  {
> +	struct dw_mci *host = arg;

Why changing the argument to void*?

Best regards,
Krzysztof

>  	struct mmc_data *data = host->data;
>  
>  	dev_vdbg(host->dev, "DMA complete\n");
>  
> +	if (host->use_dma == TRANS_MODE_EDMAC)
> +		if (data && (data->flags & MMC_DATA_READ))
> +			/* Invalidate cache after read */
> +			dma_sync_sg_for_cpu(mmc_dev(host->cur_slot->mmc),
> +					    data->sg,
> +					    data->sg_len,
> +					    DMA_FROM_DEVICE);
> +
>  	host->dma_ops->cleanup(host);
