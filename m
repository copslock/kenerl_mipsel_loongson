Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2015 15:02:52 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:48929 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009829AbbJLNCuF7PS4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Oct 2015 15:02:50 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 14B0B47BB; Mon, 12 Oct 2015 15:02:43 +0200 (CEST)
Received: from localhost (81-67-231-93.rev.numericable.fr [81.67.231.93])
        by mail.free-electrons.com (Postfix) with ESMTPSA id CC1F12C1;
        Mon, 12 Oct 2015 15:02:42 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@free-electrons.com>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Russell King <linux@arm.linux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Maxime Coquelin <maxime.coquelin@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
        =?utf-8?Q?S=C3=B6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Carlo Caione <carlo@caione.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Barry Song <baohua@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org,
        kernel@stlinux.com, linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] sched_clock: add data pointer argument to read callback
References: <1444427858-576-1-git-send-email-mans@mansr.com>
Date:   Mon, 12 Oct 2015 15:02:42 +0200
In-Reply-To: <1444427858-576-1-git-send-email-mans@mansr.com> (Mans Rullgard's
        message of "Fri, 9 Oct 2015 22:57:35 +0100")
Message-ID: <87io6c6xzh.fsf@free-electrons.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <gregory.clement@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.clement@free-electrons.com
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

Hi Mans,
 
 On ven., oct. 09 2015, Mans Rullgard <mans@mansr.com> wrote:

> This passes a data pointer specified in the sched_clock_register()
> call to the read callback allowing simpler implementations thereof.
>
> In this patch, existing uses of this interface are simply updated
> with a null pointer.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
[...]
> diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> index 2162796..a13b73b 100644
> --- a/drivers/clocksource/time-armada-370-xp.c
> +++ b/drivers/clocksource/time-armada-370-xp.c
> @@ -92,7 +92,7 @@ static void local_timer_ctrl_clrset(u32 clr, u32 set)
>  		local_base + TIMER_CTRL_OFF);
>  }
>  
> -static u64 notrace armada_370_xp_read_sched_clock(void)
> +static u64 notrace armada_370_xp_read_sched_clock(void *data)
>  {
>  	return ~readl(timer_base + TIMER0_VAL_OFF);
>  }
> @@ -290,7 +290,8 @@ static void __init armada_370_xp_timer_common_init(struct device_node *np)
>  	/*
>  	 * Set scale and timer for sched_clock.
>  	 */
> -	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk);
> +	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk,
> +			     NULL);
>  
>  	clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
>  			      "armada_370_xp_clocksource",

For the time-armada-370-xp.c file:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
