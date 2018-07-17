Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 14:19:17 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:19459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993030AbeGQMTPMderT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 14:19:15 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 05:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="216679187"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2018 05:19:09 -0700
Message-ID: <d64fc362be63bb8540447f7df2c232eedd696edb.camel@linux.intel.com>
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
Date:   Tue, 17 Jul 2018 15:19:08 +0300
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
X-archive-position: 64879
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

Can you elaborate a bit?

Are they platform specific? Are they shadow registers? Are they
something else? Datasheet link / excerpt would be also good to read.
 
>  Optional properties :
> + - reg : for "mscc,ocelot-i2c", a second register set to configure
> the SDA hold
> +   time, named ICPU_CFG:TWI_DELAY in the datasheet.
> +

Hmm... Is this registers unique to the SoC in question? Is address of
them fixed or may be configured on RTL level?

If former is right, why do we need a separate property?

>  
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

Hmm... And does how this make native DesignWare IP's registers obsolete?


> +	if (of_device_is_compatible(pdev->dev.of_node, "mscc,ocelot-
> i2c"))

Can't you just ask for this unconditionally? Why not?
(It seems I might have known why not, but can we use named resource
instead in case this is not so SoC specific)


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
