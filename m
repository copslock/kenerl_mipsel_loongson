Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2016 19:03:42 +0200 (CEST)
Received: from mail-io0-f196.google.com ([209.85.223.196]:32900 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27043121AbcFTRDjcTVqr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2016 19:03:39 +0200
Received: by mail-io0-f196.google.com with SMTP id 5so19117390ioy.0;
        Mon, 20 Jun 2016 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:from:to:cc:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HhO0sf9EK062ENTdNlmBJM1bw8qOH/+TF/myF5coQe8=;
        b=JGWkg1s8YGbyUkuebCyorTcN5o/UHctSpIVZIRx0XanHebN+iwU0n7RI+zVSgpy+Fi
         QHbqqFaPJ6tDyyusCNxj3Y7Y41TVJjZJ4/xDiqZMBkFYWCKyTt8vJw/9Qvwxfixd8CtZ
         wnAhjhEcn4faNypmhslC2eo1GvdknW8nL+G542BKp+734FalZCAksbq0bTADCCS/aNmf
         DJ7UiNRxMGyd3L8SzTaeIapsPTlafmFQH0ljgsAWGeH0BwFLQ51UtsQnToXmwku+Yo2j
         JqFHMYmFd1PfigVs9h9wuQhnQamHl2puu3XiFlTxZJdWYd4DZgxHI7q+TaVOZ33bSelo
         6L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:from:to:cc:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HhO0sf9EK062ENTdNlmBJM1bw8qOH/+TF/myF5coQe8=;
        b=hV+f4/oLzhULqDCaSngeXCgtbdamxRf/RC8GdDIBkiuyonrncccu2ZHechkmRd222H
         Ey0sKPDT3rI/3uSKhLqKcWlUNxV4IMsL72e/7ZYJAuQZRmFYhWI+wX1g2FRk481CPFMa
         WAhJLcATcSPDPRgL8LlNkBdqiHLPRgYUH07hkLb2a1t6+CwmUFg9MLmNljDrr+18lyy+
         qAYW1K4VHGBt3sjwv5PxC1m7eL6gfZvNoBReUs/N+wc/TvD4XtoyKl2hw+H3hpCdR8Jo
         AxOv79WAqFCr46XqoBwFvogTr8ScBkKHWBhMHqiFU6YzkiuxoRkpOW8HKB7F09lW/Q83
         a2ug==
X-Gm-Message-State: ALyK8tJwTBuvH2jfmvi4bk/NNvXp1TlAcelLFza6EG3UxSwjhZtBBlUEMtalk1sCFIVYBg==
X-Received: by 10.107.143.131 with SMTP id r125mr24369416iod.54.1466442212169;
        Mon, 20 Jun 2016 10:03:32 -0700 (PDT)
Received: from [10.38.195.69] ([74.51.240.241])
        by smtp.gmail.com with ESMTPSA id h193sm23036600ioe.40.2016.06.20.10.03.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Jun 2016 10:03:31 -0700 (PDT)
Subject: Re: [PATCH V2 63/63] clocksources: Switch back to the clksrc table
From:   Sylvain Lemieux <slemieux.tyco@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Maxime Coquelin <maxime.coquelin@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
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
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
        Joachim Eastwood <manabian@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Barry Song <baohua@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Noam Camus <noamc@ezchip.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@ti.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "open list:SYNOPSYS ARC ARCH..." <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:RALINK MIPS ARCHI..." <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
        "moderated list:BROADCOM BCM2835..." 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:BROADCOM BCM281XX..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:ARM/SAMSUNG EXYNO..." 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:TEGRA ARCHITECTUR..." <linux-tegra@vger.kernel.org>,
        "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>
In-Reply-To: <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
         <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 20 Jun 2016 13:03:27 -0400
Message-ID: <1466442207.1887.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-34.el6) 
Content-Transfer-Encoding: 7bit
Return-Path: <slemieux.tyco@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: slemieux.tyco@gmail.com
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

