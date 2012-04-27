Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 19:11:46 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55987 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903631Ab2D0RLg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Apr 2012 19:11:36 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E730323C006E;
        Fri, 27 Apr 2012 19:11:34 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 0/3] MIPS: ath79: allow to use USB on AR934x
Date:   Fri, 27 Apr 2012 19:11:24 +0200
Message-Id: <1335546687-32179-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 33032
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
'MIPS: ath79: various fixes'

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
