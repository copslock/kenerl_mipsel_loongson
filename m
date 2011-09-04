Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Sep 2011 20:04:39 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4984 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491066Ab1IDSEc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Sep 2011 20:04:32 +0200
X-TM-IMSS-Message-ID: <9ba5cbc30002db9d@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 9ba5cbc30002db9d ; Sun, 4 Sep 2011 11:02:23 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Sun, 4 Sep 2011 11:05:36 -0700
Date:   Sun, 4 Sep 2011 23:40:21 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 0/4] MIPS: Support for Netlogic XLP processors
Message-ID: <cover.1315075195.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 04 Sep 2011 18:05:36.0842 (UTC) FILETIME=[3F6892A0:01CC6B2D]
X-archive-position: 31038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2158

This patchset adds support for Netlogic's new XLP processor series.
Please see
http://netlogicmicro.com/Products/ProductBriefs/MultiCore/XLP832.htm 
for more details on this processor,

The changes here has the platform support with UART, PIC and 32-way SMP. 
Comments on the code and suggestions are very welcome.

Changes from the previous patchset:
 - Fixes for review comments for the first patchset
 - Remove 32-bit support code for now, this will be added when 32-bit support
   works.
 - Removed unused assembly macros and BSD code from include/netlogic

Jayachandran C (4):
  MIPS: Netlogic: XLP CPU support.
  MIPS: Netlogic: Platform files for XLP processors.
  MIPS: Netlogic: Build support for netlogic XLP
  MIPS: Netlogic: Add default XLP config.

 arch/mips/Kconfig                                  |   44 ++
 arch/mips/configs/nlm_xlp_defconfig                |  590 ++++++++++++++++++++
 arch/mips/include/asm/cpu.h                        |    3 +-
 .../asm/mach-netlogic/cpu-feature-overrides.h      |   18 +-
 arch/mips/include/asm/module.h                     |    2 +
 arch/mips/include/asm/netlogic/xlp-hal/bridge.h    |  187 +++++++
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |   83 +++
 arch/mips/include/asm/netlogic/xlp-hal/haldefs.h   |  154 +++++
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h     |  155 +++++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |  383 +++++++++++++
 arch/mips/include/asm/netlogic/xlp-hal/sys.h       |  128 +++++
 arch/mips/include/asm/netlogic/xlp-hal/uart.h      |  191 +++++++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h       |   71 +++
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/cpu-probe.c                       |   19 +-
 arch/mips/lib/Makefile                             |    1 +
 arch/mips/mm/Makefile                              |    1 +
 arch/mips/mm/c-r4k.c                               |    3 +
 arch/mips/netlogic/Kconfig                         |    3 +
 arch/mips/netlogic/Platform                        |    7 +
 arch/mips/netlogic/xlp/Makefile                    |    5 +
 arch/mips/netlogic/xlp/irq.c                       |  240 ++++++++
 arch/mips/netlogic/xlp/nlm_hal.c                   |   85 +++
 arch/mips/netlogic/xlp/platform.c                  |  108 ++++
 arch/mips/netlogic/xlp/setup.c                     |   98 ++++
 arch/mips/netlogic/xlp/smp.c                       |  285 ++++++++++
 arch/mips/netlogic/xlp/smpboot.S                   |  217 +++++++
 arch/mips/netlogic/xlp/time.c                      |   74 +++
 arch/mips/netlogic/xlp/xlp_console.c               |   50 ++
 29 files changed, 3198 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/configs/nlm_xlp_defconfig
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/bridge.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/haldefs.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/iomap.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/pic.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/sys.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/uart.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/xlp.h
 create mode 100644 arch/mips/netlogic/xlp/Makefile
 create mode 100644 arch/mips/netlogic/xlp/irq.c
 create mode 100644 arch/mips/netlogic/xlp/nlm_hal.c
 create mode 100644 arch/mips/netlogic/xlp/platform.c
 create mode 100644 arch/mips/netlogic/xlp/setup.c
 create mode 100644 arch/mips/netlogic/xlp/smp.c
 create mode 100644 arch/mips/netlogic/xlp/smpboot.S
 create mode 100644 arch/mips/netlogic/xlp/time.c
 create mode 100644 arch/mips/netlogic/xlp/xlp_console.c

-- 
1.7.4.1
