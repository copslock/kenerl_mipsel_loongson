Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 04:27:40 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:38759 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007168AbbHFC1gy4UDs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 04:27:36 +0200
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSN01RFL2TSH540@mailout2.samsung.com>; Thu,
 06 Aug 2015 11:27:28 +0900 (KST)
Received: from epcpsbgm2new.samsung.com ( [172.20.52.113])
        by epcpsbgr2.samsung.com (EPCPMTA) with SMTP id 98.A4.28411.016C2C55; Thu,
 6 Aug 2015 11:27:28 +0900 (KST)
X-AuditID: cbfee68e-f79c56d000006efb-a0-55c2c6106518
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm2new.samsung.com (EPCPMTA) with SMTP id CE.6C.07062.F06C2C55; Thu,
 6 Aug 2015 11:27:28 +0900 (KST)
Received: from [10.252.81.186] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NSN007RZ2TRZL60@mmp1.samsung.com>; Thu,
 06 Aug 2015 11:27:27 +0900 (KST)
Message-id: <55C2C60F.4020900@samsung.com>
Date:   Thu, 06 Aug 2015 11:27:27 +0900
From:   Jaehoon Chung <jh80.chung@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101
 Thunderbird/31.7.0
MIME-version: 1.0
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Seungwon Jeon <tgih.jun@samsung.com>
Cc:     dianders@chromium.org, linux-mips@linux-mips.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Stefan Agner <stefan@agner.ch>,
        Zhou Wang <wangzhou.bry@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Wang Long <long.wanglong@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        Jun Nie <jun.nie@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hao <haokexin@gmail.com>,
        Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-samsung-soc@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vineet Gupta <vgupta@synopsys.com>,
        Scott Branden <sbranden@broadcom.com>,
        Anand Moon <linux.amoon@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Tushar Behera <trblinux@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mischa Jonker <mjonker@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joachim Eastwood <manabian@gmail.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        addy ke <addy.ke@rock-chips.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Jean Delvare <jdelvare@suse.de>,
        Kevin Hilman <khilman@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        CPGS <cpgs@samsung.com>
