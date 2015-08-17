Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Aug 2015 03:11:25 +0200 (CEST)
Received: from regular1.263xmail.com ([211.150.99.135]:59021 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011348AbbHQBLWU1ukL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Aug 2015 03:11:22 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.156])
        by regular1.263xmail.com (Postfix) with SMTP id 07D3A1AEEE;
        Mon, 17 Aug 2015 09:11:17 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from [172.16.12.109] (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 8F3F910DA8;
        Mon, 17 Aug 2015 09:11:07 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <4da1c4643422331f0fa9f279e10d6705>
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.109] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 1871241K3LE;
        Mon, 17 Aug 2015 09:11:13 +0800 (CST)
Subject: Re: [RFC PATCH v5 1/9] mmc: dw_mmc: Add external dma interface
 support
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <1439541232-30100-1-git-send-email-shawn.lin@rock-chips.com>
 <1439541275-30146-1-git-send-email-shawn.lin@rock-chips.com>
 <1522710.BT6Gc0L6oH@diego>
Cc:     shawn.lin@rock-chips.com, jh80.chung@samsung.com,
        ulf.hansson@linaro.org, Vineet.Gupta1@synopsys.com,
        Wei Xu <xuwei5@hisilicon.com>,
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
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <55D134AB.80403@rock-chips.com>
Date:   Mon, 17 Aug 2015 09:11:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1522710.BT6Gc0L6oH@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shawn.lin@rock-chips.com
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

在 2015/8/15 6:13, Heiko Stübner 写道:
> Hi Shawn,
>
> Am Freitag, 14. August 2015, 16:34:35 schrieb Shawn Lin:
>> DesignWare MMC Controller can supports two types of DMA
>> mode: external dma and internal dma. We get a RK312x platform
>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>> edmac ops to support these platforms. I've tested it on RK312x
>> platform with edmac mode and RK3288 platform with idmac mode.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> judging by your "from", I guess you're running this on some older Rockchip soc
> without the idma? Because I tried testing this on a Radxa Rock, but only got
> failures, from the start (failed to read card status register). In PIO mode
> everything works again.
>
>
> I guess I overlooked just some tiny detail, but to me the dma channel ids seem
> correct after all. Maybe you have any hints what I'm doing wrong?
>

Thanks, HeiKo.

yes, I'm running a quite older low-end Rockchip soc w/o idma.

Hmm... from your failure to read CSR, I think generic DMA of Radxa Rock 
was not runing properly. Your dma channel ids is correct, but it 
certainly work on my platform。 I will try to find a Radxa Rock to 
re-test my patch ASAP.



> diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
> index 4497d28..92d7156 100644
> --- a/arch/arm/boot/dts/rk3xxx.dtsi
> +++ b/arch/arm/boot/dts/rk3xxx.dtsi
> @@ -217,6 +217,8 @@
>                  interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>                  clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
>                  clock-names = "biu", "ciu";
> +             dmas = <&dmac2 1>;
> +             dma-names = "rx-tx";
>                  fifo-depth = <256>;
>                  status = "disabled";
>          };
> @@ -227,6 +229,8 @@
>                  interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>                  clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
>                  clock-names = "biu", "ciu";
> +             dmas = <&dmac2 3>;
> +             dma-names = "rx-tx";
>                  fifo-depth = <256>;
>                  status = "disabled";
>          };
> @@ -237,6 +241,8 @@
>                  interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>                  clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
>                  clock-names = "biu", "ciu";
> +             dmas = <&dmac2 4>;
> +             dma-names = "rx-tx";
>                  fifo-depth = <256>;
>                  status = "disabled";
>          };
>
>
> [...]
>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index fcbf552..e01ead3 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2517,8 +2642,23 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot
>> *slot, unsigned int id) static void dw_mci_init_dma(struct dw_mci *host)
>>   {
>>   	int addr_config;
>> +	int trans_mode;
>> +	struct device *dev = host->dev;
>> +	struct device_node *np = dev->of_node;
>> +
>> +	/* Check tansfer mode */
>> +	trans_mode = SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
>> +	if (trans_mode == 0) {
>> +		trans_mode = TRANS_MODE_IDMAC;
>> +	} else if (trans_mode == 1 || trans_mode == 2) {
>> +		trans_mode = TRANS_MODE_EDMAC;
>> +	} else {
>> +		trans_mode = TRANS_MODE_PIO;
>> +		goto no_dma;
>> +	}
>> +
>>   	/* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
>> -	addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
>> +	addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
>>
>>   	if (addr_config == 1) {
>>   		/* host supports IDMAC in 64-bit address mode */
>
> I guess the idmac address size checking block
>
>          /* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
>          addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
>
>          if (addr_config == 1) {
>                  /* host supports IDMAC in 64-bit address mode */
>                  host->dma_64bit_address = 1;
>                  dev_info(host->dev, "IDMAC supports 64-bit address mode.\n");
>                  if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
>                          dma_set_coherent_mask(host->dev, DMA_BIT_MASK(64));
>          } else {
>                  /* host supports IDMAC in 32-bit address mode */
>                  host->dma_64bit_address = 0;
>                  dev_info(host->dev, "IDMAC supports 32-bit address mode.\n");
>          }
>
> could either live inside the trans_mode == 0 conditional above or get its own
> if (trans_mode == 0) conditional. Either way I guess it should not talk about
> idmac when either pio or extdmac are used.
>
>
> Thanks
> Heiko
>
>
>


-- 
Shawn Lin
