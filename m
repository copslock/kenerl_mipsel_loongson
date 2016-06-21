Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2016 08:46:14 +0200 (CEST)
Received: from mail-am1on0076.outbound.protection.outlook.com ([157.56.112.76]:43552
        "EHLO emea01-am1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27043322AbcFUGqGGdfUh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2016 08:46:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ea62DiC5WEJ7ZyraWuOLJvok42HdQsAjC7+jLMyUlvs=;
 b=iF+nwAcQOMm8UaGt4A/u0IwFdml9ef9p9Oh42V1BjsE0Nedb6EAhKRgBCcTC1UAcwbAhhDqftfta9B9VzwDJp7t5+OJNyDIe3HsBG0/fVmGzWrAqvOgeouc2jEyaFf1jdSVJpudB6kc8yFTbVQtHAMZ567YduSFAK2Zc2JMiv6Y=
Received: from HE1PR05MB1625.eurprd05.prod.outlook.com (10.169.119.139) by
 HE1PR05MB1625.eurprd05.prod.outlook.com (10.169.119.139) with Microsoft SMTP
 Server (TLS) id 15.1.523.12; Tue, 21 Jun 2016 06:45:59 +0000
Received: from HE1PR05MB1625.eurprd05.prod.outlook.com ([10.169.119.139]) by
 HE1PR05MB1625.eurprd05.prod.outlook.com ([10.169.119.139]) with mapi id
 15.01.0523.015; Tue, 21 Jun 2016 06:45:59 +0000
From:   Noam Camus <noamca@mellanox.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vineet Gupta" <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        "Michal Simek" <monstr@monstr.eu>, John Crispin <john@phrozen.org>,
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
        S?ren Brinkmann <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        "Krzysztof Kozlowski" <k.kozlowski@samsung.com>,
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
        Uwe Kleine-K?nig <kernel@pengutronix.de>,
        "Joachim Eastwood" <manabian@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "Sylvain Lemieux" <slemieux.tyco@gmail.com>,
        Barry Song <baohua@kernel.org>,
        "Baruch Siach" <baruch@tkos.co.il>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        "Arnd Bergmann" <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Felipe Balbi" <balbi@ti.com>,
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
Subject: RE: [PATCH V2 63/63] clocksources: Switch back to the clksrc table
Thread-Topic: [PATCH V2 63/63] clocksources: Switch back to the clksrc table
Thread-Index: AQHRyBY5mwQtw3ZLtkyctDwy1gbbZp/zfjVQ
Date:   Tue, 21 Jun 2016 06:45:58 +0000
Message-ID: <HE1PR05MB162581196C0157F45749344FAA2B0@HE1PR05MB1625.eurprd05.prod.outlook.com>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noamca@mellanox.com; 
x-originating-ip: [212.179.42.66]
x-ms-office365-filtering-correlation-id: 24f6145e-558d-43f1-f5e7-08d3999fb442
x-microsoft-exchange-diagnostics: 1;HE1PR05MB1625;6:6zmaz2BWI0bZUrEiH6f6DpIx5ByaP7tuspipjNfeQf+ovqGKjmB+WpcSr/WLL26etlcT96G3fcIkJzzKo+OrGD6kS1jIaF43ak/krE18bE9kO4ClYova860JQeoLt1acmIJwBxb9L+ZPkUDqD5/MOPH0tqs6ivvY1+RITYVhHZSnGlcLVqYD10rtrbXTJPSDwiCdA17IITuaOM8lvPxVYF538cQ5c2A71sLwXSusflcnQkCqYuZXy2BKFokWeKOYyWP51tsWBPqRMJgdLpQ26ZHxQGdjUAcfS+58Js8LgeBbydovBU4Jx9HDKyP/lcOnXfj6+Jfb7NPz0nmgLjqioA==;5:x08suStRwCHzg9WjIrembtYLYawnRP05o0KIdLZCYbhQeCa7dFL5kvchXKKq4y822SPgK28PLBzuo788Kzzmja694P7HBnUcSBOBlBSRGq1/AzuhECbugmc7i3O8Kwv9cYahxHsNwBgxWqICmPnJkA==;24:yf5kUwPZBjLUgnmdwcyUbxiZwWEJhKDcNHzl7dHU+CmOrDzsJ1hf9dQQoiNOobqwxm4RNT4meJoIOI7OQyMI3/WEhxS5fxC7oDAYedMTg2w=;7:eFPp7M6779hC8hfW6c5lhy1Jiha/sbNInNPEgV0WVZR3PFELb7zkohL3i8y1+w8S8lcPtlyws6d57iB1rIRzT3cPBbVJOag0MJlg3pkkigF4LYJFQZLBljfTgsn9jsUxlTuao+EQtqwGzcf0ToR6k98pSeED+L3iUFTMvWOU4GxrGMMViN1FJ86L6A8kvKSUtBkGhjdddYqf8r8M/ynmXpB01IUrIB38FeOp1S8WDBKhy4VRaGwxFsleitg+GPgv
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB1625;
x-microsoft-antispam-prvs: <HE1PR05MB1625867E5ED976F8A525ED46AA2B0@HE1PR05MB1625.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6055026);SRVR:HE1PR05MB1625;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB1625;
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(7916002)(199003)(377454003)(189002)(81156014)(50986999)(189998001)(97736004)(8936002)(5002640100001)(54356999)(19580395003)(101416001)(106116001)(4326007)(81166006)(7736002)(5003600100003)(76176999)(76576001)(8676002)(11100500001)(122556002)(2906002)(106356001)(105586002)(92566002)(5001770100001)(19580405001)(2950100001)(10400500002)(9686002)(3660700001)(3280700002)(2900100001)(87936001)(33656002)(77096005)(8666005)(7846002)(74316001)(2501003)(102836003)(86362001)(6116002)(3846002)(7696003)(66066001)(586003)(68736007)(7059030)(40753002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB1625;H:HE1PR05MB1625.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2016 06:45:59.0897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB1625
Return-Path: <noamca@mellanox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noamca@mellanox.com
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

>From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org] 
>Sent: Friday, June 17, 2016 12:27 AM

