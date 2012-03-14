Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:23:14 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34753 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903648Ab2CNJXH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:23:07 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0420E23C00C4;
        Wed, 14 Mar 2012 09:52:38 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org
Subject: [PATCH 0/2] MIPS: ath79: small fixes
Date:   Wed, 14 Mar 2012 11:28:34 +0100
Message-Id: <1331720916-4015-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 32669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch-set contains a fix and a cleanup for ath79. Both patch was 
submitted to the list already, this is a rebased version of them.

Gabor Juhos (1):
  MIPS: ath79: fix AR933X WMAC reset code

Thomas Meyer (1):
  MIPS: ath79: Use kmemdup rather than duplicating its implementation

 arch/mips/ath79/dev-gpio-buttons.c |    4 +---
 arch/mips/ath79/dev-leds-gpio.c    |    4 +---
 arch/mips/ath79/dev-wmac.c         |    2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

-- 
1.7.2.1
