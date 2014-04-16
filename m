Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:53:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:59005 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834699AbaDPMxseKtl5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:53:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 22FC3DEC51F51
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:53:38 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 13:53:41 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:53:40 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:53:40 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/39] CPS cpuidle & hotplug
Date:   Wed, 16 Apr 2014 13:52:51 +0100
Message-ID: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39807
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

This series implements a cpuidle driver for systems built around the
MIPS Coherent Processing System (CPS) architecture - that is, systems
with a Coherence Manager, Global Interrupt Controller & for CM>=2 a
Cluster Power Controller.

The first 5 patches provide some infrastructure used to save context
across states where CPUs lose power. In this series that is the cpuidle
power gated idle state, but in future may also include suspend to RAM.

Patches 6 to 11 ensure that clockevent devices are used appropriately
allowing CPUs to switch to using tick broadcasts when necessary.

Patches 12 to 16 provide various small things for use by later patches
in the series.

Patches 17 to 25 provide access to a few new instructions via uasm for
use by later patches in the series.

Patches 26 to 29 make changes to smp-cps in preparation for supporting
hotplug & the power gated idle state.

Patch 30 introduces code to generate entry points for the various idle
states available in the system. Patch 31 makes use of that to implement
support for hotplug, powering down cores where possible.

Patches 32 to 34 make things a little more foolproof by ensuring that
multi-core SMP is not attempted with an unsuitable (non-coherent) CCA,
and by setting a suitable CCA by default.

Patches 35 & 36 are general infrastructure for supporting cpuidle
drivers for the MIPS architecture.

Patch 37 allows access to the struct cpuidle_device per-CPU variable
defined in generic cpuidle code.

Patch 38 adds a cpuidle driver for MIPS CPS systems, making use of the
infrastructure added earlier in the series.

Finally patch 39 enables the CONFIG_MIPS_CPS SMP implementation by
default on Malta, in place of the older & deprecated CONFIG_MIPS_CMP.

James Hogan (5):
  MIPS: PM: Add CPU PM callbacks for general CPU context
  MIPS: traps: Add CPU PM callback for trap configuration
  MIPS: c-r4k: Add CPU PM callback for coherency
  MIPS: tlb-r4k: Add CPU PM callback to reconfigure TLB
  MIPS: PM: Implement PM helper macros

Paul Burton (34):
  MIPS: mark GIC clockevent device with CLOCK_EVT_FEAT_C3STOP
  MIPS: allow GIC clockevent device config from other CPUs
  MIPS: mark R4K clockevent device with CLOCK_EVT_FEAT_C3STOP
  MIPS: mark R4K clockevent device with CLOCK_EVT_FEAT_PERCPU
  MIPS: allow R4K clockevent device to function regardless of GIC
  MIPS: support for generic clockevents broadcast
  MIPS: introduce cpu_coherent_mask
  MIPS: CPC: provide functions to retrieve register addresses
  MIPS: CPC: provide locking functions
  MIPS: add kmap_noncoherent to wire a cached non-coherent TLB entry
  MIPS: MT: define write_c0_tchalt macro
  MIPS: inst.h: define COP0 wait op
  MIPS: inst.h: define MT yield op
  MIPS: inst.h: define microMIPS sync op
  MIPS: inst.h: define microMIPS wait op
  MIPS: uasm: add a label variant of beq
  MIPS: uasm: add jalr instruction
  MIPS: uasm: add sync instruction
  MIPS: uasm: add wait instruction
  MIPS: uasm: add MT ASE yield instruction
  MIPS: smp-cps: rework core/VPE initialisation
  MIPS: smp-cps: function to determine whether CPS SMP is in use
  MIPS: smp-cps: flush cache after patching mips_cps_core_entry
  MIPS: smp-cps: use CPC core-other locking
  MIPS: pm-cps: add PM state entry code for CPS systems
  MIPS: smp-cps: hotplug support
  MIPS: smp-cps: prevent multi-core SMP with unsuitable CCA
  MIPS: smp-cps: set a coherent default CCA
  MIPS: smp-cps: duplicate core0 CCA on secondary cores
  MIPS: cpuidle wait instruction state
  MIPS: include cpuidle Kconfig menu
  cpuidle: declare cpuidle_dev in cpuidle.h
  cpuidle: cpuidle-cps: add MIPS CPS cpuidle driver
  MIPS: Malta: CPS SMP by default

 arch/mips/Kconfig                         |  15 +-
 arch/mips/configs/maltasmvp_defconfig     |   3 +-
 arch/mips/configs/maltasmvp_eva_defconfig |   3 +-
 arch/mips/include/asm/cacheflush.h        |   6 +
 arch/mips/include/asm/gic.h               |   1 +
 arch/mips/include/asm/idle.h              |  14 +
 arch/mips/include/asm/mips-cpc.h          |  34 +-
 arch/mips/include/asm/mipsmtregs.h        |   2 +
 arch/mips/include/asm/mmu_context.h       |  10 +-
 arch/mips/include/asm/pgtable.h           |   2 +
 arch/mips/include/asm/pm-cps.h            |  51 +++
 arch/mips/include/asm/pm.h                | 167 +++++++
 arch/mips/include/asm/smp-cps.h           |  19 +-
 arch/mips/include/asm/smp.h               |   3 +
 arch/mips/include/asm/uasm.h              |   9 +
 arch/mips/include/uapi/asm/inst.h         |  26 +-
 arch/mips/kernel/Makefile                 |   3 +
 arch/mips/kernel/asm-offsets.c            |  29 +-
 arch/mips/kernel/cevt-gic.c               |   5 +-
 arch/mips/kernel/cevt-r4k.c               |  10 +-
 arch/mips/kernel/cps-vec.S                | 328 +++++++++++++-
 arch/mips/kernel/idle.c                   |  11 +
 arch/mips/kernel/irq-gic.c                |  15 +
 arch/mips/kernel/mips-cpc.c               |  28 ++
 arch/mips/kernel/pm-cps.c                 | 705 ++++++++++++++++++++++++++++++
 arch/mips/kernel/pm.c                     |  99 +++++
 arch/mips/kernel/smp-cps.c                | 426 +++++++++++-------
 arch/mips/kernel/smp-gic.c                |  11 +
 arch/mips/kernel/smp.c                    |  47 ++
 arch/mips/kernel/traps.c                  |  93 +++-
 arch/mips/mm/c-r4k.c                      |  24 +
 arch/mips/mm/init.c                       |  14 +-
 arch/mips/mm/tlb-r4k.c                    |  34 +-
 arch/mips/mm/uasm-micromips.c             |   2 +
 arch/mips/mm/uasm-mips.c                  |   4 +
 arch/mips/mm/uasm.c                       |  31 +-
 drivers/cpuidle/Kconfig                   |   5 +
 drivers/cpuidle/Kconfig.mips              |  17 +
 drivers/cpuidle/Makefile                  |   4 +
 drivers/cpuidle/cpuidle-cps.c             | 186 ++++++++
 include/linux/cpuidle.h                   |   1 +
 41 files changed, 2261 insertions(+), 236 deletions(-)
 create mode 100644 arch/mips/include/asm/pm-cps.h
 create mode 100644 arch/mips/include/asm/pm.h
 create mode 100644 arch/mips/kernel/pm-cps.c
 create mode 100644 arch/mips/kernel/pm.c
 create mode 100644 drivers/cpuidle/Kconfig.mips
 create mode 100644 drivers/cpuidle/cpuidle-cps.c

-- 
1.8.5.3
