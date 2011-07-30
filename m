Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jul 2011 15:33:02 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:2254 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491115Ab1G3Ncz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jul 2011 15:32:55 +0200
X-TM-IMSS-Message-ID: <e148a54800026d24@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id e148a54800026d24 ; Sat, 30 Jul 2011 06:31:16 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Sat, 30 Jul 2011 06:27:17 -0700
Date:   Sat, 30 Jul 2011 18:57:48 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 0/4] MIPS: Support for Netlogic XLP processors.
Message-ID: <cover.1312024106.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 30 Jul 2011 13:27:17.0732 (UTC) FILETIME=[67179A40:01CC4EBC]
X-archive-position: 30770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22302

This patchset adds support for Netlogic's new XLP processor series.
http://netlogicmicro.com/Products/ProductBriefs/MultiCore/XLP832.htm
has more details on this processor, but here's a short blurb:

  8-core, 4-way multi-threaded, MIPS64r2 CPUs with quad-issue out-of-order
  execution. Cache-coherent, 32KB D-cache & 64KB I-cache per core, 4MB L2 cache,
  8MB L3 cache. Floating point support. On-chip devices include DDR3 DRAM
  controller, 40 GBps network accelerator, security accelerator, compression
  engine, PCI, USB, I2C, UART, Flash, GPIO  and so on. Inter-chip
  interconnect allows upto 4 chips to be connected into a 128 cpu system.
  
The changes here has the platform support with UART, PIC and 32-way SMP.
Comments on the code and suggestions are very welcome.

Thanks,
JC.

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
 arch/mips/include/asm/netlogic/xlp-hal/cop2.h      |  319 +++++++++++
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |   71 +++
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h     |  133 +++++
 arch/mips/include/asm/netlogic/xlp-hal/mmio.h      |  441 +++++++++++++++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |  339 +++++++++++
 arch/mips/include/asm/netlogic/xlp-hal/sys.h       |  128 +++++
 arch/mips/include/asm/netlogic/xlp-hal/uart.h      |  191 +++++++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h       |   68 +++
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/cpu-probe.c                       |   19 +-
 arch/mips/lib/Makefile                             |    1 +
 arch/mips/mm/Makefile                              |    1 +
 arch/mips/mm/c-r4k.c                               |    4 +
 arch/mips/mm/tlbex.c                               |    1 +
 arch/mips/netlogic/Kconfig                         |    3 +
 arch/mips/netlogic/Platform                        |    7 +
 arch/mips/netlogic/xlp/Makefile                    |    5 +
 arch/mips/netlogic/xlp/irq.c                       |  240 ++++++++
 arch/mips/netlogic/xlp/nlm_hal.c                   |   84 +++
 arch/mips/netlogic/xlp/platform.c                  |  107 ++++
 arch/mips/netlogic/xlp/setup.c                     |   98 ++++
 arch/mips/netlogic/xlp/smp.c                       |  286 ++++++++++
 arch/mips/netlogic/xlp/smpboot.S                   |  217 +++++++
 arch/mips/netlogic/xlp/time.c                      |   74 +++
 arch/mips/netlogic/xlp/xlp_console.c               |   49 ++
 31 files changed, 3723 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/configs/nlm_xlp_defconfig
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/bridge.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/cop2.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/iomap.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/mmio.h
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
