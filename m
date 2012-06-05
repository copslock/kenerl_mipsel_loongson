Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:57:54 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43593 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903759Ab2FEVwX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:52:23 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AX-000824-CB; Tue, 05 Jun 2012 16:20:01 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 25/35] MIPS: MSP71xx, Yosemite: Cleanup files effected by firmware changes.
Date:   Tue,  5 Jun 2012 16:19:29 -0500
Message-Id: <1338931179-9611-26-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33544
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
 .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |   27 ++-----
 arch/mips/pmc-sierra/msp71xx/msp_prom.c            |   79 +++-----------------
 arch/mips/pmc-sierra/msp71xx/msp_serial.c          |   60 +++++----------
 arch/mips/pmc-sierra/msp71xx/msp_setup.c           |   33 ++++----
 arch/mips/pmc-sierra/msp71xx/msp_time.c            |   53 ++++---------
 arch/mips/pmc-sierra/msp71xx/msp_usb.c             |   28 ++-----
 arch/mips/pmc-sierra/yosemite/prom.c               |   14 ++--
 drivers/mtd/maps/pmcmsp-flash.c                    |   49 ++++--------
 8 files changed, 98 insertions(+), 245 deletions(-)

diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
index b8c34ff..ceacb7e 100644
--- a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
+++ b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
@@ -1,25 +1,14 @@
 /*
- * MIPS boards bootprom interface for the Linux kernel.
- *
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- * Author: Carsten Langgaard, carstenl@mips.com
- *
- * ########################################################################
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * MIPS boards bootprom interface for the Linux kernel.
  *
- * ########################################################################
+ * Copyright (C) 2000,2012 MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *          Steven J. Hill <sjhill@mips.com>
  */
 
 #ifndef _ASM_MSP_PROM_H
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
index 885256f..39eddff 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
@@ -1,42 +1,18 @@
 /*
- * BRIEF MODULE DESCRIPTION
- *    PROM library initialisation code, assuming a version of
- *    pmon is the boot code.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * PROM library initialisation code, assuming a version of PMON is
+ * the boot code.
  *
  * Copyright 2000,2001 MontaVista Software Inc.
  * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
- *
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
+ * 	   Pete Popov <ppopov@mvista.com> or <source@mvista.com>
  *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/string.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
@@ -58,11 +34,9 @@ fw_memblock_t mdesc[7];
 
 /* default feature sets */
 static char msp_default_features[] =
-#if defined(CONFIG_PMC_MSP4200_EVAL) \
- || defined(CONFIG_PMC_MSP4200_GW)
+#if defined(CONFIG_PMC_MSP4200_EVAL) || defined(CONFIG_PMC_MSP4200_GW)
 	"ERER";
-#elif defined(CONFIG_PMC_MSP7120_EVAL) \
- || defined(CONFIG_PMC_MSP7120_GW)
+#elif defined(CONFIG_PMC_MSP7120_EVAL) || defined(CONFIG_PMC_MSP7120_GW)
 	"EMEMSP";
 #elif defined(CONFIG_PMC_MSP7120_FPGA)
 	"EMEM";
@@ -132,35 +106,6 @@ const char *get_system_type(void)
 #endif
 }
 
