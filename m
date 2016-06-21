Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2016 08:00:48 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34825 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27043322AbcFUGApmLWm- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2016 08:00:45 +0200
Received: by mail-pa0-f47.google.com with SMTP id hl6so2953658pac.2
        for <linux-mips@linux-mips.org>; Mon, 20 Jun 2016 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=w1TMntwuk5yHHhTkUXZGPOTw/dA7N0xu4FRSrDD86CQ=;
        b=KJ8mMnOBIsZKia2yNXGbwFn4eZ0uGiTgL/Z1lUX6OJptXT6r9hJovmFi+h7ijjQnBw
         eE0eN1KAU/6wdsWmwLqWqDYJhnVjN0IPlYr0FzaxRLa1g38nWHi1R5mIUHY1BpoZd5BP
         oUa+tqDhD9OX1ffW01kX5XuQnF/UmGqZLcWfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=w1TMntwuk5yHHhTkUXZGPOTw/dA7N0xu4FRSrDD86CQ=;
        b=RikYlhTrJyOhZnRlME0e1BxXrKM7T+8Oy1wNlnMxT0HWBLuATSkGIg/8BdNagXn0Xt
         0FRIGZB69iYDWAV/YUm+QfadzIvuCe3MXGLaGt9k6+nH4t4Z8mz1xnJ4hikw0sB5R6/c
         xKUG3QmlTt22mhffdXktY7frC96myYcHD7gPSMQnOC5An6II1xkw8xZZxHB0o9x+Q36X
         Q3gMnn5MHwQzNMTaOm6kyfAwHz0UMdkWABKBZjxzrzfHJN3bzOM+iorA4z6PDgfZpr27
         3zsVDvv1hsnMWZAy/YJOLZnL/cS+HlclMTY3YYhz2bLd6veY5I7qiBNp8rvfiEFhv6si
         +gyw==
X-Gm-Message-State: ALyK8tLDM9lJIaq2XF2ONUHE1UJroTYL8IiDYX4kMyVPVwE3Pb5tgq0Ae1BQfsLpIxUi6ItC
X-Received: by 10.66.155.167 with SMTP id vx7mr26283626pab.125.1466488839172;
        Mon, 20 Jun 2016 23:00:39 -0700 (PDT)
Received: from [10.136.8.236] ([216.31.219.19])
        by smtp.gmail.com with ESMTPSA id ab6sm22327858pad.44.2016.06.20.23.00.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Jun 2016 23:00:38 -0700 (PDT)
Subject: Re: [PATCH V2 63/63] clocksources: Switch back to the clksrc table
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
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
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
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
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <kernel@pengutronix.de>,
        Joachim Eastwood <manabian@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
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
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <35869d12-1686-98d3-185c-cedacbc7eed1@broadcom.com>
Date:   Mon, 20 Jun 2016 23:00:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ray.jui@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ray.jui@broadcom.com
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

Hi Daniel,

On 6/16/2016 2:27 PM, Daniel Lezcano wrote:
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

[..]

> diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
> index 98bc2a2..ee07e7e3 100644
> --- a/drivers/clocksource/bcm_kona_timer.c
> +++ b/drivers/clocksource/bcm_kona_timer.c
> @@ -200,9 +200,9 @@ static int __init kona_timer_init(struct device_node *node)
>  	return 0;
>  }
>
> -CLOCKSOURCE_OF_DECLARE_RET(brcm_kona, "brcm,kona-timer", kona_timer_init);
> +CLOCKSOURCE_OF_DECLARE(brcm_kona, "brcm,kona-timer", kona_timer_init);
>  /*
>   * bcm,kona-timer is deprecated by brcm,kona-timer
>   * being kept here for driver compatibility
>   */
> -CLOCKSOURCE_OF_DECLARE_RET(bcm_kona, "bcm,kona-timer", kona_timer_init);
> +CLOCKSOURCE_OF_DECLARE(bcm_kona, "bcm,kona-timer", kona_timer_init);

For Broadcom Kona timer change:

Acked-by: Ray Jui <ray.jui@broadcom.com>

Thanks!

Ray
