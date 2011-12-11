Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2011 17:12:05 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:49972 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903704Ab1LKQMB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Dec 2011 17:12:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id CE7AE140679;
        Sun, 11 Dec 2011 17:11:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nbF4eJSuRPhC; Sun, 11 Dec 2011 17:11:55 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 3EF26140653;
        Sun, 11 Dec 2011 17:11:55 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: ath79: avoid a kernel bug on AR913X
Date:   Sun, 11 Dec 2011 17:11:41 +0100
Message-Id: <1323619901-2512-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-archive-position: 32084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8605

Wireless mac registration causes a BUG on AR913X SoCs due to
a missing 'else'.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-wmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/dev-wmac.c b/arch/mips/ath79/dev-wmac.c
index 24f5469..e215070 100644
--- a/arch/mips/ath79/dev-wmac.c
+++ b/arch/mips/ath79/dev-wmac.c
@@ -96,7 +96,7 @@ void __init ath79_register_wmac(u8 *cal_data)
 {
 	if (soc_is_ar913x())
 		ar913x_wmac_setup();
-	if (soc_is_ar933x())
+	else if (soc_is_ar933x())
 		ar933x_wmac_setup();
 	else
 		BUG();
-- 
1.7.2.1
