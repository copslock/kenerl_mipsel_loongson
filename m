Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:37:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39420 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990557AbdHMEh1LBpAd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:37:27 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 751248FF09085;
        Sun, 13 Aug 2017 05:37:18 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:37:20 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/38] irqchip: mips-gic: Cleanup & optimisation
Date:   Sat, 12 Aug 2017 21:36:08 -0700
Message-ID: <20170813043646.25821-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series cleans up the MIPS Global Interrupt Controller (GIC) driver
somewhat. It moves us towards using a header in a similar vein to the
ones we have for the MIPS Coherence Manager (CM) & Cluster Power
Controller (CPC) which allows us to access the GIC outside of the
irqchip driver - something beneficial already for the clocksource &
clock event driver, and which will be beneficial for further drivers
(eg. one for the GIC watchdog timer) and for multi-cluster work. Using
this header is also beneficial for consistency & code-sharing.

In addition to cleanups the series also optimises the driver in various
ways, including by using a per-CPU variable for pcpu_masks & removing
the need to read the GIC_SH_MASK_* registers when decoding interrupts in
gic_handle_shared_int().

This series requires my "[PATCH 00/19] MIPS: Initial multi-cluster
support" series to be applied first.


James Hogan (1):
  irqchip: mips-gic: SYNC after enabling GIC region

Paul Burton (37):
  MIPS: GIC: Introduce asm/mips-gic.h with accessor functions
  clocksource: mips-gic-timer: Use new GIC accessor functions
  irqchip: mips-gic: Remove counter access functions
  MIPS: CPS: Read GIC_VL_IDENT directly, not via irqchip driver
  irqchip: mips-gic: Remove gic_read_local_vp_id()
  lib/iomap_copy.c: Add __ioread64_copy
  irqchip: mips-gic: Simplify shared interrupt pending/mask reads
  irqchip: mips-gic: Simplify gic_local_irq_domain_map()
  irqchip: mips-gic: Drop gic_(re)set_mask() functions
  irqchip: mips-gic: Remove gic_set_polarity()
  irqchip: mips-gic: Remove gic_set_trigger()
  irqchip: mips-gic: Remove gic_set_dual_edge()
  irqchip: mips-gic: Remove gic_map_to_pin()
  irqchip: mips-gic: Remove gic_map_to_vpe()
  irqchip: mips-gic: Convert remaining shared reg access to new
    accessors
  irqchip: mips-gic: Convert local int mask access to new accessors
  irqchip: mips-gic: Convert remaining local reg access to new accessors
  MIPS: GIC: Move GIC_LOCAL_INT_* to asm/mips-gic.h
  irqchip: mips-gic: Remove GIC_CPU_INT* macros
  irqchip: mips-gic: Move various definitions to the driver
  MIPS: VDSO: Drop gic_get_usm_range() usage
  irqchip: mips-gic: Remove gic_get_usm_range()
  irqchip: mips-gic: Remove __gic_irq_dispatch() forward declaration
  irqchip: mips-gic: Remove gic_init()
  MIPS: Use mips_gic_present() in place of gic_present
  irqchip: mips-gic: Remove gic_present
  irqchip: mips-gic: Move gic_get_c0_*_int() to asm/mips-gic.h
  MIPS: VDSO: Avoid use of linux/irqchip/mips-gic.h
  MIPS: Remove unnecessary inclusions of linux/irqchip/mips-gic.h
  irqchip: mips-gic: Remove linux/irqchip/mips-gic.h
  irqchip: mips-gic: Inline __gic_init()
  irqchip: mips-gic: Inline gic_basic_init()
  irqchip: mips-gic: Make pcpu_masks a per-cpu variable
  irqchip: mips-gic: Use pcpu_masks to avoid reading GIC_SH_MASK*
  irqchip: mips-gic: Clean up mti,reserved-cpu-vectors handling
  irqchip: mips-gic: Use cpumask_first_and() in gic_set_affinity()
  irqchip: mips-gic: Let the core set struct irq_common_data affinity

 arch/mips/generic/irq.c                      |   8 +-
 arch/mips/include/asm/mips-boards/maltaint.h |   5 -
 arch/mips/include/asm/mips-cps.h             |   1 +
 arch/mips/include/asm/mips-gic.h             | 347 +++++++++++++++
 arch/mips/kernel/smp-cmp.c                   |   1 -
 arch/mips/kernel/smp-cps.c                   |   3 +-
 arch/mips/kernel/smp-mt.c                    |   6 +-
 arch/mips/kernel/vdso.c                      |  15 +-
 arch/mips/lantiq/irq.c                       |   4 -
 arch/mips/mti-malta/malta-int.c              |   4 +-
 arch/mips/mti-malta/malta-time.c             |  20 +-
 arch/mips/pistachio/irq.c                    |   1 -
 arch/mips/pistachio/time.c                   |   2 +-
 arch/mips/ralink/irq-gic.c                   |   2 +-
 arch/mips/vdso/gettimeofday.c                |   7 +-
 drivers/clocksource/mips-gic-timer.c         |  37 +-
 drivers/irqchip/irq-mips-gic.c               | 604 ++++++++-------------------
 include/linux/io.h                           |   1 +
 include/linux/irqchip/mips-gic.h             | 297 -------------
 lib/iomap_copy.c                             |  25 ++
 20 files changed, 609 insertions(+), 781 deletions(-)
 create mode 100644 arch/mips/include/asm/mips-gic.h
 delete mode 100644 include/linux/irqchip/mips-gic.h

-- 
2.14.0
