Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 17:16:22 +0200 (CEST)
Received: from mga17.intel.com ([192.55.52.151]:9339 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990401AbeGQPQSyukK7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 17:16:18 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 08:16:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="57563054"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2018 08:16:11 -0700
Message-ID: <1886510d2a828d3a246ef1f490c6819f073fbdcb.camel@linux.intel.com>
Subject: Re: [PATCH 3/5] i2c: designware: add MSCC Ocelot support
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
Date:   Tue, 17 Jul 2018 18:16:10 +0300
In-Reply-To: <20180717114837.21839-4-alexandre.belloni@bootlin.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
         <20180717114837.21839-4-alexandre.belloni@bootlin.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <andriy.shevchenko@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64894
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

On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> The Microsemi Ocelot I2C controller is a designware IP. It also has a
> second set of registers to allow tweaking SDA hold time and spike
> filtering.

Thanks for information you provided. See my comments below.

>  struct dw_i2c_dev {
>  	struct device		*dev;
>  	void __iomem		*base;
> +	void __iomem		*base_ext;

Maybe simple "ext"? Up to you.
 
> +#define MSCC_ICPU_CFG_TWI_DELAY		0x0
> +#define MSCC_ICPU_CFG_TWI_DELAY_ENABLE	BIT(0)
> +#define MSCC_ICPU_CFG_TWI_SPIKE_FILTER	0x4
> +
> +static int mscc_twi_set_sda_hold_time(struct dw_i2c_dev *dev)
> +{
> +	writel((dev->sda_hold_time << 1) |
> MSCC_ICPU_CFG_TWI_DELAY_ENABLE,
> +	       dev->base_ext + MSCC_ICPU_CFG_TWI_DELAY);
> +
> +	return 0;
> +}

(1)

>  
> +	if (of_device_is_compatible(pdev->dev.of_node, "mscc,ocelot-
> i2c")) {
> +		mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		dev->base_ext = devm_ioremap_resource(&pdev->dev,
> mem);
> +		if (!IS_ERR(dev->base_ext))
> +			dev->set_sda_hold_time =
> mscc_twi_set_sda_hold_time;
> +	}

(2)

>  static const struct of_device_id dw_i2c_of_match[] = {
>  	{ .compatible = "snps,designware-i2c", },
> +	{ .compatible = "mscc,ocelot-i2c", },
>  	{},
>  };

(3)


I would rather place them in analogue how we do for ACPI, i.e.

--- 8< --- 8< ---

...
#define MODEL_MSCC_OCELOT  0x00000200
#define MODEL_MASK         0x00000f00
...

#ifdef CONFIG_OF
-->(1)
int dw_i2c_of_configure(pdev)
{
...
-->(2) (perhaps we don't care if it goes without condition, or move it
below in the corresponding case?
...

 switch(dev->flags & MODEL_MASK) {
  case MODEL_MSCC_OCELOT:
   ...
   break;
  default:
   break;
 }

 return 0;
}

-->(3)
...
{ .compatible = "mscc,ocelot-i2c", .data = (void *)MODEL_MSCC_OCELOT },
...

#else
static inline int dw_i2c_of_configure(pdev) { return -ENODEV; }
#endif

...

->probe():

...

/* REPLACE THIS in dw_i2c_acpi_configure() by below in ->probe():
 * id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev-
>dev);
 * if (id && id->driver_data)
 *   dev->flags |= (u32)id->driver_data;
 */

  dev->flags |= (u32)device_get_match_data(&pdev->dev);

  if (&pdev->dev.of_node)
    dw_i2c_of_configure(pdev);

...

--- 8< --- 8< ---

What do you think?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
