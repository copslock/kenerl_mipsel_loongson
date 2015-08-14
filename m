Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Aug 2015 00:14:15 +0200 (CEST)
Received: from gloria.sntech.de ([95.129.55.99]:56525 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011795AbbHNWONJg9wS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Aug 2015 00:14:13 +0200
Received: from ip5f5b6ac8.dynamic.kabel-deutschland.de ([95.91.106.200] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1ZQNEU-0004Zo-Af; Sat, 15 Aug 2015 00:13:50 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     jh80.chung@samsung.com, ulf.hansson@linaro.org,
        Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, dianders@chromium.org,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/9] mmc: dw_mmc: Add external dma interface support
Date:   Sat, 15 Aug 2015 00:13:49 +0200
Message-ID: <1522710.BT6Gc0L6oH@diego>
User-Agent: KMail/4.14.1 (Linux/3.16.0-4-amd64; KDE/4.14.2; x86_64; ; )
In-Reply-To: <1439541275-30146-1-git-send-email-shawn.lin@rock-chips.com>
References: <1439541232-30100-1-git-send-email-shawn.lin@rock-chips.com> <1439541275-30146-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <heiko@sntech.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko@sntech.de
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

Hi Shawn,

Am Freitag, 14. August 2015, 16:34:35 schrieb Shawn Lin:
> DesignWare MMC Controller can supports two types of DMA
> mode: external dma and internal dma. We get a RK312x platform
> integrated dw_mmc and ARM pl330 dma controller. This patch add
> edmac ops to support these platforms. I've tested it on RK312x
> platform with edmac mode and RK3288 platform with idmac mode.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

judging by your "from", I guess you're running this on some older Rockchip soc 
without the idma? Because I tried testing this on a Radxa Rock, but only got 
failures, from the start (failed to read card status register). In PIO mode 
everything works again.


I guess I overlooked just some tiny detail, but to me the dma channel ids seem 
correct after all. Maybe you have any hints what I'm doing wrong?

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 4497d28..92d7156 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -217,6 +217,8 @@
                interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
                clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
                clock-names = "biu", "ciu";
+             dmas = <&dmac2 1>;
+             dma-names = "rx-tx";
                fifo-depth = <256>;
                status = "disabled";
        };
@@ -227,6 +229,8 @@
                interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
                clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
                clock-names = "biu", "ciu";
+             dmas = <&dmac2 3>;
+             dma-names = "rx-tx";
                fifo-depth = <256>;
                status = "disabled";
        };
@@ -237,6 +241,8 @@
                interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
                clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
                clock-names = "biu", "ciu";
+             dmas = <&dmac2 4>;
+             dma-names = "rx-tx";
                fifo-depth = <256>;
                status = "disabled";
        };


[...]

> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index fcbf552..e01ead3 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2517,8 +2642,23 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot
> *slot, unsigned int id) static void dw_mci_init_dma(struct dw_mci *host)
>  {
>  	int addr_config;
> +	int trans_mode;
> +	struct device *dev = host->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	/* Check tansfer mode */
> +	trans_mode = SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
> +	if (trans_mode == 0) {
> +		trans_mode = TRANS_MODE_IDMAC;
> +	} else if (trans_mode == 1 || trans_mode == 2) {
> +		trans_mode = TRANS_MODE_EDMAC;
> +	} else {
> +		trans_mode = TRANS_MODE_PIO;
> +		goto no_dma;
> +	}
> +
>  	/* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
> -	addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
> +	addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
> 
>  	if (addr_config == 1) {
>  		/* host supports IDMAC in 64-bit address mode */

I guess the idmac address size checking block

        /* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
        addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));

        if (addr_config == 1) {
                /* host supports IDMAC in 64-bit address mode */
                host->dma_64bit_address = 1;
                dev_info(host->dev, "IDMAC supports 64-bit address mode.\n");
                if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
                        dma_set_coherent_mask(host->dev, DMA_BIT_MASK(64));
        } else {
                /* host supports IDMAC in 32-bit address mode */
                host->dma_64bit_address = 0;
                dev_info(host->dev, "IDMAC supports 32-bit address mode.\n");
        }

could either live inside the trans_mode == 0 conditional above or get its own
if (trans_mode == 0) conditional. Either way I guess it should not talk about 
idmac when either pio or extdmac are used.


Thanks
Heiko
