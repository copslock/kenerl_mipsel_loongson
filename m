Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 07:50:16 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:50622 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011198AbaJUFuPKtQii (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 07:50:15 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue001) with ESMTP (Nemesis)
        id 0LbUlf-1YQlE43gPD-00l9uD; Tue, 21 Oct 2014 07:49:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org,
        geert@linux-m68k.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 4/9] Documentation: DT: Add entries for bcm63xx UART
Date:   Tue, 21 Oct 2014 07:49:51 +0200
Message-ID: <3370097.yeNWMGbi8v@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <54459281.7050004@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com> <2100909.UrHPDWWSai@wuerfel> <54459281.7050004@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:TswApH9CcVDWh9D/CSvIYdX+Pes/QbrBQADedFuUZir
 qPOWxotxATO1kThjbVzdJh4FiS4oPeaGv/I2vKEci/o2O3hON6
 cIrmKKvuh493MZmVi9Exd/wIUFZtwjOidtGj2MJt208MGE/LXG
 5fIoEiEEYw2349UeeUTmvARYX/WHFmHdoLzKBVLkLobYIQ+ZN7
 L9Wro1K9jeifaz/ib9+dTQ1lHUrvwi7mJtt0c8fYqwa9PVTwGF
 trdRE2DPxQVRngX9BgQ3z6pExsWXNVDMNjxbpvJDWVoJP0KG21
 YFsTurF2Ssc8vNpxzbbGF6YUXFiIM4zeGMLw91X1jQzKB6zVeg
 BGgfLD4Aw9kRiw0MZ3aw=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Monday 20 October 2014 15:53:53 Florian Fainelli wrote:
> 
> For now, I suppose that s simple fix could be to use an anonymous clock
> request when probed via DT. This code you quote dates from 2008 when
> there was no clkdev in the kernel at all. So something like this would
> probably do it for now:
> 
> diff --git a/drivers/tty/serial/bcm63xx_uart.c
> b/drivers/tty/serial/bcm63xx_uart.c
> index e0b87d507670..1b914b85dd31 100644
> --- a/drivers/tty/serial/bcm63xx_uart.c
> +++ b/drivers/tty/serial/bcm63xx_uart.c
> @@ -819,7 +819,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
>         if (!res_irq)
>                 return -ENODEV;
> 
> -       clk = clk_get(&pdev->dev, "periph");
> +       clk = clk_get(&pdev->dev, pdev->dev.of_node ? NULL : "periph");
>         if (IS_ERR(clk))
>                 return -ENODEV;
> 
> 

Yes, that would work. Just make sure the same bug doesn't creep in
for other drivers you are converting.

	Arnd