Subject: Re: [RFC PATCH v3 1/5] mmc: dw_mmc: Add external dma interface support
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762648-22202-1-git-send-email-shawn.lin@rock-chips.com>
In-reply-to: <1438762648-22202-1-git-send-email-shawn.lin@rock-chips.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1DTdRjH77Pvr4HNvi3Aj7tLO67+iBIDhj1lpXVX9+36Q+86qawL19oB
        Fz/mhqR/eMcBpmfG2BAZU3EcjB8xJgw1BVFZ+5E0kLFizGAMNzKEBVIJwiFtrC7/ez3P5/28
        n/fnj4dPCO/RIn5OfqFMkS/JTaRjSWOceP8W1m7Z8/LFgThomV1BUPrLJAONqws8KDUr4dhw
        PQ/8tZdoWNHYGZhtPIFg+PY5GqYsL8A56wAF/Y29NKhm6ig4e1qDYHHSR4L9rp+C1TvTFAzc
        a0FgW5aDYWyehobgBAPTv6eAKjBNwN8/NCOYmehEYA4MU+DuOkNDRZWGAeuqCsG8f5UA7a1r
        PDB13GbgV7cArG4jgm7PAAKDx8WD8foFBH2eP8NT1W0ktGsfkRBoDjEwdPU5mKzppOFIj5WB
        Rec3JPzRGkQwGjxPQbUjRMHXdjsFnaajDIxUl1EwN+4ioLxtiIb2yu7wLnUlAkfbh2C5eIeE
        ptpUuDZvQBDS2xiYuv8jCUHbSQK8xkFm5w6ufsFHcMZaI+LKSk/Q3PKSBnG68X6aO13sIjl3
        +bc8buWuh+QujzUgruvKGYoLml2IU/dv4a7oxhiupekvmguc7WC4MmuI2v3s3tjXv5Dl5hTJ
        FFvf3BebfX3Uz8hb1eigd66LLEY3FcdRDB+zYtzj76OjnIAHfefDHMsXss0I66wlxH+imaEj
        TPTBgLB+qg5FCz/CpsAF8jji8wVsEm6YpSIDJPs8LtG3MRGm2Zfw9w8cvAjHsxnYqT1GRljA
        PoUXK31rHMcW4ftVC7yIJ8EahXiivQlFPJ9md+GOuieju44irF7+eS1qDPsengmcXNMQbDIe
        dyVF2gS7GXcaQ0REj1ntOtw7WEtHA7H4QaVlLSdmn8HmG/9+bCPubR4hK1CC7rFIuv9ddY+5
        6hHxHYqXyaVy5edZitRkpSRPeSA/K1lakGdG4RP46dFv5ZeR98Z2C2L5KPEJgd9o2SOkJEXK
        Q3kWlB4OoSZE8dKC8NXkF2ampG1LhXRxelrqK69uS9wg2Cd6+IGQzZIUyr6UyeQyRabiQK5M
        aUE8foyoGBnW5XzksXycOaa1jVT3tEo3OYIFmy8J9/NMS4fnpjcW5s2lf5pt26Q6lfGGKc17
        oSqDczortpsTHr7V41T4ejWHqMPljaqvblnEuzyjopGD727dmTyxJH67j37NV3Lz6vrdO/bK
        St6//uKG0CfvSB0cqR0kmtbrC7zdve6amFM1nyWSymxJShKhUEr+AbSIwib9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTf1CTdRzH++75NbDV45R6jq6Le046RQdsgvtwJ/04yx7OtJVSnHdFj/Dc
        wNhYG1D6FwkkkgkMDJrKj2MMkYH8SAU0vcYAS4cCxhIFBoOMgBD6AcUhbXCWV9+/3t/3vV/v
        z933ex8xJr1A+YsTtSmCXssnsaQvfu2Bm5bRHbbo0GstOFRPLyLI+H6MAsvSnAgyGg2Q3Vch
        AlfJeRIWjR0UTFuOIujrLyVh3LYBSu1dBDgs35CQO1lOwKkTRgTzY4M4dNxzEbA0MkFA18/V
        CNoXdFA5MEuCeXSYgomf5JDrnsDg97bTCCaHmxA0uvsI6G09SULecSMF9qVcBLOuJQyKb1wW
        QV1DPwV3eiVg77UiuOjsQlDp7BbBUMUcgu+cv3qooloc6osf4OA+PUVBz6V1MPZlEwlZX9sp
        mL/+GQ6/1IwiuDt6loCizikCPu3oIKCp7jAFPxRlEnB/qBuDY7U9JNQXXPTMyi9A0Fn7DtjO
        jeBQVaKAy7OVCKbK2ikYn7mKw2h7IQa3rTepl17kKuYGMc5aYkVcZsZRklv4y4g405CD5E6k
        d+Nc77HPRdziPSfONQ+YEdfacpLgRhu7EZfvkHEtpgGKq676jeTcpxooLtM+RagC9qajrQkC
        Hy/oAwRtXHJ8olYdye7YHbstNnxLqFwmjwAlG6DlNUIk+8rrKtn2xCTPd7IBaXxSqsdS8QYD
        G/LC/xui92yXwUMwRrZzz1v/MIrQ/5z3rSjhyl0XpavJRx/fvt+Kp6Nv9TnIR8zQYcxkTxa1
        op9ibg6eJXOQr1hKVyKmbLwcrVxciKlzf4XnILFYQgcx5mnCC+B0IHOorHYZJulNzIU/OkVe
        7Ue/zVwvzsa9WkKvZuYLBpf1WjqNmTk+J/J2YrRVygzXVyFv5xr6Daah/MmVWYcRk79wi/QC
        PnQUM+kuXM5gdDAz1B3ktTH6OabJOoXlIdr0yAjTvynTI6kyhJ1BjKCL0xn2qTUKrfBRsIHX
        GFK16uC4ZE0jWl6aH59pRm2tr9kQLUbs4xKX1RYtJfg0wwGNDTFijF0rmc72WJJ4/sBBQZ8c
        q09NEgw2FO55g3zM3y8u2bOC2pRY+eawLYoIhVIOis1K9mlJSFhjtJRW8ynCB4KgE/QPOZHY
        xz8dhTJPHKk0y2LMEb6rI9lNl+Z3OPz365wf+qetSlGvv7EtSuZoVqk2wr48x3nZu/hWMx5z
        zv7eFbpQnnIn6eWr8W11RzKlpbjSWNCV+kmk8uBuS1Tf/qDHFsZH+iu+sCQ8q54pe7UmcJef
        5s/1E6ueL7i1hkrfsLcoMPnNM4fCNzqyQljckMDLgzC9gf8baw8QZkoEAAA=
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jh80.chung@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jh80.chung@samsung.com
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

Hi, Shawn.

