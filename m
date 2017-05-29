Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 10:42:07 +0200 (CEST)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:32772
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990601AbdE2Il67LiVH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2017 10:41:58 +0200
Received: by mail-oi0-x244.google.com with SMTP id h4so10526916oib.0;
        Mon, 29 May 2017 01:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tW6jST3FBpzuZJ0dqVxQfY9fCZz5YG7eBy5TxFRkxHw=;
        b=FhMa6dyYTrMJbPzYDn7+n3p4b6ALKqhtN0OXw2CdS8FGKB8AuXgHXtqf1/6JLEp0Ox
         fqcMZQqiJsHQPUkMLCvPTo7mbRWt8WdLuw879NKbQREMSCET7Svd7tMbJJcErRCHTgDA
         dY8oxyCRdnEX7O7McB6QZ/gGQyMkf8Sy/XoWhPXNGWw0HMCliWEY9crOuU7DlTrvGvSg
         xfGeKO+Hh5hl/Th5f4eJY475/8kbTfkr9xKx2FbPuMJkuYezhPG3auqaADZVKTsTXVmd
         PI/X/74GxeoxjBOWYPHAGkJTQaDEjSRxcX6ul2cXuKscB2y/o4/OP49jTnsP5s80Lk3d
         Jy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tW6jST3FBpzuZJ0dqVxQfY9fCZz5YG7eBy5TxFRkxHw=;
        b=AuSyU6YKAoprzIFoOw80woydJzVo8RKoD0BcZI3rVwWUmCK9jzM1y+jN+LR3LE39AC
         BQN1vbfCTUVP2SpDGo9VD8kanw27i5SjaOb+kyQYfvGdjQ/bMJsghJ5kQiFxUIKiiZZX
         oe8ENFjitlCTmqnTv5kbyqf55LzCodVQ3ilhk8f1UCFVl6LrlEl4gBLl+XUeryABNtq2
         fJDO6i9iMOPre48/13MrS4OlbJ+ogCHZXeKE4YbfzT8pR5Bhfk3y4S5zcC4gdquhrGzm
         NtkijOYKNNPrkmWHsDFdoz+7/9z4k/9rRwzA47JgheqkgxMAr6qapnNOP4Dnt5g/PY41
         miuw==
X-Gm-Message-State: AODbwcBi3AHG40XnNtaAYhL0qAj2jsPDU0NHYHIgbb0gefHf/CprstWP
        CCzbfCBSJKss9ZrDT9mRdgwy1icVWQ==
X-Received: by 10.202.204.198 with SMTP id c189mr6839964oig.71.1496047313107;
 Mon, 29 May 2017 01:41:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.66.2 with HTTP; Mon, 29 May 2017 01:41:52 -0700 (PDT)
In-Reply-To: <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org> <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 May 2017 10:41:52 +0200
X-Google-Sender-Auth: OFtBhtgOH_llattBDJwf-4rVcHg
Message-ID: <CAK8P3a3QACHYqtCO1z_FpW0nXEtx356wCDha_=SNXU872=q1UQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] clocksource: Rename CLOCKSOURCE_OF_DECLARE
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
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
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
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
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

Could you either leave the old name as an alias for one release, or introduce
the new name as an alias now for 4.13?

I think that that would make it easier to merge new drivers. Otherwise this
looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
