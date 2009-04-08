Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 00:37:37 +0100 (BST)
Received: from mx1.rmicorp.com ([12.239.216.72]:17511 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S20030477AbZDHXgT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 00:36:19 +0100
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Apr 2009 16:36:09 -0700
Received: from localhost.localdomain (unknown [10.8.0.44])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id A43A37B7FC4;
	Sat,  4 Apr 2009 05:34:46 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH v3 1/5] Alchemy: Initial Au1300 and DBAu1300 support
Date:	Wed,  8 Apr 2009 18:36:04 -0500
Message-Id: <1239233768-11927-2-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1239233768-11927-1-git-send-email-khickey@rmicorp.com>
References: <>
 <1239233768-11927-1-git-send-email-khickey@rmicorp.com>
X-OriginalArrivalTime: 08 Apr 2009 23:36:09.0337 (UTC) FILETIME=[CB64E690:01C9B8A2]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

This patch introduces the new RMI Alchemy Au1300 series SOC to the kernel, as
well as its first development board, the DBAu1300 (or DB1300).  This patch is
just the basic CPU identification and some resouce constants.

Also included are some new Alchemy IO functions and macros, named to match with
the current kernel standard.  They include au_iowrite32, au_ioread32, etc.
These are used heavily in the Au1300/DB1300 code so they need to be included
here.

Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
---
 arch/mips/Makefile                               |    6 +
 arch/mips/alchemy/Kconfig                        |    6 +
 arch/mips/alchemy/devboards/Makefile             |    1 +
 arch/mips/alchemy/devboards/db1300/Makefile      |    6 +
 arch/mips/alchemy/devboards/db1300/board_setup.c |  107 ++++++++++++
 arch/mips/include/asm/cpu.h                      |   10 +-
 arch/mips/include/asm/mach-au1x00/au1000.h       |   45 +++++
 arch/mips/include/asm/mach-au1x00/au13xx.h       |  201 ++++++++++++++++++++++
 arch/mips/include/asm/mach-au1x00/au1xxx.h       |    3 +
 arch/mips/include/asm/mach-au1x00/dev_boards.h   |   44 +++++
 arch/mips/include/asm/mips-boards/db1300.h       |  121 +++++++++++++
 arch/mips/kernel/cpu-probe.c                     |   20 ++
 arch/mips/mm/c-r4k.c                             |    1 +
 arch/mips/mm/tlbex.c                             |    1 +
 14 files changed, 569 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1300/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1300/board_setup.c
 create mode 100644 arch/mips/include/asm/mach-au1x00/au13xx.h
 create mode 100644 arch/mips/include/asm/mach-au1x00/dev_boards.h
 create mode 100644 arch/mips/include/asm/mips-boards/db1300.h

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 21b00e9..15e1577 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -255,6 +255,12 @@ core-$(CONFIG_MIPS_DB1200)	+= arch/mips/alchemy/devboards/
 cflags-$(CONFIG_MIPS_DB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
 load-$(CONFIG_MIPS_DB1200)	+= 0xffffffff80100000
 
+# RMI Alchemy DBAu1300 development board
+#
+core-$(CONFIG_MIPS_DB1300)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1300)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1300)	+= 0xffffffff80100000
+
 #
 # AMD Alchemy Bosporus eval board
 #
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 7f8ef13..50d426d 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -53,6 +53,12 @@ config MIPS_DB1550
 	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
+config MIPS_DB1300
+	bool "Alchemy DBAu1300 Development Board"
+	select SOC_AU13XX
+	select DMA_COHERENT
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
 config MIPS_MIRAGE
 	bool "Alchemy Mirage board"
 	select DMA_NONCOHERENT
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 730f9f2..0d2d224 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_MIPS_PB1550)	+= pb1550/
 obj-$(CONFIG_MIPS_DB1000)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1100)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1200)	+= pb1200/
