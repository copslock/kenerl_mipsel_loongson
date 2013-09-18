Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 13:33:33 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:44796 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825727Ab3IRLdIa6R8k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 13:33:08 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 0259B857F;
        Wed, 18 Sep 2013 13:33:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SeizSQ5FfF4r; Wed, 18 Sep 2013 13:33:03 +0200 (CEST)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 88E2F8F61;
        Wed, 18 Sep 2013 13:33:03 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] MIPS: BCM47XX: fix detected clock on Asus WL520GC and WL520GU
Date:   Wed, 18 Sep 2013 13:33:00 +0200
Message-Id: <1379503980-9156-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1379503980-9156-1-git-send-email-hauke@hauke-m.de>
References: <1379503980-9156-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The Asus WL520GC and WL520GU are based on the BCM5354 and clocked at
200MHz, but they do not have a clkfreq nvram variable set to the
correct value. This adds a workaround for these devices.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

This depends on MIPS: BCM47XX: add board detection

 arch/mips/bcm47xx/time.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/bcm47xx/time.c b/arch/mips/bcm47xx/time.c
index 5e5d797..2c85d92 100644
--- a/arch/mips/bcm47xx/time.c
+++ b/arch/mips/bcm47xx/time.c
@@ -28,6 +28,7 @@
 #include <asm/time.h>
 #include <bcm47xx.h>
 #include <bcm47xx_nvram.h>
+#include <bcm47xx_board.h>
 
 void __init plat_time_init(void)
 {
@@ -35,6 +36,7 @@ void __init plat_time_init(void)
 	u16 chip_id = 0;
 	char buf[10];
 	int len;
+	enum bcm47xx_board board = bcm47xx_board_get();
 
 	/*
 	 * Use deterministic values for initial counter interrupt
@@ -64,6 +66,15 @@ void __init plat_time_init(void)
 			hz = 100000000;
 	}
 
+	switch (board) {
+	case BCM47XX_BOARD_ASUS_WL520GC:
+	case BCM47XX_BOARD_ASUS_WL520GU:
+		hz = 100000000;
+		break;
+	default:
+		break;
+	}
+
 	if (!hz)
 		hz = 100000000;
 
-- 
1.7.10.4
