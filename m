Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2012 19:29:18 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46146 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903825Ab2AWS3O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Jan 2012 19:29:14 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id C9E2723C00B6;
        Mon, 23 Jan 2012 19:29:12 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: ath79: fix AR933X WMAC reset code
Date:   Mon, 23 Jan 2012 19:29:07 +0100
Message-Id: <1327343347-26928-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 32314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The current code puts the built-in WMAC device of the
AR933X SoCs into reset instead of starting it. This
causes a hard lock on AR933X based boards when the
wireless driver tries to access the device.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---

Ralf,

This one is for 3.3.

Thanks,
Gabor

 arch/mips/ath79/dev-wmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/dev-wmac.c b/arch/mips/ath79/dev-wmac.c
index e215070..9c717bf 100644
--- a/arch/mips/ath79/dev-wmac.c
+++ b/arch/mips/ath79/dev-wmac.c
@@ -58,8 +58,8 @@ static void __init ar913x_wmac_setup(void)
 
 static int ar933x_wmac_reset(void)
 {
-	ath79_device_reset_clear(AR933X_RESET_WMAC);
 	ath79_device_reset_set(AR933X_RESET_WMAC);
+	ath79_device_reset_clear(AR933X_RESET_WMAC);
 
 	return 0;
 }
-- 
1.7.2.1
