Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 17:13:01 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4121 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831953Ab3ANQMiRa4eY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Jan 2013 17:12:38 +0100
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Jan 2013 08:07:16 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 irvexchcas06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server id 14.1.355.2; Mon, 14 Jan 2013 08:09:27 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 2B0BF40FE3; Mon, 14
 Jan 2013 08:09:25 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 00/10] Netlogic: Fixes and updates for 3.9
Date:   Mon, 14 Jan 2013 21:41:52 +0530
Message-ID: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7CEAF2BE3Q42012102-04-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35427
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Here are the updates and fixes to Netlogic XLR/XLS/XLP platform code
for 3.9. The major changes in the patchset are:
 - Update PIC and irq code to optimize EIMR/EIRR register access
   in 32-bit kernel.
 - Add PIC timer 7 as a clocksource for both XLR and XLP. This is
   a better clocksource compared with Cop0 count, and the PIC timer
   count register is available to all cores.
 - Fix quad-XLP boards boot problem, and add support for PCIe devices
   on all the SoCs on quad-XLP boards.
The rest are minor fixes for various issues.

JC.

Jayachandran C (10):
  MIPS: Netlogic: add XLS6xx to FMN config
  MIPS: Netlogic: Optimize EIMR/EIRR accesses in 32-bit
  MIPS: PCI: Byteswap not needed in little-endian mode
  MIPS: Netlogic: Split XLP L1 i-cache among threads
  MIPS: Netlogic: Use PIC timer as a clocksource
  MIPS: PCI: Prevent hang on XLP reg read
  MIPS: Netlogic: No hazards needed for XLR/XLS
  MIPS: Netlogic: use preset loops per jiffy
  MIPS: Netlogic: Fix for quad-XLP boot
  MIPS: PCI: Multi-node PCI support for Netlogic XLP

 arch/mips/include/asm/hazards.h                    |    2 +-
 arch/mips/include/asm/netlogic/mips-extns.h        |   79 +++++++++++++
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |    2 +
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |   12 +-
 arch/mips/include/asm/netlogic/xlr/pic.h           |   48 +++++++-
 arch/mips/netlogic/common/irq.c                    |   41 +++----
 arch/mips/netlogic/common/smp.c                    |    8 +-
 arch/mips/netlogic/common/smpboot.S                |    6 +
 arch/mips/netlogic/common/time.c                   |   56 ++++++++++
 arch/mips/netlogic/xlp/wakeup.c                    |   35 ++++--
 arch/mips/netlogic/xlr/fmn-config.c                |    2 +
 arch/mips/netlogic/xlr/platform.c                  |    2 +-
 arch/mips/netlogic/xlr/setup.c                     |    2 +-
 arch/mips/pci/pci-xlp.c                            |  116 +++++++++++++-------
 14 files changed, 322 insertions(+), 89 deletions(-)

-- 
1.7.9.5