-int get_ethernet_addr(char *ethaddr_name, char *ethernet_addr)
-{
-	char *ethaddr_str;
-
-	ethaddr_str = fw_getenv(ethaddr_name);
-	if (!ethaddr_str) {
-		printk(KERN_WARNING "%s not set in boot prom\n", ethaddr_name);
-		return -1;
-	}
-
-	if (str2eaddr(ethernet_addr, ethaddr_str) == -1) {
-		printk(KERN_WARNING "%s badly formatted-<%s>\n",
-			ethaddr_name, ethaddr_str);
-		return -1;
-	}
-
-	if (init_debug > 1) {
-		int i;
-		printk(KERN_DEBUG "get_ethernet_addr: for %s ", ethaddr_name);
-		for (i = 0; i < 5; i++)
-			printk(KERN_DEBUG "%02x:",
-				(unsigned char)*(ethernet_addr+i));
-		printk(KERN_DEBUG "%02x\n", *(ethernet_addr+i));
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(get_ethernet_addr);
-
 static char *get_features(void)
 {
 	char *feature = fw_getenv(FEATURES);
@@ -400,8 +345,8 @@ fw_memblock_t *__init fw_getmdesc(void)
 	str = fw_getenv(heaptop_env);
 	if (!str) {
 		heaptop = CPHYSADDR((u32)&_text);
-		ppfinit("heaptop not set in boot prom, "
-			"set to default 0x%08x\n", heaptop);
+		ppfinit("heaptop not set in boot prom, set to default 0x%08x\n",
+			heaptop);
 	} else {
 		tmp = kstrtol(str, 16, &val);
 		heaptop = (unsigned int)val;
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
index 7080bce..041b53b 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_serial.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
@@ -1,37 +1,15 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * The setup file for serial related hardware on PMC-Sierra MSP processors.
  *
  * Copyright 2005 PMC-Sierra, Inc.
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
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <linux/serial_reg.h>
 #include <linux/slab.h>
-
-#include <asm/io.h>
-#include <asm/processor.h>
-#include <asm/serial.h>
+#include <linux/serial_reg.h>
 #include <linux/serial_8250.h>
 
 #include <asm/fw/fw.h>
@@ -127,25 +105,25 @@ void __init msp_serial_setup(void)
 
 	/* Initialize the second serial port, if one exists */
 	switch (mips_machtype) {
-		case MACH_MSP4200_EVAL:
-		case MACH_MSP4200_GW:
-		case MACH_MSP4200_FPGA:
-		case MACH_MSP7120_EVAL:
-		case MACH_MSP7120_GW:
-		case MACH_MSP7120_FPGA:
-			/* Enable UART1 on MSP4200 and MSP7120 */
-			*GPIO_CFG2_REG = 0x00002299;
-			break;
-
-		default:
-			return; /* No second serial port, good-bye. */
+	case MACH_MSP4200_EVAL:
+	case MACH_MSP4200_GW:
+	case MACH_MSP4200_FPGA:
+	case MACH_MSP7120_EVAL:
+	case MACH_MSP7120_GW:
+	case MACH_MSP7120_FPGA:
+		/* Enable UART1 on MSP4200 and MSP7120 */
+		*GPIO_CFG2_REG = 0x00002299;
+		break;
+
+	default:
+		return; /* No second serial port, good-bye. */
 	}
 
 	up.mapbase      = MSP_UART1_BASE;
 	up.membase      = ioremap_nocache(up.mapbase, MSP_UART_REG_LEN);
 	up.irq          = MSP_INT_UART1;
 	up.line         = 1;
-	up.private_data		= (void*)UART1_STATUS_REG;
+	up.private_data		= (void *)UART1_STATUS_REG;
 	if (early_serial_setup(&up)) {
 		kfree(up.private_data);
 		pr_err("Early serial init of port 1 failed\n");
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
index 6fa0d76..c3adca6 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
@@ -1,15 +1,15 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * The generic setup file for PMC-Sierra MSP processors
  *
  * Copyright 2005-2007 PMC-Sierra, Inc,
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-
 #include <asm/cacheflush.h>
 #include <asm/r4kcache.h>
 #include <asm/reboot.h>
@@ -28,9 +28,8 @@
 extern void msp_serial_setup(void);
 extern void pmctwiled_setup(void);
 
-#if defined(CONFIG_PMC_MSP7120_EVAL) || \
-    defined(CONFIG_PMC_MSP7120_GW) || \
-    defined(CONFIG_PMC_MSP7120_FPGA)
+#if defined(CONFIG_PMC_MSP7120_EVAL) || defined(CONFIG_PMC_MSP7120_GW) || \
+	defined(CONFIG_PMC_MSP7120_FPGA)
 /*
  * Performs the reset for MSP7120-based boards
  */
@@ -77,7 +76,8 @@ void msp7120_reset(void)
 	 */
 
 	/* Wait a bit for the DDRC to settle */
-	for (i = 0; i < 100000000; i++);
+	for (i = 0; i < 100000000; i++)
+		;
 
 #if defined(CONFIG_PMC_MSP7120_GW)
 	/*
@@ -107,11 +107,10 @@ void msp7120_reset(void)
 
 void msp_restart(char *command)
 {
-	printk(KERN_WARNING "Now rebooting .......\n");
+	pr_warn("Now rebooting .......\n");
 
-#if defined(CONFIG_PMC_MSP7120_EVAL) || \
-    defined(CONFIG_PMC_MSP7120_GW) || \
-    defined(CONFIG_PMC_MSP7120_FPGA)
+#if defined(CONFIG_PMC_MSP7120_EVAL) || defined(CONFIG_PMC_MSP7120_GW) || \
+	defined(CONFIG_PMC_MSP7120_FPGA)
 	msp7120_reset();
 #else
 	/* No chip-specific reset code, just jump to the ROM reset vector */
@@ -120,13 +119,17 @@ void msp_restart(char *command)
 	flush_cache_all();
 	write_c0_wired(0);
 
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
+	__asm__ __volatile__ (
+		"	jr	%0				\n"
+		:
+		: "r" (0xbfc00000)
+	);
 #endif
 }
 
 void msp_halt(void)
 {
-	printk(KERN_WARNING "\n** You can safely turn off the power\n");
+	pr_warn("\n** You can safely turn off the power\n");
 	while (1)
 		/* If possible call official function to get CPU WARs */
 		if (cpu_wait)
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
index d76cbdb..e24c1c5 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -1,41 +1,21 @@
 /*
- * Setting up the clock on MSP SOCs.  No RTC typically.
- *
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * ########################################################################
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
+ * Setting up the clock on MSP SOCs.  No RTC typically.
  *
- * ########################################################################
+ * Copyright (C) 1999,2000,2012 MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *	    Steven J. Hill <sjhill@mips.com>
  */
-
-#include <linux/init.h>
-#include <linux/kernel_stat.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/module.h>
-#include <linux/ptrace.h>
-
 #include <asm/cevt-r4k.h>
 #include <asm/mipsregs.h>
 #include <asm/time.h>
 #include <asm/fw/fw.h>
 
 #include <msp_int.h>
-#include <msp_regs.h>
 
 #define get_current_vpe()   \
 	((read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE)
@@ -49,33 +29,30 @@ void __init plat_time_init(void)
 
 	cpu_rate = fw_getenvl("clkfreqhz");
 	if (cpu_rate == 0)
-		printk(KERN_ERR "Clock rate in Hz parse error: %s\n", s);
+		pr_err("Clock rate in Hz parse error\n");
 
 	if (cpu_rate == 0) {
 		cpu_rate = 1000 * fw_getenvl("clkfreq");
 		if (cpu_rate == 0)
-			printk(KERN_ERR "Clock rate in MHz parse error: %s\n", s);
-		}
+			pr_err("Clock rate in MHz parse error\n");
 	}
 
 	if (cpu_rate == 0) {
-#if defined(CONFIG_PMC_MSP7120_EVAL) \
- || defined(CONFIG_PMC_MSP7120_GW)
+#if defined(CONFIG_PMC_MSP7120_EVAL) || defined(CONFIG_PMC_MSP7120_GW)
 		cpu_rate = 400000000;
 #elif defined(CONFIG_PMC_MSP7120_FPGA)
 		cpu_rate = 25000000;
 #else
 		cpu_rate = 150000000;
 #endif
-		printk(KERN_ERR
-			"Failed to determine CPU clock rate, "
-			"assuming %ld hz ...\n", cpu_rate);
+		pr_err("Failed to determine CPU clock rate, assuming %ld Hz\n",
+			cpu_rate);
 	}
 
-	printk(KERN_WARNING "Clock rate set to %ld\n", cpu_rate);
+	pr_warn("Clock rate set to %ld\n", cpu_rate);
 
 	/* timer frequency is 1/2 clock rate */
-	mips_hpt_frequency = cpu_rate/2;
+	mips_hpt_frequency = (cpu_rate / 2);
 }
 
 unsigned int __cpuinit get_c0_compare_int(void)
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_usb.c b/arch/mips/pmc-sierra/msp71xx/msp_usb.c
index ee4ed9b..3ba9da0 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_usb.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_usb.c
@@ -1,35 +1,17 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * The setup file for USB related hardware on PMC-Sierra MSP processors.
  *
  * Copyright 2006 PMC-Sierra, Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
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
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_GADGET)
 
-#include <linux/init.h>
-#include <linux/ioport.h>
 #include <linux/platform_device.h>
 
-#include <asm/mipsregs.h>
 #include <asm/fw/fw.h>
 
 #include <msp_regs.h>
diff --git a/arch/mips/pmc-sierra/yosemite/prom.c b/arch/mips/pmc-sierra/yosemite/prom.c
index b4ce648..945911d 100644
--- a/arch/mips/pmc-sierra/yosemite/prom.c
+++ b/arch/mips/pmc-sierra/yosemite/prom.c
@@ -1,12 +1,12 @@
 /*
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
  * Copyright (C) 2003, 2004 PMC-Sierra Inc.
  * Author: Manish Lachwani (lachwani@pmc-sierra.com)
  * Copyright (C) 2004 Ralf Baechle
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #include <linux/init.h>
 #include <linux/sched.h>
@@ -14,8 +14,8 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/smp.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/reboot.h>
@@ -52,7 +52,7 @@ static void prom_cpu0_exit(void *arg)
 	mdelay(100 + (1000 / 16));
 
 	/* if the watchdog fails for some reason, let people know */
-	printk(KERN_NOTICE "Watchdog reset failed\n");
+	pr_notice("Watchdog reset failed\n");
 }
 
 /*
@@ -73,7 +73,7 @@ static void prom_exit(void)
  */
 static void prom_halt(void)
 {
-	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
+	pr_notice("\n** You can safely turn off the power\n");
 	while (1)
 		__asm__(".set\tmips3\n\t" "wait\n\t" ".set\tmips0");
 }
diff --git a/drivers/mtd/maps/pmcmsp-flash.c b/drivers/mtd/maps/pmcmsp-flash.c
index c19d9e4..896a76c 100644
--- a/drivers/mtd/maps/pmcmsp-flash.c
+++ b/drivers/mtd/maps/pmcmsp-flash.c
@@ -1,42 +1,25 @@
 /*
- * Mapping of a custom board with both AMD CFI and JEDEC flash in partitions.
- * Config with both CFI and JEDEC device support.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- * Basically physmap.c with the addition of partitions and
- * an array of mapping info to accommodate more than one flash type per board.
+ * Mapping of a custom board with both AMD CFI and JEDEC flash in partitions.
+ * Config with both CFI and JEDEC device support. Basically physmap.c with
+ * the addition of partitions and an array of mapping info to accommodate more
+ * than one flash type per board.
  *
  * Copyright 2005-2007 PMC-Sierra, Inc.
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
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
 
-#include <asm/io.h>
 #include <asm/fw/fw.h>
 
 #include <msp_prom.h>
@@ -48,8 +31,6 @@ static struct mtd_partition **msp_parts;
 static struct map_info *msp_maps;
 static int fcnt;
 
-#define DEBUG_MARKER printk(KERN_NOTICE "%s[%d]\n", __func__, __LINE__)
-
 static int __init init_msp_flash(void)
 {
 	int i, j, ret = -ENOMEM;
@@ -63,7 +44,7 @@ static int __init init_msp_flash(void)
 	/* If ELB is disabled by "ful-mux" mode, we can't get at flash */
 	if ((*DEV_ID_REG & DEV_ID_SINGLE_PC) &&
 	    (*ELB_1PC_EN_REG & SINGLE_PCCARD)) {
-		printk(KERN_NOTICE "Single PC Card mode: no flash access\n");
+		pr_notice("Single PC Card mode: no flash access\n");
 		return -ENXIO;
 	}
 
@@ -74,7 +55,7 @@ static int __init init_msp_flash(void)
 	if (fcnt < 1)
 		return -ENXIO;
 
-	printk(KERN_NOTICE "Found %d PMC flash devices\n", fcnt);
+	pr_notice("Found %d PMC flash devices\n", fcnt);
 
 	msp_flash = kmalloc(fcnt * sizeof(struct map_info *), GFP_KERNEL);
 	if (!msp_flash)
@@ -97,8 +78,7 @@ static int __init init_msp_flash(void)
 			part_name[7] = '0' + pcnt + 1;
 
 		if (pcnt == 0) {
-			printk(KERN_NOTICE "Skipping flash device %d "
-				"(no partitions defined)\n", i);
+			pr_notice("Skipping flash device %d (no partitions defined)\n", i);
 			continue;
 		}
 
@@ -118,8 +98,7 @@ static int __init init_msp_flash(void)
 		}
 		addr = CPHYSADDR(addr);
 
-		printk(KERN_NOTICE
-			"MSP flash device \"%s\": 0x%08x at 0x%08x\n",
+		pr_notice("MSP flash device \"%s\": 0x%08x at 0x%08x\n",
 			flash_name, size, addr);
 		/* This must matchs the actual size of the flash chip */
 		msp_maps[i].size = size;
@@ -176,7 +155,7 @@ static int __init init_msp_flash(void)
 			msp_flash[i]->owner = THIS_MODULE;
 			mtd_device_register(msp_flash[i], msp_parts[i], pcnt);
 		} else {
-			printk(KERN_ERR "map probe failed for flash\n");
+			pr_err("map probe failed for flash\n");
 			ret = -ENXIO;
 			kfree(msp_maps[i].name);
 			iounmap(msp_maps[i].virt);
-- 
1.7.10.3