>All the clocksource drivers's init function are now converted to return an error code. CLOCKSOURCE_OF_DECLARE is no longer used as well as the clksrc-of table.

>Let's convert back the names:
> - CLOCKSOURCE_OF_DECLARE_RET => CLOCKSOURCE_OF_DECLARE
> - clksrc-of-ret              => clksrc-of

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> arch/arc/kernel/time.c                    |  6 +++---
> arch/arm/kernel/smp_twd.c                 |  6 +++---
> arch/microblaze/kernel/timer.c            |  2 +-
> arch/mips/ralink/cevt-rt3352.c            |  2 +-
> arch/nios2/kernel/time.c                  |  2 +-
> drivers/clocksource/arm_arch_timer.c      |  6 +++---
> drivers/clocksource/arm_global_timer.c    |  2 +-
> drivers/clocksource/armv7m_systick.c      |  2 +-
> drivers/clocksource/asm9260_timer.c       |  2 +-
> drivers/clocksource/bcm2835_timer.c       |  2 +-
> drivers/clocksource/bcm_kona_timer.c      |  4 ++--
> drivers/clocksource/cadence_ttc_timer.c   |  2 +-
> drivers/clocksource/clksrc-dbx500-prcmu.c |  2 +-
> drivers/clocksource/clksrc-probe.c        | 14 --------------
> drivers/clocksource/clksrc_st_lpc.c       |  2 +-
> drivers/clocksource/clps711x-timer.c      |  2 +-
> drivers/clocksource/dw_apb_timer_of.c     |  8 ++++----
> drivers/clocksource/exynos_mct.c          |  4 ++--
> drivers/clocksource/fsl_ftm_timer.c       |  2 +-
> drivers/clocksource/h8300_timer16.c       |  2 +-
> drivers/clocksource/h8300_timer8.c        |  2 +-
> drivers/clocksource/h8300_tpu.c           |  2 +-
> drivers/clocksource/meson6_timer.c        |  2 +-
> drivers/clocksource/mips-gic-timer.c      |  2 +-
> drivers/clocksource/moxart_timer.c        |  2 +-
> drivers/clocksource/mps2-timer.c          |  2 +-
> drivers/clocksource/mtk_timer.c           |  2 +-
> drivers/clocksource/mxs_timer.c           |  2 +-
> drivers/clocksource/nomadik-mtu.c         |  2 +-
> drivers/clocksource/pxa_timer.c           |  2 +-
> drivers/clocksource/qcom-timer.c          |  4 ++--
> drivers/clocksource/rockchip_timer.c      |  8 ++++----
> drivers/clocksource/samsung_pwm_timer.c   |  8 ++++----
> drivers/clocksource/sun4i_timer.c         |  2 +-
> drivers/clocksource/tango_xtal.c          |  2 +-
> drivers/clocksource/tegra20_timer.c       |  4 ++--
> drivers/clocksource/time-armada-370-xp.c  |  6 +++---
> drivers/clocksource/time-efm32.c          |  4 ++--
> drivers/clocksource/time-lpc32xx.c        |  2 +-
> drivers/clocksource/time-orion.c          |  2 +-
> drivers/clocksource/time-pistachio.c      |  2 +-
> drivers/clocksource/timer-atlas7.c        |  2 +-
> drivers/clocksource/timer-atmel-pit.c     |  2 +-
> drivers/clocksource/timer-atmel-st.c      |  2 +-
> drivers/clocksource/timer-digicolor.c     |  2 +-
> drivers/clocksource/timer-imx-gpt.c       | 24 ++++++++++++------------
> drivers/clocksource/timer-integrator-ap.c |  2 +-
> drivers/clocksource/timer-keystone.c      |  2 +-
> drivers/clocksource/timer-nps.c           |  4 ++--
> drivers/clocksource/timer-oxnas-rps.c     |  4 ++--
> drivers/clocksource/timer-prima2.c        |  2 +-
> drivers/clocksource/timer-sp804.c         |  4 ++--
> drivers/clocksource/timer-stm32.c         |  2 +-
> drivers/clocksource/timer-sun5i.c         |  4 ++--
> drivers/clocksource/timer-ti-32k.c        |  2 +-
> drivers/clocksource/timer-u300.c          |  2 +-
> drivers/clocksource/versatile.c           |  4 ++--
> drivers/clocksource/vf_pit_timer.c        |  2 +-
> drivers/clocksource/vt8500_timer.c        |  2 +-
> drivers/clocksource/zevio-timer.c         |  2 +-
> include/asm-generic/vmlinux.lds.h         |  2 --
> include/linux/clocksource.h               |  5 +----
> 62 files changed, 98 insertions(+), 117 deletions(-)

[..]

> diff --git a/drivers/clocksource/timer-nps.c b/drivers/clocksource/timer-nps.c index b5c7b2b..70c149a 100644
> --- a/drivers/clocksource/timer-nps.c
> +++ b/drivers/clocksource/timer-nps.c
> @@ -96,5 +96,5 @@ static int __init nps_timer_init(struct device_node *node)
> 	return nps_setup_clocksource(node, clk);  }
 
> -CLOCKSOURCE_OF_DECLARE_RET(ezchip_nps400_clksrc, "ezchip,nps400-timer",
> -			   nps_timer_init);
> +CLOCKSOURCE_OF_DECLARE(ezchip_nps400_clksrc, "ezchip,nps400-timer",
> +		       nps_timer_init);
> diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
> index 0d99f40..bd887e2 100644
> --- a/drivers/clocksource/timer-oxnas-rps.c
> +++ b/drivers/clocksource/timer-oxnas-rps.c
> @@ -293,5 +293,5 @@ err_alloc:
>  	return ret;
> }
 

Acked-by: Noam Camus <noamca@mellanox.com>
