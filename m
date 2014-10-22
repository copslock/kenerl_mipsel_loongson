Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 13:03:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60306 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012094AbaJVLDZLUDKt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 13:03:25 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9D979329C5926;
        Wed, 22 Oct 2014 12:03:15 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 22 Oct
 2014 12:03:17 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 22 Oct 2014 12:03:17 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 22 Oct
 2014 12:03:16 +0100
Message-ID: <54478EF4.7050909@imgtec.com>
Date:   Wed, 22 Oct 2014 12:03:16 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Paul Burton <paul.burton@imgtec.com>,
        "John Crispin" <blogic@openwrt.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/19] MIPS GIC cleanup, part 2
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

On 10/20/2014 08:03 PM, Andrew Bresticker wrote:
> Second round of cleanups for the MIPS GIC drivers:
>   - Patches 1 through 5 get rid of the ugly REG() macros and instead use
>     proper iomem accessors.
>   - Patches 6 and 7 move the GIC header to linux/irqchip/ and clean it up.
>   - Patches 8 through 10 are misc. GIC irqchip cleanups.
>   - Patches 11 and 12 combine the GIC clocksource and clockevent drivers and
>     move them to drivers/clocksource/.
>   - Patches 13 through 19 are various cleanups for the GIC clocksource driver.
>
> Boot tested on Malta and (with additional out-of-tree patches) a platform
> based on the IMG Pistachio SoC.  Build tested for SEAD-3.

I used your github tree to boot test this on sead3 and it worked fine.

Except for the one comment I had, feel free to add my 
tested-and-reviewed by.

Nice work :)

Qais

> Based on 3.18-rc1 + part 1 of my GIC cleanup series [0].  A tree with both
> series is available at:
>    https://github.com/abrestic/linux/commits/mips-gic-cleanup-pt2-v1
>
> [0] https://lkml.org/lkml/2014/9/18/487
>
> Andrew Bresticker (19):
>    MIPS: Malta: Use gic_read_count() to read GIC timer
>    irqchip: mips-gic: Export function to read counter width
>    MIPS: sead3: Stop using GIC REG macros
>    MIPS: Malta: Stop using GIC REG macros
>    irqchip: mips-gic: Use proper iomem accessors
>    MIPS: Move gic.h to include/linux/irqchip/mips-gic.h
>    irqchip: mips-gic: Clean up header file
>    irqchip: mips-gic: Clean up #includes
>    irqchip: mips-gic: Remove gic_{pending,itrmask}_regs
>    irqchip: mips-gic: Use GIC_SH_WEDGE_{SET,CLR} macros
>    MIPS: Move GIC clocksource driver to drivers/clocksource/
>    clocksource: mips-gic: Combine with GIC clockevent driver
>    clocksource: mips-gic: Staticize local symbols
>    clocksource: mips-gic: Move gic_frequency to clocksource driver
>    clocksource: mips-gic: Remove gic_event_handler
>    clocksource: mips-gic: Use percpu_dev_id
>    clocksource: mips-gic: Use CPU notifiers to setup the timer
>    clocksource: mips-gic: Use clockevents_config_and_register
>    clocksource: mips-gic: Bump up rating of GIC timer
>
>   arch/mips/Kconfig                                  |  21 +-
>   arch/mips/include/asm/mips-boards/maltaint.h       |   2 +-
>   arch/mips/include/asm/mips-boards/sead3int.h       |   2 +-
>   arch/mips/include/asm/time.h                       |   5 +-
>   arch/mips/kernel/Makefile                          |   2 -
>   arch/mips/kernel/cevt-gic.c                        | 103 ---------
>   arch/mips/kernel/cevt-r4k.c                        |   2 +-
>   arch/mips/kernel/csrc-gic.c                        |  40 ----
>   arch/mips/kernel/smp-cmp.c                         |   2 +-
>   arch/mips/kernel/smp-cps.c                         |   2 +-
>   arch/mips/kernel/smp-gic.c                         |   2 +-
>   arch/mips/kernel/smp-mt.c                          |   2 +-
>   arch/mips/mti-malta/malta-int.c                    |  15 +-
>   arch/mips/mti-malta/malta-time.c                   |  20 +-
>   arch/mips/mti-sead3/sead3-ehci.c                   |   2 +-
>   arch/mips/mti-sead3/sead3-int.c                    |   9 +-
>   arch/mips/mti-sead3/sead3-net.c                    |   2 +-
>   arch/mips/mti-sead3/sead3-platform.c               |   2 +-
>   arch/mips/mti-sead3/sead3-time.c                   |   2 +-
>   drivers/clocksource/Kconfig                        |   4 +
>   drivers/clocksource/Makefile                       |   1 +
>   drivers/clocksource/mips-gic-timer.c               | 139 ++++++++++++
>   drivers/irqchip/irq-mips-gic.c                     | 243 +++++++++++++--------
>   .../asm/gic.h => include/linux/irqchip/mips-gic.h  | 203 +++--------------
>   24 files changed, 363 insertions(+), 464 deletions(-)
>   delete mode 100644 arch/mips/kernel/cevt-gic.c
>   delete mode 100644 arch/mips/kernel/csrc-gic.c
>   create mode 100644 drivers/clocksource/mips-gic-timer.c
>   rename arch/mips/include/asm/gic.h => include/linux/irqchip/mips-gic.h (61%)
>