On 08/05/2015 05:17 PM, Shawn Lin wrote:
> DesignWare MMC Controller can supports two types of DMA
> mode: external dma and internal dma. We get a RK312x platform
> integrated dw_mmc and ARM pl330 dma controller. This patch add
> edmac ops to support these platforms. I've tested it on RK312x
> platform with edmac mode and RK3288 platform with idmac mode.

RK312X doesn't support the idamc? Just wondering...

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
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
>  drivers/mmc/host/dw_mmc.c       | 277 +++++++++++++++++++++++++++++++++-------
>  include/linux/mmc/dw_mmc.h      |  28 +++-
>  4 files changed, 255 insertions(+), 63 deletions(-)
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
> index 40e9d8e..9341879 100644
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
> @@ -441,8 +439,9 @@ static void dw_mci_idmac_stop_dma(struct dw_mci *host)
>  	mci_writel(host, BMOD, temp);
>  }
>  
> -static void dw_mci_idmac_complete_dma(struct dw_mci *host)
> +static void dw_mci_idmac_complete_dma(void *arg)
>  {
> +	struct dw_mci *host = arg;
>  	struct mmc_data *data = host->data;
>  
>  	dev_vdbg(host->dev, "DMA complete\n");
> @@ -527,7 +526,7 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
>  	wmb();
>  }
>  
> -static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
> +static int dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>  {
>  	u32 temp;
>  
> @@ -551,6 +550,8 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>  
>  	/* Start it running */
>  	mci_writel(host, PLDMND, 1);
> +
> +	return 0;

void -> int? What do you want to do at here?

>  }
>  
>  static int dw_mci_idmac_init(struct dw_mci *host)
> @@ -632,7 +633,142 @@ static const struct dw_mci_dma_ops dw_mci_idmac_ops = {
>  	.complete = dw_mci_idmac_complete_dma,
>  	.cleanup = dw_mci_dma_cleanup,
>  };
> -#endif /* CONFIG_MMC_DW_IDMAC */
> +
> +static void dw_mci_edmac_cleanup(struct dw_mci *host)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	if (data && (!data->host_cookie))
> +		dma_unmap_sg(host->dev, data->sg,
> +			     data->sg_len, dw_mci_get_dma_dir(data));
> +}
> +

Can it reuse the dw_mci_dma_cleanup()?

> +static void dw_mci_edmac_stop_dma(struct dw_mci *host)
> +{
> +	dmaengine_terminate_all(host->dms->ch);
> +}
> +
> +static void dw_mci_edmac_complete_dma(void *arg)
> +{
> +	struct dw_mci *host = arg;
> +	struct mmc_data *data = host->data;
> +
> +	dev_vdbg(host->dev, "DMA complete\n");
> +
> +	if (data && data->flags & MMC_DATA_READ)
> +		/* Invalidate cache after read */
> +		dma_sync_sg_for_cpu(mmc_dev(host->cur_slot->mmc), data->sg,
> +				    data->sg_len, DMA_FROM_DEVICE);
> +
> +	host->dma_ops->cleanup(host);
> +
> +	/*
> +	* If the card was removed, data will be NULL. No point in trying to
> +	* send the stop command or waiting for NBUSY in this case.
> +	*/
> +	if (data) {
> +		set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
> +		tasklet_schedule(&host->tasklet);
> +	}
> +}

Ditto.

we can reduce the code lines..

