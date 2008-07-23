Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 16:26:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:33514 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28578800AbYGWPXi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 16:23:38 +0100
Received: from localhost.localdomain (p3049-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.49])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9FFF2A929; Thu, 24 Jul 2008 00:23:31 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 10/10] txx9: Random cleanup
Date:	Thu, 24 Jul 2008 00:25:21 +0900
Message-Id: <1216826721-28259-10-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.5.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Random cleanups spotted by checkpatch script.
* Do not initialize panic_timeout.  "panic=" kernel parameter can be used.
* Do not add "ip=any" or "ip=bootp".  This options is not board specific.
* Do not add "root=/dev/nfs".  This is default on CONFIG_ROOT_NFS.
* Kill unused error checking.
* Fix IRQ comment to match current code.
* Kill some unneeded includes
* ST0_ERL is already cleared in generic code.
* conswitchp is initialized generic code.
* __init is not needed in prototype.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/smsc_fdc37m81x.c |   20 ++--
 arch/mips/txx9/jmr3927/irq.c            |    4 -
 arch/mips/txx9/jmr3927/prom.c           |   12 +--
 arch/mips/txx9/jmr3927/setup.c          |   22 +----
 arch/mips/txx9/rbtx4927/irq.c           |  161 ++++++++++++++++---------------
 arch/mips/txx9/rbtx4927/setup.c         |   38 ++------
 arch/mips/txx9/rbtx4938/irq.c           |  107 ++++++++++-----------
 arch/mips/txx9/rbtx4938/setup.c         |   39 ++------
 include/asm-mips/txx9/smsc_fdc37m81x.h  |    2 +-
 include/asm-mips/txx9/tx3927.h          |    4 +-
 include/asm-mips/txx9/tx4927pcic.h      |    4 +-
 11 files changed, 170 insertions(+), 243 deletions(-)

diff --git a/arch/mips/txx9/generic/smsc_fdc37m81x.c b/arch/mips/txx9/generic/smsc_fdc37m81x.c
index 69e4874..a2b2d62 100644
--- a/arch/mips/txx9/generic/smsc_fdc37m81x.c
+++ b/arch/mips/txx9/generic/smsc_fdc37m81x.c
@@ -15,8 +15,6 @@
 #include <asm/io.h>
 #include <asm/txx9/smsc_fdc37m81x.h>
 
-#define DEBUG
-
 /* Common Registers */
 #define SMSC_FDC37M81X_CONFIG_INDEX  0x00
 #define SMSC_FDC37M81X_CONFIG_DATA   0x01
@@ -55,7 +53,7 @@
 #define SMSC_FDC37M81X_CONFIG_EXIT   0xaa
 #define SMSC_FDC37M81X_CHIP_ID       0x4d
 
