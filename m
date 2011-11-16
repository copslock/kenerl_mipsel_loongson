Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 21:50:38 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:46250 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903871Ab1KPUue (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 21:50:34 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 0163D3AA74E;
        Wed, 16 Nov 2011 21:50:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VYxLbT+CidQb; Wed, 16 Nov 2011 21:50:33 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 9CF0F3AA74B;
        Wed, 16 Nov 2011 21:50:33 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: BCM63XX: generate WLAN MAC address after registering ethernet devices.
Date:   Wed, 16 Nov 2011 21:49:58 +0100
Message-Id: <1321476598-9450-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 31705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13827

In case the MAC address pool is not big enough to also register a WLAN device
prefer registering the Ethernet devices.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index ac948c2..fcd5a8c 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -791,18 +791,6 @@ void __init board_prom_init(void)
 	}
 
 	bcm_gpio_writel(val, GPIO_MODE_REG);
-
-	/* Generate MAC address for WLAN and
-	 * register our SPROM */
-#ifdef CONFIG_SSB_PCIHOST
-	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
-		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
-		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
-		if (ssb_arch_register_fallback_sprom(
-				&bcm63xx_get_fallback_sprom) < 0)
-			printk(KERN_ERR PFX "failed to register fallback SPROM\n");
-	}
-#endif
 }
 
 /*
@@ -886,6 +874,19 @@ int __init board_register_devices(void)
 	if (board.has_dsp)
 		bcm63xx_dsp_register(&board.dsp);
 
+	/* Generate MAC address for WLAN and register our SPROM,
+	 * do this after registering enet devices
+	 */
+#ifdef CONFIG_SSB_PCIHOST
+	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
+		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
+		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
+		if (ssb_arch_register_fallback_sprom(
+			&bcm63xx_get_fallback_sprom) < 0)
+			pr_err(PFX "failed to register fallback SPROM\n");
+	}
+#endif
+
 	/* read base address of boot chip select (0) */
 	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
 	val &= MPI_CSBASE_BASE_MASK;
-- 
1.7.5.4
