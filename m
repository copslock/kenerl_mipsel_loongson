Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:30:59 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:42609 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903715Ab2CNJah (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:30:37 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id DE2A723C00C9;
        Wed, 14 Mar 2012 10:00:07 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org
Subject: [PATCH v3 00/12] MIPS: ath79: AR724X PCI fixes and AR71XX PCI support
Date:   Wed, 14 Mar 2012 11:36:02 +0100
Message-Id: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 32681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch set fixes some errors in the AR724X specific
PCI code, and adds support for the PCI Host controller
of the AR71XX SoCs.

This depends the following patch set:
v5 of 'MIPS: ath79: cleanup AR724X PCI support code'

Changes since v2:
 - fix build error if PCI is disabled

Gabor Juhos (12):
  MIPS: ath79: remove superfluous alignment checks from pci-ar724x.c
  MIPS: ath79: fix broken ar724x_pci_{read,write} functions
  MIPS: ath79: add a workaround for a PCI controller bug in AR7240 SoCs
  MIPS: ath79: fix a wrong IRQ number
  MIPS: ath79: add PCI IRQ handling code for AR724X SoCs
  MIPS: ath79: get rid of some ifdefs in mach-ubnt-xm.c
  MIPS: ath79: allow to use board specific pci_plat_dev_init functions
  MIPS: ath79: add support for the PCI host controller of the AR71XX
    SoCs
  MIPS: ath79: allow to use SoC specific PCI IRQ maps
  MIPS: ath79: remove ar724x_pci_add_data function
  MIPS: ath79: register PCI controller on the PB44 board
  MIPS: ath79: update copyright headers of PCI related files

 arch/mips/ath79/Kconfig                |    1 +
 arch/mips/ath79/mach-pb44.c            |    2 +
 arch/mips/ath79/mach-ubnt-xm.c         |   42 ++--
 arch/mips/ath79/pci.c                  |   97 +++++++--
 arch/mips/ath79/pci.h                  |   19 +-
 arch/mips/include/asm/mach-ath79/irq.h |    6 +-
 arch/mips/include/asm/mach-ath79/pci.h |   14 +-
 arch/mips/pci/Makefile                 |    1 +
 arch/mips/pci/pci-ar71xx.c             |  375 ++++++++++++++++++++++++++++++++
 arch/mips/pci/pci-ar724x.c             |  211 +++++++++++++++---
 10 files changed, 689 insertions(+), 79 deletions(-)
 create mode 100644 arch/mips/pci/pci-ar71xx.c

-- 
1.7.2.1
