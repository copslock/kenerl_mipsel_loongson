Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:50:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8289 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990552AbdHMCuJm8lB6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:50:09 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 148B8150C35C6;
        Sun, 13 Aug 2017 03:50:00 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:50:01 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/19] MIPS: Initial multi-cluster support
Date:   Sat, 12 Aug 2017 19:49:24 -0700
Message-ID: <20170813024943.14989-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59496
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

This series cleans up some MIPS Coherent Processing System (CPS) code,
and then introduces the first portions of support for multi-cluster
systems, which are introduced with CM 3.5 & the MIPS I6500 core. My hope
is that this initial groundwork can go in first, then patches adding
support to the necessary drivers, power management & SMP code can follow
culminating in a later patchset to enable actually booting CPUs in
secondary clusters.

Applies to mips-for-linux-next as of aa9a357f236f.


Paul Burton (19):
  MIPS: CM: Rename mips_cm_base to mips_gcr_base
  MIPS: CM: Specify register size when generating accessors
  MIPS: CM: Use BIT/GENMASK for register fields, order & drop shifts
  MIPS: CPC: Use common CPS accessor generation macros
  MIPS: CPC: Use BIT/GENMASK for register fields, order & drop shifts
  MIPS: CPS: Introduce register modify (set/clear/change) accessors
  MIPS: CPS: Use change_*, set_* & clear_* where appropriate
  MIPS: CPS: Add CM/CPC 3.5 register definitions
  MIPS: Add accessor & bit definitions for GlobalNumber
  MIPS: CPS: Use GlobalNumber macros rather than magic numbers
  MIPS: Abstract CPU core & VP(E) ID access through accessor functions
  MIPS: Store core & VP IDs in GlobalNumber-style variable
  MIPS: Unify checks for sibling CPUs
  MIPS: Add CPU cluster number accessors
  MIPS: CM: Add cluster & block args to mips_cm_lock_other()
  MIPS: SMP: Allow boot_secondary SMP op to return errors
  MIPS: CPS: Have asm/mips-cps.h include CM & CPC headers
  MIPS: CPS: Cluster support for topology functions
  MIPS: CPS: Detect CPUs in secondary clusters

 arch/mips/cavium-octeon/smp.c         |   8 +-
 arch/mips/include/asm/cpu-info.h      |  62 +++-
 arch/mips/include/asm/mips-cm.h       | 567 +++++++++++++++-------------------
 arch/mips/include/asm/mips-cpc.h      | 177 ++++++-----
 arch/mips/include/asm/mips-cps.h      | 239 ++++++++++++++
 arch/mips/include/asm/mipsregs.h      |  13 +
 arch/mips/include/asm/smp-ops.h       |   4 +-
 arch/mips/include/asm/topology.h      |   2 +-
 arch/mips/kernel/cps-vec.S            |   4 +-
 arch/mips/kernel/cpu-probe.c          |  39 ++-
 arch/mips/kernel/mips-cm.c            |  94 +++---
 arch/mips/kernel/mips-cpc.c           |  17 +-
 arch/mips/kernel/pm-cps.c             |  15 +-
 arch/mips/kernel/proc.c               |   6 +-
 arch/mips/kernel/smp-bmips.c          |   6 +-
 arch/mips/kernel/smp-cmp.c            |   3 +-
 arch/mips/kernel/smp-cps.c            | 145 +++++----
 arch/mips/kernel/smp-mt.c             |   6 +-
 arch/mips/kernel/smp-up.c             |   3 +-
 arch/mips/kernel/smp.c                |  20 +-
 arch/mips/kernel/traps.c              |  11 +-
 arch/mips/loongson64/loongson-3/smp.c |  14 +-
 arch/mips/mm/c-r4k.c                  |   2 +-
 arch/mips/mm/sc-mips.c                |  47 ++-
 arch/mips/mti-malta/malta-dtshim.c    |   4 +-
 arch/mips/mti-malta/malta-init.c      |   3 +-
 arch/mips/mti-malta/malta-int.c       |   1 -
 arch/mips/mti-malta/malta-setup.c     |   4 +-
 arch/mips/netlogic/common/smp.c       |   6 +-
 arch/mips/oprofile/op_model_mipsxx.c  |   4 +-
 arch/mips/paravirt/paravirt-smp.c     |   3 +-
 arch/mips/pci/pci-malta.c             |   6 +-
 arch/mips/pistachio/init.c            |   3 +-
 arch/mips/ralink/mt7621.c             |   5 +-
 arch/mips/sgi-ip27/ip27-smp.c         |   3 +-
 arch/mips/sibyte/bcm1480/smp.c        |   3 +-
 arch/mips/sibyte/sb1250/smp.c         |   3 +-
 arch/mips/vdso/gettimeofday.c         |   1 -
 drivers/cpuidle/cpuidle-cps.c         |   2 +-
 drivers/irqchip/irq-mips-cpu.c        |   2 +-
 drivers/irqchip/irq-mips-gic.c        |   6 +-
 41 files changed, 922 insertions(+), 641 deletions(-)
 create mode 100644 arch/mips/include/asm/mips-cps.h

-- 
2.14.0
