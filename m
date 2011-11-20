Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Nov 2011 22:39:40 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:41487 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903614Ab1KTVja (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Nov 2011 22:39:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 4B91014044F;
        Sun, 20 Nov 2011 22:39:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aZGxxLQhLVh5; Sun, 20 Nov 2011 22:39:24 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 8454114039D;
        Sun, 20 Nov 2011 22:39:24 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rene Bolldorf <xsecute@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 0/7] MIPS: ath79: cleanup AR724X PCI support code
Date:   Sun, 20 Nov 2011 22:39:04 +0100
Message-Id: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-archive-position: 31821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16767

This patch-set contains patches to clean up the recently 
introduced code for the AR724X PCI controller. This is required
allow to add support for the AR71XX PCI controller. 

Gabor Juhos (7):
  MIPS: ath79: separate common PCI code
  MIPS: ath79: rename pci-ath724x.h
  MIPS: ath79: make ath724x_pcibios_init visible for external code
  MIPS: ath79: add a common PCI registration function
  MIPS: ath79: rename pci-ath724x.c to make it reflect the real SoC name
  MIPS: ath79: replace ath724x to ar724x
  MIPS: ath79: use io-accessor macros in pci-ar724x.c

 arch/mips/ath79/Makefile                       |    1 +
 arch/mips/ath79/mach-ubnt-xm.c                 |    7 +-
 arch/mips/ath79/pci.c                          |   60 ++++++++
 arch/mips/ath79/pci.h                          |   27 ++++
 arch/mips/include/asm/mach-ath79/pci-ath724x.h |   21 ---
 arch/mips/include/asm/mach-ath79/pci.h         |   20 +++
 arch/mips/pci/Makefile                         |    2 +-
 arch/mips/pci/pci-ar724x.c                     |  149 ++++++++++++++++++++
 arch/mips/pci/pci-ath724x.c                    |  174 ------------------------
 9 files changed, 262 insertions(+), 199 deletions(-)
 create mode 100644 arch/mips/ath79/pci.c
 create mode 100644 arch/mips/ath79/pci.h
 delete mode 100644 arch/mips/include/asm/mach-ath79/pci-ath724x.h
 create mode 100644 arch/mips/include/asm/mach-ath79/pci.h
 create mode 100644 arch/mips/pci/pci-ar724x.c
 delete mode 100644 arch/mips/pci/pci-ath724x.c

-- 
1.7.2.1
