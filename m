Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2011 18:54:47 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:3938 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491097Ab1DVQxx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2011 18:53:53 +0200
X-TM-IMSS-Message-ID: <e42c461000016b66@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id e42c461000016b66 ; Fri, 22 Apr 2011 09:53:34 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 22 Apr 2011 09:54:06 -0700
Date:   Fri, 22 Apr 2011 22:30:45 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 0/8] Support for Netlogic XLR/XLS processors
Message-ID: <cover.1303487516.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 22 Apr 2011 16:54:06.0649 (UTC) FILETIME=[E47CD290:01CC010D]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Here's the latest version of the patchset for XLR/XLS support on 
Linux/MIPS, with PCI and USB support added.

I would really appreciate a ACK/NAK if there is any issue with
the code or license, since at this point I'm not sure why this
patchset has not been merged.

Thanks,
JC.

Changes from last version(v3):
* USB support for XLS processors
* PCI support for XLR/XLS processors
* irq code updated - added PCI interrupts, minor fixes.

Changes from last version(v2):
* Netlogic files updated to use a dual license (GPLv2 or Netlogic
  2-clause BSD license.)
* irq.c updated to use new style of irq_data based handlers.
* Rebased to latest linux-mips master tip.
* Minor reshuffle of patches to group them better.

Changes from last version(v1):
* Initial 64-bit support
* cleanup irq.c, don't use irq_desc[] directly
* couple of checkpatch.pl white-space fixes

Changes from last version(v0):
* Remove c-netlogic.c for now, c-r4k works well enough for the first
  cut, so the custom cache handler can be considered later.
* More elaborate asm/mach-netlogic/cpu-feature-overrides.h
  (noted by David Daney)

These set of patches add support for the XLR and XLS multi-core MIPS64
SoCs from Netlogic Microsystems.

These changes enable us to boot linux-mips on Netlogic evaluation boards
from the netlogic bootloader.

Jayachandran C (8):
  Netlogic XLR/XLS processor IDs.
  mach-netlogic include directory and files.
  Cache support, TLB support, asm/module.h entry
  Platform files for XLR/XLS processor support.
  Kconfig and Makefile update for Netlogic XLR/XLS
  Add default configuration for XLR/XLS processors
  USB support for XLS platforms.
  PCI support for XLR/XLS

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
 arch/mips/include/asm/netlogic/pci.h               |    8 +
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
 arch/mips/netlogic/xlr/platform.c                  |  189 +++
 arch/mips/netlogic/xlr/setup.c                     |  188 +++
 arch/mips/netlogic/xlr/smp.c                       |  225 +++
 arch/mips/netlogic/xlr/smpboot.S                   |   94 ++
 arch/mips/netlogic/xlr/time.c                      |   51 +
 arch/mips/netlogic/xlr/xlr_console.c               |   46 +
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/pci-xlr.c                            |  215 +++
 drivers/usb/host/ehci-hcd.c                        |    5 +
 drivers/usb/host/ehci-xls.c                        |  170 ++
 drivers/usb/host/ohci-hcd.c                        |    5 +
 drivers/usb/host/ohci-xls.c                        |  160 ++
 37 files changed, 4344 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/configs/nlm_xlr_defconfig
 create mode 100644 arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-netlogic/irq.h
 create mode 100644 arch/mips/include/asm/mach-netlogic/war.h
 create mode 100644 arch/mips/include/asm/netlogic/interrupt.h
 create mode 100644 arch/mips/include/asm/netlogic/mips-extns.h
 create mode 100644 arch/mips/include/asm/netlogic/pci.h
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
