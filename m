Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 12:30:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64373 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992196AbdEaKaKJd0hE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 12:30:10 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 932F3D2753DC8;
        Wed, 31 May 2017 11:30:00 +0100 (IST)
Received: from [10.40.8.58] (10.40.8.58) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 31 May
 2017 11:30:03 +0100
Subject: Re: [PATCH 3/7] clocksource: Rename clocksource_probe
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-3-git-send-email-daniel.lezcano@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        John Crispin <john@phrozen.org>,
        Ley Foon Tan <lftan@altera.com>,
        Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Noam Camus <noamc@ezchip.com>, Rob Herring <robh@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Paul Burton <paul.burton@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Eric Anholt <eric@anholt.net>, Ray Jui <ray.jui@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OMAP2+ SUPPORT" <linux-omap@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "open list:ARM/SHMOBILE ARM ARCHITECTURE" 
        <linux-renesas-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
From:   James Hartley <james.hartley@imgtec.com>
Message-ID: <a974f62d-5a3c-629c-7e80-b45ba34f44dc@imgtec.com>
Date:   Wed, 31 May 2017 11:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1495879129-28109-3-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.8.58]
Return-Path: <James.Hartley@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hartley@imgtec.com
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



On 27/05/17 10:58, Daniel Lezcano wrote:
> The function name is now renamed to 'timer_probe' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arc/kernel/setup.c                  |  2 +-
>  arch/arm/kernel/time.c                   |  2 +-
>  arch/arm/mach-mediatek/mediatek.c        |  2 +-
>  arch/arm/mach-omap2/timer.c              | 10 +++++-----
>  arch/arm/mach-rockchip/rockchip.c        |  2 +-
>  arch/arm/mach-shmobile/setup-rcar-gen2.c |  2 +-
>  arch/arm/mach-spear/spear13xx.c          |  2 +-
>  arch/arm/mach-sunxi/sunxi.c              |  2 +-
>  arch/arm/mach-u300/core.c                |  2 +-
>  arch/arm/mach-zynq/common.c              |  2 +-
>  arch/arm64/kernel/time.c                 |  2 +-
>  arch/h8300/kernel/setup.c                |  2 +-
>  arch/microblaze/kernel/setup.c           |  2 +-
>  arch/mips/generic/init.c                 |  2 +-
>  arch/mips/mti-malta/malta-time.c         |  2 +-
>  arch/mips/pic32/pic32mzda/time.c         |  2 +-
>  arch/mips/pistachio/time.c               |  2 +-
>  arch/mips/ralink/clk.c                   |  2 +-
>  arch/mips/ralink/timer-gic.c             |  2 +-
>  arch/mips/xilfpga/time.c                 |  2 +-
>  arch/nios2/kernel/time.c                 |  2 +-
>  arch/sh/boards/of-generic.c              |  2 +-
>  arch/xtensa/kernel/time.c                |  2 +-
>  drivers/clocksource/clksrc-probe.c       |  2 +-
>  include/linux/clocksource.h              |  4 ++--
>  25 files changed, 30 insertions(+), 30 deletions(-)
>
>
For pistachio:

Acked-by: James Hartley <james.hartley@imgtec.com>

Thanks,
James.
