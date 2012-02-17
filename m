Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 17:41:49 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:60337 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903688Ab2BQQlm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2012 17:41:42 +0100
Received: by bkcjk13 with SMTP id jk13so4339428bkc.36
        for <linux-mips@linux-mips.org>; Fri, 17 Feb 2012 08:41:37 -0800 (PST)
Received: by 10.204.9.205 with SMTP id m13mr4440618bkm.68.1329496897082;
        Fri, 17 Feb 2012 08:41:37 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id bw9sm23694525bkb.8.2012.02.17.08.41.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 08:41:35 -0800 (PST)
Message-ID: <4F3E9129.9040704@mvista.com>
Date:   Fri, 17 Feb 2012 20:40:57 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 9/9] WDT: MIPS: lantiq: convert watchdog driver to clkdev
 api
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org> <1329474800-20979-10-git-send-email-blogic@openwrt.org>
In-Reply-To: <1329474800-20979-10-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkPAsX0QL9uzL9/HDDXdCqobyNyx1hPtvHvLZZACOTo1leu+EmXrYEdaPGcQdrCD2aVGNP5
X-archive-position: 32459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 02/17/2012 01:33 PM, John Crispin wrote:

> Update from old pmu_{dis,en}able() to ckldev api.

   Again, you're doing something different.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Cc: linux-watchdog@vger.kernel.org
> ---
> This patch should go via MIPS with the rest of the series.
>
>   drivers/watchdog/lantiq_wdt.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index 9c8b10c..05646b8 100644
> --- a/drivers/watchdog/lantiq_wdt.c
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -206,7 +206,7 @@ ltq_wdt_probe(struct platform_device *pdev)
>   	}
>
>   	/* we do not need to enable the clock as it is always running */
> -	clk = clk_get(&pdev->dev, "io");
> +	clk = clk_get_sys("io", NULL);

    Why not clk_get(&pdev->dev, NULL)?

WBR, Sergei
