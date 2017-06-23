Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 05:57:14 +0200 (CEST)
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:58308 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990864AbdFWD5FcQeT1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 05:57:05 +0200
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com [209.85.223.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id B0CCC20759;
        Fri, 23 Jun 2017 11:57:00 +0800 (CST)
Received: by mail-io0-f182.google.com with SMTP id c201so33777373ioe.1;
        Thu, 22 Jun 2017 20:57:00 -0700 (PDT)
X-Gm-Message-State: AKS2vOwDSJP/Wo3/jGmW5gm3ZqHnAopjK4qiT06HCpf55un7Ram6cIWe
        sKWuiBO8/auBNxkIRaVG3ilnYL2y5g==
X-Received: by 10.107.189.68 with SMTP id n65mr6140561iof.223.1498190218765;
 Thu, 22 Jun 2017 20:56:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.29.144 with HTTP; Thu, 22 Jun 2017 20:56:38 -0700 (PDT)
In-Reply-To: <1497443984-12371-13-git-send-email-daniel.lezcano@linaro.org>
References: <20170614123800.GH2261@mai> <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
 <1497443984-12371-13-git-send-email-daniel.lezcano@linaro.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 23 Jun 2017 11:56:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v65PAg3twJnLmre6MkBoRj7UP_BD0UJf_g2ZttLQX+gpJw@mail.gmail.com>
Message-ID: <CAGb2v65PAg3twJnLmre6MkBoRj7UP_BD0UJf_g2ZttLQX+gpJw@mail.gmail.com>
Subject: Re: [PATCH 13/23] clocksource/drivers: Rename clocksource_probe to timer_probe
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <james.hartley@imgtec.com>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        John Crispin <john@phrozen.org>,
        Ley Foon Tan <lftan@altera.com>,
        Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Vlad Zakharov <Vladislav.Zakharov@synopsys.com>,
        Rob Herring <robh@kernel.org>, Noam Camus <noamc@ezchip.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        "open list:SYNOPSYS ARC ARCH..." <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:OMAP2+ SUPPORT" <linux-omap@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:TENSILICA XTENSA..." <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <wens@csie.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wens@csie.org
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

On Wed, Jun 14, 2017 at 8:39 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The function name is now renamed to 'timer_probe' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arc/kernel/setup.c                  |  2 +-
>  arch/arm/kernel/time.c                   |  2 +-
>  arch/arm/mach-mediatek/mediatek.c        |  2 +-
>  arch/arm/mach-omap2/timer.c              | 10 +++++-----
>  arch/arm/mach-rockchip/rockchip.c        |  2 +-
>  arch/arm/mach-shmobile/setup-rcar-gen2.c |  2 +-
>  arch/arm/mach-spear/spear13xx.c          |  2 +-
>  arch/arm/mach-sunxi/sunxi.c              |  2 +-

Acked-by: Chen-Yu Tsai <wens@csie.org>
