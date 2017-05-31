Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 10:19:53 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:59964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991948AbdEaIToT3kK- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 May 2017 10:19:44 +0200
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com [209.85.223.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0023323A16;
        Wed, 31 May 2017 08:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0023323A16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
Received: by mail-io0-f174.google.com with SMTP id p24so11938955ioi.0;
        Wed, 31 May 2017 01:19:38 -0700 (PDT)
X-Gm-Message-State: AODbwcD6UlsJGwAYdMeN7glFZqX/7FW54oMfpzK1blZA0yl1y6pgCSKV
        zuxHYWt6Q3PT9HbYAuoJKV/kJRZS+w==
X-Received: by 10.107.6.27 with SMTP id 27mr21697387iog.53.1496218778350; Wed,
 31 May 2017 01:19:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.50.81 with HTTP; Wed, 31 May 2017 01:19:37 -0700 (PDT)
In-Reply-To: <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org> <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 31 May 2017 10:19:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd6GGPCD1L2LtwzpJbcWeJS9d23iJUd6f3RbuBP1h+-Hw@mail.gmail.com>
Message-ID: <CAJKOXPd6GGPCD1L2LtwzpJbcWeJS9d23iJUd6f3RbuBP1h+-Hw@mail.gmail.com>
Subject: Re: [PATCH 2/7] clocksource: Rename CLOCKSOURCE_OF_DECLARE
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <kernel@pengutronix.de>,
        Joachim Eastwood <manabian@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Richard Cochran <rcochran@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Noam Camus <noamca@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        "moderated list:ARM/OXNAS platform support" 
        <linux-oxnas@lists.tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <krzk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58082
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
> The CLOCKSOUCE_OF_DECLARE macro is used widely for the timers to declare the
> clocksource at early stage. However, this macro is also used to initialize
> the clockevent if any, or the clockevent only.
>
> It was originally suggested to declare another macro to initialize a
> clockevent, so in order to separate the two entities even they belong to the
> same IP. This was not accepted because of the impact on the DT where splitting
> a clocksource/clockevent definition does not make sense as it is a Linux
> concept not a hardware description.
>
> On the other side, the clocksource has not interrupt declared while the
> clockevent has, so it is easy from the driver to know if the description is
> for a clockevent or a clocksource, IOW it could be implemented at the driver
> level.
>
> So instead of dealing with a named clocksource macro, let's use a more generic
> one: TIMER_OF_DECLARE.
>
> The patch has not functional changes.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/kernel/smp_twd.c                 |  6 +++---
>  arch/microblaze/kernel/timer.c            |  2 +-
>  arch/mips/ralink/cevt-rt3352.c            |  2 +-
>  arch/nios2/kernel/time.c                  |  2 +-
>  drivers/clocksource/arc_timer.c           |  6 +++---
>  drivers/clocksource/arm_arch_timer.c      |  6 +++---
>  drivers/clocksource/arm_global_timer.c    |  2 +-
>  drivers/clocksource/armv7m_systick.c      |  2 +-
>  drivers/clocksource/asm9260_timer.c       |  2 +-
>  drivers/clocksource/bcm2835_timer.c       |  2 +-
>  drivers/clocksource/bcm_kona_timer.c      |  4 ++--
>  drivers/clocksource/cadence_ttc_timer.c   |  2 +-
>  drivers/clocksource/clksrc-dbx500-prcmu.c |  2 +-
>  drivers/clocksource/clksrc_st_lpc.c       |  2 +-
>  drivers/clocksource/clps711x-timer.c      |  2 +-
>  drivers/clocksource/dw_apb_timer_of.c     |  8 ++++----
>  drivers/clocksource/exynos_mct.c          |  4 ++--
>  drivers/clocksource/fsl_ftm_timer.c       |  2 +-
>  drivers/clocksource/h8300_timer16.c       |  2 +-
>  drivers/clocksource/h8300_timer8.c        |  2 +-
>  drivers/clocksource/h8300_tpu.c           |  2 +-
>  drivers/clocksource/jcore-pit.c           |  2 +-
>  drivers/clocksource/meson6_timer.c        |  2 +-
>  drivers/clocksource/mips-gic-timer.c      |  2 +-
>  drivers/clocksource/mps2-timer.c          |  2 +-
>  drivers/clocksource/mtk_timer.c           |  2 +-
>  drivers/clocksource/mxs_timer.c           |  2 +-
>  drivers/clocksource/nomadik-mtu.c         |  2 +-
>  drivers/clocksource/pxa_timer.c           |  2 +-
>  drivers/clocksource/qcom-timer.c          |  4 ++--
>  drivers/clocksource/renesas-ostm.c        |  2 +-
>  drivers/clocksource/rockchip_timer.c      |  4 ++--
>  drivers/clocksource/samsung_pwm_timer.c   |  8 ++++----

For exynos_mct and samsung_pwm_timer:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
