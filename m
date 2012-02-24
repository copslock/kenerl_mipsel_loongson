Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 11:47:14 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:45904 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903648Ab2BXKrH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 11:47:07 +0100
Received: by bkcjk13 with SMTP id jk13so2437168bkc.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 02:47:02 -0800 (PST)
Received-SPF: pass (google.com: domain of sshtylyov@mvista.com designates 10.204.128.75 as permitted sender) client-ip=10.204.128.75;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sshtylyov@mvista.com designates 10.204.128.75 as permitted sender) smtp.mail=sshtylyov@mvista.com
Received: from mr.google.com ([10.204.128.75])
        by 10.204.128.75 with SMTP id j11mr640685bks.2.1330080422499 (num_hops = 1);
        Fri, 24 Feb 2012 02:47:02 -0800 (PST)
Received: by 10.204.128.75 with SMTP id j11mr525746bks.2.1330080422307;
        Fri, 24 Feb 2012 02:47:02 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-85-203.pppoe.mtu-net.ru. [91.79.85.203])
        by mx.google.com with ESMTPS id ey8sm7922479bkb.1.2012.02.24.02.47.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 02:47:01 -0800 (PST)
Message-ID: <4F476A5A.1060007@mvista.com>
Date:   Fri, 24 Feb 2012 14:45:46 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 08/14] MIPS: lantiq: convert falcon gpio to clkdev
 api
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org> <1330012993-13510-8-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330012993-13510-8-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnqSaP75/5Mk5alLzB233WC0TbQV+dgtCE87fid0/qfT/7mFkRDKB737L3fbNu/PqCkavlF
X-archive-position: 32542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 23-02-2012 20:03, John Crispin wrote:

> The falcon gpio clocks used to be enabled when registering the platform device.
> Move this code into the driver and use clkdev api.

> Signed-off-by: John Crispin<blogic@openwrt.org>
[...]

> diff --git a/arch/mips/lantiq/falcon/gpio.c b/arch/mips/lantiq/falcon/gpio.c
> index b7611d7..89c9896 100644
> --- a/arch/mips/lantiq/falcon/gpio.c
> +++ b/arch/mips/lantiq/falcon/gpio.c
[...]
> @@ -332,6 +333,14 @@ falcon_gpio_probe(struct platform_device *pdev)
>   		goto err;
>   	}
>
> +	gpio_port->clk = clk_get(&pdev->dev, NULL);
> +	if (!gpio_port->clk) {

    clk_get() returns error, not NULL. So you should use IS_ERR(gpio_port->clk).

> +		dev_err(&pdev->dev, "Could not get clock\n");
> +		ret = -ENOENT;

	ret = PTR_ERR(gpio_port->clk);

WBR, Sergei
