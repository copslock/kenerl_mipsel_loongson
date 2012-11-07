Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2012 10:25:51 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:59144 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823473Ab2KGJZtJrmm3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2012 10:25:49 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so570342bkw.36
        for <multiple recipients>; Wed, 07 Nov 2012 01:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ErBgzdfYblZ74zzrIW2HCQwmGQpY2w7fgwunqseEvSA=;
        b=N/kFiWWqMMe8wZ/dy7VRjuuVSGY8rZzdz6nl2ZqdCmBEN0aDuiTVn6N8WRlcOOhgy6
         gkUqqX/2aGZ6sWFMKw409k0MKY9tnt6/B/od7EsbWRd+0RNAV7ikw/DmMMaqjTNBunoF
         KLKJD/GIBoDuUsySmldmyoDrtvHICZtCD3pSTMKuLtvTwOPPVJ+4dbciCVGLtc+RNVSP
         DUVJrqeky7r4+pe0VtjfWe4e1J1VFnARnD3CwcGKz2HcAuBNt4LCQ1BSspJXkW3Tc2fd
         UkvKG3noyYLoUZ7+W+O5zCIBxVa4NYuF/L2y0JGfLH7KTES93zderGG5d4RRaIh/aw6L
         N98A==
Received: by 10.204.4.149 with SMTP id 21mr896608bkr.122.1352280343571;
        Wed, 07 Nov 2012 01:25:43 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id ht18sm13774213bkc.14.2012.11.07.01.25.40
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Nov 2012 01:25:42 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH] MIPS: BCM63XX: move nvram functions into their own file
Date:   Wed,  7 Nov 2012 10:25:28 +0100
Message-Id: <1352280328-14949-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 34916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Refactor nvram related functions into its own unit for easier expansion
and exposure of the values to other drivers.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---

This patch depends on the previous reset helper patch series or the
Makefile change needs to be merged manually. It has no real functional
dependencies.

 arch/mips/bcm63xx/Makefile                         |    7 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |   71 ++-----------
 arch/mips/bcm63xx/nvram.c                          |  104 ++++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h |   35 +++++++
 .../mips/include/asm/mach-bcm63xx/board_bcm963xx.h |   17 ---
 5 files changed, 154 insertions(+), 80 deletions(-)
 create mode 100644 arch/mips/bcm63xx/nvram.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index bfc9b84..ac28073 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,6 +1,7 @@
-obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o reset.o setup.o \
-		   timer.o dev-dsp.o dev-enet.o dev-flash.o dev-pcmcia.o \
-		   dev-rng.o dev-spi.o dev-uart.o dev-wdt.o dev-usb-usbd.o
+obj-y		+= clk.o cpu.o cs.o gpio.o irq.o nvram.o prom.o reset.o \
+		   setup.o timer.o dev-dsp.o dev-enet.o dev-flash.o \
+		   dev-pcmcia.o dev-rng.o dev-spi.o dev-uart.o dev-wdt.o \
+		   dev-usb-usbd.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 1cd4d73..73be9b3 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -18,6 +18,7 @@
 #include <bcm63xx_dev_uart.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
+#include <bcm63xx_nvram.h>
 #include <bcm63xx_dev_pci.h>
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
@@ -29,8 +30,6 @@
 
 #define PFX	"board_bcm963xx: "
 
