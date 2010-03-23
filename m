Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2010 10:30:21 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59800 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491194Ab0CWJaS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Mar 2010 10:30:18 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id BFE4B34180CF;
        Tue, 23 Mar 2010 10:30:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4iQB9MKw0vq8; Tue, 23 Mar 2010 10:30:15 +0100 (CET)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id DF55234180D1;
        Tue, 23 Mar 2010 10:30:15 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
Date:   Tue, 23 Mar 2010 10:30:08 +0100
Subject: [PATCH] bcm63xx: fix build failure in board_bcm963xx.c
MIME-Version: 1.0
X-UID:  26208
X-Length: 4566
Organization: Freebox
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003231030.09003.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

Since 2083e832, the SPROM is now registered in the board_prom_init callback,
but it references variables and functions which are declared below. Move the
variables and functions above board_prom_init.

Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 5addb9c..8dba8cf 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -619,6 +619,76 @@ static const struct board_info __initdata *bcm963xx_boards[] = {
 };
 
 /*
+ * Register a sane SPROMv2 to make the on-board
+ * bcm4318 WLAN work
+ */
+#ifdef CONFIG_SSB_PCIHOST
+static struct ssb_sprom bcm63xx_sprom = {
+	.revision		= 0x02,
+	.board_rev		= 0x17,
+	.country_code		= 0x0,
+	.ant_available_bg 	= 0x3,
+	.pa0b0			= 0x15ae,
+	.pa0b1			= 0xfa85,
+	.pa0b2			= 0xfe8d,
+	.pa1b0			= 0xffff,
+	.pa1b1			= 0xffff,
+	.pa1b2			= 0xffff,
+	.gpio0			= 0xff,
+	.gpio1			= 0xff,
+	.gpio2			= 0xff,
+	.gpio3			= 0xff,
+	.maxpwr_bg		= 0x004c,
+	.itssi_bg		= 0x00,
+	.boardflags_lo		= 0x2848,
+	.boardflags_hi		= 0x0000,
+};
+#endif
+
+/*
+ * return board name for /proc/cpuinfo
+ */
+const char *board_get_name(void)
+{
+	return board.name;
+}
+
+/*
+ * register & return a new board mac address
+ */
+static int board_get_mac_address(u8 *mac)
+{
+	u8 *p;
+	int count;
+
+	if (mac_addr_used >= nvram.mac_addr_count) {
+		printk(KERN_ERR PFX "not enough mac address\n");
+		return -ENODEV;
+	}
+
+	memcpy(mac, nvram.mac_addr_base, ETH_ALEN);
+	p = mac + ETH_ALEN - 1;
+	count = mac_addr_used;
+
+	while (count--) {
+		do {
+			(*p)++;
+			if (*p != 0)
+				break;
+			p--;
+		} while (p != mac);
+	}
+
+	if (p == mac) {
+		printk(KERN_ERR PFX "unable to fetch mac address\n");
+		return -ENODEV;
+	}
+
+	mac_addr_used++;
+	return 0;
+}
+
+/*
  * early init callback, read nvram data from flash and checksum it
  */
 void __init board_prom_init(void)
@@ -744,49 +814,6 @@ void __init board_setup(void)
 		panic("unexpected CPU for bcm963xx board");
 }
 
-/*
- * return board name for /proc/cpuinfo
- */
-const char *board_get_name(void)
-{
-	return board.name;
-}
-
-/*
- * register & return a new board mac address
- */
-static int board_get_mac_address(u8 *mac)
-{
-	u8 *p;
-	int count;
-
-	if (mac_addr_used >= nvram.mac_addr_count) {
-		printk(KERN_ERR PFX "not enough mac address\n");
-		return -ENODEV;
-	}
-
-	memcpy(mac, nvram.mac_addr_base, ETH_ALEN);
-	p = mac + ETH_ALEN - 1;
-	count = mac_addr_used;
-
-	while (count--) {
-		do {
-			(*p)++;
-			if (*p != 0)
-				break;
-			p--;
-		} while (p != mac);
-	}
-
-	if (p == mac) {
-		printk(KERN_ERR PFX "unable to fetch mac address\n");
-		return -ENODEV;
-	}
-
-	mac_addr_used++;
-	return 0;
-}
-
 static struct mtd_partition mtd_partitions[] = {
 	{
 		.name		= "cfe",
@@ -818,33 +845,6 @@ static struct platform_device mtd_dev = {
 	},
 };
 
-/*
- * Register a sane SPROMv2 to make the on-board
- * bcm4318 WLAN work
- */
-#ifdef CONFIG_SSB_PCIHOST
-static struct ssb_sprom bcm63xx_sprom = {
-	.revision		= 0x02,
-	.board_rev		= 0x17,
-	.country_code		= 0x0,
-	.ant_available_bg 	= 0x3,
-	.pa0b0			= 0x15ae,
-	.pa0b1			= 0xfa85,
-	.pa0b2			= 0xfe8d,
-	.pa1b0			= 0xffff,
-	.pa1b1			= 0xffff,
-	.pa1b2			= 0xffff,
-	.gpio0			= 0xff,
-	.gpio1			= 0xff,
-	.gpio2			= 0xff,
-	.gpio3			= 0xff,
-	.maxpwr_bg		= 0x004c,
-	.itssi_bg		= 0x00,
-	.boardflags_lo		= 0x2848,
-	.boardflags_hi		= 0x0000,
-};
-#endif
-
 static struct gpio_led_platform_data bcm63xx_led_data;
 
 static struct platform_device bcm63xx_gpio_leds = {