+obj-$(CONFIG_MIPS_DB1300)	+= db1300/
 obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1550)	+= db1x00/
 obj-$(CONFIG_MIPS_BOSPORUS)	+= db1x00/
diff --git a/arch/mips/alchemy/devboards/db1300/Makefile b/arch/mips/alchemy/devboards/db1300/Makefile
new file mode 100644
index 0000000..edaff49
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1300/Makefile
@@ -0,0 +1,6 @@
+#
+# Copyright 2008 RMI Corporation.  All rights reserved.
+# Author: Kevin Hickey <khickey@rmicorp.com>
+#
+
+obj-y := board_setup.o mmc.o
diff --git a/arch/mips/alchemy/devboards/db1300/board_setup.c b/arch/mips/alchemy/devboards/db1300/board_setup.c
new file mode 100644
index 0000000..1fdec7d
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1300/board_setup.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright 2003-2008 RMI Corporation. All rights reserved.
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>		/* for printk */
+
+#include <prom.h>
+#include <au1xxx.h>
+#include <asm/mach-au1x00/dev_boards.h>
+
+#define DB1300_SYSTEM_TYPE_STRING	"RMI DBAu1300 Development Board"
+
+struct bcsr_regs *const bcsr =
+	(struct bcsr_regs *)(DB1300_BCSR_REGS_PHYS_ADDR + KSEG1);
+
+extern void (*board_irq_dispatch)(unsigned int);
+
+/*
+ * Called by plat_irq_dispatch to do board-specific things (i.e. display the
+ * interrupt on a hex output).  This should *not* be used for board-specific
+ * interrupt handling; for that register a new interrupt handler as a device
+ * driver would do.
+ */
+void db1300_board_irq_dispatch(unsigned int irq)
+{
+	if (irq != AU1300_IRQ_RTCMATCH_2)
+		db_set_hex((u8)irq);
+}
+
+void __init board_setup(void)
+{
+	char *argptr = NULL;
+
+	printk(KERN_INFO DB1300_SYSTEM_TYPE_STRING "\n");
+
+	/*
+	 * Add some text to the command line to point the au1200fb driver to
+	 * the board switch.
+	 */
+	argptr = prom_getcmdline();
+	strcat(argptr, "console=ttyS0,115200 video=au1200fb:panel:bs");
+
+	/*
+	 * Enable VBUS to the USB Host port
+	 */
+	au_set_bits_16(BCSR_RESETS_USB_HOST, &bcsr->resets);
+
+	board_irq_dispatch = db1300_board_irq_dispatch;
+}
+
+void board_reset(void)
+{
+	/* KH: TODO - write board_reset() */
+}
+
+const char *get_system_type(void)
+{
+	return DB1300_SYSTEM_TYPE_STRING;
+}
+
+/*
+ * Board specific functions for the Au1200 Framebuffer driver
+ */
+
+int board_au1200fb_panel(void)
+{
+	u16 switches = (au_ioread16(&db_bcsr->switches) & 0x0f00) >> 8;
+
+	printk(KERN_INFO "Returning LCD switch setting %d\n", switches);
+	return switches;
+}
+
+int board_au1200fb_panel_init(void)
+{
+	/* Apply power */
+	au_set_bits_16(0x7, &db_bcsr->board);
+	return 0;
+}
+
+int board_au1200fb_panel_shutdown(void)
+{
+	/* Remove power */
+	au_clear_bits_16(0x7, &db_bcsr->board);
+	return 0;
+}
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index c018727..e3528a7 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -33,9 +33,9 @@
 #define PRID_COMP_TOSHIBA	0x070000
 #define PRID_COMP_LSI		0x080000
 #define PRID_COMP_LEXRA		0x0b0000
+#define PRID_COMP_RMI		0x0c0000
 #define PRID_COMP_CAVIUM	0x0d0000
 
