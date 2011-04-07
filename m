Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2011 16:33:27 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:56255 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491061Ab1DGOdX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2011 16:33:23 +0200
Received: by wyb28 with SMTP id 28so2773857wyb.36
        for <multiple recipients>; Thu, 07 Apr 2011 07:33:18 -0700 (PDT)
Received: by 10.216.79.6 with SMTP id h6mr485270wee.68.1302186798387;
        Thu, 07 Apr 2011 07:33:18 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id m73sm863829wej.40.2011.04.07.07.33.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 07:33:16 -0700 (PDT)
Message-ID: <4D9DCAC3.9090607@mvista.com>
Date:   Thu, 07 Apr 2011 18:31:31 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V5 05/10] MIPS: lantiq: add watchdog support
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org> <1301470076-17279-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1301470076-17279-6-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

John Crispin wrote:

> This patch adds the driver for the watchdog found inside the Lantiq SoC family.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-mips@linux-mips.org
> Cc: linux-watchdog@vger.kernel.org

> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> new file mode 100644
> index 0000000..0a78dfb
> --- /dev/null
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -0,0 +1,217 @@
[...]
> +/* Section 3.4 of the datasheet
> + * The password sequence protects the WDT control register from unintended
> + * write actions, which might cause malfunction of the WDT.
> + *
> + * essentially the following two magic passwords need to be written to allow
> + * io access to the wdt core

    s/io/IO/, s/wdt/WDT. Be consistent. :-)

> +static void
> +ltq_wdt_enable(unsigned int timeout)

    This function is always called with 'ltw_wdt_timeout' as a parameter. Seems 
better to use it internally, and not pass it every time.

> +{
> +	timeout = ((timeout * (ltq_io_region_clk_rate / LTQ_WDT_DIVIDER))
> +		+ 0x1000);

    The parens around rvalue are not needed.

[...]
> +static ssize_t
> +ltq_wdt_write(struct file *file, const char __user *data,
> +		size_t len, loff_t *ppos)
> +{
> +	size_t i;
> +
> +	if (!len)
> +		return 0;
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT

    Er, Documentation/CodingStyle asks not to use #ifdef inside the code. You 
could create a special function here...

> +	for (i = 0; i != len; i++) {
> +		char c;
> +
> +		if (get_user(c, data + i))
> +			return -EFAULT;
> +		if (c == 'V')
> +			ltq_wdt_ok_to_close = 1;
> +	}
> +#endif
> +	ltq_wdt_enable(ltq_wdt_timeout);
> +	return len;
> +}

[...]

> +static int __init
> +ltq_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct clk *clk;
> +
> +	if (!res) {
> +		dev_err(&pdev->dev, "cannot obtain I/O memory region");
> +		return -ENOENT;
> +	}
> +	res = devm_request_mem_region(&pdev->dev, res->start,
> +		resource_size(res), dev_name(&pdev->dev));
> +	if (!res) {
> +		dev_err(&pdev->dev, "cannot request I/O memory region");
> +		return -EBUSY;
> +	}
> +	ltq_wdt_membase = devm_ioremap_nocache(&pdev->dev, res->start,
> +		resource_size(res));
> +	if (!ltq_wdt_membase) {
> +		dev_err(&pdev->dev, "cannot remap I/O memory region\n");
> +		return -ENOMEM;
> +	}
> +	/* we do not need to enable the clock as it is always running */
> +	clk = clk_get(&pdev->dev, "io");
> +	BUG_ON(!clk);

    WARN_ON(). We shouldn't kill the whole machine I think.

> +static int __init
> +init_ltq_wdt(void)
> +{
> +	return platform_driver_probe(&ltq_wdt_driver, ltq_wdt_probe);
> +}
> +
> +module_init(init_ltq_wdt);

    How about module_exit()?

WBR, Sergei
