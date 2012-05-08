Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 14:43:41 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2743 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903636Ab2EHMmn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 14:42:43 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 08 May 2012 05:42:42 -0700
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 8 May 2012 05:41:38 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id DA1019F9F7; Tue, 8
 May 2012 05:42:17 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Tue, 8 May 2012 05:42:17 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH UPDATED 00/14] Netlogic XLR/XLS/XLP updates.
Date:   Tue, 8 May 2012 18:11:54 +0530
Message-ID: <1336480928-18887-1-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 63B7CB4844G1245115-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This is an update for the patcheset I had posted earlier.

The changes from v1 are:
 - re-write the MSI fix a bit make it look better [and also update 
   commit message - noted by sshtylyov@mvista.com]
 - Add two more patches for XLP - one to probe FDT SoC devices, and 
   another to add a few IRQs which will be used for SoC devices.

[Description of the patchset from v1]
Fixes and updates for the next merge window. This includes
 - PCI fixs for XLR/XLS
 - I2C, Flash and USB platform drivers for XLR/XLS
 - XLP SMP code update and clean up
 - XLP TLB size fix
 - XLP USB and PCI changes.

Let me know if there are any comments.

Thanks,
JC.

Ganesan Ramalingam (5):
  MIPS: Netlogic: MSI enable fix for XLS
  MIPS: Netlogic: Platform NAND/NOR flash support
  MIPS: Netlogic: XLP PCIe controller support.
  MIPS: Netlogic: USB support for XLP
  MIPS: Netlogic: Add XLP SoC devices in FDT

Jayachandran C (9):
  MIPS: Netlogic: Fix PCIX irq on XLR chips
  MIPS: Netlogic: Remove unused pcibios_fixups
  MIPS: Netlogic: Fix TLB size of boot CPU.
  MIPS: Netlogic: Update comments in smpboot.S
  MIPS: Netlogic: SMP wakeup code update
  MIPS: Netlogic: Remove NETLOGIC_ prefix
  MIPS: Netlogic: Platform changes for XLS USB
  MIPS: Netlogic: Platform changes for XLR/XLS I2C
  MIPS: Netlogic: Add IRQ mappings for more devices

 arch/mips/Kconfig                                  |    3 +-
 arch/mips/configs/nlm_xlr_defconfig                |    4 +
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |    4 +-
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h     |    5 +-
 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h    |   76 ++++++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |    4 +
 arch/mips/include/asm/netlogic/xlp-hal/usb.h       |   64 +++++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h       |   17 +-
 arch/mips/include/asm/netlogic/xlr/bridge.h        |  104 +++++++++
 arch/mips/include/asm/netlogic/xlr/flash.h         |   55 +++++
 arch/mips/include/asm/netlogic/xlr/gpio.h          |   59 ++---
 arch/mips/netlogic/common/smpboot.S                |  159 ++++++++-----
 arch/mips/netlogic/xlp/Makefile                    |    1 +
 arch/mips/netlogic/xlp/nlm_hal.c                   |   52 +++++
 arch/mips/netlogic/xlp/platform.c                  |    2 +-
 arch/mips/netlogic/xlp/setup.c                     |   24 +-
 arch/mips/netlogic/xlp/usb-init.c                  |  124 ++++++++++
 arch/mips/netlogic/xlr/Makefile                    |    2 +-
 arch/mips/netlogic/xlr/platform-flash.c            |  220 +++++++++++++++++
 arch/mips/netlogic/xlr/platform.c                  |  140 +++++++++++
 arch/mips/netlogic/xlr/setup.c                     |    2 +-
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/pci-xlp.c                            |  247 ++++++++++++++++++++
 arch/mips/pci/pci-xlr.c                            |   65 ++++--
 24 files changed, 1326 insertions(+), 108 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/usb.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/bridge.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/flash.h
 create mode 100644 arch/mips/netlogic/xlp/usb-init.c
 create mode 100644 arch/mips/netlogic/xlr/platform-flash.c
 create mode 100644 arch/mips/pci/pci-xlp.c

-- 
1.7.9.5
