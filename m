Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2015 16:02:57 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:38067 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012812AbbKWPCyWt427 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Nov 2015 16:02:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id C844E287BA5;
        Mon, 23 Nov 2015 16:00:50 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com [209.85.215.53])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 38A1228058C;
        Mon, 23 Nov 2015 16:00:39 +0100 (CET)
Received: by lfaz4 with SMTP id z4so109299233lfa.0;
        Mon, 23 Nov 2015 07:02:41 -0800 (PST)
X-Received: by 10.25.39.19 with SMTP id n19mr8907366lfn.156.1448290961561;
 Mon, 23 Nov 2015 07:02:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.162.78 with HTTP; Mon, 23 Nov 2015 07:02:22 -0800 (PST)
In-Reply-To: <5651CC3C.5090200@simon.arlott.org.uk>
References: <5650BFD6.5030700@simon.arlott.org.uk> <5650C08C.6090300@simon.arlott.org.uk>
 <5650E2FA.6090408@roeck-us.net> <5650E5BB.6020404@simon.arlott.org.uk>
 <56512937.6030903@roeck-us.net> <5651CB13.4090704@simon.arlott.org.uk> <5651CC3C.5090200@simon.arlott.org.uk>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 23 Nov 2015 16:02:22 +0100
X-Gmail-Original-Message-ID: <CAOiHx==Z=4H=-L2CY-FE5m6WMV0XzgsCmy1b9tUbsmOHydzkEw@mail.gmail.com>
Message-ID: <CAOiHx==Z=4H=-L2CY-FE5m6WMV0XzgsCmy1b9tUbsmOHydzkEw@mail.gmail.com>
Subject: Re: [PATCH 6/10] watchdog: bcm63xx_wdt: Obtain watchdog clock HZ from
 "periph" clk
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi,

On Sun, Nov 22, 2015 at 3:07 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
> Instead of using a fixed clock HZ in the driver, obtain it from the
> "periph" clk that the watchdog timer uses.
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  drivers/watchdog/bcm63xx_wdt.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
> index 1d2a501..eb5e551 100644
> --- a/drivers/watchdog/bcm63xx_wdt.c
> +++ b/drivers/watchdog/bcm63xx_wdt.c
> @@ -13,6 +13,7 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/clk.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -32,11 +33,13 @@
>
>  #define PFX KBUILD_MODNAME
>
> -#define WDT_HZ                 50000000                /* Fclk */
> +#define WDT_CLK_NAME           "periph"

@Florian:
Is this correct? The comment for the watchdog in 6358_map_part.h and
earlier claims that the clock is 40 MHz there, but the code uses 50MHz
- is this a bug in the comments or is it a bug taken over from the
original broadcom code? I'm sure that the periph clock being 50 MHz
even on the older chips is correct, else we'd have noticed that in
serial output (where it's also used).


Jonas
