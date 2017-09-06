Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 13:02:07 +0200 (CEST)
Received: from mail-vk0-x242.google.com ([IPv6:2607:f8b0:400c:c05::242]:34621
        "EHLO mail-vk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdIFLCAuInfq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2017 13:02:00 +0200
Received: by mail-vk0-x242.google.com with SMTP id v203so1709146vkv.1;
        Wed, 06 Sep 2017 04:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PVWlUYea714WxkcYQrWDXaA2wRDbF3X6AVOKu+kgLLE=;
        b=hVxyEiAfNd5Z8iDIkcbp/HVVfpaQbMckx+s03V3xDe59jO8ep6jsvyyQ8kvsysrn/p
         xpguYZxhug6VW1KW8+a8e5kCDZW5XbDJXGNr0D82uoegGAfTzRhOW86/20S9Rztvu6M4
         TUAeHI6pUNJqa0M6goxhd1q9cC+FAKFesOZVdrr8SMq4UMYLkF09nCtaZibt5tqtxCLW
         BWu94B4a0c2QVbeq+l3C/zYAQLv7GaiYEHnQ+BwYAZE70ltUtEAHt0FhB65+fbi5JXOV
         dnGeT5cZAXdc3W0lqtSXkqjqcrYWr0IcXMtn0lMyiWUTA8lQj3QMqjv7SEzaJOoj7RTv
         ZLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PVWlUYea714WxkcYQrWDXaA2wRDbF3X6AVOKu+kgLLE=;
        b=Frzr4qKCuMg/HGl5/RgpUzagPJK9iO7kmSU11a40wsXK88b8GR14O0G62TtNcemdGM
         9gQ7KsSvvrUbZFWKJbqdIyUqHfqtDwP0gQkrRpEEREd7fZXiid/XP9YgC+zMQMl5eMjK
         p07hP4IUYAXW2oDGrEOlfKxl/ysHuvx7Cnr/J7E1kqBMI22gFoXJz+Ueg7emj15d5cKK
         Sf+nWdeHPVlt3qTOEAnJLRD+Wj3jKgrS1yCuggsFsSnpW9hkC+YjsrBUGhVWTcE6NLJc
         HTsSHP2GryOs9pRPRREJ1nCYI/ir0NJrBdphHKmmgI70dWnKlUugBJZqfrQkrThx1pNk
         YfnA==
X-Gm-Message-State: AHPjjUi4FbwefsR9sAWs5jzKrXtHeVRynjVN2loHTB3HU+iZhXVgWQvj
        7HCQaumLVYZlFQBX5Rhw5j1EDvNTR6e/0C4=
X-Google-Smtp-Source: ADKCNb4loi2lFxS9eB+rMNyjYka6Z1u3GMPlc79wM4PPAvplXbdjLjN+OoaFWpzkHAfdKeBleA1lJCwAp2yxb480a5A=
X-Received: by 10.31.124.137 with SMTP id x131mr1281654vkc.6.1504695712796;
 Wed, 06 Sep 2017 04:01:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.28.81 with HTTP; Wed, 6 Sep 2017 04:01:32 -0700 (PDT)
In-Reply-To: <20170802093429.12572-5-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com> <20170802093429.12572-5-jonas.gorski@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 6 Sep 2017 13:01:32 +0200
Message-ID: <CAOiHx=mC=GfX0VvuRWR-AmXYfVOEkuruwGHooS08WrL_z-60UA@mail.gmail.com>
Subject: Re: [PATCH 4/8] tty/bcm63xx_uart: allow naming clock in device tree
To:     MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Hi Greg,

On 2 August 2017 at 11:34, Jonas Gorski <jonas.gorski@gmail.com> wrote:
> Codify using a named clock for the refclk of the uart. This makes it
> easier if we might need to add a gating clock (like present on the
> BCM6345).
>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Could I please get a (N)Ack so Ralf can add this patch to his tree?


Regards
Jonas


> ---
>  Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt | 6 ++++++
>  drivers/tty/serial/bcm63xx_uart.c                              | 6 ++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
> index 5c52e5eef16d..8b2b0460259a 100644
> --- a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
> @@ -11,6 +11,11 @@ Required properties:
>  - clocks: Clock driving the hardware; used to figure out the baud rate
>    divisor.
>
> +
> +Optional properties:
> +
> +- clock-names: Should be "refclk".
> +
>  Example:
>
>         uart0: serial@14e00520 {
> @@ -19,6 +24,7 @@ Example:
>                 interrupt-parent = <&periph_intc>;
>                 interrupts = <2>;
>                 clocks = <&periph_clk>;
> +               clock-names = "refclk";
>         };
>
>         clocks {
> diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
> index a2b9376ec861..f227eff28d3a 100644
> --- a/drivers/tty/serial/bcm63xx_uart.c
> +++ b/drivers/tty/serial/bcm63xx_uart.c
> @@ -841,8 +841,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
>         if (!res_irq)
>                 return -ENODEV;
>
> -       clk = pdev->dev.of_node ? of_clk_get(pdev->dev.of_node, 0) :
> -                                 clk_get(&pdev->dev, "refclk");
> +       clk = clk_get(&pdev->dev, "refclk");
> +       if (IS_ERR(clk) && pdev->dev.of_node)
> +               clk = of_clk_get(pdev->dev.of_node, 0);
> +
>         if (IS_ERR(clk))
>                 return -ENODEV;
>
> --
> 2.13.2
>
