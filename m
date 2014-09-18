Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:47:45 +0200 (CEST)
Received: from mail-ie0-f201.google.com ([209.85.223.201]:50093 "EHLO
        mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009206AbaIRVrmx6TVR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:42 +0200
Received: by mail-ie0-f201.google.com with SMTP id rl12so311150iec.2
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zIBBu6St4k4yWdQkbFWHQwfsMBlbliwF9gpgZnAXXYo=;
        b=UJGfjIqE/SYWIuFXGzvQdoDDLgTt1Ibd1Or93f6V3HPwSCA80ZPbzZ66IrfIgTp9J6
         WTMGl1ZTcXpJbIZ9/SLz/J3AhcOcfeRtCxQZjXy5R+yAfd+yRIZC/p2kRBNfUkipgHcy
         8sDju+u6wgoV7yuNAwQJ7Qpt6o8tgmX7ttvQjUar6Mh7iKU9pOM5rLcSjJAbuMojodmM
         xkg8luPL6oL7Z8Ctv9kMSf36ocaP8kwFYpibHVDdSWGPCoR7dxQAdK1a5j+yXs7zMeJY
         bELB8odH0PLOmn1Xtp5AQqaY8/xQ2eNSa5YUZGKga3tYTlosiK/ipNd9U3nQHdHpSbWm
         Rpzw==
X-Gm-Message-State: ALoCoQnPOEncSHaKZyopNSfrZVOppi37JipGEYd1nKqDMT7kj/34vBHENjbB5W1W+zxQtbcCMH1o
X-Received: by 10.182.40.197 with SMTP id z5mr1257394obk.24.1411076856392;
        Thu, 18 Sep 2014 14:47:36 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n24si1737yha.6.2014.09.18.14.47.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:36 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id f1hWl2aq.1; Thu, 18 Sep 2014 14:47:36 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id E77B7220B91; Thu, 18 Sep 2014 14:47:34 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/24] MIPS GIC cleanup, part 1
Date:   Thu, 18 Sep 2014 14:47:06 -0700
Message-Id: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

The current MIPS GIC driver and the platform code using it are rather
ugly and could use a good cleanup before adding device-tree support [0].
This major issues addressed in this series are converting the GIC (and
platforms using it) to use IRQ domains and properly mapping interrupts
through the GIC instead of using it transparently.  For part 2 I plan
on: updating the driver to use proper iomem accessors, cleaning up and
moving the GIC clocksource driver to drivers/clocksource/, adding DT
support, and possibly converting the GIC driver to use generic irqchip.

Patches 1-16 are cleanups for the existing GIC driver and prepare platforms
using it for the switch to IRQ domains and using the GIC in a non-transparent
way.

Patches 17-24 convert the GIC driver to use IRQ domains and updates the
platforms using it to properly map GIC interrupts instead of using the static
routing tables to make the GIC appear transparent.

I've tested this series on Malta and, with additional patches, on the
DT-enabled Pistachio (formerly known as Danube) platform.  Unfortunately
I do not have SEAD-3 hardware, but Qais Yousef has tested V1 of this series
on a SEAD-3.  Compile tested on all other affected architectures (ath79,
ralink, lantiq).

Changes from v1:
 - handle core interrupts in descending order
 - dropped unnecessary irq_chip callbacks when possible
 - used separate irq_chip to deal with C0 timer/perf interrupts
 - added locking around potentially concurrent r-m-w operations

[0] https://lkml.org/lkml/2014/9/5/542

