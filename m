Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 11:41:00 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:65118 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903647Ab2BXKkz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 11:40:55 +0100
Received: by bkcjk13 with SMTP id jk13so2432240bkc.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 02:40:50 -0800 (PST)
Received-SPF: pass (google.com: domain of sshtylyov@mvista.com designates 10.204.154.28 as permitted sender) client-ip=10.204.154.28;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sshtylyov@mvista.com designates 10.204.154.28 as permitted sender) smtp.mail=sshtylyov@mvista.com
Received: from mr.google.com ([10.204.154.28])
        by 10.204.154.28 with SMTP id m28mr817896bkw.54.1330080050046 (num_hops = 1);
        Fri, 24 Feb 2012 02:40:50 -0800 (PST)
Received: by 10.204.154.28 with SMTP id m28mr674211bkw.54.1330080049866;
        Fri, 24 Feb 2012 02:40:49 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-85-203.pppoe.mtu-net.ru. [91.79.85.203])
        by mx.google.com with ESMTPS id u8sm7833252bkg.13.2012.02.24.02.40.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 02:40:49 -0800 (PST)
Message-ID: <4F4768E6.8080302@mvista.com>
Date:   Fri, 24 Feb 2012 14:39:34 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 6/6] MIPS: lantiq: convert gpio_stp to managed gpio
References: <1330012913-13293-1-git-send-email-blogic@openwrt.org> <1330012913-13293-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330012913-13293-6-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQn/pYXQmhxhi+cGmYlAmt7OyuS+Mbae5iwHuijWUcgR05gl44MUVnHeW6xkXJFeNk+Yk18S
X-archive-position: 32541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 23-02-2012 20:01, John Crispin wrote:

> ltq_gpio_request() now uses devres to manage the gpios. We need to pass a
> struct device pointer to make it work.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> ---
>   arch/mips/lantiq/xway/gpio_stp.c |   13 ++++++++-----
>   1 files changed, 8 insertions(+), 5 deletions(-)

> diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
> index cb6f170..e6b4809 100644
> --- a/arch/mips/lantiq/xway/gpio_stp.c
> +++ b/arch/mips/lantiq/xway/gpio_stp.c
> @@ -80,11 +80,6 @@ static struct gpio_chip ltq_stp_chip = {
>
>   static int ltq_stp_hw_init(void)
>   {
> -	/* the 3 pins used to control the external stp */
> -	ltq_gpio_request(4, 2, 1, "stp-st");
> -	ltq_gpio_request(5, 2, 1, "stp-d");
> -	ltq_gpio_request(6, 2, 1, "stp-sh");
> -
>   	/* sane defaults */
>   	ltq_stp_w32(0, LTQ_STP_AR);
>   	ltq_stp_w32(0, LTQ_STP_CPU0);
> @@ -133,6 +128,14 @@ static int __devinit ltq_stp_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "failed to remap STP memory\n");
>   		return -ENOMEM;
>   	}
> +
> +	/* the 3 pins used to control the external stp */
> +	if (ltq_gpio_request(&pdev->dev, 4, 2, 1, "stp-st") ||
> +			ltq_gpio_request(&pdev->dev, 5, 2, 1, "stp-d") ||
> +			ltq_gpio_request(&pdev->dev, 6, 2, 1, "stp-sh")) {

    This needs to be merged to patch 1...

WBR, Sergei
