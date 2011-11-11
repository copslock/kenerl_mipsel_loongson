Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 12:35:18 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4961 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903544Ab1KKLfL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 12:35:11 +0100
X-TM-IMSS-Message-ID: <1acad7e50007c9d0@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 1acad7e50007c9d0 ; Fri, 11 Nov 2011 03:35:03 -0800
Date:   Fri, 11 Nov 2011 17:07:07 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [PATCH 00/12] MIPS: Support for Netlogic XLP processors
Message-ID: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 11 Nov 2011 11:35:02.0739 (UTC) FILETIME=[F3AF3A30:01CCA065]
X-archive-position: 31542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10218

[Here's is the patchset again, it has been re-based on top of the
ralf/upstream-sfr.git and few conflicts there have been resolved.]

This patchset adds support for Netlogic's XLP processor family.

The first few patches are to update XLR and move common files to a new
netlogic/common directory.

As always, comments and suggestions welcome. More details on the chip at
http://www.netlogicmicro.com/Products/ProductBriefs/MultiCore/XLP832.htm

Changes from  version:
 - merge smp wakeup code of XLR and XLP
 - common support for booting with 1/2/4 threads per core
 - Add supprt for XLP 3xx processors
 - mark netlogic chips SMT capable

Hillf Danton (1):
  MIPS: Netlogic: Mark Netlogic chips as SMT capable

Jayachandran C (11):
  MIPS: Netlogic: Style fixes for Platform
  MIPS: Netlogic: Use CPU_XLR instead of NLM_XLR
  MIPS: Netlogic: No need to set -Werror in mips/xlr
  MIPS: Netlogic: Move code common with XLP to common/
  MIPS: Netlogic: Update default config
  MIPS: Netlogic: XLP CPU support.
  MIPS: Netlogic: Add XLP platform files for XLP SoC
  MIPS: Netlogic: Add XLP makefiles and config
  MIPS: Netlogic: Add default XLP config.
  MIPS: Netlogic: Merge some of XLR/XLP wakup code
  MIPS: Netlogic: Add support for XLP 3XX cores

 arch/mips/Kconfig                                  |   44 ++-
 arch/mips/configs/nlm_xlp_defconfig                |  570 ++++++++++++++++++++
 arch/mips/configs/nlm_xlr_defconfig                |   16 +-
 arch/mips/include/asm/cpu.h                        |    5 +-
 .../asm/mach-netlogic/cpu-feature-overrides.h      |   18 +-
 arch/mips/include/asm/module.h                     |    2 +
 arch/mips/include/asm/netlogic/common.h            |   76 +++
 arch/mips/include/asm/netlogic/haldefs.h           |  163 ++++++
 arch/mips/include/asm/netlogic/xlp-hal/bridge.h    |  187 +++++++
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |   83 +++
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h     |  153 ++++++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |  411 ++++++++++++++
 arch/mips/include/asm/netlogic/xlp-hal/sys.h       |  129 +++++
 arch/mips/include/asm/netlogic/xlp-hal/uart.h      |  191 +++++++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h       |   51 ++
 arch/mips/include/asm/netlogic/xlr/iomap.h         |   22 -
 arch/mips/include/asm/netlogic/xlr/pic.h           |   69 ++-
 arch/mips/include/asm/netlogic/xlr/xlr.h           |   13 +-
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/cpu-probe.c                       |   20 +-
 arch/mips/lib/Makefile                             |    1 +
 arch/mips/mm/Makefile                              |    1 +
 arch/mips/mm/c-r4k.c                               |    3 +
 arch/mips/netlogic/Kconfig                         |    3 -
 arch/mips/netlogic/Makefile                        |    3 +
 arch/mips/netlogic/Platform                        |   13 +-
 arch/mips/netlogic/common/Makefile                 |    3 +
 arch/mips/netlogic/common/earlycons.c              |   60 ++
 arch/mips/netlogic/common/irq.c                    |  238 ++++++++
 arch/mips/netlogic/common/smp.c                    |  270 +++++++++
 arch/mips/netlogic/common/smpboot.S                |  272 ++++++++++
 arch/mips/netlogic/common/time.c                   |   51 ++
 arch/mips/netlogic/xlp/Makefile                    |    2 +
 arch/mips/netlogic/xlp/nlm_hal.c                   |  111 ++++
 arch/mips/netlogic/xlp/platform.c                  |  108 ++++
 arch/mips/netlogic/xlp/setup.c                     |  105 ++++
 arch/mips/netlogic/xlp/wakeup.c                    |  102 ++++
 arch/mips/netlogic/xlr/Makefile                    |    7 +-
 arch/mips/netlogic/xlr/irq.c                       |  305 -----------
 arch/mips/netlogic/xlr/platform.c                  |   31 +-
 arch/mips/netlogic/xlr/setup.c                     |   31 +-
 arch/mips/netlogic/xlr/smp.c                       |  220 --------
 arch/mips/netlogic/xlr/smpboot.S                   |  100 ----
 arch/mips/netlogic/xlr/time.c                      |   51 --
 arch/mips/netlogic/xlr/wakeup.c                    |   68 +++
 arch/mips/netlogic/xlr/xlr_console.c               |   46 --
 arch/mips/pci/Makefile                             |    2 +-
 arch/mips/pci/pci-xlr.c                            |   77 +++
 48 files changed, 3679 insertions(+), 829 deletions(-)
 create mode 100644 arch/mips/configs/nlm_xlp_defconfig
 create mode 100644 arch/mips/include/asm/netlogic/common.h
 create mode 100644 arch/mips/include/asm/netlogic/haldefs.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/bridge.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/iomap.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/pic.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/sys.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/uart.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/xlp.h
 create mode 100644 arch/mips/netlogic/Makefile
 create mode 100644 arch/mips/netlogic/common/Makefile
 create mode 100644 arch/mips/netlogic/common/earlycons.c
 create mode 100644 arch/mips/netlogic/common/irq.c
 create mode 100644 arch/mips/netlogic/common/smp.c
 create mode 100644 arch/mips/netlogic/common/smpboot.S
 create mode 100644 arch/mips/netlogic/common/time.c
 create mode 100644 arch/mips/netlogic/xlp/Makefile
 create mode 100644 arch/mips/netlogic/xlp/nlm_hal.c
 create mode 100644 arch/mips/netlogic/xlp/platform.c
 create mode 100644 arch/mips/netlogic/xlp/setup.c
 create mode 100644 arch/mips/netlogic/xlp/wakeup.c
 delete mode 100644 arch/mips/netlogic/xlr/irq.c
 delete mode 100644 arch/mips/netlogic/xlr/smp.c
 delete mode 100644 arch/mips/netlogic/xlr/smpboot.S
 delete mode 100644 arch/mips/netlogic/xlr/time.c
 create mode 100644 arch/mips/netlogic/xlr/wakeup.c
 delete mode 100644 arch/mips/netlogic/xlr/xlr_console.c

-- 
1.7.5.4
