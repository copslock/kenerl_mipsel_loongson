Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 13:04:28 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:52973 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014172AbcCQME0tTISr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 13:04:26 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id BDA5F17D7; Thu, 17 Mar 2016 13:04:19 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 8D32D249;
        Thu, 17 Mar 2016 13:04:19 +0100 (CET)
Date:   Thu, 17 Mar 2016 13:04:19 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/5] rtc: rtc-jz4740: Add support for the RTC in the
 jz4780 SoC
Message-ID: <20160317120419.GB3362@piout.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Please, always include a commit message, even if it is short.

On 05/03/2016 at 23:38:47 +0100, Paul Cercueil wrote :
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/rtc/Kconfig      |  6 +++---
>  drivers/rtc/rtc-jz4740.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index e593c55..b322f08 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1494,10 +1494,10 @@ config RTC_DRV_MPC5121
>  
>  config RTC_DRV_JZ4740
>  	tristate "Ingenic JZ4740 SoC"
> -	depends on MACH_JZ4740 || COMPILE_TEST
> +	depends on MACH_INGENIC || COMPILE_TEST
>  	help
> -	  If you say yes here you get support for the Ingenic JZ4740 SoC RTC
> -	  controller.
> +	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
> +	  controllers.
>  
>  	  This driver can also be buillt as a module. If so, the module
>  	  will be called rtc-jz4740.
> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> index b2bcfc0..47617bd 100644
> --- a/drivers/rtc/rtc-jz4740.c
> +++ b/drivers/rtc/rtc-jz4740.c
> @@ -29,6 +29,10 @@
>  #define JZ_REG_RTC_HIBERNATE	0x20
>  #define JZ_REG_RTC_SCRATCHPAD	0x34
>  
> +/* The following are present on the jz4780 */
> +#define JZ_REG_RTC_WENR	0x3C
> +#define JZ_RTC_WENR_WEN	BIT(31)
> +
>  #define JZ_RTC_CTRL_WRDY	BIT(7)
>  #define JZ_RTC_CTRL_1HZ		BIT(6)
>  #define JZ_RTC_CTRL_1HZ_IRQ	BIT(5)
> @@ -37,8 +41,17 @@
>  #define JZ_RTC_CTRL_AE		BIT(2)
>  #define JZ_RTC_CTRL_ENABLE	BIT(0)
>  
> +/* Magic value to enable writes on jz4780 */
> +#define JZ_RTC_WENR_MAGIC	0xA55A
> +
> +enum jz4740_rtc_type {
> +	ID_JZ4740,
> +	ID_JZ4780,
> +};
> +
>  struct jz4740_rtc {
>  	void __iomem *base;
> +	enum jz4740_rtc_type type;
>  
>  	struct rtc_device *rtc;
>  
> @@ -64,11 +77,33 @@ static int jz4740_rtc_wait_write_ready(struct jz4740_rtc *rtc)
>  	return timeout ? 0 : -EIO;
>  }
>  
> +static inline int jz4780_rtc_enable_write(struct jz4740_rtc *rtc)
> +{
> +	uint32_t ctrl;
> +	int ret, timeout = 1000;
> +
> +	ret = jz4740_rtc_wait_write_ready(rtc);
> +	if (ret != 0)
> +		return ret;
> +
> +	writel(JZ_RTC_WENR_MAGIC, rtc->base + JZ_REG_RTC_WENR);
> +
> +	do {
> +		ctrl = readl(rtc->base + JZ_REG_RTC_WENR);
> +	} while (!(ctrl & JZ_RTC_WENR_WEN) && --timeout);
> +
> +	return timeout ? 0 : -EIO;
> +}
> +
>  static inline int jz4740_rtc_reg_write(struct jz4740_rtc *rtc, size_t reg,
>  	uint32_t val)
>  {
> -	int ret;
> -	ret = jz4740_rtc_wait_write_ready(rtc);
> +	int ret = 0;
> +
> +	if (rtc->type >= ID_JZ4780)
> +		ret = jz4780_rtc_enable_write(rtc);
> +	if (ret == 0)
> +		ret = jz4740_rtc_wait_write_ready(rtc);
>  	if (ret == 0)
>  		writel(val, rtc->base + reg);
>  
> @@ -216,11 +251,14 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
>  	struct jz4740_rtc *rtc;
>  	uint32_t scratchpad;
>  	struct resource *mem;
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
>  
>  	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
>  	if (!rtc)
>  		return -ENOMEM;
>  
> +	rtc->type = id->driver_data;
> +
>  	rtc->irq = platform_get_irq(pdev, 0);
>  	if (rtc->irq < 0) {
>  		dev_err(&pdev->dev, "Failed to get platform irq\n");
> @@ -295,12 +333,20 @@ static const struct dev_pm_ops jz4740_pm_ops = {
>  #define JZ4740_RTC_PM_OPS NULL
>  #endif  /* CONFIG_PM */
>  
> +static const struct platform_device_id jz4740_rtc_ids[] = {
> +	{"jz4740-rtc", ID_JZ4740},
> +	{"jz4780-rtc", ID_JZ4780},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, jz4740_rtc_ids);
> +
>  static struct platform_driver jz4740_rtc_driver = {
>  	.probe	 = jz4740_rtc_probe,
>  	.driver	 = {
>  		.name  = "jz4740-rtc",
>  		.pm    = JZ4740_RTC_PM_OPS,
>  	},
> +	.id_table = jz4740_rtc_ids,
>  };
>  
>  module_platform_driver(jz4740_rtc_driver);
> -- 
> 2.7.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
