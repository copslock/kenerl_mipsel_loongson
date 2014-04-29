Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:31:57 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:2296 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843076AbaD2ObwoNTJQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:31:52 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="26654960"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw3-out.broadcom.com with ESMTP; 29 Apr 2014 07:51:52 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:31:43 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:31:44 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 109DF51E7D;    Tue, 29 Apr 2014 07:31:41 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 00/17] Broadcom XLP changes for 3.16
Date:   Tue, 29 Apr 2014 20:07:39 +0530
Message-ID: <cover.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39968
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

The changes in the patchset are:
 * add support for the on chip SATA interfaces of XLP and XLPII
 * add MSI/MSIX support for the XLP9xx processors
 * add support for the new XLP5xx processors
 * update frequency calculation logic for core and PIC
 * many fixes and improvements

Patch 01/17 is to support upto 256 CPUs on mips, which is needed for
multi-node XLP9xx configuration. The rest of the changes are to Broadcom
XLR/XLP specific code.

This is for 3.16, please let me know if there are any comments.

Thanks,
JC.


Ganesan Ramalingam (4):
  MIPS: Netlogic: PIC freq calculation for XLP 9XX/2XX
  MIPS: Add MSI support for XLP9XX
  MIPS: Netlogic: Support for XLP3XX on-chip SATA
  MIPS: Netlogic: XLP9XX on-chip SATA support

Jayachandran C (12):
  MIPS: Support upto 256 CPUs
  MIPS: Netlogic: Fix uniprocessor compilation
  MIPS: Netlogic: Move coremask setup to nlm_node_init
  MIPS: Netlogic: Warn on invalid irq
  MIPS: Netlogic: Update function to read DRAM BARs
  MIPS: Netlogic: Use cpumask_scnprintf for wakup_mask
  MIPS: Netlogic: Reduce size of reset code
  MIPS: Netlogic: Enable access to more than 64GB
  MIPS: Netlogic: IRQ mapping for some more SoC blocks
  MIPS: Netlogic: Use PRID_IMP_MASK macro
  MIPS: Netlogic: Fix XLP9XX pic entry
  MIPS: Netlogic: Update XLP9XX/2XX core freq calculation

Yonghong Song (1):
  MIPS: Netlogic: Add support for XLP5XX

 arch/mips/Kconfig                               |    4 +-
 arch/mips/include/asm/cpu.h                     |    1 +
 arch/mips/include/asm/mach-netlogic/topology.h  |    2 +
 arch/mips/include/asm/netlogic/mips-extns.h     |    5 +-
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h  |   18 +-
 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h |   14 +
 arch/mips/include/asm/netlogic/xlp-hal/pic.h    |    4 +
 arch/mips/include/asm/netlogic/xlp-hal/sys.h    |   35 +++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h    |   21 +-
 arch/mips/kernel/cpu-probe.c                    |    1 +
 arch/mips/netlogic/common/irq.c                 |    2 +
 arch/mips/netlogic/common/reset.S               |   39 ++-
 arch/mips/netlogic/common/smp.c                 |    7 +-
 arch/mips/netlogic/common/smpboot.S             |    6 +-
 arch/mips/netlogic/common/time.c                |    5 +-
 arch/mips/netlogic/dts/xlp_gvp.dts              |    5 +-
 arch/mips/netlogic/xlp/Makefile                 |    2 +
 arch/mips/netlogic/xlp/ahci-init-xlp2.c         |  378 +++++++++++++++++++++++
 arch/mips/netlogic/xlp/ahci-init.c              |  209 +++++++++++++
 arch/mips/netlogic/xlp/dt.c                     |    3 +-
 arch/mips/netlogic/xlp/nlm_hal.c                |  295 +++++++++++++-----
 arch/mips/netlogic/xlp/setup.c                  |    5 +-
 arch/mips/netlogic/xlp/wakeup.c                 |   16 +-
 arch/mips/pci/msi-xlp.c                         |  178 ++++++++---
 24 files changed, 1079 insertions(+), 176 deletions(-)
 create mode 100644 arch/mips/netlogic/xlp/ahci-init-xlp2.c
 create mode 100644 arch/mips/netlogic/xlp/ahci-init.c

-- 
1.7.9.5
