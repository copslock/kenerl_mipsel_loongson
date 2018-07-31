Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 16:13:47 +0200 (CEST)
Received: from mga07.intel.com ([134.134.136.100]:64833 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993097AbeGaONn2wtVP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2018 16:13:43 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 07:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,427,1526367600"; 
   d="scan'208";a="220585211"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 31 Jul 2018 07:13:37 -0700
Message-ID: <a59ec51ced70b86492cbb2d6d456ee6d7b211b4a.camel@linux.intel.com>
Subject: Re: [PATCH v2 4/6] i2c: designware: add MSCC Ocelot support
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 Jul 2018 17:13:37 +0300
In-Reply-To: <20180731134740.441-5-alexandre.belloni@bootlin.com>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
         <20180731134740.441-5-alexandre.belloni@bootlin.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <andriy.shevchenko@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andriy.shevchenko@linux.intel.com
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

On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
> The Microsemi Ocelot I2C controller is a designware IP. It also has a
> second set of registers to allow tweaking SDA hold time and spike
> filtering.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(except the bindings, not my area)

> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Changes in v2:
>  - improved binding doc
>  - changed the model handling as suggested by Andy
> 
>  .../bindings/i2c/i2c-designware.txt           |  9 ++++-
>  drivers/i2c/busses/i2c-designware-core.h      |  3 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c   | 40
> +++++++++++++++++++
>  3 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fbb0a6d8b964..0fb17387c735 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -2,7 +2,8 @@
>  
>  Required properties :
>  
> - - compatible : should be "snps,designware-i2c"
> + - compatible : should be "snps,designware-i2c" or "mscc,ocelot-i2c"
> followed by
> +   "snps,designware-i2c" for fallback
>   - reg : Offset and length of the register set for the device
>   - interrupts : <IRQ> where IRQ is the interrupt number.
>  
> @@ -11,8 +12,12 @@ Recommended properties :
>   - clock-frequency : desired I2C bus clock frequency in Hz.
>  
>  Optional properties :
> + - reg : for "mscc,ocelot-i2c", a second register set to configure
> the SDA hold
> +   time, named ICPU_CFG:TWI_DELAY in the datasheet.
> +
>   - i2c-sda-hold-time-ns : should contain the SDA hold time in
> nanoseconds.
> -   This option is only supported in hardware blocks version 1.11a or
> newer.
> +   This option is only supported in hardware blocks version 1.11a or
> newer and

> +   on Microsemi SoCs ("mscc,ocelot-i2c" compatible).wtf

wtf?

>  
>   - i2c-scl-falling-time-ns : should contain the SCL falling time in
> nanoseconds.
>     This value which is by default 300ns is used to compute the tLOW
> period.
> diff --git a/drivers/i2c/busses/i2c-designware-core.h
> b/drivers/i2c/busses/i2c-designware-core.h
> index 870444bbbcc4..5e240ce9968e 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -225,6 +225,7 @@
>  struct dw_i2c_dev {
>  	struct device		*dev;
>  	void __iomem		*base;
> +	void __iomem		*ext;
>  	struct completion	cmd_complete;
>  	struct clk		*clk;
>  	struct reset_control	*rst;
> @@ -279,6 +280,8 @@ struct dw_i2c_dev {
>  #define ACCESS_INTR_MASK	0x00000004
>  
>  #define MODEL_CHERRYTRAIL	0x00000100
> +#define MODEL_MSCC_OCELOT	0x00000200
> +#define MODEL_MASK		0x00000f00
>  
>  u32 dw_readl(struct dw_i2c_dev *dev, int offset);
>  void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index ba142d7c0e05..68619b270b4c 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -158,11 +158,48 @@ static inline int dw_i2c_acpi_configure(struct
> platform_device *pdev)
>  #endif
>  
>  #ifdef CONFIG_OF
> +#define MSCC_ICPU_CFG_TWI_DELAY		0x0
> +#define MSCC_ICPU_CFG_TWI_DELAY_ENABLE	BIT(0)
> +#define MSCC_ICPU_CFG_TWI_SPIKE_FILTER	0x4
> +
> +static int mscc_twi_set_sda_hold_time(struct dw_i2c_dev *dev)
> +{
> +	writel((dev->sda_hold_time << 1) |
> MSCC_ICPU_CFG_TWI_DELAY_ENABLE,
> +	       dev->ext + MSCC_ICPU_CFG_TWI_DELAY);
> +
> +	return 0;
> +}
> +
> +int dw_i2c_of_configure(struct platform_device *pdev)
> +{
> +	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
> +	struct resource *mem;
> +
> +	switch (dev->flags & MODEL_MASK) {
> +	case MODEL_MSCC_OCELOT:
> +		mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		dev->ext = devm_ioremap_resource(&pdev->dev, mem);
> +		if (!IS_ERR(dev->ext))
> +			dev->set_sda_hold_time =
> mscc_twi_set_sda_hold_time;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id dw_i2c_of_match[] = {
>  	{ .compatible = "snps,designware-i2c", },
> +	{ .compatible = "mscc,ocelot-i2c", .data = (void
> *)MODEL_MSCC_OCELOT },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
> +#else
> +static inline int dw_i2c_of_configure(struct platform_device *pdev)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  static void i2c_dw_configure_master(struct dw_i2c_dev *dev)
> @@ -275,6 +312,9 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  
>  	dev->flags |= (u32)device_get_match_data(&pdev->dev);
>  
> +	if (pdev->dev.of_node)
> +		dw_i2c_of_configure(pdev);
> +
>  	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
>  	/*
>  	 * Some DSTDs use a non standard speed, round down to the
> lowest

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