> +
> +static int dw_mci_edmac_start_dma(struct dw_mci *host,
> +					    unsigned int sg_len)
> +{
> +	struct dma_slave_config cfg;
> +	struct dma_async_tx_descriptor *desc = NULL;
> +	struct scatterlist *sgl = host->data->sg;
> +	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
> +	u32 sg_elems = host->data->sg_len;

doesn't check whether data is present or not?

> +	u32 fifoth_val;
> +	u32 fifo_offset = host->fifo_reg - host->regs;
> +	int ret = 0;
> +
> +	/* Set external dma config: burst size, burst width */
> +	cfg.dst_addr = (dma_addr_t)(host->phy_regs + fifo_offset);
> +	cfg.src_addr = cfg.dst_addr;
> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +
> +	/* Match burst msize with external dma config */
> +	fifoth_val = mci_readl(host, FIFOTH);
> +	cfg.dst_maxburst = mszs[(fifoth_val >> 28) & 0x7];
> +	cfg.src_maxburst = cfg.dst_maxburst;
> +
> +	if (host->data->flags & MMC_DATA_WRITE)
> +		cfg.direction = DMA_MEM_TO_DEV;
> +	else /* MMC_DATA_READ */
> +		cfg.direction = DMA_DEV_TO_MEM;
> +
> +	ret = dmaengine_slave_config(host->dms->ch, &cfg);
> +	if (ret) {
> +		dev_err(host->dev, "Failed to config edmac.\n");
> +		return -EBUSY;
> +	}
> +
> +	desc = dmaengine_prep_slave_sg(host->dms->ch, sgl,
> +				       sg_len, cfg.direction,
> +				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc) {
> +		dev_err(host->dev, "Can't prepare slave sg.\n");
> +		return -EBUSY;
> +	}
> +
> +	/* Set dw_mci_edmac_complete_dma as callback */
> +	desc->callback = dw_mci_edmac_complete_dma;
> +	desc->callback_param = (void *)host;
> +	dmaengine_submit(desc);
> +
> +	/* Flush cache before write */
> +	if (host->data->flags & MMC_DATA_WRITE)
> +		dma_sync_sg_for_device(mmc_dev(host->cur_slot->mmc), sgl,
> +				       sg_elems, DMA_TO_DEVICE);
> +
> +	dma_async_issue_pending(host->dms->ch);
> +
> +	return 0;
> +}
> +
> +static int dw_mci_edmac_init(struct dw_mci *host)
> +{
> +	/* Request external dma channel */
> +	host->dms = kzalloc(sizeof(struct dw_mci_dma_slave), GFP_KERNEL);
> +	if (!host->dms)
> +		return -ENOMEM;
> +
> +	host->dms->ch = dma_request_slave_channel(host->dev, "rx-tx");
> +	if (!host->dms->ch) {
> +		dev_err(host->dev,
> +			"Failed to get external DMA channel %d\n",
> +			host->dms->ch->chan_id);
> +		kfree(host->dms);
> +		host->dms = NULL;
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static void dw_mci_edmac_exit(struct dw_mci *host)
> +{
> +	if (host->dms) {
> +		if (host->dms->ch) {
> +			dma_release_channel(host->dms->ch);
> +			host->dms->ch = NULL;
> +		}
> +		kfree(host->dms);
> +		host->dms = NULL;
> +	}
> +}
> +
> +static const struct dw_mci_dma_ops dw_mci_edmac_ops = {
> +	.init = dw_mci_edmac_init,
> +	.exit = dw_mci_edmac_exit,
> +	.start = dw_mci_edmac_start_dma,
> +	.stop = dw_mci_edmac_stop_dma,
> +	.complete = dw_mci_edmac_complete_dma,
> +	.cleanup = dw_mci_edmac_cleanup,
> +};
>  
>  static int dw_mci_pre_dma_transfer(struct dw_mci *host,
>  				   struct mmc_data *data,
> @@ -712,7 +848,6 @@ static void dw_mci_post_req(struct mmc_host *mmc,
>  
>  static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
>  {
> -#ifdef CONFIG_MMC_DW_IDMAC
>  	unsigned int blksz = data->blksz;
>  	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
>  	u32 fifo_width = 1 << host->data_shift;
> @@ -720,6 +855,9 @@ static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
>  	u32 msize = 0, rx_wmark = 1, tx_wmark, tx_wmark_invers;
>  	int idx = (sizeof(mszs) / sizeof(mszs[0])) - 1;
>  
> +	if (host->trans_mode == TRANS_MODE_PIO)
> +		return;
> +

"trans_mode" refer to Heiko's comment.

Best Regards,
Jaehoon Chung

>  	tx_wmark = (host->fifo_depth) / 2;
>  	tx_wmark_invers = host->fifo_depth - tx_wmark;
>  
> @@ -748,7 +886,6 @@ static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
>  done:
>  	fifoth_val = SDMMC_SET_FIFOTH(msize, rx_wmark, tx_wmark);
>  	mci_writel(host, FIFOTH, fifoth_val);
> -#endif
>  }
>  
>  static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
> @@ -835,7 +972,11 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
>  	mci_writel(host, INTMASK, temp);
>  	spin_unlock_irqrestore(&host->irq_lock, irqflags);
>  
> -	host->dma_ops->start(host, sg_len);
> +	if (host->dma_ops->start(host, sg_len)) {
> +		/* We can't do DMA */
> +		dev_err(host->dev, "%s: failed to start DMA.\n", __func__);
> +		return -ENODEV;
> +	}
>  
>  	return 0;
>  }
> @@ -2256,26 +2397,30 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  
>  	}
>  
> -#ifdef CONFIG_MMC_DW_IDMAC
> -	/* Handle DMA interrupts */
> -	if (host->dma_64bit_address == 1) {
> -		pending = mci_readl(host, IDSTS64);
> -		if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
> -			mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI |
> -							SDMMC_IDMAC_INT_RI);
> -			mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
> -			host->dma_ops->complete(host);
> -		}
> -	} else {
> -		pending = mci_readl(host, IDSTS);
> -		if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
> -			mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
> -							SDMMC_IDMAC_INT_RI);
> -			mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
> -			host->dma_ops->complete(host);
> +	if ((host->trans_mode == TRANS_MODE_IDMAC) && host->use_dma) {
> +		/* Handle DMA interrupts */
> +		if (host->dma_64bit_address == 1) {
> +			pending = mci_readl(host, IDSTS64);
> +			if (pending & (SDMMC_IDMAC_INT_TI |
> +				       SDMMC_IDMAC_INT_RI)) {
> +				mci_writel(host, IDSTS64,
> +					   SDMMC_IDMAC_INT_TI |
> +					   SDMMC_IDMAC_INT_RI);
> +				mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
> +				host->dma_ops->complete((void *)host);
> +			}
> +		} else {
> +			pending = mci_readl(host, IDSTS);
> +			if (pending & (SDMMC_IDMAC_INT_TI |
> +				       SDMMC_IDMAC_INT_RI)) {
> +				mci_writel(host, IDSTS,
> +					   SDMMC_IDMAC_INT_TI |
> +					   SDMMC_IDMAC_INT_RI);
> +				mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
> +				host->dma_ops->complete((void *)host);
> +			}
>  		}
>  	}
> -#endif
>  
>  	return IRQ_HANDLED;
>  }
> @@ -2391,19 +2536,29 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  		mmc->max_seg_size = host->pdata->blk_settings->max_seg_size;
>  	} else {
>  		/* Useful defaults if platform data is unset. */
> -#ifdef CONFIG_MMC_DW_IDMAC
> -		mmc->max_segs = host->ring_size;
> -		mmc->max_blk_size = 65536;
> -		mmc->max_seg_size = 0x1000;
> -		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
> -		mmc->max_blk_count = mmc->max_req_size / 512;
> -#else
> -		mmc->max_segs = 64;
> -		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
> -		mmc->max_blk_count = 512;
> -		mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> -		mmc->max_seg_size = mmc->max_req_size;
> -#endif /* CONFIG_MMC_DW_IDMAC */
> +		if (host->trans_mode == TRANS_MODE_IDMAC && host->use_dma) {
> +			mmc->max_segs = host->ring_size;
> +			mmc->max_blk_size = 65536;
> +			mmc->max_seg_size = 0x1000;
> +			mmc->max_req_size = mmc->max_seg_size * host->ring_size;
> +			mmc->max_blk_count = mmc->max_req_size / 512;
> +		} else if (host->trans_mode == TRANS_MODE_EDMAC &&
> +			   host->use_dma) {
> +			mmc->max_segs = 64;
> +			mmc->max_blk_size = 65536;
> +			mmc->max_blk_count = 65535;
> +			mmc->max_req_size =
> +					mmc->max_blk_size * mmc->max_blk_count;
> +			mmc->max_seg_size = mmc->max_req_size;
> +		} else {
> +			/* TRANS_MODE_PIO */
> +			mmc->max_segs = 64;
> +			mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
> +			mmc->max_blk_count = 512;
> +			mmc->max_req_size =
> +					mmc->max_blk_size * mmc->max_blk_count;
> +			mmc->max_seg_size = mmc->max_req_size;
> +		}
>  	}
>  
>  	if (dw_mci_get_cd(mmc))
> @@ -2437,6 +2592,11 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
>  static void dw_mci_init_dma(struct dw_mci *host)
>  {
>  	int addr_config;
> +
> +	/* Check tansfer mode */
> +	if (host->trans_mode == TRANS_MODE_PIO)
> +		goto no_dma;
> +
>  	/* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
>  	addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
>  
> @@ -2462,10 +2622,14 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  	}
>  
>  	/* Determine which DMA interface to use */
> -#ifdef CONFIG_MMC_DW_IDMAC
> -	host->dma_ops = &dw_mci_idmac_ops;
> -	dev_info(host->dev, "Using internal DMA controller.\n");
> -#endif
> +	if (host->trans_mode == TRANS_MODE_IDMAC) {
> +		host->dma_ops = &dw_mci_idmac_ops;
> +		dev_info(host->dev, "Using internal DMA controller.\n");
> +	} else {
> +		/* TRANS_MODE_EDMAC */
> +		host->dma_ops = &dw_mci_edmac_ops;
> +		dev_info(host->dev, "Using external DMA controller.\n");
> +	}
>  
>  	if (!host->dma_ops)
>  		goto no_dma;
> @@ -2570,10 +2734,9 @@ static bool dw_mci_reset(struct dw_mci *host)
>  		}
>  	}
>  
> -#if IS_ENABLED(CONFIG_MMC_DW_IDMAC)
> -	/* It is also recommended that we reset and reprogram idmac */
> -	dw_mci_idmac_reset(host);
> -#endif
> +	if (host->trans_mode == TRANS_MODE_IDMAC)
> +		/* It is also recommended that we reset and reprogram idmac */
> +		dw_mci_idmac_reset(host);
>  
>  	ret = true;
>  
> @@ -2653,6 +2816,21 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  	if (of_find_property(np, "supports-highspeed", NULL))
>  		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>  
> +	if (of_find_property(np, "supports-idmac", NULL)) {
> +		host->trans_mode = TRANS_MODE_IDMAC;
> +		if (of_find_property(np, "supports-edmac", NULL)) {
> +			dev_err(dev, "can't configure idmac & edmac simultaneously\n");
> +			/* Force pio mode */
> +			host->trans_mode = TRANS_MODE_PIO;
> +		}
> +
> +	} else if (of_find_property(np, "supports-edmac", NULL)) {
> +		host->trans_mode = TRANS_MODE_EDMAC;
> +	} else {
> +		/* Default use pio */
> +		host->trans_mode = TRANS_MODE_PIO;
> +	}
> +
>  	return pdata;
>  }
>  
> @@ -2958,6 +3136,9 @@ EXPORT_SYMBOL(dw_mci_remove);
>   */
>  int dw_mci_suspend(struct dw_mci *host)
>  {
> +	if (host->use_dma && host->dma_ops->exit)
> +		host->dma_ops->exit(host);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(dw_mci_suspend);
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 5be9767..6c1c7ea 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -16,6 +16,7 @@
>  
>  #include <linux/scatterlist.h>
>  #include <linux/mmc/core.h>
> +#include <linux/dmaengine.h>
>  
>  #define MAX_MCI_SLOTS	2
>  
> @@ -40,6 +41,17 @@ enum {
>  
>  struct mmc_data;
>  
> +enum {
> +	TRANS_MODE_PIO = 0,
> +	TRANS_MODE_IDMAC,
> +	TRANS_MODE_EDMAC
> +};
> +
> +struct dw_mci_dma_slave {
> +	struct dma_chan *ch;
> +	enum dma_transfer_direction direction;
> +};
> +
>  /**
>   * struct dw_mci - MMC controller state shared between all slots
>   * @lock: Spinlock protecting the queue and associated data.
> @@ -147,17 +159,23 @@ struct dw_mci {
>  
>  	/* DMA interface members*/
>  	int			use_dma;
> +	int			trans_mode;
>  	int			using_dma;
>  	int			dma_64bit_address;
>  
>  	dma_addr_t		sg_dma;
>  	void			*sg_cpu;
>  	const struct dw_mci_dma_ops	*dma_ops;
> -#ifdef CONFIG_MMC_DW_IDMAC
> +	/* For idmac */
>  	unsigned int		ring_size;
> -#else
> +
> +	/* For edmac */
> +	struct dw_mci_dma_slave *dms;
> +	/* Registers's physical base address */
> +	void                    *phy_regs;
> +
>  	struct dw_mci_dma_data	*dma_data;
> -#endif
> +
>  	u32			cmd_status;
>  	u32			data_status;
>  	u32			stop_cmdr;
> @@ -210,8 +228,8 @@ struct dw_mci {
>  struct dw_mci_dma_ops {
>  	/* DMA Ops */
>  	int (*init)(struct dw_mci *host);
> -	void (*start)(struct dw_mci *host, unsigned int sg_len);
> -	void (*complete)(struct dw_mci *host);
> +	int (*start)(struct dw_mci *host, unsigned int sg_len);
> +	void (*complete)(void *host);
>  	void (*stop)(struct dw_mci *host);
>  	void (*cleanup)(struct dw_mci *host);
>  	void (*exit)(struct dw_mci *host);
> 
