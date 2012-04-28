Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:13:45 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:4934 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903697Ab2D1NMv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:12:51 +0200
Received: from [10.9.200.131] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 28 Apr 2012 06:12:36 -0700
X-Server-Uuid: B730DE51-FC43-4C83-941F-F1F78A914BDD
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 28 Apr 2012 06:12:31 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id EBC3E9F9F5; Sat, 28
 Apr 2012 06:12:30 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Sat, 28 Apr 2012 06:12:30 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 00/12] Netlogic XLR/XLS/XLP updates
Date:   Sat, 28 Apr 2012 18:42:06 +0530
Message-ID: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 6385334E3E024591298-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Fixes and updates for the next merge window. This includes
 - PCI fixs for XLR/XLS
 - I2C, Flash and USB platform drivers for XLR/XLS
 - XLP SMP code update and clean up
 - XLP TLB size fix
 - XLP USB and PCI changes.

Let me know if there are any comments.

Thanks,
JC.

Ganesan Ramalingam (4):
  MIPS: Netlogic: MSI enable fix for XLS
  MIPS: Netlogic: Platform NAND/NOR flash support
  MIPS: Netlogic: XLP PCIe controller support.
  MIPS: Netlogic: USB support for XLP

Jayachandran C (8):
  MIPS: Netlogic: Fix PCIX irq on XLR chips
  MIPS: Netlogic: Remove unused pcibios_fixups
  MIPS: Netlogic: Fix TLB size of boot CPU.
  MIPS: Netlogic: Update comments in smpboot.S
  MIPS: Netlogic: SMP wakeup code update
  MIPS: Netlogic: Remove NETLOGIC_ prefix
  MIPS: Netlogic: Platform changes for XLS USB
  MIPS: Netlogic: Platform changes for XLR/XLS I2C

 arch/mips/Kconfig                                  |    3 +-
 arch/mips/configs/nlm_xlr_defconfig                |    4 +
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |    4 +-
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h     |    5 +-
 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h    |   76 ++++++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |    4 +
 arch/mips/include/asm/netlogic/xlp-hal/usb.h       |   64 +++++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h       |   14 +-
 arch/mips/include/asm/netlogic/xlr/bridge.h        |  104 +++++++++
 arch/mips/include/asm/netlogic/xlr/flash.h         |   55 +++++
 arch/mips/include/asm/netlogic/xlr/gpio.h          |   59 ++---
 arch/mips/netlogic/common/smpboot.S                |  159 ++++++++-----
 arch/mips/netlogic/xlp/Makefile                    |    1 +
 arch/mips/netlogic/xlp/nlm_hal.c                   |   40 ++++
 arch/mips/netlogic/xlp/platform.c                  |    2 +-
 arch/mips/netlogic/xlp/setup.c                     |    8 +-
 arch/mips/netlogic/xlp/usb-init.c                  |  124 ++++++++++
 arch/mips/netlogic/xlr/Makefile                    |    2 +-
 arch/mips/netlogic/xlr/platform-flash.c            |  220 +++++++++++++++++
 arch/mips/netlogic/xlr/platform.c                  |  140 +++++++++++
 arch/mips/netlogic/xlr/setup.c                     |    2 +-
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/pci-xlp.c                            |  247 ++++++++++++++++++++
 arch/mips/pci/pci-xlr.c                            |   36 ++-
 24 files changed, 1270 insertions(+), 104 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/usb.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/bridge.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/flash.h
 create mode 100644 arch/mips/netlogic/xlp/usb-init.c
 create mode 100644 arch/mips/netlogic/xlr/platform-flash.c
 create mode 100644 arch/mips/pci/pci-xlp.c

-- 
1.7.9.5
