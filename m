Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Aug 2017 18:20:20 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:38117
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993103AbdHOQUJsi9fO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Aug 2017 18:20:09 +0200
Received: by mail-pg0-x243.google.com with SMTP id 123so2123382pga.5;
        Tue, 15 Aug 2017 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sHyeII3vV7QRODPtV6CtVsoECUIVPvOlIR/9GQ9qwYI=;
        b=NHW/6elw7fob7mgDx7CVYyGDQYNIYuuFQ4lKQiUocez4dOf5oQxV9h6YeEBLssuDPB
         y0iPJTZ2JumHCuS32bKnKoG/n9d/95e83Xvms+JiXOzF+8KIqAUzvNy17CtlkLH3/YxU
         MuxezEDkrtiP9dwYJEmCudcdp1SJQj3pW6Hk9jAreac0ALAQzVlFzew9d+c8k00CLFmK
         4cR/fQzxaar7NUqKTuRH8PTQccDKAKvnoWpw9rqzenFUxjn8RF0bdHo/BxKG7NjQxrJo
         TmDJMnqhIsCkG4LrfJV9sJnWBVHR/YmAgMIWpGoaGe+tw5yB9hjgUnkcq1WUoiIrUmFY
         NlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHyeII3vV7QRODPtV6CtVsoECUIVPvOlIR/9GQ9qwYI=;
        b=PJfNPAgrye3XLsj4XsgVJSU5ZGXkFZ+G/n1g2xJXnHXGFJky3qwxdyQ9th6sWd/8NI
         zxr076NZzDxnn/F+bNnHypG9UokS8G2ykigoku3prF5EaVFv7XkVMa8o4ue9F42zElVg
         hYo7wWqRIY7ndfUOl5zdktzMlN1ffLSBkpIGWA+gkzLJYsmHsqR/TTAhJl4myWCWtK0F
         p4t9juO0p7Kr/vIbeMnvFJ1DJfXTZn/zDNykXKWzZF7R6MtcAAQenCxgG3HllA6pkp1k
         7VUbILrI1aSmigBUpBvC8xYYY+f3bIlYIPdFyUNDqaKr3WXUZpUf8FHj3B09RUdYB+lO
         Evgg==
X-Gm-Message-State: AHYfb5gCO+WfanXNKWS59F1b+qnp/z2kjTPcZtJLV3E9lVEH5bRN2yNb
        4LP3o4aSstNnRQ==
X-Received: by 10.84.218.71 with SMTP id f7mr32775869plm.129.1502814002485;
        Tue, 15 Aug 2017 09:20:02 -0700 (PDT)
Received: from [192.168.1.156] (c-73-202-191-91.hsd1.ca.comcast.net. [73.202.191.91])
        by smtp.gmail.com with ESMTPSA id n1sm20009411pfj.46.2017.08.15.09.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 09:20:01 -0700 (PDT)
Subject: Re: [PATCH 0/8] MIPS: BCM63XX: add and use clkdev lookup support
To:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b180fcb8-0282-3bad-aad0-4f1faaea73b0@gmail.com>
Date:   Tue, 15 Aug 2017 09:20:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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



On 08/02/2017 02:34 AM, Jonas Gorski wrote:
> This patchset adds and uses clckdev lookup support to name input clocks
> in various drivers more closely to their functions, or simplify their
> usage.
> 
> Since most of these patches touch arch/mips, it probably makes most
> sense to go through the MIPS tree.
> 
> The HSSPI driver was already updated previously to support a "pll"
> input with ff18e1ef04e2 ("spi/bcm63xx-hsspi: allow providing clock rate
> through a second clock"), so there is no need to touch it.
> 
> This patch series is part of an effort to modernize BCM63XX and clean up
> its drivers to eventually make them usable with BMIPS and device tree.

For this entire series:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

> 
> Jonas Gorski (8):
>   MIPS: BCM63XX: add clkdev lookup support
>   MIPS: BCM63XX: provide periph clock as refclk for uart
>   tty/bcm63xx_uart: use refclk for the expected clock name
>   tty/bcm63xx_uart: allow naming clock in device tree
>   MIPS: BCM63XX: provide enet clocks as "enet" to the ethernet devices
>   bcm63xx_enet: just use "enet" as the clock name
>   MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
>   MIPS: BMIPS: name the refclk clock for uart
> 
>  .../bindings/serial/brcm,bcm6345-uart.txt          |   6 +
>  arch/mips/Kconfig                                  |   1 +
>  arch/mips/bcm63xx/clk.c                            | 181 ++++++++++++++++-----
>  arch/mips/boot/dts/brcm/bcm3368.dtsi               |   2 +
>  arch/mips/boot/dts/brcm/bcm63268.dtsi              |   2 +
>  arch/mips/boot/dts/brcm/bcm6328.dtsi               |   2 +
>  arch/mips/boot/dts/brcm/bcm6358.dtsi               |   2 +
>  arch/mips/boot/dts/brcm/bcm6362.dtsi               |   2 +
>  arch/mips/boot/dts/brcm/bcm6368.dtsi               |   2 +
>  drivers/net/ethernet/broadcom/bcm63xx_enet.c       |   5 +-
>  drivers/tty/serial/bcm63xx_uart.c                  |   6 +-
>  11 files changed, 168 insertions(+), 43 deletions(-)
> 

-- 
Florian
