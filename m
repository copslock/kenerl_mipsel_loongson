Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 17:40:06 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:56689 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903691Ab2BQQkA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2012 17:40:00 +0100
Received: by bkcjk13 with SMTP id jk13so4337038bkc.36
        for <linux-mips@linux-mips.org>; Fri, 17 Feb 2012 08:39:54 -0800 (PST)
Received: by 10.204.152.208 with SMTP id h16mr4715011bkw.6.1329496794466;
        Fri, 17 Feb 2012 08:39:54 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id x22sm23653492bkw.11.2012.02.17.08.39.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 08:39:53 -0800 (PST)
Message-ID: <4F3E90C4.8010904@mvista.com>
Date:   Fri, 17 Feb 2012 20:39:16 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 7/9] SERIAL: MIPS: lantiq: convert serial driver to clkdev
 api
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org> <1329474800-20979-8-git-send-email-blogic@openwrt.org>
In-Reply-To: <1329474800-20979-8-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnxnJSazOEP8ifgbM1kOCc4uuQ68PWKW1ULZtDqu8pby104lqNotBK0rvoxslkFFxVuWpZN
X-archive-position: 32458
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

    The comment doesn't match the essence of patch.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Cc: linux-serial@vger.kernel.org
> ---
> This patch should go via MIPS with the rest of the series.

>   drivers/tty/serial/lantiq.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 96c1cac..136dae8 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -686,7 +686,7 @@ lqasc_probe(struct platform_device *pdev)
>   	if (lqasc_port[pdev->id] != NULL)
>   		return -EBUSY;
>
> -	clk = clk_get(&pdev->dev, "fpi");
> +	clk = clk_get_sys("fpi", NULL);

    Why not just clk_get(&pdev->dev, NULL)?

WBR, Sergei
