Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:40:32 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34303 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903729Ab2CNJkC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:40:02 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id DEB4223C00C1;
        Wed, 14 Mar 2012 10:09:29 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, juhosg@openwrt.org
Subject: [PATCH v2 00/13] MIPS: ath79: add initial support for the Atheros AR934X SoCs
Date:   Wed, 14 Mar 2012 11:45:18 +0100
Message-Id: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 32694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch set adds initial support for the Atheros AR934X SoCs.

This depends on the following patch set:
v3 of 'MIPS: ath79: AR724X PCI fixes and AR71XX PCI support'

Changes since v1:
 - the watchdog related patch is removed because that is in
   in upstream already
 - the USB support is removed, it will be reintroduced by a
   separate series 

Gabor Juhos (13):
  MIPS: ath79: add early_printk support for AR934X
  MIPS: ath79: sort case statements in ath79_detect_sys_type
  MIPS: ath79: add SoC detection code for AR934X
  MIPS: ath79: add clock initialization code for AR934X
  MIPS: ath79: add GPIO support code for AR934X
  MIPS: ath79: rework IP2/IP3 interrupt handling
  MIPS: ath79: add IRQ handling code for AR934X
  MIPS: ath79: add AR934X specific glue to ath79_device_reset_{clear,set}
  MIPS: ath79: register UART device for AR934X SoCs
  MIPS: ath79: add WMAC registration code for AR934X
  MIPS: ath79: add PCI_AR724X Kconfig symbol
  MIPS: ath79: add PCI registration code for AR934X
  MIPS: ath79: add initial support for the Atheros DB120 board

 arch/mips/ath79/Kconfig                        |   24 ++++-
 arch/mips/ath79/Makefile                       |    1 +
 arch/mips/ath79/clock.c                        |   81 +++++++++++++
 arch/mips/ath79/common.c                       |    9 ++-
 arch/mips/ath79/dev-common.c                   |    3 +-
 arch/mips/ath79/dev-wmac.c                     |   30 +++++-
 arch/mips/ath79/early_printk.c                 |    3 +
 arch/mips/ath79/gpio.c                         |   47 +++++++-
 arch/mips/ath79/irq.c                          |  147 +++++++++++++++++++----
 arch/mips/ath79/mach-db120.c                   |  153 ++++++++++++++++++++++++
 arch/mips/ath79/machtypes.h                    |    1 +
 arch/mips/ath79/pci.c                          |   13 ++-
 arch/mips/ath79/setup.c                        |   45 +++++--
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   91 ++++++++++++++-
 arch/mips/include/asm/mach-ath79/ath79.h       |   23 ++++
 arch/mips/include/asm/mach-ath79/irq.h         |    6 +-
 arch/mips/include/asm/mach-ath79/pci.h         |    2 +-
 arch/mips/pci/Makefile                         |    2 +-
 18 files changed, 635 insertions(+), 46 deletions(-)
 create mode 100644 arch/mips/ath79/mach-db120.c

-- 
1.7.2.1
