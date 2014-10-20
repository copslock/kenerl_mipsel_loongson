Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 00:54:20 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:50880 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011821AbaJTWyTc0MZA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 00:54:19 +0200
Received: by mail-pd0-f176.google.com with SMTP id fp1so20758pdb.35
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=39WIcapM48zT8IHxkMOiGW94bmLPOsC6oEvpXW0YhFQ=;
        b=tUgi+iontZDu2nSwtmJm/XWOApzOgucf43MXspVxh8tjJaO+xdLZbCnWhrjDMgkXeL
         SW6FwOl7EcyRzPNGk3RqiZ5VH0SwKZYGiIVbbqIa+zVYksogWhebmF/hT5Loxv6YHez8
         fI6w6gduDKcZBVC+zy4HlNm9v3Du9nlv3Yp/i9s0eD9sS6zJtFRUN7pQeZ4I8mYHAZEW
         7x1vsxuuMuPJjkk/QHXINNWzj3vxQcQ7BQkz6BlexD9ql68ezYpKKxcodV1c2rQDmFOg
         DFisc86UXI8Y3kQ5omPuPpKFrnpV2Obef3LeYqeMIzy3tOoVgEHrgPY727a1K+QAjU2T
         HquQ==
X-Received: by 10.68.141.4 with SMTP id rk4mr8374484pbb.54.1413845653053;
        Mon, 20 Oct 2014 15:54:13 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id ra4sm10168540pab.33.2014.10.20.15.54.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 15:54:12 -0700 (PDT)
Message-ID: <54459281.7050004@gmail.com>
Date:   Mon, 20 Oct 2014 15:53:53 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Cernekee <cernekee@gmail.com>
CC:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org, geert@linux-m68k.org, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 4/9] Documentation: DT: Add entries for bcm63xx UART
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com> <1413838448-29464-5-git-send-email-cernekee@gmail.com> <6216923.cK1phqtEXn@wuerfel> <2100909.UrHPDWWSai@wuerfel>
In-Reply-To: <2100909.UrHPDWWSai@wuerfel>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43393
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

On 10/20/2014 02:25 PM, Arnd Bergmann wrote:
> On Monday 20 October 2014 23:20:08 Arnd Bergmann wrote:
>>
>> In this example, the clock output name of the clock provider is
>> the same as the clock input of the consumer, that is almost always
>> a bug and would not be a good example at all.
>>
>>
> 
> Ah, found the bug: the MIPS code is written to ignore the device
> and just look up a global clock name:
> 
> struct clk *clk_get(struct device *dev, const char *id)
> {
>         if (!strcmp(id, "enet0"))
>                 return &clk_enet0;
>         if (!strcmp(id, "enet1"))
>                 return &clk_enet1;
>         if (!strcmp(id, "enetsw"))
>                 return &clk_enetsw;
>         if (!strcmp(id, "ephy"))
>                 return &clk_ephy;
>         if (!strcmp(id, "usbh"))
>                 return &clk_usbh;
>         if (!strcmp(id, "usbd"))
>                 return &clk_usbd;
>         if (!strcmp(id, "spi"))
>                 return &clk_spi;
>         if (!strcmp(id, "hsspi"))
>                 return &clk_hsspi;
>         if (!strcmp(id, "xtm"))
>                 return &clk_xtm;
>         if (!strcmp(id, "periph"))
>                 return &clk_periph;
>         if ((BCMCPU_IS_3368() || BCMCPU_IS_6358()) && !strcmp(id, "pcm"))
>                 return &clk_pcm;
>         if ((BCMCPU_IS_6362() || BCMCPU_IS_6368()) && !strcmp(id, "ipsec"))
>                 return &clk_ipsec;
>         if ((BCMCPU_IS_6328() || BCMCPU_IS_6362()) && !strcmp(id, "pcie"))
>                 return &clk_pcie;
>         return ERR_PTR(-ENOENT);
> }
> 
> This should be changed to use the drivers/clk/clkdev.c lookup code if
> you want to share drivers between architectures.

For now, I suppose that s simple fix could be to use an anonymous clock
request when probed via DT. This code you quote dates from 2008 when
there was no clkdev in the kernel at all. So something like this would
probably do it for now:

diff --git a/drivers/tty/serial/bcm63xx_uart.c
b/drivers/tty/serial/bcm63xx_uart.c
index e0b87d507670..1b914b85dd31 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -819,7 +819,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
        if (!res_irq)
                return -ENODEV;

-       clk = clk_get(&pdev->dev, "periph");
+       clk = clk_get(&pdev->dev, pdev->dev.of_node ? NULL : "periph");
        if (IS_ERR(clk))
                return -ENODEV;



> 
> In particular, the "enet0"/"enet1" clock name makes no sense -- the
> clock input name should be independent of the instance, aside from
> the question of which output of the provider it is wired up to.
> 
> 	Arnd
> 
