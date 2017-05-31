Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 10:25:08 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991948AbdEaIZBDX19P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 May 2017 10:25:01 +0200
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com [209.85.214.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00B5923A1D;
        Wed, 31 May 2017 08:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B5923A1D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
Received: by mail-it0-f49.google.com with SMTP id r63so7381218itc.1;
        Wed, 31 May 2017 01:24:58 -0700 (PDT)
X-Gm-Message-State: AODbwcASSsV5I1JCJ9a++QJnrFkn2XgdRoxKQao9rOnN0qkkv1IpKOvH
        PufULAAQVXE4ZPaufG/2XHFLKcqpKg==
X-Received: by 10.36.135.137 with SMTP id f131mr6402705ite.47.1496219098357;
 Wed, 31 May 2017 01:24:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.50.81 with HTTP; Wed, 31 May 2017 01:24:57 -0700 (PDT)
In-Reply-To: <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org> <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 31 May 2017 10:24:57 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc54UKCBr_8jqUE+5_YHbwEWOv=YRz0zR-ymaXaiGUHyw@mail.gmail.com>
Message-ID: <CAJKOXPc54UKCBr_8jqUE+5_YHbwEWOv=YRz0zR-ymaXaiGUHyw@mail.gmail.com>
Subject: Re: [PATCH 6/7] clocksource: Rename CLKSRC_OF to TIMER_OF
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <krzk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzk@kernel.org
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

On Sat, May 27, 2017 at 11:58 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The config option name is now renamed to 'TIMER_OF' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/Kconfig                        | 10 +++---
>  arch/arm/mach-bcm/Kconfig               |  2 +-
>  arch/arm/mach-clps711x/Kconfig          |  2 +-
>  arch/arm/mach-imx/epit.c                |  2 +-
>  arch/arm/mach-s3c24xx/Kconfig           |  2 +-
>  arch/arm/mach-s3c64xx/Kconfig           |  2 +-
>  arch/arm64/Kconfig.platforms            |  4 +--
>  arch/h8300/Kconfig                      |  2 +-
>  arch/microblaze/Kconfig                 |  2 +-
>  arch/mips/ralink/Kconfig                |  2 +-
>  arch/nios2/Kconfig                      |  2 +-
>  arch/sh/boards/Kconfig                  |  2 +-
>  drivers/clocksource/Kconfig             | 60 ++++++++++++++++-----------------
>  drivers/clocksource/Makefile            |  2 +-
>  drivers/clocksource/clksrc-probe.c      | 55 ------------------------------
>  drivers/clocksource/clps711x-timer.c    |  2 +-
>  drivers/clocksource/samsung_pwm_timer.c |  2 +-

For s3c24xx, s3c64xx and samsung_pwm_timer:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
