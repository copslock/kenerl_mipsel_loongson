Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 18:56:35 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:42042 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904611Ab1KXR42 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Nov 2011 18:56:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 3A2011405B2;
        Thu, 24 Nov 2011 18:56:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XxvSN9RtujWx; Thu, 24 Nov 2011 18:56:21 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 6F251140505;
        Thu, 24 Nov 2011 18:56:21 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 00/12] MIPS: ath79: AR724X PCI fixes and AR71XX PCI support
Date:   Thu, 24 Nov 2011 18:55:55 +0100
Message-Id: <1322157367-31089-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-archive-position: 31964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21006

This patch set fixes some errors in the AR724X specific
PCI code, and adds support for the PCI Host controller
of the AR71XX SoCs.

This set depends on v4 of the
'MIPS: ath79: cleanup AR724X PCI support code' patches.

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
