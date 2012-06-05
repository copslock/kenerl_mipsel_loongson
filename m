Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:21:38 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43436 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903723Ab2FEVT5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:19:57 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AM-000824-Jk; Tue, 05 Jun 2012 16:19:50 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 03/35] MIPS: Alchemy: Cleanup files effected by firmware changes.
Date:   Tue,  5 Jun 2012 16:19:07 -0500
Message-Id: <1338931179-9611-4-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33517
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
 arch/mips/alchemy/board-gpr.c       |   26 +++++++-----------------
 arch/mips/alchemy/board-mtx1.c      |   26 +++++++-----------------
 arch/mips/alchemy/board-xxs1500.c   |   24 ++++++-----------------
 arch/mips/alchemy/common/platform.c |   27 +++++++++++++------------
 arch/mips/alchemy/common/prom.c     |   37 +++++++++--------------------------
 arch/mips/alchemy/devboards/prom.c  |   35 ++++++++-------------------------
 6 files changed, 51 insertions(+), 124 deletions(-)

diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index 1139173..8ad454a 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -1,27 +1,15 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * GPR board platform device registration (Au1550)
  *
  * Copyright (C) 2010 Wolfgang Grandegger <wg@denx.de>
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
 #include <linux/delay.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/mtd/partitions.h>
@@ -65,7 +53,7 @@ static void gpr_reset(char *c)
 	alchemy_gpio_direction_output(5, 0);
 
 	/* trigger watchdog to reset board in 200ms */
-	printk(KERN_EMERG "Triggering watchdog soft reset...\n");
+	pr_emerg("Triggering watchdog soft reset...\n");
 	raw_local_irq_disable();
 	alchemy_gpio_direction_output(1, 0);
 	udelay(1);
@@ -82,7 +70,7 @@ static void gpr_power_off(void)
 
 void __init board_setup(void)
 {
-	printk(KERN_INFO "Trapeze ITS GPR board\n");
+	pr_info("Trapeze ITS GPR board\n");
 
 	pm_power_off = gpr_power_off;
 	_machine_halt = gpr_power_off;
diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 7d1ea7a..6d5e56c 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -1,26 +1,14 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * MTX-1 platform devices registration (Au1500)
  *
  * Copyright (C) 2007-2009, Florian Fainelli <florian@openwrt.org>
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
-#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
 #include <linux/gpio.h>
@@ -98,7 +86,7 @@ void __init board_setup(void)
 	_machine_halt = mtx1_power_off;
 	_machine_restart = mtx1_reset;
 
-	printk(KERN_INFO "4G Systems MTX-1 Board\n");
+	pr_info("4G Systems MTX-1 Board\n");
 }
 
 /******************************************************************************/
@@ -296,7 +284,7 @@ static int __init mtx1_register_devices(void)
 	rc = gpio_request(mtx1_gpio_button[0].gpio,
 					mtx1_gpio_button[0].desc);
 	if (rc < 0) {
-		printk(KERN_INFO "mtx1: failed to request %d\n",
+		pr_info("mtx1: failed to request %d\n",
 					mtx1_gpio_button[0].gpio);
 		goto out;
 	}
diff --git a/arch/mips/alchemy/board-xxs1500.c b/arch/mips/alchemy/board-xxs1500.c
index 0469f1c..e7a3745 100644
--- a/arch/mips/alchemy/board-xxs1500.c
+++ b/arch/mips/alchemy/board-xxs1500.c
@@ -1,25 +1,13 @@
 /*
- * BRIEF MODULE DESCRIPTION
- *	MyCable XXS1500 board support
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- * Copyright 2003, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
+ * MyCable XXS1500 board support
  *
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
+ * Copyright 2003, 2008 MontaVista Software Inc. <source@mvista.com>
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 2c5c014..6a870a9 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -1,4 +1,8 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Platform device support for Au1x00 SoCs.
  *
  * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
@@ -6,11 +10,8 @@
  * (C) Copyright Embedded Alley Solutions, Inc 2005
  * Author: Pantelis Antoniou <pantelis@embeddedalley.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/init.h>
@@ -103,7 +104,7 @@ static void __init alchemy_setup_uarts(int ctype)
 
 	ports = kzalloc(s * (c + 1), GFP_KERNEL);
 	if (!ports) {
-		printk(KERN_INFO "Alchemy: no memory for UART data\n");
+		pr_info("Alchemy: no memory for UART data\n");
 		return;
 	}
 	memcpy(ports, au1x00_uart_data[ctype], s * c);
@@ -113,7 +114,7 @@ static void __init alchemy_setup_uarts(int ctype)
 	for (s = 0; s < c; s++)
 		ports[s].uartclk = uartclk;
 	if (platform_device_register(&au1xx0_uart_device))
-		printk(KERN_INFO "Alchemy: failed to register UARTs\n");
+		pr_info("Alchemy: failed to register UARTs\n");
 }
 
 
@@ -173,7 +174,7 @@ static void __init alchemy_setup_usb(int ctype)
 	pdev->dev.dma_mask = &alchemy_ohci_dmamask;
 
 	if (platform_device_register(pdev))
-		printk(KERN_INFO "Alchemy USB: cannot add OHCI0\n");
+		pr_info("Alchemy USB: cannot add OHCI0\n");
 
 
 	/* setup EHCI0: Au1200/Au1300 */
@@ -192,7 +193,7 @@ static void __init alchemy_setup_usb(int ctype)
 		pdev->dev.dma_mask = &alchemy_ehci_dmamask;
 
 		if (platform_device_register(pdev))
-			printk(KERN_INFO "Alchemy USB: cannot add EHCI0\n");
+			pr_info("Alchemy USB: cannot add EHCI0\n");
 	}
 
 	/* Au1300: OHCI1 */
