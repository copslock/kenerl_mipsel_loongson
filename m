Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 19:10:58 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55794 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903618Ab2D0RK0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Apr 2012 19:10:26 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A52F023C006E;
        Fri, 27 Apr 2012 19:10:20 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 0/2] MIPS: ath79: various fixes
Date:   Fri, 27 Apr 2012 19:10:11 +0200
Message-Id: <1335546613-32078-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 33030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This set contains two fixes for the ath79 platform.

It is based on the mips-for-linux-next branch of the 
upstream-sfr tree.

Gabor Juhos (2):
  MIPS: ath79: fix number of GPIO lines for AR724[12]
  MIPS: ath79: use correct IRQ number for the OHCI controller on AR7240

 arch/mips/ath79/dev-usb.c                      |    2 ++
 arch/mips/ath79/gpio.c                         |    6 ++++--
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

-- 
1.7.2.1
