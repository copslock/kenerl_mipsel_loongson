Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 23:40:43 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:53584 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832656Ab3ISVkUB7zUt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Sep 2013 23:40:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 85CFB8F62;
        Thu, 19 Sep 2013 23:40:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qdYbeKu3S7ke; Thu, 19 Sep 2013 23:40:14 +0200 (CEST)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 4636F857F;
        Thu, 19 Sep 2013 23:40:14 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] MIPS: BCM47XX: only print SoC name in system type in cpuinfo
Date:   Thu, 19 Sep 2013 23:40:09 +0200
Message-Id: <1379626810-30103-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37896
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

Recently the output of "system type" in  /proc/cpuinfo was changed to
Broadcom BCM4730 (Some sample board), but it is better to just print
the SoC name in the "system type" entry. The board name will be added
in the machine entry later.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/prom.c                     |   31 ++++++++------------------
 arch/mips/bcm47xx/setup.c                    |    2 ++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    2 ++
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 5cba318..53b9a3fb 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -37,32 +37,19 @@
 
 static int cfe_cons_handle;
 
-static u16 get_chip_id(void)
-{
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		return bcm47xx_bus.ssb.chip_id;
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		return bcm47xx_bus.bcma.bus.chipinfo.id;
-#endif
-	}
-	return 0;
-}
+static char bcm47xx_system_type[20] = "Broadcom BCM47XX";
 
 const char *get_system_type(void)
 {
-	static char buf[50];
-	u16 chip_id = get_chip_id();
-
-	snprintf(buf, sizeof(buf),
-		 (chip_id > 0x9999) ? "Broadcom BCM%d (%s)" :
-				      "Broadcom BCM%04X (%s)",
-		 chip_id, bcm47xx_board_get_name());
+	return bcm47xx_system_type;
+}
 
-	return buf;
+__init void bcm47xx_set_system_type(u16 chip_id)
+{
+	snprintf(bcm47xx_system_type, sizeof(bcm47xx_system_type),
+		 (chip_id > 0x9999) ? "Broadcom BCM%d" :
+				      "Broadcom BCM%04X",
+		 chip_id);
 }
 
 void prom_putchar(char c)
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 1f30571..de08ba9 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -210,12 +210,14 @@ void __init plat_mem_setup(void)
 #ifdef CONFIG_BCM47XX_BCMA
 		bcm47xx_bus_type = BCM47XX_BUS_TYPE_BCMA;
 		bcm47xx_register_bcma();
+		bcm47xx_set_system_type(bcm47xx_bus.bcma.bus.chipinfo.id);
 #endif
 	} else {
 		printk(KERN_INFO "bcm47xx: using ssb bus\n");
 #ifdef CONFIG_BCM47XX_SSB
 		bcm47xx_bus_type = BCM47XX_BUS_TYPE_SSB;
 		bcm47xx_register_ssb();
+		bcm47xx_set_system_type(bcm47xx_bus.ssb.chip_id);
 #endif
 	}
 
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index cc7563b..7527c1d 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -56,4 +56,6 @@ void bcm47xx_fill_bcma_boardinfo(struct bcma_boardinfo *boardinfo,
 				 const char *prefix);
 #endif
 
+void bcm47xx_set_system_type(u16 chip_id);
+
 #endif /* __ASM_BCM47XX_H */
-- 
1.7.10.4