-static unsigned long g_smsc_fdc37m81x_base = 0;
+static unsigned long g_smsc_fdc37m81x_base;
 
 static inline unsigned char smsc_fdc37m81x_rd(unsigned char index)
 {
@@ -107,7 +105,8 @@ unsigned long __init smsc_fdc37m81x_init(unsigned long port)
 	u8 chip_id;
 
 	if (g_smsc_fdc37m81x_base)
-		printk("smsc_fdc37m81x_init() stepping on old base=0x%0*lx\n",
+		printk(KERN_WARNING "%s: stepping on old base=0x%0*lx\n",
+		       __func__,
 		       field, g_smsc_fdc37m81x_base);
 
 	g_smsc_fdc37m81x_base = port;
@@ -118,7 +117,7 @@ unsigned long __init smsc_fdc37m81x_init(unsigned long port)
 	if (chip_id == SMSC_FDC37M81X_CHIP_ID)
 		smsc_fdc37m81x_config_end();
 	else {
-		printk("smsc_fdc37m81x_init() unknow chip id 0x%02x\n",
+		printk(KERN_WARNING "%s: unknow chip id 0x%02x\n", __func__,
 		       chip_id);
 		g_smsc_fdc37m81x_base = 0;
 	}
@@ -127,22 +126,23 @@ unsigned long __init smsc_fdc37m81x_init(unsigned long port)
 }
 
 #ifdef DEBUG
-void smsc_fdc37m81x_config_dump_one(char *key, u8 dev, u8 reg)
+static void smsc_fdc37m81x_config_dump_one(const char *key, u8 dev, u8 reg)
 {
-	printk("%s: dev=0x%02x reg=0x%02x val=0x%02x\n", key, dev, reg,
+	printk(KERN_INFO "%s: dev=0x%02x reg=0x%02x val=0x%02x\n",
+	       key, dev, reg,
 	       smsc_fdc37m81x_rd(reg));
 }
 
 void smsc_fdc37m81x_config_dump(void)
 {
 	u8 orig;
-	char *fname = "smsc_fdc37m81x_config_dump()";
+	const char *fname = __func__;
 
 	smsc_fdc37m81x_config_beg();
 
 	orig = smsc_fdc37m81x_rd(SMSC_FDC37M81X_DNUM);
 
-	printk("%s: common\n", fname);
+	printk(KERN_INFO "%s: common\n", fname);
 	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
 				       SMSC_FDC37M81X_DNUM);
 	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
@@ -154,7 +154,7 @@ void smsc_fdc37m81x_config_dump(void)
 	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_NONE,
 				       SMSC_FDC37M81X_PMGT);
 
-	printk("%s: keyboard\n", fname);
+	printk(KERN_INFO "%s: keyboard\n", fname);
 	smsc_dc37m81x_wr(SMSC_FDC37M81X_DNUM, SMSC_FDC37M81X_KBD);
 	smsc_fdc37m81x_config_dump_one(fname, SMSC_FDC37M81X_KBD,
 				       SMSC_FDC37M81X_ACTIVE);
diff --git a/arch/mips/txx9/jmr3927/irq.c b/arch/mips/txx9/jmr3927/irq.c
index 68f7436..6ec626c 100644
--- a/arch/mips/txx9/jmr3927/irq.c
+++ b/arch/mips/txx9/jmr3927/irq.c
@@ -30,15 +30,11 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 
 #include <asm/io.h>
 #include <asm/mipsregs.h>
-#include <asm/system.h>
-
-#include <asm/processor.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/jmr3927.h>
 
diff --git a/arch/mips/txx9/jmr3927/prom.c b/arch/mips/txx9/jmr3927/prom.c
index 2cadb42..23df38c 100644
--- a/arch/mips/txx9/jmr3927/prom.c
+++ b/arch/mips/txx9/jmr3927/prom.c
@@ -36,6 +36,7 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <asm/bootinfo.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/jmr3927.h>
@@ -56,20 +57,11 @@ prom_putchar(char c)
 	return;
 }
 
-void
-puts(const char *cp)
-{
-    while (*cp)
-	prom_putchar(*cp++);
-    prom_putchar('\r');
-    prom_putchar('\n');
-}
-
 void __init jmr3927_prom_init(void)
 {
 	/* CCFG */
 	if ((tx3927_ccfgptr->ccfg & TX3927_CCFG_TLBOFF) == 0)
-		puts("Warning: TX3927 TLB off\n");
+		printk(KERN_ERR "TX3927 TLB off\n");
 
 	prom_init_cmdline();
 	add_memory_region(0, JMR3927_SDRAM_SIZE, BOOT_MEM_RAM);
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 7378a83..cf7513d 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -74,9 +74,6 @@ static void __init jmr3927_mem_setup(void)
 
 	_machine_restart = jmr3927_machine_restart;
 
-	/* Reboot on panic */
-	panic_timeout = 180;
-
 	/* cache setup */
 	{
 		unsigned int conf;
@@ -94,7 +91,8 @@ static void __init jmr3927_mem_setup(void)
 #endif
 
 		conf = read_c0_conf();
-		conf &= ~(TX39_CONF_ICE | TX39_CONF_DCE | TX39_CONF_WBON | TX39_CONF_CWFON);
+		conf &= ~(TX39_CONF_ICE | TX39_CONF_DCE |
+			  TX39_CONF_WBON | TX39_CONF_CWFON);
 		conf |= mips_ic_disable ? 0 : TX39_CONF_ICE;
 		conf |= mips_dc_disable ? 0 : TX39_CONF_DCE;
 		conf |= mips_config_wbon ? TX39_CONF_WBON : 0;
@@ -107,19 +105,11 @@ static void __init jmr3927_mem_setup(void)
 	/* initialize board */
 	jmr3927_board_init();
 
-	argptr = prom_getcmdline();
-	if ((argptr = strstr(argptr, "ip=")) == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " ip=bootp");
-	}
-
 	tx3927_setup_serial(1 << 1); /* ch1: noCTS */
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
 	argptr = prom_getcmdline();
-	if ((argptr = strstr(argptr, "console=")) == NULL) {
-		argptr = prom_getcmdline();
+	if (!strstr(argptr, "console="))
 		strcat(argptr, " console=ttyS1,115200");
-	}
 #endif
 }
 
@@ -199,16 +189,14 @@ static unsigned long jmr3927_swizzle_addr_b(unsigned long port)
 #endif
 }
 
