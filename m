Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 10:37:14 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:61860 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27030556AbcFQIhL1Bscu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 10:37:11 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8W00JOZQLRRV10@mailout4.w1.samsung.com>; Fri,
 17 Jun 2016 09:37:04 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-22-5763b6af342b
Received: from eusync2.samsung.com ( [203.254.199.212])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id D5.93.04866.FA6B3675; Fri,
 17 Jun 2016 09:37:03 +0100 (BST)
Received: from [106.120.53.17] by eusync2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0O8W00613QLOPY30@eusync2.samsung.com>; Fri,
 17 Jun 2016 09:37:03 +0100 (BST)
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
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <5763B6AB.3010201@samsung.com>
Date:   Fri, 17 Jun 2016 10:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-version: 1.0
In-reply-to: <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbZRTG896P95bOmrsO5juIMWncXDDgGBpP1ExjYrzGmMzEOJVEV7sb
        2KCMtWNxxjhEPqTC6KpEdwfIhrWVwcDeDUqBrTSuG2OydUU+tIytgK18DDZlgyGbLY1x/z3n
        Ob/nnJzkKGi1FScqdubuFQ252hwNVjK99871pzS36rZtCnUqYdS2BZYtXg66Rw/AuKeCBvvA
        NANNFWcZuNbYTMPsD+UIav96FNyf+RHcvfEzB32TQQZanF+ycD84xcLFpRS4dKcdw1Q4DRqq
        2hmYG/KyUDk2RcNi6UkKnCVHGZgwBzB8/Y+Ngrojq+AL1zwDjrEBFvyuagz+z30IzFUWDm5d
        u0/Dod9bOPj20mkKigNNFJT9LWHwVHUhKPLbaXBbSxmYXgpz0DHYh2A5cA9DvamGBeugj4LC
        onQI9tZjOOXoomH8Zi8DnoMZYJImMEz3X+ag+vyvCMbsMxxc6XwcJg7LGG4cH0dgcSaCxWOA
        YafMQcnt9yEgyyzYLjgZmOwuYUB2VEXucdUyL70qFHeZsVA468VCY20jEvwDPlpYumtBwu15
        CyPMDhVzgjT6CxZMPQcpoSV4nBWmy/pYYdzhQ0K7NMIJ9Z1/UoKjoQwLgYFOvPWJ95Qv7BBz
        du4TDU9t2a7MCrurqbx+9UfeHyu5AhRWmVCcgvBPE+/CdTqm15LLV5uxCSkVat6KyGKTiYoV
        fyDivtnBRqk1/OvknHdyJRHPv0xah0+zMciEiPyTk4kWNO8nRA4NryQwn05k2/c4qlV8Muk5
        NrjiM/x6Un60ZkUn8O8QqW2BijGrycJXV5mojotss10PRXxFZGgqGfUlR22af4zIjTO0GfHS
        Awnpf0p6gKpDdANKEPN1ecYPM/WbU41avTE/NzNVt1vvQLHnnXciq/c5D+IVSPOQyp6g26Zm
        tfuM+/UeRBS0Jl61S45Yqh3a/R+Lht0fGPJzRKMHJSkYzSOqw67Zt9R8pnavmC2KeaLhvy6l
        iEssQNXxF7zPV3SUHvCeWTV3Khhyl2Qce/vI6uW2kfxsmy6uuM2/6EvTJ3fvmbPvejgpSzV/
        /hP1OvHZ9nefLNqY8spQRuX2N3PX3QltyJ45QShX6ybxSvf6mlttL468tufQxhO2xLqtv6nN
        Z8q/69dTOD2c3ePfIK19I/QNnrtY+MynBUlqDWPM0qYl0waj9l/j97wBuAMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

On 06/16/2016 11:27 PM, Daniel Lezcano wrote:
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

For exynos_mct and samsung_pwm_timer:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