-
 /*
  * Assigned values for the product ID register.  In order to detect a
  * certain CPU type exactly eventually additional registers may need to
@@ -115,9 +115,13 @@
 #define PRID_IMP_BCM3302	0x9000
 
 /*
- * These are the PRID's for when 23:16 == PRID_COMP_CAVIUM
+ * These are the PRID's for when 23:16 == PRID_COMP_RMI
  */
+#define PRID_IMP_AU13XX		0x8000
 
+/*
+ * These are the PRID's for when 23:16 == PRID_COMP_CAVIUM
+ */
 #define PRID_IMP_CAVIUM_CN38XX 0x0000
 #define PRID_IMP_CAVIUM_CN31XX 0x0100
 #define PRID_IMP_CAVIUM_CN30XX 0x0200
@@ -210,7 +214,7 @@ enum cpu_type_enum {
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_AU1000, CPU_AU1100, CPU_AU1200, CPU_AU1210, CPU_AU1250, CPU_AU1500,
-	CPU_AU1550, CPU_PR4450, CPU_BCM3302, CPU_BCM4710,
+	CPU_AU1550, CPU_AU13XX, CPU_PR4450, CPU_BCM3302, CPU_BCM4710,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 62f91f5..c7fe356 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -6,6 +6,9 @@
  * Copyright 2000-2001, 2006-2008 MontaVista Software Inc.
  * Author: MontaVista Software, Inc. <source@mvista.com>
  *
+ * Copyright 2008 RMI Corporation
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
@@ -43,6 +46,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
+#include <au13xx.h>
+
 /* cpu pipeline flush */
 void static inline au_sync(void)
 {
@@ -130,6 +135,46 @@ static inline int au1xxx_cpu_needs_config_od(void)
 	return 0;
 }
 
+void static inline au_iowrite16(u16 val, volatile u16 *reg)
+{
+	*reg = val;
+}
+
+static inline u16 au_ioread16(volatile u16 *reg)
+{
+	return *reg;
+}
+
+void static inline au_iowrite32(u32 val, volatile u32 *reg)
+{
+	*reg = val;
+}
+
+static inline u32 au_ioread32(volatile u32 *reg)
+{
+	return *reg;
+}
+
+static inline void au_set_bits_16(u16 mask, volatile u16 *reg)
+{
+	au_iowrite16((au_ioread16(reg) | mask), reg);
+}
+
+static inline void au_clear_bits_16(u16 mask, volatile u16 *reg)
+{
+	au_iowrite16((au_ioread16(reg) & ~mask), reg);
+}
+
+static inline void au_set_bits_32(u32 mask, volatile u32 *reg)
+{
+	au_iowrite32((au_ioread32(reg) | mask), reg);
+}
+
+static inline void au_clear_bits_32(u32 mask, volatile u32 *reg)
+{
+	au_iowrite32((au_ioread32(reg) & ~mask), reg);
+}
+
 /* arch/mips/au1000/common/clocks.c */
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
diff --git a/arch/mips/include/asm/mach-au1x00/au13xx.h b/arch/mips/include/asm/mach-au1x00/au13xx.h
new file mode 100644
index 0000000..ea05234
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/au13xx.h
@@ -0,0 +1,201 @@
+/*
+ * Copyright 2008 RMI Corporation
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _AU13XX_H
+#define _AU13XX_H
+
+#ifdef CONFIG_SOC_AU13XX
+#include <asm/addrspace.h>
+
+#define UART0_ADDR		0xB0100000
+#define UART1_ADDR		0xB0101000
+#define UART2_ADDR		0xB0102000
+#define UART3_ADDR		0xB0103000
+
+#define GPIO_INT_CTRLR_BASE	0x10200000
+/*
+ * Linux uses IRQ 0-7 for the 8 causes.  That means that all of our channel
+ * bits need to be offset by 8 either when passed to do_IRQ or when received
+ * through the irq_chip calls
+ *
+ * KH: TODO - This is duplicated from gpio_int.h  Is that the right thing to do?
+ */
+#define	GPINT_LINUX_IRQ_OFFSET		8
+
+#define AU1300_IRQ_UART1	17
+#define AU1300_IRQ_UART2	25
+#define AU1300_IRQ_UART3	27
+#define AU1300_IRQ_SD1		32
+#define AU1300_IRQ_SD2		38
+#define AU1300_IRQ_PSC0		48
+#define AU1300_IRQ_PSC1		52
+#define AU1300_IRQ_PSC2		56
+#define AU1300_IRQ_PSC3		60
+#define AU1300_IRQ_NAND		62
+#define AU1300_IRQ_DDMA		75
+#define AU1300_IRQ_GPU		78
+#define AU1300_IRQ_MPU		77
+#define AU1300_IRQ_MMU		76
+#define AU1300_IRQ_UDMA		79
+#define AU1300_IRQ_TOY_TICK	80
+#define AU1300_IRQ_TOYMATCH_0	81
+#define AU1300_IRQ_TOYMATCH_1	82
+#define AU1300_IRQ_TOYMATCH_2	83
+#define AU1300_IRQ_RTC_TICK	84
+#define AU1300_IRQ_RTCMATCH_0	85
+#define AU1300_IRQ_RTCMATCH_1	86
+#define AU1300_IRQ_RTCMATCH_2	87
+#define AU1300_IRQ_UART0	88
+#define AU1300_IRQ_SD0		89
+#define AU1300_IRQ_USB		90
+#define AU1300_IRQ_LCD		91
+#define AU1300_IRQ_BSA		94
+#define AU1300_IRQ_MPE		93
+#define AU1300_IRQ_ITE		92
+#define AU1300_IRQ_AES		95
+#define AU1300_IRQ_CIM		96
+
+#define LCD_PHYS_ADDR		0x15000000
+
+#define AU1200_LCD_INT		(GPINT_LINUX_IRQ_OFFSET + AU1300_IRQ_LCD)
+#define AU1000_RTC_MATCH2_INT	(GPINT_LINUX_IRQ_OFFSET + AU1300_IRQ_RTCMATCH_2)
+
+#define SD0_PHYS_ADDR		0x10600000
+#define SD1_PHYS_ADDR		0x10601000
+
+
+#define	USB_BASE_PHYS_ADDR	0x14021000
+#define USB_EHCI_BASE		0x14020000
+#define USB_EHCI_LEN		0x400
+#define USB_OHCI_BASE		0x14020800
+#define USB_OHCI_LEN		0x400
+#define USB_UOC_BASE		0x14022000
+#define USB_UOC_LEN		0x20
+#define USB_UDC_BASE		0x14022000
+#define USB_UDC_LEN		0x2000
+
+struct au13xx_usb_regs {
+    u32 dwc_ctrl1;
+    u32 dwc_ctrl2;
+    u32 reserved0[2];
+
+    u32 vbus_timer;
+    u32 sbus_ctrl;
+    u32 msr_err;
+    u32 dwc_ctrl3;
+
+    u32 dwc_ctrl4;
+    u32 reserved1;
+    u32 otg_status;
+    u32 dwc_ctrl5;
+
+    u32 dwc_ctrl6;
+    u32 dwc_ctrl7;
+
+    u32 reserved2[(0xC0-0x38)/4];
+
+    u32 phy_status;
+    u32 intr_status;
+    u32 intr_enable;
+
+};
+
+#define USB_DWC_CTRL1_OTGD              (1<<2)
+#define USB_DWC_CTRL1_HSTRS             (1<<1)
+#define USB_DWC_CTRL1_DCRS              (1<<0)
+
+#define USB_DWC_CTRL2_HTBSE1            (1<<11)
+#define USB_DWC_CTRL2_HTBSE0            (1<<10)
+#define USB_DWC_CTRL2_LTBSE1            (1<<9)
+#define USB_DWC_CTRL2_LTBSE0            (1<<8)
+#define USB_DWC_CTRL2_LPBKE1            (1<<5)
+#define USB_DWC_CTRL2_LPBKE0            (1<<4)
+#define USB_DWC_CTRL2_VBUSD             (1<<3)
+#define USB_DWC_CTRL2_PH1RS             (1<<2)
+#define USB_DWC_CTRL2_PHY0RS            (1<<1)
+#define USB_DWC_CTRL2_PHYRS             (1<<0)
+
+#define USB_VBUS_TIMER(n)               (n)
+
+#define USB_SBUS_CTRL_SBCA              (1<<2)
+#define USB_SBUS_CTRL_HWSZ              (1<<1)
+#define USB_SBUS_CTRL_BSZ               (1<<0)
+
+#define USB_MSR_ERR_ILLBM               (1<<18)
+#define USB_MSR_ERR_ILLBRST             (1<<17)
+#define USB_MSR_ERR_UADDRSTS            (1<<16)
+#define USB_MSR_ERR_BMMSK               (1<<2)
+#define USB_MSR_ERR_BRSTMSK             (1<<1)
+#define USB_MSR_ERR_UADMK               (1<<0)
+
+#define USB_DWC_CTRL3_VATEST_EN         (1<<20)
+#define USB_DWC_CTRL3_OHC1_CLKEN        (1<<19)
+#define USB_DWC_CTRL3_OHC0_CLKEN        (1<<18)
+#define USB_DWC_CTRL3_EHC_CLKEN         (1<<17)
+#define USB_DWC_CTRL3_OTG_CLKEN         (1<<16)
+#define USB_DWC_CTRL3_OHCI_SUSP         (1<<3)
+#define USB_DWC_CTRL3_VBUS_VALID_PORT1  (1<<2)
+#define USB_DWC_CTRL3_VBUS_VALID_PORT0  (1<<1)
+#define USB_DWC_CTRL3_VBUS_VALID_SEL    (1<<0)
+
+#define USB_DWC_CTRL4_USB_MODE          (1<<16)
+#define USB_DWC_CTRL4_AHB_CLKDIV(n)     ((n&0xF)<<0)
+
+#define USB_OTG_STATUS_IDPULLUP         (1<<8)
+#define USB_OTG_STATUS_IDDIG            (1<<7)
+#define USB_OTG_STATUS_DISCHRGVBUS      (1<<6)
+#define USB_OTG_STATUS_CHRGVBUS         (1<<5)
+#define USB_OTG_STATUS_DRVVBUS          (1<<4)
+#define USB_OTG_STATUS_SESSIONEND       (1<<3)
+#define USB_OTG_STATUS_VBUSVALID        (1<<2)
+#define USB_OTG_STATUS_BVALID           (1<<1)
+#define USB_OTG_STATUS_AVALID           (1<<0)
+
+#define USB_DWC_CTRL5_REFCLK_DIV(n)     ((n&3)<<18)
+#define USB_DWC_CTRL5_REFCLK_EN(n)      ((n&3)<<16)
+#define USB_DWC_CTRL5_SIDDQ             (1<<1)
+#define USB_DWC_CTRL5_COMMONONN         (1<<0)
+
+#define USB_DWC_CTRL6_DMPULLDOWN_PORT1  (1<<3)
+#define USB_DWC_CTRL6_DPPULLDOWN_PORT1  (1<<2)
+#define USB_DWC_CTRL6_DMPULLDOWN_PORT2  (1<<1)
+#define USB_DWC_CTRL6_DPPULLDOWN_PORT2  (1<<0)
+
+#define USB_DWC_CTRL7_OHC_STARTCLK      (1<<0)
+
+#define USB_PHY_STATUS_VBUS             (1<<0)
+
+#define USB_INTR_S2A                    (1<<6)
+#define USB_INTR_FORCE                  (1<<5)
+#define USB_INTR_PHY                    (1<<4)
+#define USB_INTR_DEVICE                 (1<<3)
+#define USB_INTR_EHCI                   (1<<2)
+#define USB_INTR_OHCI1                  (1<<1)
+#define USB_INTR_OHCI0                  (1<<0)
+
+#define AU1000_USB_HOST_INT (AU1300_IRQ_USB + GPINT_LINUX_IRQ_OFFSET)
+
+#endif  /* CONFIG_SOC_AU13XX */
+#endif  /* _AU13XX_H */
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx.h b/arch/mips/include/asm/mach-au1x00/au1xxx.h
index 1b36550..9a6d9f1 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx.h
@@ -38,6 +38,9 @@
 #elif defined(CONFIG_MIPS_DB1200)
 #include <asm/mach-db1x00/db1200.h>
 
+#elif defined(CONFIG_MIPS_DB1300)
+#include <asm/mips-boards/db1300.h>
+
 #endif
 
 #endif /* _AU1XXX_H_ */
diff --git a/arch/mips/include/asm/mach-au1x00/dev_boards.h b/arch/mips/include/asm/mach-au1x00/dev_boards.h
new file mode 100644
index 0000000..27bca17
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/dev_boards.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2003-2008 RMI Corporation. All rights reserved.
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _AU_DEV_BOARDS_H
+#define _AU_DEV_BOARDS_H
+
+#ifdef CONFIG_MIPS_DB1300
+#include <asm/mips-boards/db1300.h>
+#endif
+
+#ifdef CONFIG_MIPS_DB1200
+#include <asm/mach-db1x00/db1200.h>
+#endif
+
+void db_set_hex(u8 val);
+
+/*
+ * 2 dots use 2 bits
+ */
+void db_set_hex_dots(u8 val);
+
+#endif /* _AU_DEV_BOARDS_H */
diff --git a/arch/mips/include/asm/mips-boards/db1300.h b/arch/mips/include/asm/mips-boards/db1300.h
new file mode 100644
index 0000000..122432a
--- /dev/null
+++ b/arch/mips/include/asm/mips-boards/db1300.h
@@ -0,0 +1,121 @@
+/*
+ * Copyright 2003-2008 RMI Corporation. All rights reserved.
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef ASM_DB1300_H
+#define ASM_DB1300_H
+#ifdef CONFIG_MIPS_DB1300
+#include <asm/addrspace.h>
+#include <asm/mach-au1x00/au13xx.h>
+
+struct db1300_hex_regs {
+	u16 hex;		/* Write 8-bit value here */
+	u16 reserved;
+	u16 blank;		/* Write 11b to blank */
+};
+
+
+#define	DB1300_HEX_REGS_PHYS_ADDR	0x19C00000
+
+/* For alchemy/dev_boards/leds.c */
+typedef struct db1300_hex_regs hex_regs;
+#define HEX_REGS_KSEG1_ADDR	(DB1300_HEX_REGS_PHYS_ADDR + KSEG1)
+
+struct bcsr_regs {
+	/*00*/	u16 whoami;
+		u16 reserved0;
+	/*04*/	u16 status;
+		u16 reserved1;
+	/*08*/	u16 switches;
+		u16 reserved2;
+	/*0C*/	u16 resets;
+		u16 reserved3;
+
+	/*10*/	u16 pcmcia;
+		u16 reserved4;
+	/*14*/	u16 board;
+		u16 reserved5;
+	/*18*/	u16 disk_leds;
+		u16 reserved6;
+	/*1C*/	u16 system;
+		u16 reserved7;
+
+	/*20*/	u16 intclr;
+		u16 reserved8;
+	/*24*/	u16 intset;
+		u16 reserved9;
+	/*28*/	u16 intclr_mask;
+		u16 reserved10;
+	/*2C*/	u16 intset_mask;
+		u16 reserved11;
+
+	/*30*/	u16 sig_status;
+		u16 reserved12;
+	/*34*/	u16 int_status;
+		u16 reserved13;
+	/*38*/	u16 reserved14;
+		u16 reserved15;
+	/*3C*/	u16 reserved16;
+		u16 reserved17;
+};
+
+#define DB1300_BCSR_REGS_PHYS_ADDR	0x19800000
+#define BCSR_REGS_KSEG1_ADDR (KSEG1 + DB1300_BCSR_REGS_PHYS_ADDR)
+
+static volatile struct bcsr_regs *const db_bcsr =
+	(struct bcsr_regs *)(DB1300_BCSR_REGS_PHYS_ADDR + KSEG1);
+
+#define BCSR_STATUS_SD1_WP 		(1<<10)
+#define BCSR_INT_SD1_INSERT		(1<<12)
+
+#define BCSR_RESETS_USB_OTG	0x4000
+#define BCSR_RESETS_USB_HOST	0x8000
+
+#define CASCADE_IRQ_MIN  129
+
+enum db1300_cascade_irqs {
+	DB1300_IDE_IRQ = CASCADE_IRQ_MIN,
+	DB1300_ETHERNET_IRQ,
+	DB1300_AC97_IRQ,
+	DB1300_AC97_PEN_IRQ,
+};
+
+#define CASCADE_IRQ_MAX DB1300_AC97_PEN_IRQ
+
+#define CASCADE_IRQ (5 + GPINT_LINUX_IRQ_OFFSET)
+#define CASCADE_IRQ_TYPE_STRING "DB1300 Cascade"
+
+/*
+ * Defines for au1xxx-ide
+ * See the CPLD/BCSR datasheet for details
+ */
+#define IDE_PHYS_ADDR		0x18800000
+#define IDE_REG_SHIFT		5
+#define IDE_INT 		DB1300_IDE_IRQ
+#define IDE_DDMA_REQ		DSCR_CMD0_DMA_REQ1
+#define IDE_RQSIZE		128
+#define IDE_PHYS_LEN		(16 << IDE_REG_SHIFT)
+
+
+#endif /* CONFIG_MIPS_DB1300 */
+#endif /* ASM_DB1300_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index a7162a4..03e0ae7 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -189,6 +189,7 @@ void __init check_wait(void)
 	case CPU_AU1200:
 	case CPU_AU1210:
 	case CPU_AU1250:
