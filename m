Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 13:30:12 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:44734 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824104Ab3IRLaJeQF4B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 13:30:09 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id DDDD78F62;
        Wed, 18 Sep 2013 13:30:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W0pJgq03qhdo; Wed, 18 Sep 2013 13:30:02 +0200 (CEST)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 39BEA8F61;
        Wed, 18 Sep 2013 13:30:02 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] MIPS: BCM47XX: print board name in /proc/cpuinfo
Date:   Wed, 18 Sep 2013 13:29:58 +0200
Message-Id: <1379503798-9014-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1379503798-9014-1-git-send-email-hauke@hauke-m.de>
References: <1379503798-9014-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37844
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

Do not print the constant system type "Broadcom BCM47XX" but print the
name of the actual SoC in use and the detected board.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/prom.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 8c155afb..5cba318 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -32,12 +32,37 @@
 #include <asm/bootinfo.h>
 #include <asm/fw/cfe/cfe_api.h>
 #include <asm/fw/cfe/cfe_error.h>
+#include <bcm47xx.h>
+#include <bcm47xx_board.h>
 
 static int cfe_cons_handle;
 
+static u16 get_chip_id(void)
+{
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		return bcm47xx_bus.ssb.chip_id;
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		return bcm47xx_bus.bcma.bus.chipinfo.id;
+#endif
+	}
+	return 0;
+}
+
 const char *get_system_type(void)
 {
-	return "Broadcom BCM47XX";
+	static char buf[50];
+	u16 chip_id = get_chip_id();
+
+	snprintf(buf, sizeof(buf),
+		 (chip_id > 0x9999) ? "Broadcom BCM%d (%s)" :
+				      "Broadcom BCM%04X (%s)",
+		 chip_id, bcm47xx_board_get_name());
+
+	return buf;
 }
 
 void prom_putchar(char c)
-- 
1.7.10.4
