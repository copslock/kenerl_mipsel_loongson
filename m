Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2011 10:28:20 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4756 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491802Ab1I0I2O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2011 10:28:14 +0200
X-TM-IMSS-Message-ID: <326236df00001085@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 326236df00001085 ; Tue, 27 Sep 2011 01:28:06 -0700
Received: from orion8.netlogicmicro.com (10.10.16.60) by
 hqcas01.netlogicmicro.com (10.10.50.14) with Microsoft SMTP Server id
 14.1.339.1; Tue, 27 Sep 2011 01:28:05 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by
 orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);         Tue, 27 Sep
 2011 01:27:40 -0700
Date:   Tue, 27 Sep 2011 14:06:30 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [PATCH 0/9] Add support for Netlogic XLP
Message-ID: <cover.1317111127.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 27 Sep 2011 08:27:40.0794 (UTC) FILETIME=[525FCDA0:01CC7CEF]
X-archive-position: 31171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15271

This is an update to the XLP support patches based on the feedback
I have received so far. The main change is that I have created a new
directory arch/mips/netlogic/common and moved code that can be shared
between XLR and XLP there.  The mmio functions and PIC interface functions
have been unified as much as possible to be used from the common files.

The first 3 patches are minor fixes to the existing XLR code. The third
patch rearrages the current XLR code and creates the common directory. 
The 4th patch updates the current XLR default config to enable PCI by
default.  The patches after that add XLP processor support.

As always, comments and suggestions welcome. More details on the chip
at http://www.netlogicmicro.com/Products/ProductBriefs/MultiCore/XLP832.htm 

Thanks,
JC.

Jayachandran C (9):
  MIPS: Netlogic: Style fixes for Platform
  MIPS: Netlogic: Use CPU_XLR instead of NLM_XLR
  MIPS: Netlogic: No need to set -Werror in mips/xlr
  MIPS: Netlogic: Move code common with XLP to common/
  MIPS: Netlogic: Update default config
  MIPS: Netlogic: XLP CPU support.
  MIPS: Netlogic: Add XLP platform files for XLP SoC
  MIPS: Netlogic: Add XLP makefiles and config
  MIPS: Netlogic: Add default XLP config.

 arch/mips/Kconfig                                  |   44 ++-
 arch/mips/configs/nlm_xlp_defconfig                |  570 ++++++++++++++++++++
 arch/mips/configs/nlm_xlr_defconfig                |   16 +-
 arch/mips/include/asm/cpu.h                        |    3 +-
 .../asm/mach-netlogic/cpu-feature-overrides.h      |   18 +-
 arch/mips/include/asm/module.h                     |    2 +
 arch/mips/include/asm/netlogic/common.h            |   56 ++
 arch/mips/include/asm/netlogic/haldefs.h           |  163 ++++++
 arch/mips/include/asm/netlogic/xlp-hal/bridge.h    |  187 +++++++
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |   83 +++
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h     |  153 ++++++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |  411 ++++++++++++++
 arch/mips/include/asm/netlogic/xlp-hal/sys.h       |  129 +++++
 arch/mips/include/asm/netlogic/xlp-hal/uart.h      |  191 +++++++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h       |   58 ++
 arch/mips/include/asm/netlogic/xlr/iomap.h         |   22 -
 arch/mips/include/asm/netlogic/xlr/pic.h           |   69 ++-
 arch/mips/include/asm/netlogic/xlr/xlr.h           |   11 -
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/cpu-probe.c                       |   19 +-
 arch/mips/lib/Makefile                             |    1 +
 arch/mips/mm/Makefile                              |    1 +
 arch/mips/mm/c-r4k.c                               |    3 +
 arch/mips/netlogic/Kconfig                         |    3 -
 arch/mips/netlogic/Makefile                        |    3 +
 arch/mips/netlogic/Platform                        |   13 +-
 arch/mips/netlogic/common/Makefile                 |    3 +
 arch/mips/netlogic/common/earlycons.c              |   60 ++
 arch/mips/netlogic/common/irq.c                    |  238 ++++++++
 arch/mips/netlogic/common/smp.c                    |  191 +++++++
 arch/mips/netlogic/common/time.c                   |   51 ++
 arch/mips/netlogic/xlp/Makefile                    |    2 +
 arch/mips/netlogic/xlp/nlm_hal.c                   |  105 ++++
 arch/mips/netlogic/xlp/platform.c                  |  108 ++++
 arch/mips/netlogic/xlp/setup.c                     |  101 ++++
 arch/mips/netlogic/xlp/smpboot.S                   |  217 ++++++++
 arch/mips/netlogic/xlp/wakeup.c                    |  149 +++++
 arch/mips/netlogic/xlr/Makefile                    |    7 +-
 arch/mips/netlogic/xlr/irq.c                       |  305 -----------
 arch/mips/netlogic/xlr/platform.c                  |   31 +-
 arch/mips/netlogic/xlr/setup.c                     |   24 +-
 arch/mips/netlogic/xlr/smp.c                       |  216 --------
 arch/mips/netlogic/xlr/smpboot.S                   |    6 +-
 arch/mips/netlogic/xlr/time.c                      |   51 --
 arch/mips/netlogic/xlr/wakeup.c                    |   71 +++
 arch/mips/netlogic/xlr/xlr_console.c               |   46 --
 arch/mips/pci/Makefile                             |    2 +-
 arch/mips/pci/pci-xlr.c                            |   77 +++
 48 files changed, 3564 insertions(+), 727 deletions(-)
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
 create mode 100644 arch/mips/netlogic/common/time.c
 create mode 100644 arch/mips/netlogic/xlp/Makefile
 create mode 100644 arch/mips/netlogic/xlp/nlm_hal.c
 create mode 100644 arch/mips/netlogic/xlp/platform.c
 create mode 100644 arch/mips/netlogic/xlp/setup.c
 create mode 100644 arch/mips/netlogic/xlp/smpboot.S
 create mode 100644 arch/mips/netlogic/xlp/wakeup.c
 delete mode 100644 arch/mips/netlogic/xlr/irq.c
 delete mode 100644 arch/mips/netlogic/xlr/smp.c
 delete mode 100644 arch/mips/netlogic/xlr/time.c
 create mode 100644 arch/mips/netlogic/xlr/wakeup.c
 delete mode 100644 arch/mips/netlogic/xlr/xlr_console.c

-- 
1.7.4.1