@@ -211,7 +212,7 @@ static void __init alchemy_setup_usb(int ctype)
 		pdev->dev.dma_mask = &alchemy_ohci_dmamask;
 
 		if (platform_device_register(pdev))
-			printk(KERN_INFO "Alchemy USB: cannot add OHCI1\n");
+			pr_info("Alchemy USB: cannot add OHCI1\n");
 	}
 }
 
@@ -335,7 +336,7 @@ static void __init alchemy_setup_macs(int ctype)
 
 	macres = kmalloc(sizeof(struct resource) * MAC_RES_COUNT, GFP_KERNEL);
 	if (!macres) {
-		printk(KERN_INFO "Alchemy: no memory for MAC0 resources\n");
+		pr_info("Alchemy: no memory for MAC0 resources\n");
 		return;
 	}
 	memcpy(macres, au1xxx_eth0_resources[ctype],
@@ -348,7 +349,7 @@ static void __init alchemy_setup_macs(int ctype)
 
 	ret = platform_device_register(&au1xxx_eth0_device);
 	if (ret)
-		printk(KERN_INFO "Alchemy: failed to register MAC0\n");
+		pr_info("Alchemy: failed to register MAC0\n");
 
 
 	/* Handle 2nd MAC */
@@ -357,7 +358,7 @@ static void __init alchemy_setup_macs(int ctype)
 
 	macres = kmalloc(sizeof(struct resource) * MAC_RES_COUNT, GFP_KERNEL);
 	if (!macres) {
-		printk(KERN_INFO "Alchemy: no memory for MAC1 resources\n");
+		pr_info("Alchemy: no memory for MAC1 resources\n");
 		return;
 	}
 	memcpy(macres, au1xxx_eth1_resources[ctype],
@@ -372,7 +373,7 @@ static void __init alchemy_setup_macs(int ctype)
 	if (!(au_readl(SYS_PINFUNC) & (u32)SYS_PF_NI2)) {
 		ret = platform_device_register(&au1xxx_eth1_device);
 		if (ret)
-			printk(KERN_INFO "Alchemy: failed to register MAC1\n");
+			pr_info("Alchemy: failed to register MAC1\n");
 	}
 }
 
diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index a67012d..57e754d 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -1,38 +1,19 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- * BRIEF MODULE DESCRIPTION
- *    PROM library initialisation code, supports YAMON and U-Boot.
+ * PROM library initialisation code, supports YAMON and U-Boot. This file
+ * was derived from Carsten Langgaard's arch/mips/mips-boards/xx files.
  *
  * Copyright 2000-2001, 2006, 2008 MontaVista Software Inc.
  * Author: MontaVista Software, Inc. <source@mvista.com>
  *
- * This file was derived from Carsten Langgaard's
- * arch/mips/mips-boards/xx files.
- *
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ * Copyright (C) 1999,2000,2012 MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *	    Steven J. Hill <sjhill@mips.com>
  */
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index 59af1d4..a48f9ae 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -1,40 +1,21 @@
 /*
- * Common code used by all Alchemy develboards.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- * Extracted from files which had this to say:
+ * Common code used by all Alchemy development boards.
+ * GPR board platform device registration (Au1550)
  *
  * Copyright 2000, 2008 MontaVista Software Inc.
  * Author: MontaVista Software, Inc. <source@mvista.com>
  *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved
  */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
 #include <asm/fw/fw.h>
 #include <asm/mach-au1x00/au1000.h>
 
-#if defined(CONFIG_MIPS_DB1000) || \
-    defined(CONFIG_MIPS_PB1100) || \
-    defined(CONFIG_MIPS_PB1500)
+#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_PB1100) ||	\
+	defined(CONFIG_MIPS_PB1500)
 #define ALCHEMY_BOARD_DEFAULT_MEMSIZE	0x04000000
 
 #else	/* Au1550/Au1200-based develboards */
-- 
1.7.10.3
