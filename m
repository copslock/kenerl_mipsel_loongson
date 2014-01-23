Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2014 08:45:19 +0100 (CET)
Received: from cassarossa.samfundet.no ([193.35.52.29]:47480 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825865AbaAWHpGzHswr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jan 2014 08:45:06 +0100
Received: from egtvedt by cassarossa.samfundet.no with local (Exim 4.80)
        (envelope-from <egtvedt@samfundet.no>)
        id 1W6EtN-0001Hn-JU; Thu, 23 Jan 2014 08:40:01 +0100
Date:   Thu, 23 Jan 2014 08:40:01 +0100
From:   Hans-Christian Egtvedt <egtvedt@samfundet.no>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Russell King <linux@arm.linux.org.uk>,
        David Brown <davidb@codeaurora.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Barry Song <baohua@kernel.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        davinci-linux-open-source@linux.davincidsp.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linux@lists.openrisc.net, linuxppc-dev@lists.ozlabs.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions void
Message-ID: <20140123074001.GA3080@samfundet.no>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <egtvedt@samfundet.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: egtvedt@samfundet.no
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

Around Thu 23 Jan 2014 15:12:46 +0800 or thereabout, Yijing Wang wrote:
> Currently, clocksource_register() and __clocksource_register_scale()
> functions always return 0, it's pointless, make functions void.
> And remove the dead code that check the clocksource_register_hz()
> return value.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

For the avr32 related change

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/arm/mach-davinci/time.c                    |    5 ++---
>  arch/arm/mach-msm/timer.c                       |    4 +---
>  arch/arm/mach-omap2/timer.c                     |    8 +++-----
>  arch/avr32/kernel/time.c                        |    4 +---
>  arch/blackfin/kernel/time-ts.c                  |    6 ++----
>  arch/microblaze/kernel/timer.c                  |    3 +--
>  arch/mips/jz4740/time.c                         |    6 +-----
>  arch/mips/loongson/common/cs5536/cs5536_mfgpt.c |    3 ++-
>  arch/openrisc/kernel/time.c                     |    3 +--
>  arch/powerpc/kernel/time.c                      |    6 +-----
>  arch/um/kernel/time.c                           |    6 +-----
>  arch/x86/platform/uv/uv_time.c                  |   14 ++++++--------
>  drivers/clocksource/acpi_pm.c                   |    3 ++-
>  drivers/clocksource/cadence_ttc_timer.c         |    6 +-----
>  drivers/clocksource/exynos_mct.c                |    4 +---
>  drivers/clocksource/i8253.c                     |    3 ++-
>  drivers/clocksource/mmio.c                      |    3 ++-
>  drivers/clocksource/samsung_pwm_timer.c         |    5 +----
>  drivers/clocksource/scx200_hrt.c                |    3 ++-
>  drivers/clocksource/tcb_clksrc.c                |    8 +-------
>  drivers/clocksource/timer-marco.c               |    2 +-
>  drivers/clocksource/timer-prima2.c              |    2 +-
>  drivers/clocksource/vt8500_timer.c              |    4 +---
>  include/linux/clocksource.h                     |    8 ++++----
>  kernel/time/clocksource.c                       |    6 ++----
>  kernel/time/jiffies.c                           |    3 ++-
>  26 files changed, 45 insertions(+), 83 deletions(-)

<snipp diffs>

-- 
HcE
