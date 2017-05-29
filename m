Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 11:57:40 +0200 (CEST)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:33115
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990601AbdE2J5cIweHw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2017 11:57:32 +0200
Received: by mail-oi0-x242.google.com with SMTP id h4so10751040oib.0;
        Mon, 29 May 2017 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Myq9VL35BzkDgs9QDZ1D0nHai8PhbjB4jHqw9q6ozzI=;
        b=QylriQ1pnnzKfhhB51LBvHuWFZlPcxKe/F97D7kbOepTBQm6w4RpR015VApmheX7zZ
         Kkv7nABFEARpmtvfL7yHenzI/pCcsCQI+KXHMIMinkwt80EK4NOcYssDfQMM5a+E4fJM
         9HcUq4fKEU+vyN7umTOWpjQKIA0N/yUv6K4wxxrTW8AvOJp1TmcNWZZNrLvG1vwfN9v9
         1bl+jSLI9KPfiGExwcxDfmoPQo75dFaesEnhuKkGehwxDW6EcMbt5CfFGvzD3uEdQTn9
         tu7OeGDIXg9USr6RemL6i2mbB/4/pKXWUkyE/GNMkTmDGbN93eGoHdzJlY0rV6aOedGr
         X7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Myq9VL35BzkDgs9QDZ1D0nHai8PhbjB4jHqw9q6ozzI=;
        b=B2CfkFx8IMxOrdOkJOTAQWmornR7enNXdrSNBuAe1/3V0ghzKTAJuSjVPRjWZ54ZO1
         ehYhFRMRSBseL0/eVJ+vUSlo2tzTCTrNegJolSo9rfdjyu8nRJ6OXgpFidzA2zAo/XiH
         GC9uwZ181EtculxjYor6JQtoeM/s1/d6CqZARSnlHECs+1uI+fHyesm4w06EyRecH3ub
         5uk06yVG85VbcwikY9ysloDMtXDmrUbnBeNPk/tGWqseUWOxIGcaXX8QDpGKScHfm55v
         Qk27fQnHnpnLACcBbd1UN7Jtq5Syw3xuOYdaTLHtYwgKxdhzbhS8yyDhuJ7r5E0vaP6Z
         P1Tg==
X-Gm-Message-State: AODbwcD61GdSffQkCCmpsrniqv082ilvEYCn6GXbVJiWfs00+QVJiITy
        eKFjqtyL4Npc4+Y96S/xD8UQVMOpvg==
X-Received: by 10.157.31.71 with SMTP id x7mr7723041otx.217.1496051845972;
 Mon, 29 May 2017 02:57:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.66.2 with HTTP; Mon, 29 May 2017 02:57:25 -0700 (PDT)
In-Reply-To: <20170529084809.GA2192@mai>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
 <CAK8P3a3QACHYqtCO1z_FpW0nXEtx356wCDha_=SNXU872=q1UQ@mail.gmail.com> <20170529084809.GA2192@mai>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 May 2017 11:57:25 +0200
X-Google-Sender-Auth: b4CD2GvFbP4jn4afZvvOvI9A0PI
Message-ID: <CAK8P3a1Kv_RhKL43ie6co_N5pDXvRHd7Uq8g70qt80WkxuhzLw@mail.gmail.com>
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
X-archive-position: 58063
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

On Mon, May 29, 2017 at 10:48 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On Mon, May 29, 2017 at 10:41:52AM +0200, Arnd Bergmann wrote:
>> On Sat, May 27, 2017 at 11:58 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>> > The CLOCKSOUCE_OF_DECLARE macro is used widely for the timers to declare the
>> > clocksource at early stage. However, this macro is also used to initialize
>> > the clockevent if any, or the clockevent only.
>> >
>> > It was originally suggested to declare another macro to initialize a
>> > clockevent, so in order to separate the two entities even they belong to the
>> > same IP. This was not accepted because of the impact on the DT where splitting
>> > a clocksource/clockevent definition does not make sense as it is a Linux
>> > concept not a hardware description.
>> >
>> > On the other side, the clocksource has not interrupt declared while the
>> > clockevent has, so it is easy from the driver to know if the description is
>> > for a clockevent or a clocksource, IOW it could be implemented at the driver
>> > level.
>> >
>> > So instead of dealing with a named clocksource macro, let's use a more generic
>> > one: TIMER_OF_DECLARE.
>> >
>> > The patch has not functional changes.
>> >
>> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Could you either leave the old name as an alias for one release, or introduce
>> the new name as an alias now for 4.13?
>>
>> I think that that would make it easier to merge new drivers. Otherwise this
>> looks good to me,
>
>
> New drivers should go through my tree, so I can catch them with the old macro
> name and do the change.

Sure, they should, and it's quite likely that you won't even need the fallback,
I've just seen too many cases where a similar assumption turned out wrong,
that I'd just pick the safer option just in case whenever I do an API change.

Things that could go wrong include:

- A platform maintainer wants to add a new platform and has a for-next
  branch that gets merged into linux-next, with parts of it going through
  different maintainers, and now they have to choose between a branch
  that doesn't build without the timer branch, or one that break for-next
  unless Stephen applies a fixup

- Some architecture maintainer didn't get the memo and adds an instance of
  CLOCKSOUCE_OF_DECLARE in architecture specific code without asking
  having the patch reviewed first

- A platform has a branch with complex cross-tree dependencies and
  it need to get merged in an unconventional way.

- You make a mistake and accidentally merge one driver for an unusual
  architecture that escapes your test matrix.

While those all are unlikely to happen in a particular merge window, they do
happen occasionally and tend to cause a lot of pain.

       Arnd