-static int __init jmr3927_rtc_init(void)
+static void __init jmr3927_rtc_init(void)
 {
 	static struct resource __initdata res = {
 		.start	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE,
 		.end	= JMR3927_IOC_NVRAMB_ADDR - IO_BASE + 0x800 - 1,
 		.flags	= IORESOURCE_MEM,
 	};
-	struct platform_device *dev;
-	dev = platform_device_register_simple("rtc-ds1742", -1, &res, 1);
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+	platform_device_register_simple("rtc-ds1742", -1, &res, 1);
 }
 
 static void __init jmr3927_device_init(void)
diff --git a/arch/mips/txx9/rbtx4927/irq.c b/arch/mips/txx9/rbtx4927/irq.c
index cd748a9..00cd523 100644
--- a/arch/mips/txx9/rbtx4927/irq.c
+++ b/arch/mips/txx9/rbtx4927/irq.c
@@ -27,85 +27,86 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 /*
-IRQ  Device
-00   RBTX4927-ISA/00
-01   RBTX4927-ISA/01 PS2/Keyboard
-02   RBTX4927-ISA/02 Cascade RBTX4927-ISA (irqs 8-15)
-03   RBTX4927-ISA/03
-04   RBTX4927-ISA/04
-05   RBTX4927-ISA/05
-06   RBTX4927-ISA/06
-07   RBTX4927-ISA/07
-08   RBTX4927-ISA/08
-09   RBTX4927-ISA/09
-10   RBTX4927-ISA/10
-11   RBTX4927-ISA/11
-12   RBTX4927-ISA/12 PS2/Mouse (not supported at this time)
-13   RBTX4927-ISA/13
-14   RBTX4927-ISA/14 IDE
-15   RBTX4927-ISA/15
-
-16   TX4927-CP0/00 Software 0
-17   TX4927-CP0/01 Software 1
-18   TX4927-CP0/02 Cascade TX4927-CP0
-19   TX4927-CP0/03 Multiplexed -- do not use
-20   TX4927-CP0/04 Multiplexed -- do not use
-21   TX4927-CP0/05 Multiplexed -- do not use
-22   TX4927-CP0/06 Multiplexed -- do not use
-23   TX4927-CP0/07 CPU TIMER
-
-24   TX4927-PIC/00
-25   TX4927-PIC/01
-26   TX4927-PIC/02
-27   TX4927-PIC/03 Cascade RBTX4927-IOC
-28   TX4927-PIC/04
-29   TX4927-PIC/05 RBTX4927 RTL-8019AS ethernet
-30   TX4927-PIC/06
-31   TX4927-PIC/07
-32   TX4927-PIC/08 TX4927 SerialIO Channel 0
-33   TX4927-PIC/09 TX4927 SerialIO Channel 1
-34   TX4927-PIC/10
-35   TX4927-PIC/11
-36   TX4927-PIC/12
-37   TX4927-PIC/13
-38   TX4927-PIC/14
-39   TX4927-PIC/15
-40   TX4927-PIC/16 TX4927 PCI PCI-C
-41   TX4927-PIC/17
-42   TX4927-PIC/18
-43   TX4927-PIC/19
-44   TX4927-PIC/20
-45   TX4927-PIC/21
-46   TX4927-PIC/22 TX4927 PCI PCI-ERR
-47   TX4927-PIC/23 TX4927 PCI PCI-PMA (not used)
-48   TX4927-PIC/24
-49   TX4927-PIC/25
-50   TX4927-PIC/26
-51   TX4927-PIC/27
-52   TX4927-PIC/28
-53   TX4927-PIC/29
-54   TX4927-PIC/30
-55   TX4927-PIC/31
-
-56 RBTX4927-IOC/00 FPCIB0 PCI-D PJ4/A PJ5/B SB/C PJ6/D PJ7/A (SouthBridge/NotUsed)        [RTL-8139=PJ4]
-57 RBTX4927-IOC/01 FPCIB0 PCI-C PJ4/D PJ5/A SB/B PJ6/C PJ7/D (SouthBridge/NotUsed)        [RTL-8139=PJ5]
-58 RBTX4927-IOC/02 FPCIB0 PCI-B PJ4/C PJ5/D SB/A PJ6/B PJ7/C (SouthBridge/IDE/pin=1,INTR) [RTL-8139=NotSupported]
-59 RBTX4927-IOC/03 FPCIB0 PCI-A PJ4/B PJ5/C SB/D PJ6/A PJ7/B (SouthBridge/USB/pin=4)      [RTL-8139=PJ6]
-60 RBTX4927-IOC/04
-61 RBTX4927-IOC/05
-62 RBTX4927-IOC/06
-63 RBTX4927-IOC/07
-
-NOTES:
-SouthBridge/INTR is mapped to SouthBridge/A=PCI-B/#58
-SouthBridge/ISA/pin=0 no pci irq used by this device
-SouthBridge/IDE/pin=1 no pci irq used by this device, using INTR via ISA IRQ14
-SouthBridge/USB/pin=4 using pci irq SouthBridge/D=PCI-A=#59
-SouthBridge/PMC/pin=0 no pci irq used by this device
-SuperIO/PS2/Keyboard, using INTR via ISA IRQ1
-SuperIO/PS2/Mouse, using INTR via ISA IRQ12 (mouse not currently supported)
-JP7 is not bus master -- do NOT use -- only 4 pci bus master's allowed -- SouthBridge, JP4, JP5, JP6
-*/
+ * I8259A_IRQ_BASE+00
+ * I8259A_IRQ_BASE+01 PS2/Keyboard
+ * I8259A_IRQ_BASE+02 Cascade RBTX4927-ISA (irqs 8-15)
+ * I8259A_IRQ_BASE+03
+ * I8259A_IRQ_BASE+04
+ * I8259A_IRQ_BASE+05
+ * I8259A_IRQ_BASE+06
+ * I8259A_IRQ_BASE+07
+ * I8259A_IRQ_BASE+08
+ * I8259A_IRQ_BASE+09
+ * I8259A_IRQ_BASE+10
+ * I8259A_IRQ_BASE+11
+ * I8259A_IRQ_BASE+12 PS2/Mouse (not supported at this time)
+ * I8259A_IRQ_BASE+13
+ * I8259A_IRQ_BASE+14 IDE
+ * I8259A_IRQ_BASE+15
+ *
+ * MIPS_CPU_IRQ_BASE+00 Software 0
+ * MIPS_CPU_IRQ_BASE+01 Software 1
+ * MIPS_CPU_IRQ_BASE+02 Cascade TX4927-CP0
+ * MIPS_CPU_IRQ_BASE+03 Multiplexed -- do not use
+ * MIPS_CPU_IRQ_BASE+04 Multiplexed -- do not use
+ * MIPS_CPU_IRQ_BASE+05 Multiplexed -- do not use
+ * MIPS_CPU_IRQ_BASE+06 Multiplexed -- do not use
+ * MIPS_CPU_IRQ_BASE+07 CPU TIMER
+ *
+ * TXX9_IRQ_BASE+00
+ * TXX9_IRQ_BASE+01
+ * TXX9_IRQ_BASE+02
+ * TXX9_IRQ_BASE+03 Cascade RBTX4927-IOC
+ * TXX9_IRQ_BASE+04
+ * TXX9_IRQ_BASE+05 RBTX4927 RTL-8019AS ethernet
+ * TXX9_IRQ_BASE+06
+ * TXX9_IRQ_BASE+07
+ * TXX9_IRQ_BASE+08 TX4927 SerialIO Channel 0
+ * TXX9_IRQ_BASE+09 TX4927 SerialIO Channel 1
+ * TXX9_IRQ_BASE+10
+ * TXX9_IRQ_BASE+11
+ * TXX9_IRQ_BASE+12
+ * TXX9_IRQ_BASE+13
+ * TXX9_IRQ_BASE+14
+ * TXX9_IRQ_BASE+15
+ * TXX9_IRQ_BASE+16 TX4927 PCI PCI-C
+ * TXX9_IRQ_BASE+17
+ * TXX9_IRQ_BASE+18
+ * TXX9_IRQ_BASE+19
+ * TXX9_IRQ_BASE+20
+ * TXX9_IRQ_BASE+21
+ * TXX9_IRQ_BASE+22 TX4927 PCI PCI-ERR
+ * TXX9_IRQ_BASE+23 TX4927 PCI PCI-PMA (not used)
+ * TXX9_IRQ_BASE+24
+ * TXX9_IRQ_BASE+25
+ * TXX9_IRQ_BASE+26
+ * TXX9_IRQ_BASE+27
+ * TXX9_IRQ_BASE+28
+ * TXX9_IRQ_BASE+29
+ * TXX9_IRQ_BASE+30
+ * TXX9_IRQ_BASE+31
+ *
+ * RBTX4927_IRQ_IOC+00 FPCIB0 PCI-D (SouthBridge)
+ * RBTX4927_IRQ_IOC+01 FPCIB0 PCI-C (SouthBridge)
+ * RBTX4927_IRQ_IOC+02 FPCIB0 PCI-B (SouthBridge/IDE/pin=1,INTR)
+ * RBTX4927_IRQ_IOC+03 FPCIB0 PCI-A (SouthBridge/USB/pin=4)
+ * RBTX4927_IRQ_IOC+04
+ * RBTX4927_IRQ_IOC+05
+ * RBTX4927_IRQ_IOC+06
+ * RBTX4927_IRQ_IOC+07
+ *
+ * NOTES:
+ * SouthBridge/INTR is mapped to SouthBridge/A=PCI-B/#58
+ * SouthBridge/ISA/pin=0 no pci irq used by this device
+ * SouthBridge/IDE/pin=1 no pci irq used by this device, using INTR
+ * via ISA IRQ14
+ * SouthBridge/USB/pin=4 using pci irq SouthBridge/D=PCI-A=#59
+ * SouthBridge/PMC/pin=0 no pci irq used by this device
+ * SuperIO/PS2/Keyboard, using INTR via ISA IRQ1
+ * SuperIO/PS2/Mouse, using INTR via ISA IRQ12 (mouse not currently supported)
+ * JP7 is not bus master -- do NOT use -- only 4 pci bus master's
+ * allowed -- SouthBridge, JP4, JP5, JP6
+ */
 
 #include <linux/init.h>
 #include <linux/types.h>
