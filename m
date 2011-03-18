Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 14:28:39 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:4555 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491879Ab1CRN1o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 14:27:44 +0100
X-TM-IMSS-Message-ID: <2f3160d50001a99c@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 2f3160d50001a99c ; Fri, 18 Mar 2011 06:27:33 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 18 Mar 2011 06:22:00 -0700
Date:   Fri, 18 Mar 2011 18:57:17 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 0/7] Support for Netlogic XLR/XLS processors
Message-ID: <cover.1300452150.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 18 Mar 2011 13:22:00.0941 (UTC) FILETIME=[76EAA1D0:01CBE56F]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Updated patchset for Netlogic processor support.

Changes from last version:
* Remove c-netlogic.c for now, c-r4k works well enough for the first
  cut, so the custom cache handler can be considered later.
* More elaborate asm/mach-netlogic/cpu-feature-overrides.h
  (noted by David Daney)

These set of patches add support for the XLR and XLS multi-core MIPS64
SoCs from Netlogic Microsystems.
These changes enable us to boot Linux/MIPS on Netlogic evaluation boards
from the netlogic bootloader.

As always, comments on code and licenses welcome.

Jayachandran C (7):
  Netlogic XLR/XLS processor IDs.
  mach-netlogic include directory and files
  Cache, TLB support, and feature overrides for XLR
  Add XLR to asm/module.h
  Platform files for XLR/XLS processor support
  Kconfig and Makefile update for Netlogic XLR/XLS
  Add default configuration for XLR/XLS processors

 arch/mips/Kconfig                                  |   42 +
 arch/mips/Makefile                                 |   12 +
 arch/mips/configs/nlm_xlr_defconfig                | 1698 ++++++++++++++++++++
 arch/mips/include/asm/cpu.h                        |   27 +
 .../asm/mach-netlogic/cpu-feature-overrides.h      |   47 +
 arch/mips/include/asm/mach-netlogic/irq.h          |   14 +
 arch/mips/include/asm/mach-netlogic/war.h          |   26 +
 arch/mips/include/asm/module.h                     |    2 +
 arch/mips/include/asm/netlogic/interrupt.h         |   39 +
 arch/mips/include/asm/netlogic/mips-extns.h        |   69 +
 arch/mips/include/asm/netlogic/psb-bootinfo.h      |  103 ++
 arch/mips/include/asm/netlogic/xlr/gpio.h          |   67 +
 arch/mips/include/asm/netlogic/xlr/iomap.h         |  125 ++
 arch/mips/include/asm/netlogic/xlr/pic.h           |  225 +++
 arch/mips/include/asm/netlogic/xlr/xlr.h           |   20 +
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/cpu-probe.c                       |   55 +
 arch/mips/lib/Makefile                             |    1 +
 arch/mips/mm/Makefile                              |    1 +
 arch/mips/mm/c-r4k.c                               |    1 +
 arch/mips/mm/tlbex.c                               |    1 +
 arch/mips/netlogic/Kconfig                         |    5 +
 arch/mips/netlogic/xlr/Makefile                    |    5 +
 arch/mips/netlogic/xlr/irq.c                       |  281 ++++
 arch/mips/netlogic/xlr/platform.c                  |   99 ++
 arch/mips/netlogic/xlr/setup.c                     |  181 +++
 arch/mips/netlogic/xlr/smp.c                       |  219 +++
 arch/mips/netlogic/xlr/smpboot.S                   |   88 +
 arch/mips/netlogic/xlr/time.c                      |   45 +
 arch/mips/netlogic/xlr/xlr_console.c               |   40 +
 30 files changed, 3539 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/configs/nlm_xlr_defconfig
 create mode 100644 arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-netlogic/irq.h
 create mode 100644 arch/mips/include/asm/mach-netlogic/war.h
 create mode 100644 arch/mips/include/asm/netlogic/interrupt.h
 create mode 100644 arch/mips/include/asm/netlogic/mips-extns.h
 create mode 100644 arch/mips/include/asm/netlogic/psb-bootinfo.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/gpio.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/iomap.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/pic.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/xlr.h
 create mode 100644 arch/mips/netlogic/Kconfig
 create mode 100644 arch/mips/netlogic/xlr/Makefile
 create mode 100644 arch/mips/netlogic/xlr/irq.c
 create mode 100644 arch/mips/netlogic/xlr/platform.c
 create mode 100644 arch/mips/netlogic/xlr/setup.c
 create mode 100644 arch/mips/netlogic/xlr/smp.c
 create mode 100644 arch/mips/netlogic/xlr/smpboot.S
 create mode 100644 arch/mips/netlogic/xlr/time.c
 create mode 100644 arch/mips/netlogic/xlr/xlr_console.c


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
