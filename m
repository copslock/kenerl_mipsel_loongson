Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2011 10:10:17 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4878 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491107Ab1HWIJU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Aug 2011 10:09:20 +0200
X-TM-IMSS-Message-ID: <5bb8aee40000ab72@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 5bb8aee40000ab72 ; Tue, 23 Aug 2011 01:07:19 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 23 Aug 2011 01:01:27 -0700
Date:   Tue, 23 Aug 2011 13:34:46 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 0/4] MIPS: Netlogic: XLR/XLS updates
Message-ID: <cover.1314086142.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Aug 2011 08:01:27.0807 (UTC) FILETIME=[DC57C8F0:01CC616A]
X-archive-position: 30951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16621

I had posted 3 of these changes as a single patch earlier, but here I have
split them up to different patches.

There is also a new patch to add very basic PCI MSI support on XLR and XLS.

Ganesan Ramalingam (1):
  MIPS: Netlogic: Add basic MSI support for XLR/XLS

Jayachandran C (3):
  MIPS: Netlogic: Change load address
  MIPS: Netlogic: add r4k_wait as the cpu_wait
  MIPS: Netlogic: Avoid unnecessary cache flushes

 arch/mips/Kconfig                                  |    1 +
 .../asm/mach-netlogic/cpu-feature-overrides.h      |    5 +-
 arch/mips/include/asm/netlogic/xlr/msidef.h        |   84 ++++++++++++++++++++
 arch/mips/kernel/cpu-probe.c                       |    1 +
 arch/mips/netlogic/Platform                        |    2 +-
 arch/mips/netlogic/xlr/irq.c                       |    5 +
 arch/mips/pci/pci-xlr.c                            |   51 ++++++++++++-
 7 files changed, 144 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlr/msidef.h

-- 
1.7.4.1
