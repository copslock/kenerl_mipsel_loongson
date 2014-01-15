Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:32:16 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10801 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825606AbaAOKcNofalU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:32:13 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/15] MIPS CPS SMP
Date:   Wed, 15 Jan 2014 10:31:45 +0000
Message-ID: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_32_08
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38984
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

This patchset introduces a new SMP implementation for systems based around the
MIPS Coherent Processing System architecture (ie. those with a Coherence
Manager, Cluster Power Controller & Global Interrupt Controller). Previously
the only way to run SMP on a multi-core CPS-based system was to have the
bootloader start secondary cores via the interface enabled by CONFIG_MIPS_CMP.
That causes a number of issues which this SMP implementation solves:

  - The bootloader formerly had to be able to start secondary cores, even
    though it probably didn't make use of them itself. As multiple different
    bootloaders may be used they would all have to duplicate this functionality
    despite it being of no use to them. Having the kernel bring up secondary
    cores solves this problem nicely.

  - There formerly had to be an interface between the bootloader and the
    kernel with bootloader code available for as long as the kernel may need
    to bring up secondary CPUs. Whilst right now this is only during boot, in
    the future once hotplug and/or cpuidle core power down are implemented the
    bootloader interface would need to be extended further and the bootloader
    would need to be present always. This interface also introduces dependencies
    between versions of the kernel & versions of the various bootloaders, which
    are avoided by having the kernel bring up cores.

  - There formerly had to be a bootloader. On some systems (primarily
    development platforms) it is desirable to be able to load a kernel via means
    such as a JTAG debug probe and execute it without any other code having run.
    Practically that previously meant that you could not run an SMP kernel
    across multiple cores.

As part of this the existing Malta-specific CM code is replaced with more
general, more consistent CM code & similar CPC code is introduced. At the end of
the series CONFIG_MIPS_CMP is marked as deprecated, since the new
CONFIG_MIPS_CPS should be used in preference to it.

Paul Burton (15):
  MIPS: define Config1 cache field shifts & sizes
  MIPS: add CP0 CMGCRBase definitions & accessor
  MIPS: add missing includes to gic.h
  MIPS: introduce _EXT assembler macro
  MIPS: move GIC IPI functions out of smp-cmp.c
  MIPS: add generic CM probe & access code
  MIPS: add CPC probe, access functions
  MIPS: Coherent Processing System SMP implementation
  MIPS: Malta: make use of generic CM support
  MIPS: Malta: probe CPC when supported
  MIPS: Malta: allow use of MIPS CPS SMP implementation
  MIPS: remove gcmpregs.h
  MIPS: more helpful CONFIG_MIPS_CMP label, help text
  MIPS: MIPS_CMP should depend upon !SMTC, not upon SMVP
  MIPS: deprecate CONFIG_MIPS_CMP

 arch/mips/Kconfig                         |  46 ++++-
 arch/mips/include/asm/asmmacro.h          |  11 +
 arch/mips/include/asm/gcmpregs.h          | 125 ------------
 arch/mips/include/asm/gic.h               |   3 +
 arch/mips/include/asm/mips-boards/malta.h |   5 +
 arch/mips/include/asm/mips-cm.h           | 322 +++++++++++++++++++++++++++++
 arch/mips/include/asm/mips-cpc.h          | 150 ++++++++++++++
 arch/mips/include/asm/mipsregs.h          |  18 ++
 arch/mips/include/asm/smp-cps.h           |  33 +++
 arch/mips/include/asm/smp-ops.h           |  17 ++
 arch/mips/kernel/Makefile                 |   5 +
 arch/mips/kernel/asm-offsets.c            |  13 ++
 arch/mips/kernel/cps-vec.S                | 191 +++++++++++++++++
 arch/mips/kernel/cpu-probe.c              |   2 +
 arch/mips/kernel/irq-gic.c                |   1 -
 arch/mips/kernel/mips-cm.c                | 121 +++++++++++
 arch/mips/kernel/mips-cpc.c               |  52 +++++
 arch/mips/kernel/smp-cmp.c                |  52 +----
 arch/mips/kernel/smp-cps.c                | 329 ++++++++++++++++++++++++++++++
 arch/mips/kernel/smp-gic.c                |  53 +++++
 arch/mips/mm/c-r4k.c                      |   2 +-
 arch/mips/mti-malta/malta-init.c          |  17 +-
 arch/mips/mti-malta/malta-int.c           |  70 ++-----
 arch/mips/mti-malta/malta-setup.c         |   4 +-
 arch/mips/pci/pci-malta.c                 |  22 +-
 25 files changed, 1410 insertions(+), 254 deletions(-)
 delete mode 100644 arch/mips/include/asm/gcmpregs.h
 create mode 100644 arch/mips/include/asm/mips-cm.h
 create mode 100644 arch/mips/include/asm/mips-cpc.h
 create mode 100644 arch/mips/include/asm/smp-cps.h
 create mode 100644 arch/mips/kernel/cps-vec.S
 create mode 100644 arch/mips/kernel/mips-cm.c
 create mode 100644 arch/mips/kernel/mips-cpc.c
 create mode 100644 arch/mips/kernel/smp-cps.c
 create mode 100644 arch/mips/kernel/smp-gic.c

-- 
1.8.4.2