@@ -134,7 +135,7 @@ static int toshiba_rbtx4927_irq_nested(int sw_irq)
 	level3 = readb(rbtx4927_imstat_addr) & 0x1f;
 	if (level3)
 		sw_irq = RBTX4927_IRQ_IOC + fls(level3) - 1;
-	return (sw_irq);
+	return sw_irq;
 }
 
 static void __init toshiba_rbtx4927_irq_ioc_init(void)
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index f01af38..962ada5 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -46,7 +46,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
-#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <asm/io.h>
@@ -189,9 +188,6 @@ static void __init rbtx4927_mem_setup(void)
 	u32 cp0_config;
 	char *argptr;
 
-	/* f/w leaves this on at startup */
-	clear_c0_status(ST0_ERL);
-
 	/* enable caches -- HCP5 does this, pmon does not */
 	cp0_config = read_c0_config();
 	cp0_config = cp0_config & ~(TX49_CONF_IC | TX49_CONF_DC);
@@ -218,24 +214,9 @@ static void __init rbtx4927_mem_setup(void)
 
 	tx4927_setup_serial();
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
-        argptr = prom_getcmdline();
-        if (strstr(argptr, "console=") == NULL) {
-                strcat(argptr, " console=ttyS0,38400");
-        }
-#endif
-
-#ifdef CONFIG_ROOT_NFS
-        argptr = prom_getcmdline();
-        if (strstr(argptr, "root=") == NULL) {
-                strcat(argptr, " root=/dev/nfs rw");
-        }
-#endif
-
-#ifdef CONFIG_IP_PNP
-        argptr = prom_getcmdline();
-        if (strstr(argptr, "ip=") == NULL) {
-                strcat(argptr, " ip=any");
-        }
+	argptr = prom_getcmdline();
+	if (!strstr(argptr, "console="))
+		strcat(argptr, " console=ttyS0,38400");
 #endif
 }
 