Andrew Bresticker (24):
  MIPS: Always use IRQ domains for CPU IRQs
  MIPS: Rename mips_cpu_intc_init() -> mips_cpu_irq_of_init()
  MIPS: Provide a generic plat_irq_dispatch
  MIPS: Set vint handler when mapping CPU interrupts
  MIPS: i8259: Use IRQ domains
  MIPS: Add hook to get C0 performance counter interrupt
  MIPS: smp-cps: Enable all hardware interrupts on secondary CPUs
  MIPS: Remove gic_{enable,disable}_interrupt()
  MIPS: sead3: Remove sead3-serial.c
  MIPS: sead3: Do not overlap CPU/GIC IRQ ranges
  MIPS: Malta: Move MSC01 interrupt base
  MIPS: Move MIPS_GIC_IRQ_BASE into platform irq.h
  MIPS: Move GIC to drivers/irqchip/
  irqchip: mips-gic: Remove platform irq_ack/irq_eoi callbacks
  irqchip: mips-gic: Implement irq_set_type callback
  irqchip: mips-gic: Fix gic_set_affinity() return value
  irqchip: mips-gic: Use IRQ domains
  irqchip: mips-gic: Stop using per-platform mapping tables
  irqchip: mips-gic: Probe for number of external interrupts
  irqchip: mips-gic: Use separate edge/level irq_chips
  irqchip: mips-gic: Support local interrupts
  irqchip: mips-gic: Remove unnecessary globals
  MIPS: Malta: Use generic plat_irq_dispatch
  MIPS: sead3: Use generic plat_irq_dispatch

 Documentation/devicetree/bindings/mips/cpu_irq.txt |   4 +-
 arch/mips/Kconfig                                  |  12 +-
 arch/mips/ath79/irq.c                              |   1 -
 arch/mips/ath79/setup.c                            |   5 +
 arch/mips/include/asm/gic.h                        |  82 ++-
 arch/mips/include/asm/irq_cpu.h                    |   4 +-
 arch/mips/include/asm/mach-generic/irq.h           |   6 +
 arch/mips/include/asm/mach-malta/irq.h             |   1 -
 arch/mips/include/asm/mach-sead3/irq.h             |   1 -
 arch/mips/include/asm/mips-boards/maltaint.h       |  24 +-
 arch/mips/include/asm/mips-boards/sead3int.h       |  15 +-
 arch/mips/include/asm/time.h                       |   1 +
 arch/mips/kernel/Makefile                          |   1 -
 arch/mips/kernel/cevt-gic.c                        |  14 +-
 arch/mips/kernel/cevt-r4k.c                        |   4 +-
 arch/mips/kernel/i8259.c                           |  24 +-
 arch/mips/kernel/irq-gic.c                         | 402 -------------
 arch/mips/kernel/irq_cpu.c                         |  48 +-
 arch/mips/kernel/perf_event_mipsxx.c               |  23 +-
 arch/mips/kernel/smp-cps.c                         |   4 +-
 arch/mips/kernel/smp-mt.c                          |   4 +-
 arch/mips/lantiq/irq.c                             |   8 +-
 arch/mips/mti-malta/malta-int.c                    | 307 +---------
 arch/mips/mti-malta/malta-time.c                   |  39 +-
 arch/mips/mti-sead3/sead3-ehci.c                   |   8 +-
 arch/mips/mti-sead3/sead3-int.c                    | 121 +---
 arch/mips/mti-sead3/sead3-net.c                    |  14 +-
 arch/mips/mti-sead3/sead3-platform.c               |  18 +-
 arch/mips/mti-sead3/sead3-serial.c                 |  45 --
 arch/mips/mti-sead3/sead3-time.c                   |  35 +-
 arch/mips/oprofile/op_model_mipsxx.c               |  18 +-
 arch/mips/ralink/irq.c                             |  10 +-
 drivers/irqchip/Kconfig                            |   4 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-mips-gic.c                     | 646 +++++++++++++++++++++
 35 files changed, 919 insertions(+), 1035 deletions(-)
 delete mode 100644 arch/mips/kernel/irq-gic.c
 delete mode 100644 arch/mips/mti-sead3/sead3-serial.c
 create mode 100644 drivers/irqchip/irq-mips-gic.c

-- 
2.1.0.rc2.206.gedb03e5
