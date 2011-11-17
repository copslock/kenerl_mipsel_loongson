Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 23:16:08 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:46697 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904067Ab1KQWOW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 23:14:22 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 2AB4914047E;
        Thu, 17 Nov 2011 23:14:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cjb5LbSF7DR2; Thu, 17 Nov 2011 23:14:14 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 01B211403D6;
        Thu, 17 Nov 2011 23:14:13 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 0/6] Allow to register wireless MAC device on AR933X based boards
Date:   Thu, 17 Nov 2011 23:13:41 +0100
Message-Id: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-archive-position: 31752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14884

This patch-set makes it possible to register a platform device 
for the built-in wireless MAC of the Atheros AR933X SoCs.

Gabor Juhos (6):
  MIPS: ath79: store the SoC revision in a global variable
  MIPS: ath79: remove 'ar913x' from common variable and function names
  MIPS: ath79: separate AR913x SoC specific WMAC setup code
  MIPS: ath79: add AR933x specific WMAC setup code
  MIPS: ath79: rename ATH79_DEV_AR913X_WMAC option to ATH79_DEV_WMAC
  MIPS: ath79: register the wireless MAC device on the AP121 board

 arch/mips/ath79/Kconfig                        |   11 ++--
 arch/mips/ath79/Makefile                       |    2 +-
 arch/mips/ath79/common.c                       |    1 +
 arch/mips/ath79/dev-ar913x-wmac.c              |   81 +++++++++++++++++++-----
 arch/mips/ath79/dev-ar913x-wmac.h              |   12 ++--
 arch/mips/ath79/mach-ap121.c                   |    4 +
 arch/mips/ath79/mach-ap81.c                    |    2 +-
 arch/mips/ath79/setup.c                        |    2 +
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    4 +-
 arch/mips/include/asm/mach-ath79/ath79.h       |    1 +
 10 files changed, 90 insertions(+), 30 deletions(-)

-- 
1.7.2.1