On Thu, 2016-06-16 at 23:27 +0200, Daniel Lezcano wrote:
> All the clocksource drivers's init function are now converted to return
> an error code. CLOCKSOURCE_OF_DECLARE is no longer used as well as the
> clksrc-of table.
> 
> Let's convert back the names:
>  - CLOCKSOURCE_OF_DECLARE_RET => CLOCKSOURCE_OF_DECLARE
>  - clksrc-of-ret              => clksrc-of
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arc/kernel/time.c                    |  6 +++---
>  arch/arm/kernel/smp_twd.c                 |  6 +++---
>  arch/microblaze/kernel/timer.c            |  2 +-
>  arch/mips/ralink/cevt-rt3352.c            |  2 +-
>  arch/nios2/kernel/time.c                  |  2 +-
>  drivers/clocksource/arm_arch_timer.c      |  6 +++---
>  drivers/clocksource/arm_global_timer.c    |  2 +-
>  drivers/clocksource/armv7m_systick.c      |  2 +-
>  drivers/clocksource/asm9260_timer.c       |  2 +-
>  drivers/clocksource/bcm2835_timer.c       |  2 +-
>  drivers/clocksource/bcm_kona_timer.c      |  4 ++--
>  drivers/clocksource/cadence_ttc_timer.c   |  2 +-
>  drivers/clocksource/clksrc-dbx500-prcmu.c |  2 +-
>  drivers/clocksource/clksrc-probe.c        | 14 --------------
>  drivers/clocksource/clksrc_st_lpc.c       |  2 +-
>  drivers/clocksource/clps711x-timer.c      |  2 +-
>  drivers/clocksource/dw_apb_timer_of.c     |  8 ++++----
>  drivers/clocksource/exynos_mct.c          |  4 ++--
>  drivers/clocksource/fsl_ftm_timer.c       |  2 +-
>  drivers/clocksource/h8300_timer16.c       |  2 +-
>  drivers/clocksource/h8300_timer8.c        |  2 +-
>  drivers/clocksource/h8300_tpu.c           |  2 +-
>  drivers/clocksource/meson6_timer.c        |  2 +-
>  drivers/clocksource/mips-gic-timer.c      |  2 +-
>  drivers/clocksource/moxart_timer.c        |  2 +-
>  drivers/clocksource/mps2-timer.c          |  2 +-
>  drivers/clocksource/mtk_timer.c           |  2 +-
>  drivers/clocksource/mxs_timer.c           |  2 +-
>  drivers/clocksource/nomadik-mtu.c         |  2 +-
>  drivers/clocksource/pxa_timer.c           |  2 +-
>  drivers/clocksource/qcom-timer.c          |  4 ++--
>  drivers/clocksource/rockchip_timer.c      |  8 ++++----
>  drivers/clocksource/samsung_pwm_timer.c   |  8 ++++----
>  drivers/clocksource/sun4i_timer.c         |  2 +-
>  drivers/clocksource/tango_xtal.c          |  2 +-
>  drivers/clocksource/tegra20_timer.c       |  4 ++--
>  drivers/clocksource/time-armada-370-xp.c  |  6 +++---
>  drivers/clocksource/time-efm32.c          |  4 ++--
>  drivers/clocksource/time-lpc32xx.c        |  2 +-
>  drivers/clocksource/time-orion.c          |  2 +-
>  drivers/clocksource/time-pistachio.c      |  2 +-
>  drivers/clocksource/timer-atlas7.c        |  2 +-
>  drivers/clocksource/timer-atmel-pit.c     |  2 +-
>  drivers/clocksource/timer-atmel-st.c      |  2 +-
>  drivers/clocksource/timer-digicolor.c     |  2 +-
>  drivers/clocksource/timer-imx-gpt.c       | 24 ++++++++++++------------
>  drivers/clocksource/timer-integrator-ap.c |  2 +-
>  drivers/clocksource/timer-keystone.c      |  2 +-
>  drivers/clocksource/timer-nps.c           |  4 ++--
>  drivers/clocksource/timer-oxnas-rps.c     |  4 ++--
>  drivers/clocksource/timer-prima2.c        |  2 +-
>  drivers/clocksource/timer-sp804.c         |  4 ++--
>  drivers/clocksource/timer-stm32.c         |  2 +-
>  drivers/clocksource/timer-sun5i.c         |  4 ++--
>  drivers/clocksource/timer-ti-32k.c        |  2 +-
>  drivers/clocksource/timer-u300.c          |  2 +-
>  drivers/clocksource/versatile.c           |  4 ++--
>  drivers/clocksource/vf_pit_timer.c        |  2 +-
>  drivers/clocksource/vt8500_timer.c        |  2 +-
>  drivers/clocksource/zevio-timer.c         |  2 +-
>  include/asm-generic/vmlinux.lds.h         |  2 --
>  include/linux/clocksource.h               |  5 +----
>  62 files changed, 98 insertions(+), 117 deletions(-)
> 
[..]

> diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
> index cb5b866..9649cfd 100644
> --- a/drivers/clocksource/time-lpc32xx.c
> +++ b/drivers/clocksource/time-lpc32xx.c
> @@ -311,4 +311,4 @@ static int __init lpc32xx_timer_init(struct device_node *np)
>  
>  	return ret;
>  }
> -CLOCKSOURCE_OF_DECLARE_RET(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);
> +CLOCKSOURCE_OF_DECLARE(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);

For LPC32xx driver:
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
