Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2016 09:45:00 +0200 (CEST)
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60171 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27041677AbcFTHo6KaFlp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2016 09:44:58 +0200
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5K7di2p024211;
        Mon, 20 Jun 2016 09:43:31 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 23mw6dsb91-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 20 Jun 2016 09:43:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C676B38;
        Mon, 20 Jun 2016 07:43:27 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F7821235;
        Mon, 20 Jun 2016 07:43:26 +0000 (GMT)
Received: from [10.48.1.66] (10.48.1.66) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.279.2; Mon, 20 Jun 2016 09:43:26
 +0200
Subject: Re: [PATCH V2 63/63] clocksources: Switch back to the clksrc table
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Maxime Coquelin <maxime.coquelin@st.com>,
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
From:   Patrice Chotard <patrice.chotard@st.com>
Message-ID: <57679E99.6090607@st.com>
Date:   Mon, 20 Jun 2016 09:43:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.1.66]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-06-20_05:,,
 signatures=0
Return-Path: <patrice.chotard@st.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: patrice.chotard@st.com
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
>   - CLOCKSOURCE_OF_DECLARE_RET => CLOCKSOURCE_OF_DECLARE
>   - clksrc-of-ret              => clksrc-of
>
>
>   drivers/clocksource/clksrc_st_lpc.c       |  2 +-
> diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
> index c9022a9..03cc492 100644
> --- a/drivers/clocksource/clksrc_st_lpc.c
> +++ b/drivers/clocksource/clksrc_st_lpc.c
> @@ -132,4 +132,4 @@ static int __init st_clksrc_of_register(struct device_node *np)
>   
>   	return ret;
>   }
> -CLOCKSOURCE_OF_DECLARE_RET(ddata, "st,stih407-lpc", st_clksrc_of_register);
> +CLOCKSOURCE_OF_DECLARE(ddata, "st,stih407-lpc", st_clksrc_of_register);
>


For STi :

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
