Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Nov 2012 23:37:38 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:57386 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824769Ab2KXWheVTADS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Nov 2012 23:37:34 +0100
Received: by mail-lb0-f177.google.com with SMTP id n10so5565766lbo.36
        for <linux-mips@linux-mips.org>; Sat, 24 Nov 2012 14:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=UGz67FWF1CjDWV3khlaMQfwlPChqCYa2x7RFV6JgG+I=;
        b=GMXNHE6XH+JkR9c6niOASKhCIejtNpzd+DHVNK7y/HeL7TKHIISI6IumS0+4JBqYEU
         eh837cyZljPtNGG7jWnuCSwkFqA1ro0JsBPDfJKMAgRgOfr5nifRDOsWYJIyF8btvT09
         DZ3trO3VPAh+bLmtGPadEMXVXBYLvtadyZK7QbweulDhNZjsdNHHtGPObncM9dSPl0ng
         pFvmNFCO7dxtbv/2sMqHcVK31YxQYi3RUdyFPnZpDYSVpweed7xvTB2bw20MdqBwnQmK
         Cg0L6IKaxi2DH5u2vp5dR2x2g/+a71GHNlLErSL45IdEfHKtnsQBXV82UAiKKs4lNgGX
         v2IQ==
Received: by 10.112.50.109 with SMTP id b13mr3311042lbo.8.1353796648043;
        Sat, 24 Nov 2012 14:37:28 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-76-206.pppoe.mtu-net.ru. [91.79.76.206])
        by mx.google.com with ESMTPS id ti4sm3728024lab.1.2012.11.24.14.37.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Nov 2012 14:37:27 -0800 (PST)
Message-ID: <50B14BD6.8050302@mvista.com>
Date:   Sun, 25 Nov 2012 02:36:06 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     linville@tuxdriver.com, linux-wireless@vger.kernel.org,
        wim@iguana.be, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 04/15] watchdog: bcm47xx_wdt.c: rename wdt_timeout to
 timeout
References: <1353795855-22236-1-git-send-email-hauke@hauke-m.de> <1353795855-22236-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1353795855-22236-5-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmJJrPEr6GDek+7db04kMpuPZRMJTsd1e4O5M/v66izj3jmYP8xtMTtqGKoSvvPqMhVtKme
X-archive-position: 35123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 25-11-2012 2:24, Hauke Mehrtens wrote:

> Rename rename

    Once it enough. :-)

> wdt_timeout

    'wdt_time', you mean?

> to timeout to name it like the other watchdog
> driver do it.

    It's not the only change you're doing.

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   drivers/watchdog/bcm47xx_wdt.c |   14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

> diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
> index 66f2d2b..b6a8c49 100644
> --- a/drivers/watchdog/bcm47xx_wdt.c
> +++ b/drivers/watchdog/bcm47xx_wdt.c
> @@ -30,13 +30,13 @@
>   #define DRV_NAME		"bcm47xx_wdt"
>
>   #define WDT_DEFAULT_TIME	30	/* seconds */
> -#define WDT_MAX_TIME		255	/* seconds */
> +#define WDT_SOFTTIMER_MAX	3600	/* seconds */
>
> -static int wdt_time = WDT_DEFAULT_TIME;
> +static int timeout = WDT_DEFAULT_TIME;
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>
> -module_param(wdt_time, int, 0);
> -MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog time in seconds. (default="
>   				__MODULE_STRING(WDT_DEFAULT_TIME) ")");
>
>   module_param(nowayout, bool, 0);
> @@ -94,9 +94,9 @@ static int bcm47xx_wdt_soft_stop(struct watchdog_device *wdd)
>   static int bcm47xx_wdt_soft_set_timeout(struct watchdog_device *wdd,
>   					unsigned int new_time)
>   {
> -	if (new_time < 1 || new_time > WDT_MAX_TIME) {
> +	if (new_time < 1 || new_time > WDT_SOFTTIMER_MAX) {
>   		pr_warn("timeout value must be 1<=x<=%d, using %d\n",
> -			WDT_MAX_TIME, new_time);
> +			WDT_SOFTTIMER_MAX, new_time);
>   		return -EINVAL;
>   	}
>

WBR, Sergei
