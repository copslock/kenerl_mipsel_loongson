Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 16:04:46 +0200 (CEST)
Received: from mga04.intel.com ([192.55.52.120]:63355 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993072AbeGaOEi4i0zP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2018 16:04:38 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 07:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,427,1526367600"; 
   d="scan'208";a="220582286"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 31 Jul 2018 07:04:32 -0700
Message-ID: <e9c70e9265587b69c07629dfdfd2ea041c70acae.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/6] i2c: designware: move #ifdef CONFIG_OF to the top
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
        Allan Nielsen <allan.nielsen@microsemi.com>
Date:   Tue, 31 Jul 2018 17:04:31 +0300
In-Reply-To: <20180731134740.441-3-alexandre.belloni@bootlin.com>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
         <20180731134740.441-3-alexandre.belloni@bootlin.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <andriy.shevchenko@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65307
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
> Move the #ifdef CONFIG_OF section to the top of the file, after the
> ACPI
> section so functions defined there can be used in dw_i2c_plat_probe.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 00bf62f77c47..ba142d7c0e05 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -157,6 +157,14 @@ static inline int dw_i2c_acpi_configure(struct
> platform_device *pdev)
>  }
>  #endif
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id dw_i2c_of_match[] = {
> +	{ .compatible = "snps,designware-i2c", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
> +#endif
> +
>  static void i2c_dw_configure_master(struct dw_i2c_dev *dev)
>  {
>  	struct i2c_timings *t = &dev->timings;
> @@ -391,14 +399,6 @@ static int dw_i2c_plat_remove(struct
> platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
> -static const struct of_device_id dw_i2c_of_match[] = {
> -	{ .compatible = "snps,designware-i2c", },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
> -#endif
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int dw_i2c_plat_prepare(struct device *dev)
>  {

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
