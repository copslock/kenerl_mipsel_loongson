Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 11:54:45 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:37989 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903649Ab2BXKyj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 11:54:39 +0100
Received: by bkcjk13 with SMTP id jk13so2442776bkc.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 02:54:34 -0800 (PST)
Received-SPF: pass (google.com: domain of sshtylyov@mvista.com designates 10.205.134.1 as permitted sender) client-ip=10.205.134.1;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sshtylyov@mvista.com designates 10.205.134.1 as permitted sender) smtp.mail=sshtylyov@mvista.com
Received: from mr.google.com ([10.205.134.1])
        by 10.205.134.1 with SMTP id ia1mr847169bkc.78.1330080874368 (num_hops = 1);
        Fri, 24 Feb 2012 02:54:34 -0800 (PST)
Received: by 10.205.134.1 with SMTP id ia1mr700426bkc.78.1330080874174;
        Fri, 24 Feb 2012 02:54:34 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-85-203.pppoe.mtu-net.ru. [91.79.85.203])
        by mx.google.com with ESMTPS id x20sm7930231bka.9.2012.02.24.02.54.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 02:54:33 -0800 (PST)
Message-ID: <4F476C1E.9020608@mvista.com>
Date:   Fri, 24 Feb 2012 14:53:18 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 10/14] MIPS: lantiq: convert falcon debug uart to clkdev
 api
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org> <1330012993-13510-10-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330012993-13510-10-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQm9LAdJJXYwnat1NDkUxtnzlnRzj0zwdBdbYdsIwqKxslHHA5mJTS8c9zL33G1CmYoBb7vK
X-archive-position: 32544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 23-02-2012 20:03, John Crispin wrote:

> On Falcon SoCs we have a secondary serial port that can be used to help
> debug the voice core. For the port to work several clocking bits need to
> be activated. We convert the code to clkdev api.

    You also convert to new ltq_gpio_request() here. I don't think you should 
mix these two things up in one patch.

> Signed-off-by: John Crispin<blogic@openwrt.org>
[...]

> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 99fb70f..cf88afd 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
[...]
> @@ -529,6 +533,19 @@ lqasc_request_port(struct uart_port *port)
>   		if (port->membase == NULL)
>   			return -ENOMEM;
>   	}
> +
> +	if (ltq_is_falcon()&&  (port->line == 1)) {
> +		struct ltq_uart_port *ltq_port = lqasc_port[pdev->id];
> +		if (ltq_gpio_request(&pdev->dev, MUXC_SIF_RX_PIN,
> +				3, 0, "asc1-rx") ||
> +			ltq_gpio_request(&pdev->dev, MUXC_SIF_TX_PIN,
> +				3, 1, "asc1-tx"))
> +			return -EBUSY;
> +		ltq_port->clk = clk_get(&pdev->dev, NULL);
> +		if (!ltq_port->clk)

    clk_get() returns error code, not NULL. Use IS_ERR() and PTR_ERR().

WBR, Sergei