@@ -298,19 +279,17 @@ static void __init rbtx4927_time_init(void)
 	tx4927_time_init(0);
 }
 
-static int __init toshiba_rbtx4927_rtc_init(void)
+static void __init toshiba_rbtx4927_rtc_init(void)
 {
 	struct resource res = {
 		.start	= RBTX4927_BRAMRTC_BASE - IO_BASE,
 		.end	= RBTX4927_BRAMRTC_BASE - IO_BASE + 0x800 - 1,
 		.flags	= IORESOURCE_MEM,
 	};
-	struct platform_device *dev =
-		platform_device_register_simple("rtc-ds1742", -1, &res, 1);
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+	platform_device_register_simple("rtc-ds1742", -1, &res, 1);
 }
 
-static int __init rbtx4927_ne_init(void)
+static void __init rbtx4927_ne_init(void)
 {
 	struct resource res[] = {
 		{
@@ -322,10 +301,7 @@ static int __init rbtx4927_ne_init(void)
 			.flags	= IORESOURCE_IRQ,
 		}
 	};
-	struct platform_device *dev =
-		platform_device_register_simple("ne", -1,
-						res, ARRAY_SIZE(res));
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+	platform_device_register_simple("ne", -1, res, ARRAY_SIZE(res));
 }
 
 static void __init rbtx4927_device_init(void)
