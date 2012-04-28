Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:34:44 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:32787 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903728Ab2D1Ndb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:33:31 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 37D9123C0087;
        Sat, 28 Apr 2012 15:33:29 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 0/3] MIPS: ath79: allow to use USB on AR934x
Date:   Sat, 28 Apr 2012 15:33:20 +0200
Message-Id: <1335620003-6212-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 33064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch-set adds AR934x specific glue into the USB 
platform device registration code. Additionally, it 
registers the USB host controller device on the 
DB120 board.

This depends on the following patch set:
v2 of ''MIPS: ath79: various fixes'

v2: fix patch format

Gabor Juhos (3):
  MIPS: ath79: use a helper function for USB resource initialization
  MIPS: ath79: add USB platform setup code for AR934X
  MIPS: ath79: register USB host controller on the DB120 board

 arch/mips/ath79/dev-usb.c                      |   92 ++++++++++++++---------
 arch/mips/ath79/mach-db120.c                   |    2 +
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    7 ++
 3 files changed, 65 insertions(+), 36 deletions(-)

-- 
1.7.2.1
