Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 16:54:01 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.24]:49300 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010009AbbDQOx77daOP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2015 16:53:59 +0200
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0LhTpQ-1Z5HB747ua-00mdrz; Fri, 17 Apr
 2015 16:53:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] MIPS: ath79: Add OF support to the GPIO driver
Date:   Fri, 17 Apr 2015 16:53:31 +0200
Message-ID: <4071167.An8CoV6UJC@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1429280669-2986-12-git-send-email-albeu@free.fr>
References: <1429280669-2986-1-git-send-email-albeu@free.fr> <1429280669-2986-12-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:iZu2k1VDfogWr0UXOgM6rZCbT1q4iVoRHUTFpT9LwbX/c3mIyrk
 Lni5g14frmDtQxOSiutUfJPgTJ1lIzQR9Mha9zUq5DBEu7x7Uw5EOIHraOcSMn2nAB5nE2f
 xudeCcLzTVfeVFzuxHUBpehHhOZPrH2nx84FCHW6RJ8xya1wnlzIufxxkLvCWQlfboVV63P
 gEGY0wfcDC48NtwLCq8/Q==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46897
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

On Friday 17 April 2015 16:24:26 Alban Bedel wrote:
> Replace the simple GPIO chip registration by a platform driver
> and make ath79_gpio_init() just register the device.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  arch/mips/ath79/dev-common.c | 13 ++++++++
>  arch/mips/ath79/gpio.c       | 73 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 81 insertions(+), 5 deletions(-)

Could you move the driver to drivers/gpio/ now?

> +void __init ath79_gpio_init(void)
> +{
> +	struct resource res;
> +
> +	memset(&res, 0, sizeof(res));
> +
> +	res.flags = IORESOURCE_MEM;
> +	res.start = AR71XX_GPIO_BASE;
> +	res.end = res.start + AR71XX_GPIO_SIZE - 1;
> +
> +	platform_device_register_simple("ath79-gpio", -1, &res, 1);
> +}

Your code looks correct, but could be shortened to 

	struct resource mem = DEFINE_RES_MEM(AR71XX_GPIO_BASE, AR71XX_GPIO_SIZE);

>  
> -void __init ath79_gpio_init(void)
> +static const struct of_device_id ath79_gpio_of_match[] = {
> +	{
> +		.compatible = "qca,ar7100-gpio",
> +		.data = (void *)AR71XX_GPIO_COUNT,
> +	},
> +	{
> +		.compatible = "qca,ar7240-gpio",
> +		.data = (void *)AR7240_GPIO_COUNT,
> +	},
> +	{
> +		.compatible = "qca,ar7241-gpio",
> +		.data = (void *)AR7241_GPIO_COUNT,
> +	},
> +	{
> +		.compatible = "qca,ar9130-gpio",
> +		.data = (void *)AR913X_GPIO_COUNT,
> +	},
> +	{
> +		.compatible = "qca,ar9330-gpio",
> +		.data = (void *)AR933X_GPIO_COUNT,
> +	},
> +	{
> +		.compatible = "qca,ar9340-gpio",
> +		.data = (void *)AR934X_GPIO_COUNT,
> +	},
> +	{
> +		.compatible = "qca,qca9550-gpio",
> +		.data = (void *)QCA955X_GPIO_COUNT,
> +	},
> +	{},
> +};

How about putting the number into an 'ngpios' property like some other
bindings do?

	Arnd