diff --git a/arch/mips/txx9/rbtx4938/irq.c b/arch/mips/txx9/rbtx4938/irq.c
index 3971a06..ca2f830 100644
--- a/arch/mips/txx9/rbtx4938/irq.c
+++ b/arch/mips/txx9/rbtx4938/irq.c
@@ -11,59 +11,57 @@
  */
 
 /*
-IRQ  Device
-
-16   TX4938-CP0/00 Software 0
-17   TX4938-CP0/01 Software 1
-18   TX4938-CP0/02 Cascade TX4938-CP0
-19   TX4938-CP0/03 Multiplexed -- do not use
-20   TX4938-CP0/04 Multiplexed -- do not use
-21   TX4938-CP0/05 Multiplexed -- do not use
-22   TX4938-CP0/06 Multiplexed -- do not use
-23   TX4938-CP0/07 CPU TIMER
-
-24   TX4938-PIC/00
-25   TX4938-PIC/01
-26   TX4938-PIC/02 Cascade RBTX4938-IOC
-27   TX4938-PIC/03 RBTX4938 RTL-8019AS Ethernet
-28   TX4938-PIC/04
-29   TX4938-PIC/05 TX4938 ETH1
-30   TX4938-PIC/06 TX4938 ETH0
-31   TX4938-PIC/07
-32   TX4938-PIC/08 TX4938 SIO 0
-33   TX4938-PIC/09 TX4938 SIO 1
-34   TX4938-PIC/10 TX4938 DMA0
-35   TX4938-PIC/11 TX4938 DMA1
-36   TX4938-PIC/12 TX4938 DMA2
-37   TX4938-PIC/13 TX4938 DMA3
-38   TX4938-PIC/14
-39   TX4938-PIC/15
-40   TX4938-PIC/16 TX4938 PCIC
-41   TX4938-PIC/17 TX4938 TMR0
-42   TX4938-PIC/18 TX4938 TMR1
-43   TX4938-PIC/19 TX4938 TMR2
-44   TX4938-PIC/20
-45   TX4938-PIC/21
-46   TX4938-PIC/22 TX4938 PCIERR
-47   TX4938-PIC/23
-48   TX4938-PIC/24
-49   TX4938-PIC/25
-50   TX4938-PIC/26
-51   TX4938-PIC/27
-52   TX4938-PIC/28
-53   TX4938-PIC/29
-54   TX4938-PIC/30
-55   TX4938-PIC/31 TX4938 SPI
-
-56 RBTX4938-IOC/00 PCI-D
-57 RBTX4938-IOC/01 PCI-C
-58 RBTX4938-IOC/02 PCI-B
-59 RBTX4938-IOC/03 PCI-A
-60 RBTX4938-IOC/04 RTC
-61 RBTX4938-IOC/05 ATA
-62 RBTX4938-IOC/06 MODEM
-63 RBTX4938-IOC/07 SWINT
-*/
+ * MIPS_CPU_IRQ_BASE+00 Software 0
+ * MIPS_CPU_IRQ_BASE+01 Software 1
+ * MIPS_CPU_IRQ_BASE+02 Cascade TX4938-CP0
+ * MIPS_CPU_IRQ_BASE+03 Multiplexed -- do not use
+ * MIPS_CPU_IRQ_BASE+04 Multiplexed -- do not use
+ * MIPS_CPU_IRQ_BASE+05 Multiplexed -- do not use
+ * MIPS_CPU_IRQ_BASE+06 Multiplexed -- do not use
+ * MIPS_CPU_IRQ_BASE+07 CPU TIMER
+ *
+ * TXX9_IRQ_BASE+00
+ * TXX9_IRQ_BASE+01
+ * TXX9_IRQ_BASE+02 Cascade RBTX4938-IOC
+ * TXX9_IRQ_BASE+03 RBTX4938 RTL-8019AS Ethernet
+ * TXX9_IRQ_BASE+04
+ * TXX9_IRQ_BASE+05 TX4938 ETH1
+ * TXX9_IRQ_BASE+06 TX4938 ETH0
+ * TXX9_IRQ_BASE+07
+ * TXX9_IRQ_BASE+08 TX4938 SIO 0
+ * TXX9_IRQ_BASE+09 TX4938 SIO 1
+ * TXX9_IRQ_BASE+10 TX4938 DMA0
+ * TXX9_IRQ_BASE+11 TX4938 DMA1
+ * TXX9_IRQ_BASE+12 TX4938 DMA2
+ * TXX9_IRQ_BASE+13 TX4938 DMA3
+ * TXX9_IRQ_BASE+14
+ * TXX9_IRQ_BASE+15
+ * TXX9_IRQ_BASE+16 TX4938 PCIC
+ * TXX9_IRQ_BASE+17 TX4938 TMR0
+ * TXX9_IRQ_BASE+18 TX4938 TMR1
+ * TXX9_IRQ_BASE+19 TX4938 TMR2
+ * TXX9_IRQ_BASE+20
+ * TXX9_IRQ_BASE+21
+ * TXX9_IRQ_BASE+22 TX4938 PCIERR
+ * TXX9_IRQ_BASE+23
+ * TXX9_IRQ_BASE+24
+ * TXX9_IRQ_BASE+25
+ * TXX9_IRQ_BASE+26
+ * TXX9_IRQ_BASE+27
+ * TXX9_IRQ_BASE+28
+ * TXX9_IRQ_BASE+29
+ * TXX9_IRQ_BASE+30
+ * TXX9_IRQ_BASE+31 TX4938 SPI
+ *
+ * RBTX4938_IRQ_IOC+00 PCI-D
+ * RBTX4938_IRQ_IOC+01 PCI-C
+ * RBTX4938_IRQ_IOC+02 PCI-B
+ * RBTX4938_IRQ_IOC+03 PCI-A
+ * RBTX4938_IRQ_IOC+04 RTC
+ * RBTX4938_IRQ_IOC+05 ATA
+ * RBTX4938_IRQ_IOC+06 MODEM
+ * RBTX4938_IRQ_IOC+07 SWINT
+ */
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <asm/mipsregs.h>
@@ -93,9 +91,6 @@ static int toshiba_rbtx4938_irq_nested(int sw_irq)
 	return sw_irq;
 }
 