+	case CPU_AU13XX:
 		cpu_wait = au1k_wait;
 		break;
 	case CPU_20KC:
@@ -819,6 +820,20 @@ static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 	}
 }
 
+static inline void cpu_probe_rmi(struct cpuinfo_mips *c, unsigned int cpu)
+{
+	decode_configs(c);
+	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_AU13XX:
+		c->cputype = CPU_AU13XX;
+		__cpu_name[cpu] = "Au13xx";
+		break;
+	default:
+		panic("Unknown RMI Core!\n");
+		break;
+	}
+}
+
 static inline void cpu_probe_sibyte(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
@@ -936,6 +951,11 @@ __cpuinit void cpu_probe(void)
 	case PRID_COMP_CAVIUM:
 		cpu_probe_cavium(c, cpu);
 		break;
+	case PRID_COMP_RMI:
+		cpu_probe_rmi(c, cpu);
+		break;
+	default:
+		c->cputype = CPU_UNKNOWN;
 	}
 
 	BUG_ON(!__cpu_name[cpu]);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index c43f4b2..2b4736a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1033,6 +1033,7 @@ static void __cpuinit probe_pcache(void)
 	case CPU_AU1200:
 	case CPU_AU1210:
 	case CPU_AU1250:
+	case CPU_AU13XX:
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
 		break;
 	}
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4294203..ee5e2de 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -299,6 +299,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_AU1200:
 	case CPU_AU1210:
 	case CPU_AU1250:
+	case CPU_AU13XX:
 	case CPU_PR4450:
 		uasm_i_nop(p);
 		tlbw(p);
-- 
1.5.4.3
