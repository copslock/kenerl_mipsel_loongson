Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:21:41 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:2763 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010199AbbAGLVYgvU51 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:24 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54466602"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw1-out.broadcom.com with ESMTP; 07 Jan 2015 05:25:11 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:15 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:42 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 AF46A40FE5;    Wed,  7 Jan 2015 03:20:27 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 00/17] Netlogic XLP updates
Date:   Wed, 7 Jan 2015 16:58:21 +0530
Message-ID: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This patchset is a collection of fixes and updates to the Netlogic
platform support.

Comments/suggestions welcome.

JC.

Ganesan Ramalingam (5):
  MIPS: Netlogic: Fix cop0 prid check in AHCI init
  MIPS: Netlogic: Fix for SATA PHY init
  MIPS: Netlogic: Fix frequency calculation register
  MIPS: Netlogic: Add irq mapping and setup for XHCI port 3
  MIPS: Netlogic: Add built-in dts for XLP5xx boards

Jayachandran C (8):
  MIPS: Netlogic: Disable writing IRT for disabled blocks
  MIPS: MSI: Update MSI handling for XLP
  MIPS: Netlogic: Use MIPS topology.h
  MIPS: Netlogic: Move cores per node out of multi-node.h
  MIPS: Netlogic: nlm_core_id for xlp9xx
  MIPS: Netlogic: Update function to read DRAM BARs
  MIPS: Netlogic: Handle XLP hardware errata
  MIPS: Netlogic: Do not enable SUE for core

Prem Mallappa (1):
  MIPS: Netlogic: Added HugeTLB as default

Qingmin Liu (1):
  MIPS: Netlogic: Fix nlm_xlp2_get_pic_frequency to use ref_div

Shanghui Liu (1):
  MIPS: Netlogic: Fix wait for slave CPUs

Subhendu Sekhar Behera (1):
  MIPS: Netlogic: i2c IRQ mappings for XLP9XX

 arch/mips/Kconfig                                  |  1 +
 arch/mips/boot/dts/Makefile                        |  1 +
 arch/mips/boot/dts/xlp_rvp.dts                     | 77 ++++++++++++++++++++++
 arch/mips/include/asm/mach-netlogic/multi-node.h   |  9 ---
 arch/mips/include/asm/mach-netlogic/topology.h     | 15 -----
 arch/mips/include/asm/netlogic/common.h            | 21 +++++-
 arch/mips/include/asm/netlogic/mips-extns.h        |  8 ++-
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |  2 +
 arch/mips/include/asm/netlogic/xlp-hal/sys.h       |  3 +
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h       |  3 +-
 arch/mips/netlogic/Kconfig                         |  9 +++
 arch/mips/netlogic/common/irq.c                    | 10 +--
 arch/mips/netlogic/common/reset.S                  | 20 +++++-
 arch/mips/netlogic/common/smp.c                    | 25 +++----
 arch/mips/netlogic/xlp/ahci-init-xlp2.c            | 13 ++++
 arch/mips/netlogic/xlp/ahci-init.c                 |  2 +-
 arch/mips/netlogic/xlp/dt.c                        | 10 ++-
 arch/mips/netlogic/xlp/nlm_hal.c                   | 57 ++++++++++------
 arch/mips/netlogic/xlp/setup.c                     |  7 +-
 arch/mips/netlogic/xlp/usb-init-xlp2.c             | 10 ++-
 arch/mips/netlogic/xlp/wakeup.c                    | 10 +--
 arch/mips/pci/msi-xlp.c                            | 19 +++---
 22 files changed, 244 insertions(+), 88 deletions(-)
 create mode 100644 arch/mips/boot/dts/xlp_rvp.dts
 delete mode 100644 arch/mips/include/asm/mach-netlogic/topology.h

-- 
1.9.1
