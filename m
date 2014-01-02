Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 19:06:27 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:47304 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825715AbaABSGZawD71 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 19:06:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 036228F61;
        Thu,  2 Jan 2014 19:06:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1YACyeOyNdKT; Thu,  2 Jan 2014 19:06:22 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id DA98B857F;
        Thu,  2 Jan 2014 19:06:21 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: BCM47XX: fix position of cpu_wait disabling
Date:   Thu,  2 Jan 2014 19:06:19 +0100
Message-Id: <1388685979-20678-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38839
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

The disabling of cpu_wait was done too early, before the detection was
done. This moves the code to a position where it actually works.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

Fell free to fold this into the original patch.

 arch/mips/bcm47xx/setup.c |   34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 0bd4702..5d307b6 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -205,15 +205,6 @@ static void __init bcm47xx_register_bcma(void)
 		panic("Failed to initialize BCMA bus (err %d)", err);
 
 	bcm47xx_fill_bcma_boardinfo(&bcm47xx_bus.bcma.bus.boardinfo, NULL);
-
-	/* The BCM4706 has a problem with the CPU wait instruction.
-	 * When r4k_wait or r4k_wait_irqoff is used will just hang and 
-	 * not return from a msleep(). Removing the cpu_wait 
-	 * functionality is a workaround for this problem. The BCM4716 
-	 * does not have this problem.
-	 */
-	if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
-		cpu_wait = NULL;
 }
 #endif
 
@@ -244,6 +235,31 @@ void __init plat_mem_setup(void)
 	mips_set_machine_name(bcm47xx_board_get_name());
 }
 
+static int __init bcm47xx_cpu_fixes(void)
+{
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		/* Nothing to do */
+		break;
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		/* The BCM4706 has a problem with the CPU wait instruction.
+		 * When r4k_wait or r4k_wait_irqoff is used will just hang and 
+		 * not return from a msleep(). Removing the cpu_wait 
+		 * functionality is a workaround for this problem. The BCM4716 
+		 * does not have this problem.
+		 */
+		if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
+			cpu_wait = NULL;
+		break;
+#endif
+	}
+	return 0;
+}
+arch_initcall(bcm47xx_cpu_fixes);
+
 static struct fixed_phy_status bcm47xx_fixed_phy_status __initdata = {
 	.link	= 1,
 	.speed	= SPEED_100,
-- 
1.7.10.4
