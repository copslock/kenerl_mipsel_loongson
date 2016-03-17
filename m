Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 13:08:14 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:53138 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014208AbcCQMIKPjwxr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 13:08:10 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 7431217D9; Thu, 17 Mar 2016 13:08:04 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 421CC249;
        Thu, 17 Mar 2016 13:08:04 +0100 (CET)
Date:   Thu, 17 Mar 2016 13:08:04 +0100
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
Subject: Re: [PATCH 3/5] rtc: rtc-jz4740: Add support for devicetree
Message-ID: <20160317120804.GD3362@piout.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-3-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457217531-26064-3-git-send-email-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52638
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

On 05/03/2016 at 23:38:49 +0100, Paul Cercueil wrote :
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/rtc/rtc-jz4740.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> index 47617bd..3914b1c 100644
> --- a/drivers/rtc/rtc-jz4740.c
> +++ b/drivers/rtc/rtc-jz4740.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/rtc.h>
>  #include <linux/slab.h>
> @@ -245,6 +246,13 @@ void jz4740_rtc_poweroff(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
>  
> +static const struct of_device_id jz4740_rtc_of_match[] = {
> +	{ .compatible = "ingenic,jz4740-rtc", .data = (void *) ID_JZ4740 },
> +	{ .compatible = "ingenic,jz4780-rtc", .data = (void *) ID_JZ4780 },

ingenic is not in Documentation/devicetree/bindings/vendor-prefixes.txt,
you have to add it there before using it.

Also, no space is necessary after the "(void *)" cast.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, jz4740_rtc_of_match);
> +
>  static int jz4740_rtc_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -252,12 +260,17 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
>  	uint32_t scratchpad;
>  	struct resource *mem;
>  	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	const struct of_device_id *of_id = of_match_device(
> +			jz4740_rtc_of_match, &pdev->dev);
>  
>  	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
>  	if (!rtc)
>  		return -ENOMEM;
>  
> -	rtc->type = id->driver_data;
> +	if (of_id)
> +		rtc->type = (enum jz4740_rtc_type) of_id->data;

No space after that cast either.

> +	else
> +		rtc->type = id->driver_data;
>  
>  	rtc->irq = platform_get_irq(pdev, 0);
>  	if (rtc->irq < 0) {
> @@ -345,6 +358,7 @@ static struct platform_driver jz4740_rtc_driver = {
>  	.driver	 = {
>  		.name  = "jz4740-rtc",
>  		.pm    = JZ4740_RTC_PM_OPS,
> +		.of_match_table = of_match_ptr(jz4740_rtc_of_match),
>  	},
>  	.id_table = jz4740_rtc_ids,
>  };
> -- 
> 2.7.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
