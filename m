Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 16:07:23 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:44832 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903761Ab1KUPHT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 16:07:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 781D2140245;
        Mon, 21 Nov 2011 16:07:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a6vT0kfSpBPC; Mon, 21 Nov 2011 16:07:13 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 7879D140463;
        Mon, 21 Nov 2011 16:06:55 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rene Bolldorf <xsecute@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v4 0/7] MIPS: ath79: cleanup AR724X PCI support code
Date:   Mon, 21 Nov 2011 16:06:32 +0100
Message-Id: <1321887999-14546-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17379

This patch-set contains patches to clean up the recently 
introduced code for the AR724X PCI controller. This is required
to allow to add support for the AR71XX PCI controller. 

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
