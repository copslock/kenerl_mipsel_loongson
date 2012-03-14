Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:24:30 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34860 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903648Ab2CNJXr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:23:47 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9F69023C00C4;
        Wed, 14 Mar 2012 09:53:22 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org
Subject: [PATCH v5 0/7] MIPS: ath79: cleanup AR724X PCI support code
Date:   Wed, 14 Mar 2012 11:29:20 +0100
Message-Id: <1331720967-4049-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch-set contains patches to clean up the recently 
introduced code for the AR724X PCI controller. This is required
to allow to add support for the AR71XX PCI controller.

Changes since v4:
 -fix build failure if PCI support is disabled.

Gabor Juhos (7):
  MIPS: ath79: separate common PCI code
  MIPS: ath79: rename pci-ath724x.h
  MIPS: ath79: make ath724x_pcibios_init visible for external code
  MIPS: ath79: add a common PCI registration function
  MIPS: ath79: rename pci-ath724x.c to make it reflect the real SoC name
  MIPS: ath79: replace ath724x to ar724x
  MIPS: ath79: use io-accessor macros in pci-ar724x.c

 arch/mips/ath79/Makefile                           |    1 +
 arch/mips/ath79/mach-ubnt-xm.c                     |    7 +-
 arch/mips/ath79/pci.c                              |   56 +++++++
 .../asm/mach-ath79/pci-ath724x.h => ath79/pci.h}   |   16 ++-
 .../asm/mach-ath79/{pci-ath724x.h => pci.h}        |   17 +-
 arch/mips/pci/Makefile                             |    2 +-
 arch/mips/pci/pci-ar724x.c                         |  149 +++++++++++++++++
 arch/mips/pci/pci-ath724x.c                        |  174 --------------------
 8 files changed, 230 insertions(+), 192 deletions(-)
 create mode 100644 arch/mips/ath79/pci.c
 copy arch/mips/{include/asm/mach-ath79/pci-ath724x.h => ath79/pci.h} (53%)
 rename arch/mips/include/asm/mach-ath79/{pci-ath724x.h => pci.h} (53%)
 create mode 100644 arch/mips/pci/pci-ar724x.c
 delete mode 100644 arch/mips/pci/pci-ath724x.c

-- 
1.7.2.1