-static struct bcm963xx_nvram nvram;
-static unsigned int mac_addr_used;
 static struct board_info board;
 
 /*
@@ -716,50 +715,14 @@ const char *board_get_name(void)
 }
 
 /*
- * register & return a new board mac address
- */
-static int board_get_mac_address(u8 *mac)
-{
-	u8 *oui;
-	int count;
-
-	if (mac_addr_used >= nvram.mac_addr_count) {
-		printk(KERN_ERR PFX "not enough mac address\n");
-		return -ENODEV;
-	}
-
-	memcpy(mac, nvram.mac_addr_base, ETH_ALEN);
-	oui = mac + ETH_ALEN/2 - 1;
-	count = mac_addr_used;
-
-	while (count--) {
-		u8 *p = mac + ETH_ALEN - 1;
-
-		do {
-			(*p)++;
-			if (*p != 0)
-				break;
-			p--;
-		} while (p != oui);
-
-		if (p == oui) {
-			printk(KERN_ERR PFX "unable to fetch mac address\n");
-			return -ENODEV;
-		}
-	}
-
-	mac_addr_used++;
-	return 0;
-}
-
-/*
  * early init callback, read nvram data from flash and checksum it
  */
 void __init board_prom_init(void)
 {
-	unsigned int check_len, i;
-	u8 *boot_addr, *cfe, *p;
+	unsigned int i;
+	u8 *boot_addr, *cfe;
 	char cfe_version[32];
+	char *board_name;
 	u32 val;
 
 	/* read base address of boot chip select (0)
@@ -782,27 +745,15 @@ void __init board_prom_init(void)
 		strcpy(cfe_version, "unknown");
 	printk(KERN_INFO PFX "CFE version: %s\n", cfe_version);
 
-	/* extract nvram data */
-	memcpy(&nvram, boot_addr + BCM963XX_NVRAM_OFFSET, sizeof(nvram));
-
-	/* check checksum before using data */
-	if (nvram.version <= 4)
-		check_len = offsetof(struct bcm963xx_nvram, checksum_old);
-	else
-		check_len = sizeof(nvram);
-	val = 0;
-	p = (u8 *)&nvram;
-	while (check_len--)
-		val += *p;
-	if (val) {
+	if (bcm63xx_nvram_init(boot_addr + BCM963XX_NVRAM_OFFSET)) {
 		printk(KERN_ERR PFX "invalid nvram checksum\n");
 		return;
 	}
 
+	board_name = bcm63xx_nvram_get_name();
 	/* find board by name */
 	for (i = 0; i < ARRAY_SIZE(bcm963xx_boards); i++) {
-		if (strncmp(nvram.name, bcm963xx_boards[i]->name,
-			    sizeof(nvram.name)))
+		if (strncmp(board_name, bcm963xx_boards[i]->name, 16))
 			continue;
 		/* copy, board desc array is marked initdata */
 		memcpy(&board, bcm963xx_boards[i], sizeof(board));
@@ -812,7 +763,7 @@ void __init board_prom_init(void)
 	/* bail out if board is not found, will complain later */
 	if (!board.name[0]) {
 		char name[17];
-		memcpy(name, nvram.name, 16);
+		memcpy(name, board_name, 16);
 		name[16] = 0;
 		printk(KERN_ERR PFX "unknown bcm963xx board: %s\n",
 		       name);
@@ -890,11 +841,11 @@ int __init board_register_devices(void)
 		bcm63xx_pcmcia_register();
 
 	if (board.has_enet0 &&
-	    !board_get_mac_address(board.enet0.mac_addr))
+	    !bcm63xx_nvram_get_mac_address(board.enet0.mac_addr))
 		bcm63xx_enet_register(0, &board.enet0);
 
 	if (board.has_enet1 &&
-	    !board_get_mac_address(board.enet1.mac_addr))
+	    !bcm63xx_nvram_get_mac_address(board.enet1.mac_addr))
 		bcm63xx_enet_register(1, &board.enet1);
 
 	if (board.has_usbd)
@@ -907,7 +858,7 @@ int __init board_register_devices(void)
 	 * do this after registering enet devices
 	 */
 #ifdef CONFIG_SSB_PCIHOST
-	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
+	if (!bcm63xx_nvram_get_mac_address(bcm63xx_sprom.il0mac)) {
 		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
 		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
 		if (ssb_arch_register_fallback_sprom(
diff --git a/arch/mips/bcm63xx/nvram.c b/arch/mips/bcm63xx/nvram.c
new file mode 100644
index 0000000..b57a10d
--- /dev/null
+++ b/arch/mips/bcm63xx/nvram.c
@@ -0,0 +1,104 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
+ */
+
+#define pr_fmt(fmt) "bcm63xx_nvram: " fmt
+
+#include <linux/init.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/if_ether.h>
+
+#include <bcm63xx_nvram.h>
+
+/*
+ * nvram structure
+ */
+struct bcm963xx_nvram {
+	u32	version;
+	u8	reserved1[256];
+	u8	name[16];
+	u32	main_tp_number;
+	u32	psi_size;
+	u32	mac_addr_count;
+	u8	mac_addr_base[ETH_ALEN];
+	u8	reserved2[2];
+	u32	checksum_old;
+	u8	reserved3[720];
+	u32	checksum_high;
+};
+
+static struct bcm963xx_nvram nvram;
+static int mac_addr_used;
+
+int __init bcm63xx_nvram_init(void *addr)
+{
+	unsigned int check_len;
+	u8 *p;
+	u32 val;
+
+	/* extract nvram data */
+	memcpy(&nvram, addr, sizeof(nvram));
+
+	/* check checksum before using data */
+	if (nvram.version <= 4)
+		check_len = offsetof(struct bcm963xx_nvram, checksum_old);
+	else
+		check_len = sizeof(nvram);
+	val = 0;
+	p = (u8 *)&nvram;
+
+	while (check_len--)
+		val += *p;
+	if (val)
+		return -EINVAL;
+
+	return 0;
+}
+
+u8 *bcm63xx_nvram_get_name(void)
+{
+	return nvram.name;
+}
+EXPORT_SYMBOL(bcm63xx_nvram_get_name);
+
+int bcm63xx_nvram_get_mac_address(u8 *mac)
+{
+	u8 *oui;
+	int count;
+
+	if (mac_addr_used >= nvram.mac_addr_count) {
+		pr_err("not enough mac addresses\n");
+		return -ENODEV;
+	}
+
+	memcpy(mac, nvram.mac_addr_base, ETH_ALEN);
+	oui = mac + ETH_ALEN/2 - 1;
+	count = mac_addr_used;
+
+	while (count--) {
+		u8 *p = mac + ETH_ALEN - 1;
+
+		do {
+			(*p)++;
+			if (*p != 0)
+				break;
+			p--;
+		} while (p != oui);
+
+		if (p == oui) {
+			pr_err("unable to fetch mac address\n");
+			return -ENODEV;
+		}
+	}
+
+	mac_addr_used++;
+	return 0;
+}
+EXPORT_SYMBOL(bcm63xx_nvram_get_mac_address);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
new file mode 100644
index 0000000..62d6a3b
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
@@ -0,0 +1,35 @@
+#ifndef BCM63XX_NVRAM_H
+#define BCM63XX_NVRAM_H
+
+#include <linux/types.h>
+
+/**
+ * bcm63xx_nvram_init() - initializes nvram
+ * @nvram:	address of the nvram data
+ *
+ * Initialized the local nvram copy from the target address and checks
+ * its checksum.
+ *
+ * Returns 0 on success.
+ */
+int __init bcm63xx_nvram_init(void *nvram);
+
+/**
+ * bcm63xx_nvram_get_name() - returns the board name according to nvram
+ *
+ * Returns the board name field from nvram. Note that it might not be
+ * null terminated if it is exactly 16 bytes long.
+ */
+u8 *bcm63xx_nvram_get_name(void);
+
+/**
+ * bcm63xx_nvram_get_mac_address() - register & return a new mac address
+ * @mac:	pointer to array for allocated mac
+ *
+ * Registers and returns a mac address from the allocated macs from nvram.
+ *
+ * Returns 0 on success.
+ */
+int bcm63xx_nvram_get_mac_address(u8 *mac);
+
+#endif /* BCM63XX_NVRAM_H */
diff --git a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
index b0dd4bb..682bcf3 100644
--- a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
+++ b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
@@ -15,23 +15,6 @@
 #define BCM963XX_NVRAM_OFFSET		0x580
 
 /*
- * nvram structure
- */
-struct bcm963xx_nvram {
-	u32	version;
-	u8	reserved1[256];
-	u8	name[16];
-	u32	main_tp_number;
-	u32	psi_size;
-	u32	mac_addr_count;
-	u8	mac_addr_base[6];
-	u8	reserved2[2];
-	u32	checksum_old;
-	u8	reserved3[720];
-	u32	checksum_high;
-};
-
-/*
  * board definition
  */
 struct board_info {
-- 
1.7.2.5
