Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 10:48:29 +0200 (CEST)
Received: from mail-wm0-x236.google.com ([IPv6:2a00:1450:400c:c09::236]:37301
        "EHLO mail-wm0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993009AbdE2IsVEDAQH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2017 10:48:21 +0200
Received: by mail-wm0-x236.google.com with SMTP id d127so49751666wmf.0
        for <linux-mips@linux-mips.org>; Mon, 29 May 2017 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7tqql2MnZiI9NmTGLxNtZ74cnoEXNq+3EvJRDXfkhYk=;
        b=QmYa2J0BIhlpyLwLwD7gajUdWsjN8orglmu0PwXjfzu8tcBDjUWeEYqsgG7viFWLrI
         QXSgDbGSn+kI5udt5x27j6xArxWiyhBikPVmdd8zW2/UePj1hhsWrLrFmRWdh4lJXXrJ
         KQ9RzksccKWAmIM4Vg+P09PinRpd/lBIO+7jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7tqql2MnZiI9NmTGLxNtZ74cnoEXNq+3EvJRDXfkhYk=;
        b=ZHq0/hxjAzPSF7+b39772aP/sNraYqnY1q7fW7Qwur2JEeuJb2BQseekMcGn3c9wKg
         OG4rjgpVsa7WMC189c5LM+h2kn1n0WH/F2QuEj3Tcq3tdayEuwRQ2zeTz6DpVz26tU3N
         d1ma0eXBTiEUsUrgMI/5dbR+BcBVKA7G3Lf6KtF1hBk3eQw61Tuqb3lnLqp3dpGr0sdO
         f65WsaYNhlnI+/q1EnFYY2n+bMGe+eI4h9KlVy9M91B6IFSKZCySGfvfwjGGzghwfeU0
         1khPbLLkliAVZxB7Pn5mZe22hWcra3Ju9cIVMZ6/O/4sf/bzl2tgT5sehviDmwCc1+x0
         VNTA==
X-Gm-Message-State: AODbwcBDZLkLHCC69u5QEfZJvMVblpgmoEHkvG8aDzdz2gI8ooYgVQww
        utUQxVedoOsw35zz
X-Received: by 10.28.111.7 with SMTP id k7mr10184919wmc.50.1496047695121;
        Mon, 29 May 2017 01:48:15 -0700 (PDT)
Received: from mai ([2a01:e35:879a:6cd0:3e97:eff:fe5b:1402])
        by smtp.gmail.com with ESMTPSA id x17sm5351302wrd.63.2017.05.29.01.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 May 2017 01:48:14 -0700 (PDT)
Date:   Mon, 29 May 2017 10:48:09 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
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
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
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
Subject: Re: [PATCH 2/7] clocksource: Rename CLOCKSOURCE_OF_DECLARE
Message-ID: <20170529084809.GA2192@mai>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
 <CAK8P3a3QACHYqtCO1z_FpW0nXEtx356wCDha_=SNXU872=q1UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a3QACHYqtCO1z_FpW0nXEtx356wCDha_=SNXU872=q1UQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On Mon, May 29, 2017 at 10:41:52AM +0200, Arnd Bergmann wrote:
> On Sat, May 27, 2017 at 11:58 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > The CLOCKSOUCE_OF_DECLARE macro is used widely for the timers to declare the
> > clocksource at early stage. However, this macro is also used to initialize
> > the clockevent if any, or the clockevent only.
> >
> > It was originally suggested to declare another macro to initialize a
> > clockevent, so in order to separate the two entities even they belong to the
> > same IP. This was not accepted because of the impact on the DT where splitting
> > a clocksource/clockevent definition does not make sense as it is a Linux
> > concept not a hardware description.
> >
> > On the other side, the clocksource has not interrupt declared while the
> > clockevent has, so it is easy from the driver to know if the description is
> > for a clockevent or a clocksource, IOW it could be implemented at the driver
> > level.
> >
> > So instead of dealing with a named clocksource macro, let's use a more generic
> > one: TIMER_OF_DECLARE.
> >
> > The patch has not functional changes.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Could you either leave the old name as an alias for one release, or introduce
> the new name as an alias now for 4.13?
> 
> I think that that would make it easier to merge new drivers. Otherwise this
> looks good to me,


New drivers should go through my tree, so I can catch them with the old macro
name and do the change.

> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the review.

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