-/**********************************************************************************/
-/* Functions for ioc                                                              */
-/**********************************************************************************/
 static void __init
 toshiba_rbtx4938_irq_ioc_init(void)
 {
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 3324a70..5c05a21 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -13,8 +13,6 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/console.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 
@@ -169,45 +167,29 @@ static void __init rbtx4938_mem_setup(void)
 
 	tx4938_setup_serial();
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
-        argptr = prom_getcmdline();
-        if (strstr(argptr, "console=") == NULL) {
-                strcat(argptr, " console=ttyS0,38400");
-        }
+	argptr = prom_getcmdline();
+	if (!strstr(argptr, "console="))
+		strcat(argptr, " console=ttyS0,38400");
 #endif
 
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61
-	printk("PIOSEL: disabling both ata and nand selection\n");
-	local_irq_disable();
+	printk(KERN_INFO "PIOSEL: disabling both ata and nand selection\n");
 	txx9_clear64(&tx4938_ccfgptr->pcfg,
 		     TX4938_PCFG_NDF_SEL | TX4938_PCFG_ATA_SEL);
 #endif
 
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND
-	printk("PIOSEL: enabling nand selection\n");
+	printk(KERN_INFO "PIOSEL: enabling nand selection\n");
 	txx9_set64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_NDF_SEL);
 	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_ATA_SEL);
 #endif
 
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA
-	printk("PIOSEL: enabling ata selection\n");
+	printk(KERN_INFO "PIOSEL: enabling ata selection\n");
 	txx9_set64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_ATA_SEL);
 	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_NDF_SEL);
 #endif
 
