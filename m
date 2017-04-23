Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Apr 2017 17:48:30 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:53722 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993459AbdDWPsXpSoGW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Apr 2017 17:48:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eKtxE1bdV2xT7ALYNiXdelE/NBAyraJcArCktmojH9Q=; b=qAyCf0I7+IR/QVbez6+GId8mHZ
        IAmsehkK3t0/xxwLJjdzUs19yqYxvGaQpKiIKbyRufxn2KNu3Gwd3sTdctangV3viIVXREA6AsGGF
        gIzDZI1lHCfRAEgIN4AVEPcCvKVyUKyFrlrso4o17Por8HvjnYyIp0AhQmxE0zkb9Ub1y2RUjEjBw
        pE3JYotd+wHqDBoAWpyFQhoP2ocBY+0ImwAnzN1AaIEbCQf5YX+gxejhjPK/vaO/TMYBzT8V8YfSP
        MkMo/QcB4iIE8J1EbwsQirbK9Y8zpZbKgtBl58dTS2f9jftX+I6BahGp8avLu4ftFzt5UB3HdbXz+
        3xfMrDsQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58508 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.87)
        (envelope-from <linux@roeck-us.net>)
        id 1d2JkE-0003TT-EC; Sun, 23 Apr 2017 15:48:15 +0000
Date:   Sun, 23 Apr 2017 08:48:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
Subject: Re: [04/13] watchdog: lantiq: access boot cause register through
 regmap
Message-ID: <20170423154812.GA20428@roeck-us.net>
References: <20170417192942.32219-5-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-5-hauke@hauke-m.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Mon, Apr 17, 2017 at 09:29:33PM +0200, Hauke Mehrtens wrote:
> This patch avoids accessing the function ltq_reset_cause() and directly
> accesses the register given over the syscon interface. The syscon
> interface will be implemented for the xway SoCs for the falcon SoCs the
> ltq_reset_cause() function never worked, because a wrong offset was used.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Guenter Roeck <linux@reck-us.net>

> ---
>  drivers/watchdog/lantiq_wdt.c | 47 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index e0823677d8c1..0e349ad03fdf 100644
> --- a/drivers/watchdog/lantiq_wdt.c
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -17,9 +17,14 @@
>  #include <linux/uaccess.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
>  
>  #include <lantiq_soc.h>
>  
> +#define LTQ_RST_CAUSE_WDT_XRX		BIT(31)
> +#define LTQ_RST_CAUSE_WDT_FALCON	0x02
> +
>  /*
>   * Section 3.4 of the datasheet
>   * The password sequence protects the WDT control register from unintended
> @@ -186,6 +191,40 @@ static struct miscdevice ltq_wdt_miscdev = {
>  	.fops	= &ltq_wdt_fops,
>  };
>  
> +static void ltq_set_wdt_bootstatus(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct regmap *rcu_regmap;
> +	u32 status_reg_offset;
> +	u32 val;
> +	int err;
> +
> +	rcu_regmap = syscon_regmap_lookup_by_phandle(np,
> +						     "lantiq,rcu-syscon");
> +	if (IS_ERR_OR_NULL(rcu_regmap))
> +		return;
> +
> +	err = of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
> +					 &status_reg_offset);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
> +		return;
> +	}
> +
> +	err = regmap_read(rcu_regmap, status_reg_offset, &val);
> +	if (err)
> +		return;
> +
> +	/* find out if the watchdog caused the last reboot */
> +	if (of_device_is_compatible(np, "lantiq,wdt-xrx100")) {
> +		if (val & LTQ_RST_CAUSE_WDT_XRX)
> +			ltq_wdt_bootstatus = WDIOF_CARDRESET;
> +	} else if  (of_device_is_compatible(np, "lantiq,wdt-falcon")) {
> +		if ((val & 0x7) == LTQ_RST_CAUSE_WDT_FALCON)
> +			ltq_wdt_bootstatus = WDIOF_CARDRESET;
> +	}
> +}
> +
>  static int
>  ltq_wdt_probe(struct platform_device *pdev)
>  {
> @@ -205,9 +244,7 @@ ltq_wdt_probe(struct platform_device *pdev)
>  	ltq_io_region_clk_rate = clk_get_rate(clk);
>  	clk_put(clk);
>  
> -	/* find out if the watchdog caused the last reboot */
> -	if (ltq_reset_cause() == LTQ_RST_CAUSE_WDTRST)
> -		ltq_wdt_bootstatus = WDIOF_CARDRESET;
> +	ltq_set_wdt_bootstatus(pdev);
>  
>  	dev_info(&pdev->dev, "Init done\n");
>  	return misc_register(&ltq_wdt_miscdev);
> @@ -222,7 +259,9 @@ ltq_wdt_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id ltq_wdt_match[] = {
> -	{ .compatible = "lantiq,wdt" },
> +	{ .compatible = "lantiq,wdt"},
> +	{ .compatible = "lantiq,wdt-xrx100"},
> +	{ .compatible = "lantiq,wdt-falcon"},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ltq_wdt_match);
