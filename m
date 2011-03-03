Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 12:45:58 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:56175 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491044Ab1CCLpz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2011 12:45:55 +0100
Received: by bwz1 with SMTP id 1so1107397bwz.36
        for <multiple recipients>; Thu, 03 Mar 2011 03:45:49 -0800 (PST)
Received: by 10.204.80.161 with SMTP id t33mr1339818bkk.121.1299152749491;
        Thu, 03 Mar 2011 03:45:49 -0800 (PST)
Received: from [192.168.2.2] ([91.79.88.81])
        by mx.google.com with ESMTPS id f20sm683888bkf.4.2011.03.03.03.45.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 03:45:48 -0800 (PST)
Message-ID: <4D6F7F1C.5040001@mvista.com>
Date:   Thu, 03 Mar 2011 14:44:28 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V3 05/10] MIPS: lantiq: add watchdog support
References: <1299146626-17428-1-git-send-email-blogic@openwrt.org> <1299146626-17428-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1299146626-17428-6-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 03-03-2011 13:03, John Crispin wrote:

> This patch adds the driver for the watchdog found inside the Lantiq SoC family.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Signed-off-by: Ralph Hempel<ralph.hempel@lantiq.com>
> Cc: Wim Van Sebroeck<wim@iguana.be>
> Cc: linux-mips@linux-mips.org
> Cc: linux-watchdog@vger.kernel.org
[...]

> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> new file mode 100644
> index 0000000..d49ddaa
> --- /dev/null
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -0,0 +1,235 @@
[...]
> +static void
> +ltq_wdt_disable(void)
> +{
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	ltq_wdt_ok_to_close = 0;
> +#endif
> +	/* write the first paswword magic */
                               ^
    You still didn't fix the typo here. :-)

> +	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> +	/* write the second paswword magic with no config
                                ^
    And here...

> +static int
> +ltq_wdt_probe(struct platform_device *pdev)

    Should be __init now that you're using platform_driver_probe()...

> +	/* we do not need to enable the clock as it is always running */
> +	clk = clk_get(&pdev->dev, "io");
> +	if (!clk)
> +		BUG();

    BUG_ON(!clk);

> +static struct platform_driver ltq_wdt_driver = {
> +	.probe = ltq_wdt_probe,

    No need to initialize it now that you're using platform_driver_probe()...

> +	.remove = ltq_wdt_remove,

    Shouldn't 'ltq_wdt_remove' be enclosed in __exit_p()?

WBR, Sergei