-#ifdef CONFIG_IP_PNP
-	argptr = prom_getcmdline();
-	if (strstr(argptr, "ip=") == NULL) {
-		strcat(argptr, " ip=any");
-	}
-#endif
-
-
-#ifdef CONFIG_FB
-	{
-		conswitchp = &dummy_con;
-	}
-#endif
-
 	rbtx4938_spi_setup();
 	pcfg = ____raw_readq(&tx4938_ccfgptr->pcfg);	/* updated */
 	/* fixup piosel */
@@ -228,7 +210,7 @@ static void __init rbtx4938_mem_setup(void)
 	rbtx4938_fpga_resource.end = CPHYSADDR(RBTX4938_FPGA_REG_ADDR) + 0xffff;
 	rbtx4938_fpga_resource.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	if (request_resource(&txx9_ce_res[2], &rbtx4938_fpga_resource))
-		printk("request resource for fpga failed\n");
+		printk(KERN_ERR "request resource for fpga failed\n");
 
 	_machine_restart = rbtx4938_machine_restart;
 
@@ -238,7 +220,7 @@ static void __init rbtx4938_mem_setup(void)
 	       readb(rbtx4938_dipsw_addr), readb(rbtx4938_bdipsw_addr));
 }
 
-static int __init rbtx4938_ne_init(void)
+static void __init rbtx4938_ne_init(void)
 {
 	struct resource res[] = {
 		{
@@ -250,10 +232,7 @@ static int __init rbtx4938_ne_init(void)
 			.flags	= IORESOURCE_IRQ,
 		}
 	};
-	struct platform_device *dev =
-		platform_device_register_simple("ne", -1,
-						res, ARRAY_SIZE(res));
-	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
+	platform_device_register_simple("ne", -1, res, ARRAY_SIZE(res));
 }
 
 static DEFINE_SPINLOCK(rbtx4938_spi_gpio_lock);
diff --git a/include/asm-mips/txx9/smsc_fdc37m81x.h b/include/asm-mips/txx9/smsc_fdc37m81x.h
index 9375e4f..02e161d 100644
--- a/include/asm-mips/txx9/smsc_fdc37m81x.h
+++ b/include/asm-mips/txx9/smsc_fdc37m81x.h
@@ -56,7 +56,7 @@
 #define SMSC_FDC37M81X_CONFIG_EXIT   0xaa
 #define SMSC_FDC37M81X_CHIP_ID       0x4d
 
-unsigned long __init smsc_fdc37m81x_init(unsigned long port);
+unsigned long smsc_fdc37m81x_init(unsigned long port);
 
 void smsc_fdc37m81x_config_beg(void);
 
diff --git a/include/asm-mips/txx9/tx3927.h b/include/asm-mips/txx9/tx3927.h
index 0bac37f..f0439a7 100644
--- a/include/asm-mips/txx9/tx3927.h
+++ b/include/asm-mips/txx9/tx3927.h
@@ -333,8 +333,8 @@ void tx3927_setup(void);
 void tx3927_time_init(unsigned int evt_tmrnr, unsigned int src_tmrnr);
 void tx3927_setup_serial(unsigned int cts_mask);
 struct pci_controller;
-void __init tx3927_pcic_setup(struct pci_controller *channel,
-			      unsigned long sdram_size, int extarb);
+void tx3927_pcic_setup(struct pci_controller *channel,
+		       unsigned long sdram_size, int extarb);
 void tx3927_setup_pcierr_irq(void);
 void tx3927_irq_init(void);
 
diff --git a/include/asm-mips/txx9/tx4927pcic.h b/include/asm-mips/txx9/tx4927pcic.h
index 223841c..c470b8a 100644
--- a/include/asm-mips/txx9/tx4927pcic.h
+++ b/include/asm-mips/txx9/tx4927pcic.h
@@ -193,8 +193,8 @@ struct tx4927_pcic_reg {
 
 struct tx4927_pcic_reg __iomem *get_tx4927_pcicptr(
 	struct pci_controller *channel);
-void __init tx4927_pcic_setup(struct tx4927_pcic_reg __iomem *pcicptr,
-			      struct pci_controller *channel, int extarb);
+void tx4927_pcic_setup(struct tx4927_pcic_reg __iomem *pcicptr,
+		       struct pci_controller *channel, int extarb);
 void tx4927_report_pcic_status(void);
 char *tx4927_pcibios_setup(char *str);
 void tx4927_dump_pcic_settings(void);
-- 
1.5.5.5
