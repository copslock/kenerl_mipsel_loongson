Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2011 22:05:57 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:2781 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491098Ab1EFUFA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2011 22:05:00 +0200
X-TM-IMSS-Message-ID: <2cf41ab80003a93a@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 2cf41ab80003a93a ; Fri, 6 May 2011 13:04:29 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 6 May 2011 13:05:19 -0700
Date:   Sat, 7 May 2011 01:35:30 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 0/8] Support for Netlogic XLR/XLS processors.
Message-ID: <cover.1304712046.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 06 May 2011 20:05:20.0150 (UTC) FILETIME=[ED02A360:01CC0C28]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Reposting this again.  I also have the initial XLP patchset ready,
but I will wait for this to be queued before posting the rest.

As always, please let me know if you have any comments on the code
or license.

Thanks,
JC.

Jayachandran C (8):
  Netlogic XLR/XLS processor IDs.
  mach-netlogic include directory and files.
  Cache support, TLB support, asm/module.h entry
  Platform files for XLR/XLS processor support.
  Kconfig and Makefile update for Netlogic XLR/XLS
  Add default configuration for XLR/XLS processors
  PCI support for XLR/XLS
  USB support for XLS platforms.

 arch/mips/Kconfig                                  |   44 +
 arch/mips/Makefile                                 |   12 +
 arch/mips/configs/nlm_xlr_defconfig                | 1705 ++++++++++++++++++++
 arch/mips/include/asm/cpu.h                        |   27 +
 .../asm/mach-netlogic/cpu-feature-overrides.h      |   47 +
 arch/mips/include/asm/mach-netlogic/irq.h          |   14 +
 arch/mips/include/asm/mach-netlogic/war.h          |   26 +
 arch/mips/include/asm/module.h                     |    2 +
 arch/mips/include/asm/netlogic/interrupt.h         |   45 +
 arch/mips/include/asm/netlogic/mips-extns.h        |   76 +
 arch/mips/include/asm/netlogic/psb-bootinfo.h      |  109 ++
 arch/mips/include/asm/netlogic/xlr/gpio.h          |   73 +
 arch/mips/include/asm/netlogic/xlr/iomap.h         |  131 ++
 arch/mips/include/asm/netlogic/xlr/pic.h           |  231 +++
 arch/mips/include/asm/netlogic/xlr/xlr.h           |   75 +
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/cpu-probe.c                       |   55 +
 arch/mips/lib/Makefile                             |    1 +
 arch/mips/mm/Makefile                              |    1 +
 arch/mips/mm/c-r4k.c                               |    1 +
 arch/mips/mm/tlbex.c                               |    1 +
 arch/mips/netlogic/Kconfig                         |    5 +
 arch/mips/netlogic/xlr/Makefile                    |    5 +
 arch/mips/netlogic/xlr/irq.c                       |  300 ++++
 arch/mips/netlogic/xlr/platform.c                  |  187 +++
 arch/mips/netlogic/xlr/setup.c                     |  188 +++
 arch/mips/netlogic/xlr/smp.c                       |  225 +++
 arch/mips/netlogic/xlr/smpboot.S                   |   94 ++
 arch/mips/netlogic/xlr/time.c                      |   51 +
 arch/mips/netlogic/xlr/xlr_console.c               |   46 +
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/pci-xlr.c                            |  214 +++
 drivers/usb/host/ehci-hcd.c                        |    5 +
 drivers/usb/host/ehci-xls.c                        |  161 ++
 drivers/usb/host/ohci-hcd.c                        |    5 +
 drivers/usb/host/ohci-xls.c                        |  151 ++
 36 files changed, 4315 insertions(+), 0 deletions(-)
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
 create mode 100644 arch/mips/pci/pci-xlr.c
 create mode 100644 drivers/usb/host/ehci-xls.c
 create mode 100644 drivers/usb/host/ohci-xls.c


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
