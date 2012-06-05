Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:22:32 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43441 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903725Ab2FEVT5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:19:57 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AN-000824-JJ; Tue, 05 Jun 2012 16:19:51 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 05/35] MIPS: AR7: Cleanup files effected by firmware changes.
Date:   Tue,  5 Jun 2012 16:19:09 -0500
Message-Id: <1338931179-9611-6-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

Make headers consistent across the files and make changes based on
running the checkpatch script.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/ar7/memory.c   |   19 +++++------------
 arch/mips/ar7/platform.c |   53 ++++++++++++++++++----------------------------
 arch/mips/ar7/prom.c     |   22 ++++++-------------
 arch/mips/ar7/setup.c    |   22 ++++++-------------
 4 files changed, 39 insertions(+), 77 deletions(-)

diff --git a/arch/mips/ar7/memory.c b/arch/mips/ar7/memory.c
index 3d7133d..f3009a8 100644
--- a/arch/mips/ar7/memory.c
+++ b/arch/mips/ar7/memory.c
@@ -1,20 +1,11 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 2007 Felix Fietkau <nbd@openwrt.org>
  * Copyright (C) 2007 Eugene Konev <ejka@openwrt.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #include <linux/bootmem.h>
 #include <linux/init.h>
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 284b86a..921e42c 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -1,22 +1,12 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 2006,2007 Felix Fietkau <nbd@openwrt.org>
  * Copyright (C) 2006,2007 Eugene Konev <ejka@openwrt.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/module.h>
@@ -308,8 +298,7 @@ static void __init cpmac_get_mac(int instance, unsigned char *dev_addr)
 					&dev_addr[0], &dev_addr[1],
 					&dev_addr[2], &dev_addr[3],
 					&dev_addr[4], &dev_addr[5]) != 6) {
-			pr_warning("cannot parse mac address, "
-					"using random address\n");
+			pr_warn("cannot parse mac address, using random address\n");
 			random_ether_addr(dev_addr);
 		}
 	} else
@@ -489,11 +478,11 @@ static struct gpio_led gt701_leds[] = {
 		.active_low		= 1,
 		.default_trigger	= "default-on",
 	},
-        {
-                .name                   = "ethernet",
-                .gpio                   = 10,
-                .active_low             = 1,
-        },
+	{
+		.name                   = "ethernet",
+		.gpio                   = 10,
+		.active_low             = 1,
+	},
 };
 
 static struct gpio_led_platform_data ar7_led_data;
@@ -662,7 +651,7 @@ static int __init ar7_register_devices(void)
 
 	res = platform_device_register(&physmap_flash);
 	if (res)
-		pr_warning("unable to register physmap-flash: %d\n", res);
+		pr_warn("unable to register physmap-flash: %d\n", res);
 
 	if (ar7_is_titan())
 		titan_fixup_devices();
@@ -670,13 +659,13 @@ static int __init ar7_register_devices(void)
 	ar7_device_disable(vlynq_low_data.reset_bit);
 	res = platform_device_register(&vlynq_low);
 	if (res)
-		pr_warning("unable to register vlynq-low: %d\n", res);
+		pr_warn("unable to register vlynq-low: %d\n", res);
 
 	if (ar7_has_high_vlynq()) {
 		ar7_device_disable(vlynq_high_data.reset_bit);
 		res = platform_device_register(&vlynq_high);
 		if (res)
-			pr_warning("unable to register vlynq-high: %d\n", res);
+			pr_warn("unable to register vlynq-high: %d\n", res);
 	}
 
 	if (ar7_has_high_cpmac()) {
@@ -686,9 +675,9 @@ static int __init ar7_register_devices(void)
 
 			res = platform_device_register(&cpmac_high);
 			if (res)
-				pr_warning("unable to register cpmac-high: %d\n", res);
+				pr_warn("unable to register cpmac-high: %d\n", res);
 		} else
-			pr_warning("unable to add cpmac-high phy: %d\n", res);
+			pr_warn("unable to add cpmac-high phy: %d\n", res);
 	} else
 		cpmac_low_data.phy_mask = 0xffffffff;
 
@@ -697,18 +686,18 @@ static int __init ar7_register_devices(void)
 		cpmac_get_mac(0, cpmac_low_data.dev_addr);
 		res = platform_device_register(&cpmac_low);
 		if (res)
-			pr_warning("unable to register cpmac-low: %d\n", res);
+			pr_warn("unable to register cpmac-low: %d\n", res);
 	} else
-		pr_warning("unable to add cpmac-low phy: %d\n", res);
+		pr_warn("unable to add cpmac-low phy: %d\n", res);
 
 	detect_leds();
 	res = platform_device_register(&ar7_gpio_leds);
 	if (res)
-		pr_warning("unable to register leds: %d\n", res);
+		pr_warn("unable to register leds: %d\n", res);
 
 	res = platform_device_register(&ar7_udc);
 	if (res)
-		pr_warning("unable to register usb slave: %d\n", res);
+		pr_warn("unable to register usb slave: %d\n", res);
 
 	/* Register watchdog only if enabled in hardware */
 	bootcr = ioremap_nocache(AR7_REGS_DCL, 4);
@@ -723,7 +712,7 @@ static int __init ar7_register_devices(void)
 		ar7_wdt_res.end = ar7_wdt_res.start + 0x20;
 		res = platform_device_register(&ar7_wdt);
 		if (res)
-			pr_warning("unable to register watchdog: %d\n", res);
+			pr_warn("unable to register watchdog: %d\n", res);
 	}
 
 	return 0;
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 9e5699a..64ef6de 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -1,21 +1,11 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Putting things on the screen/serial line using YAMONs facilities.
+ * Carsten Langgaard, carstenl@mips.com
+ * Steven J. Hill, sjhill@mips.com
+ * Copyright (C) 1999,2000,2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
index ec318bb..0195cf1 100644
--- a/arch/mips/ar7/setup.c
+++ b/arch/mips/ar7/setup.c
@@ -1,19 +1,11 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * Carsten Langgaard, carstenl@mips.com
+ * Steven J. Hill, sjhill@mips.com
+ * Copyright (C) 2000,2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -101,6 +93,6 @@ void __init plat_mem_setup(void)
 
 	fw_meminit();
 
-	printk(KERN_INFO "%s, ID: 0x%04x, Revision: 0x%02x\n",
+	pr_info("%s, ID: 0x%04x, Revision: 0x%02x\n",
 			get_system_type(), ar7_chip_id(), ar7_chip_rev());
 }
-- 
1.7.10.3
