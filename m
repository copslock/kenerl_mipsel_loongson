Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2012 15:39:03 +0100 (CET)
Received: from smtpgw1.netlogicmicro.com ([12.203.210.53]:46713 "EHLO
        smtpgw1.netlogicmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904104Ab2BBOi4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2012 15:38:56 +0100
Received: from pps.filterd (smtpgw1 [127.0.0.1])
        by smtpgw1.netlogicmicro.com (8.14.5/8.14.5) with SMTP id q12EaoPp002226;
        Thu, 2 Feb 2012 06:38:49 -0800
Received: from hqcas02.netlogicmicro.com (hqcas02.netlogicmicro.com [10.65.50.15])
        by smtpgw1.netlogicmicro.com with ESMTP id 12hfu7nyfc-1
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 02 Feb 2012 06:38:49 -0800
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Jayachandran C <jayachandranc@netlogicmicro.com>
Subject: [PATCH 00/11] Netlogic XLR/XLP fixes and updates.
Date:   Thu, 2 Feb 2012 20:12:54 +0530
Message-ID: <cover.1328189941.git.jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.7.0.77]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.211,0.0.0000
 definitions=2012-01-28_02:2012-01-27,2012-01-28,1970-01-01 signatures=0
X-archive-position: 32383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Here are the updates to Netlogic code for the next kernel.
The changes include fixes to the current code and new features.

* Fixes for the  current code
  XLR PCI irq fix, XLP TLB size fix, XLP smp boot sequence
  fixup, remove unused code in XLR PCI.

* New features
  XLR platform USB code, XLR platform NAND/NOR flash support,
  XLR oprofile driver, XLP initial PCI support and XLP USB support.

Let me know if there are any comments or concerns.

Thanks,
JC.
  
Ganesan Ramalingam (3):
  MIPS: Netlogic: Platform NAND/NOR flash support
  MIPS: Netlogic: XLP PCIe controller support.
  MIPS: Netlogic: USB support for XLP

Jayachandran C (7):
  MIPS: Netlogic: Fix PCIX irq on XLR chips
  MIPS: Netlogic: platform changes for XLS USB.
  MIPS: Netlogic: Remove unused pcibios_fixups
  MIPS: Netlogic: Update comments in smpboot.S
  MIPS: Netlogic: SMP wakeup code update
  MIPS: Netlogic: Fix TLB size of boot CPU.
  MIPS: Netlogic: Remove NETLOGIC_ prefix

Madhusudan Bhat (1):
  MIPS: Netlogic: Oprofile driver for XLR/XLS

 arch/mips/Kconfig                                  |    3 +-
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |    4 +-
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h     |    5 +-
 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h    |   76 ++++++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |    4 +
 arch/mips/include/asm/netlogic/xlp-hal/usb.h       |   64 +++++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h       |   14 +-
 arch/mips/include/asm/netlogic/xlr/bridge.h        |  104 ++++++++
 arch/mips/include/asm/netlogic/xlr/flash.h         |   55 +++++
 arch/mips/include/asm/netlogic/xlr/gpio.h          |   59 +++---
 arch/mips/netlogic/common/smpboot.S                |  159 ++++++++-----
 arch/mips/netlogic/xlp/Makefile                    |    1 +
 arch/mips/netlogic/xlp/nlm_hal.c                   |   40 ++++
 arch/mips/netlogic/xlp/platform.c                  |    2 +-
 arch/mips/netlogic/xlp/setup.c                     |    8 +-
 arch/mips/netlogic/xlp/usb-init.c                  |  125 ++++++++++
 arch/mips/netlogic/xlr/Makefile                    |    2 +-
 arch/mips/netlogic/xlr/platform-flash.c            |  220 +++++++++++++++++
 arch/mips/netlogic/xlr/platform.c                  |   89 +++++++
 arch/mips/netlogic/xlr/setup.c                     |    2 +-
 arch/mips/oprofile/Makefile                        |    1 +
 arch/mips/oprofile/common.c                        |    1 +
 arch/mips/oprofile/op_model_mipsxx.c               |   29 +++
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/pci-xlp.c                            |  247 ++++++++++++++++++++
 arch/mips/pci/pci-xlr.c                            |    6 +-
 26 files changed, 1222 insertions(+), 99 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/usb.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/bridge.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/flash.h
 create mode 100644 arch/mips/netlogic/xlp/usb-init.c
 create mode 100644 arch/mips/netlogic/xlr/platform-flash.c
 create mode 100644 arch/mips/pci/pci-xlp.c

-- 
1.7.5.4
