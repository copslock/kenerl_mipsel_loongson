Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2008 18:00:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:48354 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28574755AbYDOQ77 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Apr 2008 17:59:59 +0100
Received: from localhost (p1004-ipad205funabasi.chiba.ocn.ne.jp [222.146.96.4])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 59AB9AF04; Wed, 16 Apr 2008 01:59:50 +0900 (JST)
Date:	Wed, 16 Apr 2008 02:00:45 +0900 (JST)
Message-Id: <20080416.020045.75183728.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rbtx4927: misc cleanups
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Merge tx4927_pci.h into tx4927.h
* Kill (broken) external PCI clock frequency reporting
* Kill unnecessary wbflush()
* Kill unnecessary includes
* Kill debug garbages

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Patch against linux-queue tree.

 arch/mips/pci/fixup-rbtx4927.c                     |    1 -
 arch/mips/pci/ops-tx4927.c                         |    5 +-
 arch/mips/tx4927/common/tx4927_dbgio.c             |    5 +-
 arch/mips/tx4927/common/tx4927_prom.c              |    8 +-
 .../tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |  234 +--------------
 .../toshiba_rbtx4927/toshiba_rbtx4927_prom.c       |    7 +-
 .../toshiba_rbtx4927/toshiba_rbtx4927_setup.c      |  322 +-------------------
 include/asm-mips/tx4927/toshiba_rbtx4927.h         |    4 -
 include/asm-mips/tx4927/tx4927.h                   |  240 ++++++++++++++-
 include/asm-mips/tx4927/tx4927_pci.h               |  268 ----------------
 10 files changed, 266 insertions(+), 828 deletions(-)

diff --git a/arch/mips/pci/fixup-rbtx4927.c b/arch/mips/pci/fixup-rbtx4927.c
index 7450c33..2d234ca 100644
--- a/arch/mips/pci/fixup-rbtx4927.c
+++ b/arch/mips/pci/fixup-rbtx4927.c
@@ -38,7 +38,6 @@
 #include <linux/init.h>
 
 #include <asm/tx4927/tx4927.h>
-#include <asm/tx4927/tx4927_pci.h>
 
 #undef  DEBUG
 #ifdef  DEBUG
diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index 150419c..1bbafeb 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -40,10 +40,7 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-
-#include <asm/addrspace.h>
-#include <asm/byteorder.h>
-#include <asm/tx4927/tx4927_pci.h>
+#include <asm/tx4927/tx4927.h>
 
 /* initialize in setup */
 struct resource pci_io_resource = {
diff --git a/arch/mips/tx4927/common/tx4927_dbgio.c b/arch/mips/tx4927/common/tx4927_dbgio.c
index d8423e0..ea1ff23 100644
--- a/arch/mips/tx4927/common/tx4927_dbgio.c
+++ b/arch/mips/tx4927/common/tx4927_dbgio.c
@@ -28,9 +28,7 @@
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
-#include <asm/mipsregs.h>
-#include <asm/system.h>
+#include <linux/types.h>
 
 u8 getDebugChar(void)
 {
@@ -38,7 +36,6 @@ u8 getDebugChar(void)
 	return (txx9_sio_kdbg_rd());
 }
 
-
 int putDebugChar(u8 byte)
 {
 	extern int txx9_sio_kdbg_wr( u8 ch );
diff --git a/arch/mips/tx4927/common/tx4927_prom.c b/arch/mips/tx4927/common/tx4927_prom.c
index 6eed53d..cc2aa9d 100644
--- a/arch/mips/tx4927/common/tx4927_prom.c
+++ b/arch/mips/tx4927/common/tx4927_prom.c
@@ -30,12 +30,8 @@
  */
 
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
+#include <linux/types.h>
+#include <linux/io.h>
 #include <asm/tx4927/tx4927.h>
 
 static unsigned int __init tx4927_process_sdccr(unsigned long addr)
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
index 6d31f2a..c18901a 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -28,8 +28,6 @@
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
-
 /*
 IRQ  Device
 00   RBTX4927-ISA/00
@@ -112,76 +110,14 @@ JP7 is not bus master -- do NOT use -- only 4 pci bus master's allowed -- SouthB
 */
 
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/ioport.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/timex.h>
-#include <asm/bootinfo.h>
-#include <asm/page.h>
 #include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/pci.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
-#include <asm/time.h>
-#include <asm/wbflush.h>
-#include <linux/bootmem.h>
-#include <linux/blkdev.h>
 #ifdef CONFIG_TOSHIBA_FPCIB0
 #include <asm/i8259.h>
-#include <asm/tx4927/smsc_fdc37m81x.h>
 #endif
 #include <asm/tx4927/toshiba_rbtx4927.h>
 
-
-#undef TOSHIBA_RBTX4927_IRQ_DEBUG
-
-#ifdef TOSHIBA_RBTX4927_IRQ_DEBUG
-#define TOSHIBA_RBTX4927_IRQ_NONE        0x00000000
-
-#define TOSHIBA_RBTX4927_IRQ_INFO          ( 1 <<  0 )
-#define TOSHIBA_RBTX4927_IRQ_WARN          ( 1 <<  1 )
-#define TOSHIBA_RBTX4927_IRQ_EROR          ( 1 <<  2 )
-
-#define TOSHIBA_RBTX4927_IRQ_IOC_INIT      ( 1 << 10 )
-#define TOSHIBA_RBTX4927_IRQ_IOC_ENABLE    ( 1 << 13 )
-#define TOSHIBA_RBTX4927_IRQ_IOC_DISABLE   ( 1 << 14 )
-
-#define TOSHIBA_RBTX4927_SETUP_ALL         0xffffffff
-#endif
-
-
-#ifdef TOSHIBA_RBTX4927_IRQ_DEBUG
-static const u32 toshiba_rbtx4927_irq_debug_flag =
-    (TOSHIBA_RBTX4927_IRQ_NONE | TOSHIBA_RBTX4927_IRQ_INFO |
-     TOSHIBA_RBTX4927_IRQ_WARN | TOSHIBA_RBTX4927_IRQ_EROR
-//                                                 | TOSHIBA_RBTX4927_IRQ_IOC_INIT
-//                                                 | TOSHIBA_RBTX4927_IRQ_IOC_ENABLE
-//                                                 | TOSHIBA_RBTX4927_IRQ_IOC_DISABLE
-    );
-#endif
-
-
-#ifdef TOSHIBA_RBTX4927_IRQ_DEBUG
-#define TOSHIBA_RBTX4927_IRQ_DPRINTK(flag,str...) \
-        if ( (toshiba_rbtx4927_irq_debug_flag) & (flag) ) \
-        { \
-           char tmp[100]; \
-           sprintf( tmp, str ); \
-           printk( "%s(%s:%u)::%s", __func__, __FILE__, __LINE__, tmp ); \
-        }
-#else
-#define TOSHIBA_RBTX4927_IRQ_DPRINTK(flag, str...)
-#endif
-
-
-
-
 #define TOSHIBA_RBTX4927_IRQ_IOC_RAW_BEG   0
 #define TOSHIBA_RBTX4927_IRQ_IOC_RAW_END   7
 
@@ -207,39 +143,22 @@ static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
 #define TOSHIBA_RBTX4927_IOC_INTR_ENAB (void __iomem *)0xbc002000UL
 #define TOSHIBA_RBTX4927_IOC_INTR_STAT (void __iomem *)0xbc002006UL
 
-
-u32 bit2num(u32 num)
-{
-	u32 i;
-
-	for (i = 0; i < (sizeof(num) * 8); i++) {
-		if (num & (1 << i)) {
-			return (i);
-		}
-	}
-	return (0);
-}
-
 int toshiba_rbtx4927_irq_nested(int sw_irq)
 {
-	u32 level3;
+	u8 level3;
 
 	level3 = readb(TOSHIBA_RBTX4927_IOC_INTR_STAT) & 0x1f;
 	if (level3) {
-		sw_irq = TOSHIBA_RBTX4927_IRQ_IOC_BEG + bit2num(level3);
-		if (sw_irq != TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC) {
-			goto RETURN;
-		}
-	}
+		sw_irq = TOSHIBA_RBTX4927_IRQ_IOC_BEG + fls(level3) - 1;
 #ifdef CONFIG_TOSHIBA_FPCIB0
-	if (tx4927_using_backplane) {
-		int irq = i8259_irq();
-		if (irq >= 0)
-			sw_irq = irq;
-	}
+		if (sw_irq == TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC &&
+		    tx4927_using_backplane) {
+			int irq = i8259_irq();
+			if (irq >= 0)
+				sw_irq = irq;
+		}
 #endif
-
-      RETURN:
+	}
 	return (sw_irq);
 }
 
@@ -250,21 +169,10 @@ static struct irqaction toshiba_rbtx4927_irq_ioc_action = {
 	.name		= TOSHIBA_RBTX4927_IOC_NAME
 };
 
-
-/**********************************************************************************/
-/* Functions for ioc                                                              */
-/**********************************************************************************/
-
-
 static void __init toshiba_rbtx4927_irq_ioc_init(void)
 {
 	int i;
 
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_INIT,
-				     "beg=%d end=%d\n",
-				     TOSHIBA_RBTX4927_IRQ_IOC_BEG,
-				     TOSHIBA_RBTX4927_IRQ_IOC_END);
-
 	for (i = TOSHIBA_RBTX4927_IRQ_IOC_BEG;
 	     i <= TOSHIBA_RBTX4927_IRQ_IOC_END; i++)
 		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_ioc_type,
@@ -276,37 +184,16 @@ static void __init toshiba_rbtx4927_irq_ioc_init(void)
 
 static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq)
 {
-	volatile unsigned char v;
-
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_ENABLE,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_IOC_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_IOC_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
+	unsigned char v;
 
 	v = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
 	v |= (1 << (irq - TOSHIBA_RBTX4927_IRQ_IOC_BEG));
 	writeb(v, TOSHIBA_RBTX4927_IOC_INTR_ENAB);
 }
 
-
 static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq)
 {
-	volatile unsigned char v;
-
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_DISABLE,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_IOC_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_IOC_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
+	unsigned char v;
 
 	v = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
 	v &= ~(1 << (irq - TOSHIBA_RBTX4927_IRQ_IOC_BEG));
@@ -314,7 +201,6 @@ static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq)
 	mmiowb();
 }
 
-
 void __init arch_init_irq(void)
 {
 	extern void tx4927_irq_init(void);
@@ -327,102 +213,4 @@ void __init arch_init_irq(void)
 #endif
 	/* Onboard 10M Ether: High Active */
 	set_irq_type(RBTX4927_RTL_8019_IRQ, IRQF_TRIGGER_HIGH);
-
-	wbflush();
-}
-
-void toshiba_rbtx4927_irq_dump(char *key)
-{
-#ifdef TOSHIBA_RBTX4927_IRQ_DEBUG
-	{
-		u32 i, j = 0;
-		for (i = 0; i < NR_IRQS; i++) {
-			if (strcmp(irq_desc[i].chip->name, "none")
-			    == 0)
-				continue;
-
-			if ((i >= 1)
-			    && (irq_desc[i - 1].chip->name ==
-				irq_desc[i].chip->name)) {
-				j++;
-			} else {
-				j = 0;
-			}
-			TOSHIBA_RBTX4927_IRQ_DPRINTK
-			    (TOSHIBA_RBTX4927_IRQ_INFO,
-			     "%s irq=0x%02x/%3d s=0x%08x h=0x%08x a=0x%08x ah=0x%08x d=%1d n=%s/%02d\n",
-			     key, i, i, irq_desc[i].status,
-			     (u32) irq_desc[i].chip,
-			     (u32) irq_desc[i].action,
-			     (u32) (irq_desc[i].action ? irq_desc[i].
-				    action->handler : 0),
-			     irq_desc[i].depth,
-			     irq_desc[i].chip->name, j);
-		}
-	}
-#endif
-}
-
-void toshiba_rbtx4927_irq_dump_pics(char *s)
-{
-	u32 level0_m;
-	u32 level0_s;
-	u32 level1_m;
-	u32 level1_s;
-	u32 level2;
-	u32 level2_p;
-	u32 level2_s;
-	u32 level3_m;
-	u32 level3_s;
-	u32 level4_m;
-	u32 level4_s;
-	u32 level5_m;
-	u32 level5_s;
-
-	if (s == NULL)
-		s = "null";
-
-	level0_m = (read_c0_status() & 0x0000ff00) >> 8;
-	level0_s = (read_c0_cause() & 0x0000ff00) >> 8;
-
-	level1_m = level0_m;
-	level1_s = level0_s & 0x87;
-
-	level2 = __raw_readl((void __iomem *)0xff1ff6a0UL);
-	level2_p = (((level2 & 0x10000)) ? 0 : 1);
-	level2_s = (((level2 & 0x1f) == 0x1f) ? 0 : (level2 & 0x1f));
-
-	level3_m = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB) & 0x1f;
-	level3_s = readb(TOSHIBA_RBTX4927_IOC_INTR_STAT) & 0x1f;
-
-	level4_m = inb(0x21);
-	outb(0x0A, 0x20);
-	level4_s = inb(0x20);
-
-	level5_m = inb(0xa1);
-	outb(0x0A, 0xa0);
-	level5_s = inb(0xa0);
-
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_INFO,
-				     "dump_raw_pic() ");
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_INFO,
-				     "cp0:m=0x%02x/s=0x%02x ", level0_m,
-				     level0_s);
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_INFO,
-				     "cp0:m=0x%02x/s=0x%02x ", level1_m,
-				     level1_s);
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_INFO,
-				     "pic:e=0x%02x/s=0x%02x ", level2_p,
-				     level2_s);
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_INFO,
-				     "ioc:m=0x%02x/s=0x%02x ", level3_m,
-				     level3_s);
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_INFO,
-				     "sbm:m=0x%02x/s=0x%02x ", level4_m,
-				     level4_s);
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_INFO,
-				     "sbs:m=0x%02x/s=0x%02x ", level5_m,
-				     level5_s);
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_INFO, "[%s]\n",
-				     s);
 }
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
index f3f8685..fdbad4b 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
@@ -30,13 +30,10 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-
-#include <asm/addrspace.h>
+#include <linux/string.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/mipsregs.h>
 #include <asm/tx4927/tx4927.h>
 
 void __init prom_init_cmdline(void)
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index 2203c77..185f303 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -62,43 +62,10 @@
 #include <asm/tx4927/smsc_fdc37m81x.h>
 #endif
 #include <asm/tx4927/toshiba_rbtx4927.h>
-#ifdef CONFIG_PCI
-#include <asm/tx4927/tx4927_pci.h>
-#endif
 #ifdef CONFIG_SERIAL_TXX9
 #include <linux/serial_core.h>
 #endif
 
-#undef TOSHIBA_RBTX4927_SETUP_DEBUG
-
-#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
-#define TOSHIBA_RBTX4927_SETUP_SETUP       ( 1 <<  4 )
-#define TOSHIBA_RBTX4927_SETUP_PCIBIOS     ( 1 <<  7 )
-#define TOSHIBA_RBTX4927_SETUP_PCI1        ( 1 <<  8 )
-#define TOSHIBA_RBTX4927_SETUP_PCI2        ( 1 <<  9 )
-
-#define TOSHIBA_RBTX4927_SETUP_ALL         0xffffffff
-#endif
-
-#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
-static const u32 toshiba_rbtx4927_setup_debug_flag =
-    (TOSHIBA_RBTX4927_SETUP_SETUP |
-     | TOSHIBA_RBTX4927_SETUP_PCIBIOS | TOSHIBA_RBTX4927_SETUP_PCI1 |
-     TOSHIBA_RBTX4927_SETUP_PCI2);
-#endif
-
-#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
-#define TOSHIBA_RBTX4927_SETUP_DPRINTK(flag,str...) \
-        if ( (toshiba_rbtx4927_setup_debug_flag) & (flag) ) \
-        { \
-           char tmp[100]; \
-           sprintf( tmp, str ); \
-           printk( "%s(%s:%u)::%s", __func__, __FILE__, __LINE__, tmp ); \
-        }
-#else
-#define TOSHIBA_RBTX4927_SETUP_DPRINTK(flag, str...)
-#endif
-
 /* These functions are used for rebooting or halting the machine*/
 extern void toshiba_rbtx4927_restart(char *command);
 extern void toshiba_rbtx4927_halt(void);
@@ -124,7 +91,6 @@ unsigned long mips_memory_upper;
 static int tx4927_ccfg_toeon = 1;
 static int tx4927_pcic_trdyto = 0;	/* default: disabled */
 unsigned long tx4927_ce_base[8];
-void tx4927_reset_pci_pcic(void);
 int tx4927_pci66 = 0;		/* 0:auto */
 #endif
 
@@ -172,9 +138,6 @@ static int __init tx4927_pcibios_init(void)
 	int busno = 0; /* One bus on the Toshiba */
 	struct pci_controller *hose = &tx4927_controller;
 
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-				       "-\n");
-
 	for (pci_devfn = devfn_start; pci_devfn < devfn_stop; pci_devfn++) {
 		early_read_config_dword(hose, busno, busno, pci_devfn,
 					PCI_VENDOR_ID, &id);
@@ -187,13 +150,6 @@ static int __init tx4927_pcibios_init(void)
 			u8 v08_64;
 			u32 v32_b0;
 			u8 v08_e1;
-#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
-			char *s = " sb/isa --";
-#endif
-
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS, ":%s beg\n",
-			     s);
 
 			early_read_config_byte(hose, busno, busno,
 					       pci_devfn, 0x64, &v08_64);
@@ -202,16 +158,6 @@ static int __init tx4927_pcibios_init(void)
 			early_read_config_byte(hose, busno, busno,
 					       pci_devfn, 0xe1, &v08_e1);
 
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s beg 0x64 = 0x%02x\n", s, v08_64);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s beg 0xb0 = 0x%02x\n", s, v32_b0);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s beg 0xe1 = 0x%02x\n", s, v08_e1);
-
 			/* serial irq control */
 			v08_64 = 0xd0;
 
@@ -222,50 +168,12 @@ static int __init tx4927_pcibios_init(void)
 			v08_e1 &= 0xf0;
 			v08_e1 |= 0x0d;
 
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s mid 0x64 = 0x%02x\n", s, v08_64);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s mid 0xb0 = 0x%02x\n", s, v32_b0);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s mid 0xe1 = 0x%02x\n", s, v08_e1);
-
 			early_write_config_byte(hose, busno, busno,
 						pci_devfn, 0x64, v08_64);
 			early_write_config_dword(hose, busno, busno,
 						 pci_devfn, 0xb0, v32_b0);
 			early_write_config_byte(hose, busno, busno,
 						pci_devfn, 0xe1, v08_e1);
-
-#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
-			{
-				early_read_config_byte(hose, busno, busno,
-						       pci_devfn, 0x64,
-						       &v08_64);
-				early_read_config_dword(hose, busno, busno,
-							pci_devfn, 0xb0,
-							&v32_b0);
-				early_read_config_byte(hose, busno, busno,
-						       pci_devfn, 0xe1,
-						       &v08_e1);
-
-				TOSHIBA_RBTX4927_SETUP_DPRINTK
-				    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-				     ":%s end 0x64 = 0x%02x\n", s, v08_64);
-				TOSHIBA_RBTX4927_SETUP_DPRINTK
-				    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-				     ":%s end 0xb0 = 0x%02x\n", s, v32_b0);
-				TOSHIBA_RBTX4927_SETUP_DPRINTK
-				    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-				     ":%s end 0xe1 = 0x%02x\n", s, v08_e1);
-			}
-#endif
-
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS, ":%s end\n",
-			     s);
 		}
 
 		if (id == 0x91301055) {
@@ -274,13 +182,6 @@ static int __init tx4927_pcibios_init(void)
 			u8 v08_41;
 			u8 v08_43;
 			u8 v08_5c;
-#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
-			char *s = " sb/ide --";
-#endif
-
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS, ":%s beg\n",
-			     s);
 
 			early_read_config_byte(hose, busno, busno,
 					       pci_devfn, 0x04, &v08_04);
@@ -293,22 +194,6 @@ static int __init tx4927_pcibios_init(void)
 			early_read_config_byte(hose, busno, busno,
 					       pci_devfn, 0x5c, &v08_5c);
 
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s beg 0x04 = 0x%02x\n", s, v08_04);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s beg 0x09 = 0x%02x\n", s, v08_09);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s beg 0x41 = 0x%02x\n", s, v08_41);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s beg 0x43 = 0x%02x\n", s, v08_43);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s beg 0x5c = 0x%02x\n", s, v08_5c);
-
 			/* enable ide master/io */
 			v08_04 |= (PCI_COMMAND_MASTER | PCI_COMMAND_IO);
 
@@ -332,22 +217,6 @@ static int __init tx4927_pcibios_init(void)
 			 */
 			v08_5c |= 0x01;
 
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s mid 0x04 = 0x%02x\n", s, v08_04);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s mid 0x09 = 0x%02x\n", s, v08_09);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s mid 0x41 = 0x%02x\n", s, v08_41);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s mid 0x43 = 0x%02x\n", s, v08_43);
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-			     ":%s mid 0x5c = 0x%02x\n", s, v08_5c);
-
 			early_write_config_byte(hose, busno, busno,
 						pci_devfn, 0x5c, v08_5c);
 			early_write_config_byte(hose, busno, busno,
@@ -358,54 +227,11 @@ static int __init tx4927_pcibios_init(void)
 						pci_devfn, 0x41, v08_41);
 			early_write_config_byte(hose, busno, busno,
 						pci_devfn, 0x43, v08_43);
-
-#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
-			{
-				early_read_config_byte(hose, busno, busno,
-						       pci_devfn, 0x04,
-						       &v08_04);
-				early_read_config_byte(hose, busno, busno,
-						       pci_devfn, 0x09,
-						       &v08_09);
-				early_read_config_byte(hose, busno, busno,
-						       pci_devfn, 0x41,
-						       &v08_41);
-				early_read_config_byte(hose, busno, busno,
-						       pci_devfn, 0x43,
-						       &v08_43);
-				early_read_config_byte(hose, busno, busno,
-						       pci_devfn, 0x5c,
-						       &v08_5c);
-
-				TOSHIBA_RBTX4927_SETUP_DPRINTK
-				    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-				     ":%s end 0x04 = 0x%02x\n", s, v08_04);
-				TOSHIBA_RBTX4927_SETUP_DPRINTK
-				    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-				     ":%s end 0x09 = 0x%02x\n", s, v08_09);
-				TOSHIBA_RBTX4927_SETUP_DPRINTK
-				    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-				     ":%s end 0x41 = 0x%02x\n", s, v08_41);
-				TOSHIBA_RBTX4927_SETUP_DPRINTK
-				    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-				     ":%s end 0x43 = 0x%02x\n", s, v08_43);
-				TOSHIBA_RBTX4927_SETUP_DPRINTK
-				    (TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-				     ":%s end 0x5c = 0x%02x\n", s, v08_5c);
-			}
-#endif
-
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS, ":%s end\n",
-			     s);
 		}
 
 	}
 
 	register_pci_controller(&tx4927_controller);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCIBIOS,
-				       "+\n");
-
 	return 0;
 }
 
@@ -419,45 +245,13 @@ void __init tx4927_pci_setup(void)
 	static int called = 0;
 	extern unsigned int tx4927_get_mem_size(void);
 
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2, "-\n");
-
 	mips_memory_upper = tx4927_get_mem_size() << 20;
 	mips_memory_upper += KSEG0;
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "0x%08lx=mips_memory_upper\n",
-				       mips_memory_upper);
 	mips_pci_io_base = TX4927_PCIIO;
 	mips_pci_io_size = TX4927_PCIIO_SIZE;
 	mips_pci_mem_base = TX4927_PCIMEM;
 	mips_pci_mem_size = TX4927_PCIMEM_SIZE;
 
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "0x%08lx=mips_pci_io_base\n",
-				       mips_pci_io_base);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "0x%08lx=mips_pci_io_size\n",
-				       mips_pci_io_size);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "0x%08lx=mips_pci_mem_base\n",
-				       mips_pci_mem_base);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "0x%08lx=mips_pci_mem_size\n",
-				       mips_pci_mem_size);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "0x%08lx=pci_io_resource.start\n",
-				       pci_io_resource.start);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "0x%08lx=pci_io_resource.end\n",
-				       pci_io_resource.end);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "0x%08lx=pci_mem_resource.start\n",
-				       pci_mem_resource.start);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "0x%08lx=pci_mem_resource.end\n",
-				       pci_mem_resource.end);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "0x%08lx=mips_io_port_base",
-				       mips_io_port_base);
 	if (!called) {
 		printk
 		    ("%s PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
@@ -521,29 +315,10 @@ void __init tx4927_pci_setup(void)
 			}
 
 		printk("Internal(%dMHz)", pciclk / 1000000);
-	} else {
-		int pciclk = 0;
-		int pciclk_setting = *tx4927_pci_clk_ptr;
-		switch (pciclk_setting & TX4927_PCI_CLK_MASK) {
-		case TX4927_PCI_CLK_33:
-			pciclk = 33333333;
-			break;
-		case TX4927_PCI_CLK_25:
-			pciclk = 25000000;
-			break;
-		case TX4927_PCI_CLK_66:
-			pciclk = 66666666;
-			break;
-		case TX4927_PCI_CLK_50:
-			pciclk = 50000000;
-			break;
-		}
-		printk("External(%dMHz)", pciclk / 1000000);
-	}
+	} else
+		printk("External");
 	printk("\n");
 
-
-
 	/* GB->PCI mappings */
 	tx4927_pcicptr->g2piomask = (mips_pci_io_size - 1) >> 4;
 	tx4927_pcicptr->g2piogbase = mips_pci_io_base |
@@ -644,12 +419,7 @@ void __init tx4927_pci_setup(void)
 	tx4927_pcicptr->pcistatus = PCI_COMMAND_MASTER |
 	    PCI_COMMAND_MEMORY |
 	    PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       ":pci setup complete:\n");
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2, "+\n");
 }
-
 #endif /* CONFIG_PCI */
 
 static void __noreturn wait_forever(void)
@@ -679,7 +449,6 @@ void toshiba_rbtx4927_restart(char *command)
 	/* no return */
 }
 
-
 void toshiba_rbtx4927_halt(void)
 {
 	printk(KERN_NOTICE "System Halted\n");
@@ -702,33 +471,19 @@ void __init plat_mem_setup(void)
 
 	printk("CPU is %s\n", toshiba_name);
 
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
-				       "-\n");
-
 	/* f/w leaves this on at startup */
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
-				       ":Clearing STO_ERL.\n");
 	clear_c0_status(ST0_ERL);
 
 	/* enable caches -- HCP5 does this, pmon does not */
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
-				       ":Enabling TX49_CONF_IC,TX49_CONF_DC.\n");
 	cp0_config = read_c0_config();
 	cp0_config = cp0_config & ~(TX49_CONF_IC | TX49_CONF_DC);
 	write_c0_config(cp0_config);
 
 	set_io_port_base(KSEG1 + TBTX4927_ISA_IO_OFFSET);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
-				       ":mips_io_port_base=0x%08lx\n",
-				       mips_io_port_base);
 
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
-				       ":Resource\n");
 	ioport_resource.end = 0xffffffff;
 	iomem_resource.end = 0xffffffff;
 
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
-				       ":ResetRoutines\n");
 	_machine_restart = toshiba_rbtx4927_restart;
 	_machine_halt = toshiba_rbtx4927_halt;
 	pm_power_off = toshiba_rbtx4927_power_off;
@@ -761,23 +516,6 @@ void __init plat_mem_setup(void)
 	   * CPU 333MHz: PCI 66MHz : PCIDIVMODE: 101 (1/5)
 	   *
 	 */
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI1,
-				       "ccfg is %lx, PCIDIVMODE is %x\n",
-				       (unsigned long) tx4927_ccfgptr->ccfg,
-				       (unsigned long) tx4927_ccfgptr->ccfg &
-				       (mips_machtype == MACH_TOSHIBA_RBTX4937 ?
-					TX4937_CCFG_PCIDIVMODE_MASK :
-					TX4927_CCFG_PCIDIVMODE_MASK));
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI1,
-				       "PCI66 mode is %lx, PCI mode is %lx, pci arb is %lx\n",
-				       (unsigned long) tx4927_ccfgptr->
-				       ccfg & TX4927_CCFG_PCI66,
-				       (unsigned long) tx4927_ccfgptr->
-				       ccfg & TX4927_CCFG_PCIMIDE,
-				       (unsigned long) tx4927_ccfgptr->
-				       ccfg & TX4927_CCFG_PCIXARB);
-
 	if (mips_machtype == MACH_TOSHIBA_RBTX4937)
 		switch ((unsigned long)tx4927_ccfgptr->
 			ccfg & TX4937_CCFG_PCIDIVMODE_MASK) {
@@ -818,49 +556,18 @@ void __init plat_mem_setup(void)
 
 	/* this is on ISA bus behind PCI bus, so need PCI up first */
 #ifdef CONFIG_TOSHIBA_FPCIB0
-	{
-		if (tx4927_using_backplane) {
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":fpcibo=yes\n");
-
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":smsc_fdc37m81x_init()\n");
-			smsc_fdc37m81x_init(0x3f0);
-
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":smsc_fdc37m81x_config_beg()\n");
-			smsc_fdc37m81x_config_beg();
-
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":smsc_fdc37m81x_config_set(KBD)\n");
-			smsc_fdc37m81x_config_set(SMSC_FDC37M81X_DNUM,
-						  SMSC_FDC37M81X_KBD);
-			smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT, 1);
-			smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT2, 12);
-			smsc_fdc37m81x_config_set(SMSC_FDC37M81X_ACTIVE,
-						  1);
-
-			smsc_fdc37m81x_config_end();
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":smsc_fdc37m81x_config_end()\n");
-		} else {
-			TOSHIBA_RBTX4927_SETUP_DPRINTK
-			    (TOSHIBA_RBTX4927_SETUP_SETUP,
-			     ":fpcibo=not_found\n");
-		}
-	}
-#else
-	{
-		TOSHIBA_RBTX4927_SETUP_DPRINTK
-		    (TOSHIBA_RBTX4927_SETUP_SETUP, ":fpcibo=no\n");
+	if (tx4927_using_backplane) {
+		smsc_fdc37m81x_init(0x3f0);
+		smsc_fdc37m81x_config_beg();
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_DNUM,
+					  SMSC_FDC37M81X_KBD);
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT, 1);
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_INT2, 12);
+		smsc_fdc37m81x_config_set(SMSC_FDC37M81X_ACTIVE,
+					  1);
+		smsc_fdc37m81x_config_end();
 	}
 #endif
-
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_SERIAL_TXX9
@@ -894,17 +601,12 @@ void __init plat_mem_setup(void)
         }
 #endif
 
-
 #ifdef CONFIG_IP_PNP
         argptr = prom_getcmdline();
         if (strstr(argptr, "ip=") == NULL) {
                 strcat(argptr, " ip=any");
         }
 #endif
-
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
-			       "+\n");
 }
 
 void __init plat_time_init(void)
diff --git a/include/asm-mips/tx4927/toshiba_rbtx4927.h b/include/asm-mips/tx4927/toshiba_rbtx4927.h
index b188a65..d6b32ac 100644
--- a/include/asm-mips/tx4927/toshiba_rbtx4927.h
+++ b/include/asm-mips/tx4927/toshiba_rbtx4927.h
@@ -28,9 +28,6 @@
 #define __ASM_TX4927_TOSHIBA_RBTX4927_H
 
 #include <asm/tx4927/tx4927.h>
-#ifdef CONFIG_PCI
-#include <asm/tx4927/tx4927_pci.h>
-#endif
 
 #ifdef CONFIG_PCI
 #define TBTX4927_ISA_IO_OFFSET TX4927_PCIIO
@@ -44,7 +41,6 @@
 #define RBTX4927_SW_RESET_ENABLE     (void __iomem *)0xbc00f002UL
 #define RBTX4927_SW_RESET_ENABLE_SET            0x01
 
-
 #define RBTX4927_RTL_8019_BASE (0x1c020280-TBTX4927_ISA_IO_OFFSET)
 #define RBTX4927_RTL_8019_IRQ  (TX4927_IRQ_PIC_BEG + 5)
 
diff --git a/include/asm-mips/tx4927/tx4927.h b/include/asm-mips/tx4927/tx4927.h
index 193e80a..1d4816f 100644
--- a/include/asm-mips/tx4927/tx4927.h
+++ b/include/asm-mips/tx4927/tx4927.h
@@ -36,11 +36,245 @@
 #define TX4927_IRQ_PIC_END  (TXX9_IRQ_BASE + TXx9_MAX_IR - 1)
 
 
-#define TX4927_IRQ_USER0            (TX4927_IRQ_CP0_BEG+0)
-#define TX4927_IRQ_USER1            (TX4927_IRQ_CP0_BEG+1)
+#define TX4927_IRQ_USER0	    (TX4927_IRQ_CP0_BEG+0)
+#define TX4927_IRQ_USER1	    (TX4927_IRQ_CP0_BEG+1)
 #define TX4927_IRQ_NEST_PIC_ON_CP0  (TX4927_IRQ_CP0_BEG+2)
-#define TX4927_IRQ_CPU_TIMER        (TX4927_IRQ_CP0_BEG+7)
+#define TX4927_IRQ_CPU_TIMER	    (TX4927_IRQ_CP0_BEG+7)
 
 #define TX4927_IRQ_NEST_EXT_ON_PIC  (TX4927_IRQ_PIC_BEG+3)
 
+#define TX4927_CCFG_TOE 0x00004000
+#define TX4927_CCFG_WR	0x00008000
+#define TX4927_CCFG_TINTDIS	0x01000000
+
+#define TX4927_PCIMEM	   0x08000000
+#define TX4927_PCIMEM_SIZE 0x08000000
+#define TX4927_PCIIO	   0x16000000
+#define TX4927_PCIIO_SIZE  0x01000000
+
+#define TX4927_SDRAMC_REG	0xff1f8000
+#define TX4927_EBUSC_REG	0xff1f9000
+#define TX4927_PCIC_REG		0xff1fd000
+#define TX4927_CCFG_REG		0xff1fe000
+#define TX4927_IRC_REG		0xff1ff600
+#define TX4927_NR_TMR	3
+#define TX4927_TMR_REG(ch)	(0xff1ff000 + (ch) * 0x100)
+
+/* bits for ISTAT3/IMASK3/IMSTAT3 */
+#define TX4927_INT3B_PCID	0
+#define TX4927_INT3B_PCIC	1
+#define TX4927_INT3B_PCIB	2
+#define TX4927_INT3B_PCIA	3
+#define TX4927_INT3F_PCID	(1 << TX4927_INT3B_PCID)
+#define TX4927_INT3F_PCIC	(1 << TX4927_INT3B_PCIC)
+#define TX4927_INT3F_PCIB	(1 << TX4927_INT3B_PCIB)
+#define TX4927_INT3F_PCIA	(1 << TX4927_INT3B_PCIA)
+
+#define TX4927_NR_IRQ_LOCAL	TX4927_IRQ_PIC_BEG
+#define TX4927_NR_IRQ_IRC	32	/* On-Chip IRC */
+
+#define TX4927_IR_PCIC		16
+#define TX4927_IR_PCIERR	22
+#define TX4927_IR_PCIPMA	23
+#define TX4927_IRQ_IRC_PCIC	(TX4927_NR_IRQ_LOCAL + TX4927_IR_PCIC)
+#define TX4927_IRQ_IRC_PCIERR	(TX4927_NR_IRQ_LOCAL + TX4927_IR_PCIERR)
+#define TX4927_IRQ_IOC1		(TX4927_NR_IRQ_LOCAL + TX4927_NR_IRQ_IRC)
+#define TX4927_IRQ_IOC_PCID	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCID)
+#define TX4927_IRQ_IOC_PCIC	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIC)
+#define TX4927_IRQ_IOC_PCIB	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIB)
+#define TX4927_IRQ_IOC_PCIA	(TX4927_IRQ_IOC1 + TX4927_INT3B_PCIA)
+
+#ifdef _LANGUAGE_ASSEMBLY
+#define _CONST64(c)	c
+#else
+#define _CONST64(c)	c##ull
+
+#include <asm/byteorder.h>
+
+struct tx4927_sdramc_reg {
+	volatile unsigned long long cr[4];
+	volatile unsigned long long unused0[4];
+	volatile unsigned long long tr;
+	volatile unsigned long long unused1[2];
+	volatile unsigned long long cmd;
+};
+
+struct tx4927_ebusc_reg {
+	volatile unsigned long long cr[8];
+};
+
+struct tx4927_ccfg_reg {
+	volatile unsigned long long ccfg;
+	volatile unsigned long long crir;
+	volatile unsigned long long pcfg;
+	volatile unsigned long long tear;
+	volatile unsigned long long clkctr;
+	volatile unsigned long long unused0;
+	volatile unsigned long long garbc;
+	volatile unsigned long long unused1;
+	volatile unsigned long long unused2;
+	volatile unsigned long long ramp;
+};
+
+struct tx4927_pcic_reg {
+	volatile unsigned long pciid;
+	volatile unsigned long pcistatus;
+	volatile unsigned long pciccrev;
+	volatile unsigned long pcicfg1;
+	volatile unsigned long p2gm0plbase;		/* +10 */
+	volatile unsigned long p2gm0pubase;
+	volatile unsigned long p2gm1plbase;
+	volatile unsigned long p2gm1pubase;
+	volatile unsigned long p2gm2pbase;		/* +20 */
+	volatile unsigned long p2giopbase;
+	volatile unsigned long unused0;
+	volatile unsigned long pcisid;
+	volatile unsigned long unused1;		/* +30 */
+	volatile unsigned long pcicapptr;
+	volatile unsigned long unused2;
+	volatile unsigned long pcicfg2;
+	volatile unsigned long g2ptocnt;		/* +40 */
+	volatile unsigned long unused3[15];
+	volatile unsigned long g2pstatus;		/* +80 */
+	volatile unsigned long g2pmask;
+	volatile unsigned long pcisstatus;
+	volatile unsigned long pcimask;
+	volatile unsigned long p2gcfg;		/* +90 */
+	volatile unsigned long p2gstatus;
+	volatile unsigned long p2gmask;
+	volatile unsigned long p2gccmd;
+	volatile unsigned long unused4[24];		/* +a0 */
+	volatile unsigned long pbareqport;		/* +100 */
+	volatile unsigned long pbacfg;
+	volatile unsigned long pbastatus;
+	volatile unsigned long pbamask;
+	volatile unsigned long pbabm;		/* +110 */
+	volatile unsigned long pbacreq;
+	volatile unsigned long pbacgnt;
+	volatile unsigned long pbacstate;
+	volatile unsigned long long g2pmgbase[3];		/* +120 */
+	volatile unsigned long long g2piogbase;
+	volatile unsigned long g2pmmask[3];		/* +140 */
+	volatile unsigned long g2piomask;
+	volatile unsigned long long g2pmpbase[3];		/* +150 */
+	volatile unsigned long long g2piopbase;
+	volatile unsigned long pciccfg;		/* +170 */
+	volatile unsigned long pcicstatus;
+	volatile unsigned long pcicmask;
+	volatile unsigned long unused5;
+	volatile unsigned long long p2gmgbase[3];		/* +180 */
+	volatile unsigned long long p2giogbase;
+	volatile unsigned long g2pcfgadrs;		/* +1a0 */
+	volatile unsigned long g2pcfgdata;
+	volatile unsigned long unused6[8];
+	volatile unsigned long g2pintack;
+	volatile unsigned long g2pspc;
+	volatile unsigned long unused7[12];		/* +1d0 */
+	volatile unsigned long long pdmca;		/* +200 */
+	volatile unsigned long long pdmga;
+	volatile unsigned long long pdmpa;
+	volatile unsigned long long pdmcut;
+	volatile unsigned long long pdmcnt;		/* +220 */
+	volatile unsigned long long pdmsts;
+	volatile unsigned long long unused8[2];
+	volatile unsigned long long pdmdb[4];		/* +240 */
+	volatile unsigned long long pdmtdh;		/* +260 */
+	volatile unsigned long long pdmdms;
+};
+
+#endif /* _LANGUAGE_ASSEMBLY */
+
+/*
+ * PCIC
+ */
+
+/* bits for G2PSTATUS/G2PMASK */
+#define TX4927_PCIC_G2PSTATUS_ALL	0x00000003
+#define TX4927_PCIC_G2PSTATUS_TTOE	0x00000002
+#define TX4927_PCIC_G2PSTATUS_RTOE	0x00000001
+
+/* bits for PCIMASK (see also PCI_STATUS_XXX in linux/pci.h */
+#define TX4927_PCIC_PCISTATUS_ALL	0x0000f900
+
+/* bits for PBACFG */
+#define TX4927_PCIC_PBACFG_RPBA 0x00000004
+#define TX4927_PCIC_PBACFG_PBAEN	0x00000002
+#define TX4927_PCIC_PBACFG_BMCEN	0x00000001
+
+/* bits for G2PMnGBASE */
+#define TX4927_PCIC_G2PMnGBASE_BSDIS	_CONST64(0x0000002000000000)
+#define TX4927_PCIC_G2PMnGBASE_ECHG	_CONST64(0x0000001000000000)
+
+/* bits for G2PIOGBASE */
+#define TX4927_PCIC_G2PIOGBASE_BSDIS	_CONST64(0x0000002000000000)
+#define TX4927_PCIC_G2PIOGBASE_ECHG	_CONST64(0x0000001000000000)
+
+/* bits for PCICSTATUS/PCICMASK */
+#define TX4927_PCIC_PCICSTATUS_ALL	0x000007dc
+
+/* bits for PCICCFG */
+#define TX4927_PCIC_PCICCFG_LBWC_MASK	0x0fff0000
+#define TX4927_PCIC_PCICCFG_HRST	0x00000800
+#define TX4927_PCIC_PCICCFG_SRST	0x00000400
+#define TX4927_PCIC_PCICCFG_IRBER	0x00000200
+#define TX4927_PCIC_PCICCFG_IMSE0	0x00000100
+#define TX4927_PCIC_PCICCFG_IMSE1	0x00000080
+#define TX4927_PCIC_PCICCFG_IMSE2	0x00000040
+#define TX4927_PCIC_PCICCFG_IISE	0x00000020
+#define TX4927_PCIC_PCICCFG_ATR 0x00000010
+#define TX4927_PCIC_PCICCFG_ICAE	0x00000008
+
+/* bits for P2GMnGBASE */
+#define TX4927_PCIC_P2GMnGBASE_TMEMEN	_CONST64(0x0000004000000000)
+#define TX4927_PCIC_P2GMnGBASE_TBSDIS	_CONST64(0x0000002000000000)
+#define TX4927_PCIC_P2GMnGBASE_TECHG	_CONST64(0x0000001000000000)
+
+/* bits for P2GIOGBASE */
+#define TX4927_PCIC_P2GIOGBASE_TIOEN	_CONST64(0x0000004000000000)
+#define TX4927_PCIC_P2GIOGBASE_TBSDIS	_CONST64(0x0000002000000000)
+#define TX4927_PCIC_P2GIOGBASE_TECHG	_CONST64(0x0000001000000000)
+
+#define TX4927_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
+#define TX4927_PCIC_MAX_DEVNU	TX4927_PCIC_IDSEL_AD_TO_SLOT(32)
+
+/*
+ * CCFG
+ */
+/* CCFG : Chip Configuration */
+#define TX4927_CCFG_PCI66	0x00800000
+#define TX4927_CCFG_PCIMIDE	0x00400000
+#define TX4927_CCFG_PCIXARB	0x00002000
+#define TX4927_CCFG_PCIDIVMODE_MASK	0x00001800
+#define TX4927_CCFG_PCIDIVMODE_2_5	0x00000000
+#define TX4927_CCFG_PCIDIVMODE_3	0x00000800
+#define TX4927_CCFG_PCIDIVMODE_5	0x00001000
+#define TX4927_CCFG_PCIDIVMODE_6	0x00001800
+
+#define TX4937_CCFG_PCIDIVMODE_MASK	0x00001c00
+#define TX4937_CCFG_PCIDIVMODE_8	0x00000000
+#define TX4937_CCFG_PCIDIVMODE_4	0x00000400
+#define TX4937_CCFG_PCIDIVMODE_9	0x00000800
+#define TX4937_CCFG_PCIDIVMODE_4_5	0x00000c00
+#define TX4937_CCFG_PCIDIVMODE_10	0x00001000
+#define TX4937_CCFG_PCIDIVMODE_5	0x00001400
+#define TX4937_CCFG_PCIDIVMODE_11	0x00001800
+#define TX4937_CCFG_PCIDIVMODE_5_5	0x00001c00
+
+/* PCFG : Pin Configuration */
+#define TX4927_PCFG_PCICLKEN_ALL	0x003f0000
+#define TX4927_PCFG_PCICLKEN(ch)	(0x00010000<<(ch))
+
+/* CLKCTR : Clock Control */
+#define TX4927_CLKCTR_PCICKD	0x00400000
+#define TX4927_CLKCTR_PCIRST	0x00000040
+
+#ifndef _LANGUAGE_ASSEMBLY
+
+#define tx4927_sdramcptr	((struct tx4927_sdramc_reg *)TX4927_SDRAMC_REG)
+#define tx4927_pcicptr		((struct tx4927_pcic_reg *)TX4927_PCIC_REG)
+#define tx4927_ccfgptr		((struct tx4927_ccfg_reg *)TX4927_CCFG_REG)
+#define tx4927_ebuscptr		((struct tx4927_ebusc_reg *)TX4927_EBUSC_REG)
+
+#endif /* _LANGUAGE_ASSEMBLY */
+
 #endif /* __ASM_TX4927_TX4927_H */
diff --git a/include/asm-mips/tx4927/tx4927_pci.h b/include/asm-mips/tx4927/tx4927_pci.h
deleted file mode 100644
index 0be77df..0000000
--- a/include/asm-mips/tx4927/tx4927_pci.h
+++ /dev/null
@@ -1,268 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- */
-#ifndef __ASM_TX4927_TX4927_PCI_H
-#define __ASM_TX4927_TX4927_PCI_H
-
-#define TX4927_CCFG_TOE 0x00004000
-#define TX4927_CCFG_WR	0x00008000
-#define TX4927_CCFG_TINTDIS	0x01000000
-
-#define TX4927_PCIMEM      0x08000000
-#define TX4927_PCIMEM_SIZE 0x08000000
-#define TX4927_PCIIO       0x16000000
-#define TX4927_PCIIO_SIZE  0x01000000
-
-#define TX4927_SDRAMC_REG       0xff1f8000
-#define TX4927_EBUSC_REG        0xff1f9000
-#define TX4927_PCIC_REG         0xff1fd000
-#define TX4927_CCFG_REG         0xff1fe000
-#define TX4927_IRC_REG          0xff1ff600
-#define TX4927_NR_TMR	3
-#define TX4927_TMR_REG(ch)	(0xff1ff000 + (ch) * 0x100)
-#define TX4927_CE3      0x17f00000      /* 1M */
-#define TX4927_PCIRESET_ADDR    0xbc00f006
-#define TX4927_PCI_CLK_ADDR     (KSEG1 + TX4927_CE3 + 0x00040020)
-
-#define TX4927_IMSTAT_ADDR(n)   (KSEG1 + TX4927_CE3 + 0x0004001a + (n))
-#define tx4927_imstat_ptr(n)    \
-        ((volatile unsigned char *)TX4927_IMSTAT_ADDR(n))
-
-/* bits for ISTAT3/IMASK3/IMSTAT3 */
-#define TX4927_INT3B_PCID       0
-#define TX4927_INT3B_PCIC       1
-#define TX4927_INT3B_PCIB       2
-#define TX4927_INT3B_PCIA       3
-#define TX4927_INT3F_PCID       (1 << TX4927_INT3B_PCID)
-#define TX4927_INT3F_PCIC       (1 << TX4927_INT3B_PCIC)
-#define TX4927_INT3F_PCIB       (1 << TX4927_INT3B_PCIB)
-#define TX4927_INT3F_PCIA       (1 << TX4927_INT3B_PCIA)
-
-/* bits for PCI_CLK (S6) */
-#define TX4927_PCI_CLK_HOST     0x80
-#define TX4927_PCI_CLK_MASK     (0x0f << 3)
-#define TX4927_PCI_CLK_33       (0x01 << 3)
-#define TX4927_PCI_CLK_25       (0x04 << 3)
-#define TX4927_PCI_CLK_66       (0x09 << 3)
-#define TX4927_PCI_CLK_50       (0x0c << 3)
-#define TX4927_PCI_CLK_ACK      0x04
-#define TX4927_PCI_CLK_ACE      0x02
-#define TX4927_PCI_CLK_ENDIAN   0x01
-#define TX4927_NR_IRQ_LOCAL     TX4927_IRQ_PIC_BEG
-#define TX4927_NR_IRQ_IRC       32      /* On-Chip IRC */
-
-#define TX4927_IR_PCIC  	16
-#define TX4927_IR_PCIERR        22
-#define TX4927_IR_PCIPMA        23
-#define TX4927_IRQ_IRC_PCIC     (TX4927_NR_IRQ_LOCAL + TX4927_IR_PCIC)
-#define TX4927_IRQ_IRC_PCIERR   (TX4927_NR_IRQ_LOCAL + TX4927_IR_PCIERR)
-#define TX4927_IRQ_IOC1         (TX4927_NR_IRQ_LOCAL + TX4927_NR_IRQ_IRC)
-#define TX4927_IRQ_IOC_PCID     (TX4927_IRQ_IOC1 + TX4927_INT3B_PCID)
-#define TX4927_IRQ_IOC_PCIC     (TX4927_IRQ_IOC1 + TX4927_INT3B_PCIC)
-#define TX4927_IRQ_IOC_PCIB     (TX4927_IRQ_IOC1 + TX4927_INT3B_PCIB)
-#define TX4927_IRQ_IOC_PCIA     (TX4927_IRQ_IOC1 + TX4927_INT3B_PCIA)
-
-#ifdef _LANGUAGE_ASSEMBLY
-#define _CONST64(c)     c
-#else
-#define _CONST64(c)     c##ull
-
-#include <asm/byteorder.h>
-
-#define tx4927_pcireset_ptr     \
-        ((volatile unsigned char *)TX4927_PCIRESET_ADDR)
-#define tx4927_pci_clk_ptr      \
-        ((volatile unsigned char *)TX4927_PCI_CLK_ADDR)
-
-struct tx4927_sdramc_reg {
-        volatile unsigned long long cr[4];
-        volatile unsigned long long unused0[4];
-        volatile unsigned long long tr;
-        volatile unsigned long long unused1[2];
-        volatile unsigned long long cmd;
-};
-
-struct tx4927_ebusc_reg {
-        volatile unsigned long long cr[8];
-};
-
-struct tx4927_ccfg_reg {
-        volatile unsigned long long ccfg;
-        volatile unsigned long long crir;
-        volatile unsigned long long pcfg;
-        volatile unsigned long long tear;
-        volatile unsigned long long clkctr;
-        volatile unsigned long long unused0;
-        volatile unsigned long long garbc;
-        volatile unsigned long long unused1;
-        volatile unsigned long long unused2;
-        volatile unsigned long long ramp;
-};
-
-struct tx4927_pcic_reg {
-        volatile unsigned long pciid;
-        volatile unsigned long pcistatus;
-        volatile unsigned long pciccrev;
-        volatile unsigned long pcicfg1;
-        volatile unsigned long p2gm0plbase;             /* +10 */
-        volatile unsigned long p2gm0pubase;
-        volatile unsigned long p2gm1plbase;
-        volatile unsigned long p2gm1pubase;
-        volatile unsigned long p2gm2pbase;              /* +20 */
-        volatile unsigned long p2giopbase;
-        volatile unsigned long unused0;
-        volatile unsigned long pcisid;
-        volatile unsigned long unused1;         /* +30 */
-        volatile unsigned long pcicapptr;
-        volatile unsigned long unused2;
-        volatile unsigned long pcicfg2;
-        volatile unsigned long g2ptocnt;                /* +40 */
-        volatile unsigned long unused3[15];
-        volatile unsigned long g2pstatus;               /* +80 */
-        volatile unsigned long g2pmask;
-        volatile unsigned long pcisstatus;
-        volatile unsigned long pcimask;
-        volatile unsigned long p2gcfg;          /* +90 */
-        volatile unsigned long p2gstatus;
-        volatile unsigned long p2gmask;
-        volatile unsigned long p2gccmd;
-        volatile unsigned long unused4[24];             /* +a0 */
-        volatile unsigned long pbareqport;              /* +100 */
-        volatile unsigned long pbacfg;
-        volatile unsigned long pbastatus;
-        volatile unsigned long pbamask;
-        volatile unsigned long pbabm;           /* +110 */
-        volatile unsigned long pbacreq;
-        volatile unsigned long pbacgnt;
-        volatile unsigned long pbacstate;
-        volatile unsigned long long g2pmgbase[3];               /* +120 */
-        volatile unsigned long long g2piogbase;
-        volatile unsigned long g2pmmask[3];             /* +140 */
-        volatile unsigned long g2piomask;
-        volatile unsigned long long g2pmpbase[3];               /* +150 */
-        volatile unsigned long long g2piopbase;
-        volatile unsigned long pciccfg;         /* +170 */
-        volatile unsigned long pcicstatus;
-        volatile unsigned long pcicmask;
-        volatile unsigned long unused5;
-        volatile unsigned long long p2gmgbase[3];               /* +180 */
-        volatile unsigned long long p2giogbase;
-        volatile unsigned long g2pcfgadrs;              /* +1a0 */
-        volatile unsigned long g2pcfgdata;
-        volatile unsigned long unused6[8];
-        volatile unsigned long g2pintack;
-        volatile unsigned long g2pspc;
-        volatile unsigned long unused7[12];             /* +1d0 */
-        volatile unsigned long long pdmca;              /* +200 */
-        volatile unsigned long long pdmga;
-        volatile unsigned long long pdmpa;
-        volatile unsigned long long pdmcut;
-        volatile unsigned long long pdmcnt;             /* +220 */
-        volatile unsigned long long pdmsts;
-        volatile unsigned long long unused8[2];
-        volatile unsigned long long pdmdb[4];           /* +240 */
-        volatile unsigned long long pdmtdh;             /* +260 */
-        volatile unsigned long long pdmdms;
-};
-
-#endif /* _LANGUAGE_ASSEMBLY */
-
-/*
- * PCIC
- */
-
-/* bits for G2PSTATUS/G2PMASK */
-#define TX4927_PCIC_G2PSTATUS_ALL       0x00000003
-#define TX4927_PCIC_G2PSTATUS_TTOE      0x00000002
-#define TX4927_PCIC_G2PSTATUS_RTOE      0x00000001
-
-/* bits for PCIMASK (see also PCI_STATUS_XXX in linux/pci.h */
-#define TX4927_PCIC_PCISTATUS_ALL       0x0000f900
-
-/* bits for PBACFG */
-#define TX4927_PCIC_PBACFG_RPBA 0x00000004
-#define TX4927_PCIC_PBACFG_PBAEN        0x00000002
-#define TX4927_PCIC_PBACFG_BMCEN        0x00000001
-
-/* bits for G2PMnGBASE */
-#define TX4927_PCIC_G2PMnGBASE_BSDIS    _CONST64(0x0000002000000000)
-#define TX4927_PCIC_G2PMnGBASE_ECHG     _CONST64(0x0000001000000000)
-
-/* bits for G2PIOGBASE */
-#define TX4927_PCIC_G2PIOGBASE_BSDIS    _CONST64(0x0000002000000000)
-#define TX4927_PCIC_G2PIOGBASE_ECHG     _CONST64(0x0000001000000000)
-
-/* bits for PCICSTATUS/PCICMASK */
-#define TX4927_PCIC_PCICSTATUS_ALL      0x000007dc
-
-/* bits for PCICCFG */
-#define TX4927_PCIC_PCICCFG_LBWC_MASK   0x0fff0000
-#define TX4927_PCIC_PCICCFG_HRST        0x00000800
-#define TX4927_PCIC_PCICCFG_SRST        0x00000400
-#define TX4927_PCIC_PCICCFG_IRBER       0x00000200
-#define TX4927_PCIC_PCICCFG_IMSE0       0x00000100
-#define TX4927_PCIC_PCICCFG_IMSE1       0x00000080
-#define TX4927_PCIC_PCICCFG_IMSE2       0x00000040
-#define TX4927_PCIC_PCICCFG_IISE        0x00000020
-#define TX4927_PCIC_PCICCFG_ATR 0x00000010
-#define TX4927_PCIC_PCICCFG_ICAE        0x00000008
-
-/* bits for P2GMnGBASE */
-#define TX4927_PCIC_P2GMnGBASE_TMEMEN   _CONST64(0x0000004000000000)
-#define TX4927_PCIC_P2GMnGBASE_TBSDIS   _CONST64(0x0000002000000000)
-#define TX4927_PCIC_P2GMnGBASE_TECHG    _CONST64(0x0000001000000000)
-
-/* bits for P2GIOGBASE */
-#define TX4927_PCIC_P2GIOGBASE_TIOEN    _CONST64(0x0000004000000000)
-#define TX4927_PCIC_P2GIOGBASE_TBSDIS   _CONST64(0x0000002000000000)
-#define TX4927_PCIC_P2GIOGBASE_TECHG    _CONST64(0x0000001000000000)
-
-#define TX4927_PCIC_IDSEL_AD_TO_SLOT(ad)        ((ad) - 11)
-#define TX4927_PCIC_MAX_DEVNU   TX4927_PCIC_IDSEL_AD_TO_SLOT(32)
-
-/*
- * CCFG
- */
-/* CCFG : Chip Configuration */
-#define TX4927_CCFG_PCI66       0x00800000
-#define TX4927_CCFG_PCIMIDE     0x00400000
-#define TX4927_CCFG_PCIXARB     0x00002000
-#define TX4927_CCFG_PCIDIVMODE_MASK     0x00001800
-#define TX4927_CCFG_PCIDIVMODE_2_5      0x00000000
-#define TX4927_CCFG_PCIDIVMODE_3        0x00000800
-#define TX4927_CCFG_PCIDIVMODE_5        0x00001000
-#define TX4927_CCFG_PCIDIVMODE_6        0x00001800
-
-#define TX4937_CCFG_PCIDIVMODE_MASK	0x00001c00
-#define TX4937_CCFG_PCIDIVMODE_8	0x00000000
-#define TX4937_CCFG_PCIDIVMODE_4	0x00000400
-#define TX4937_CCFG_PCIDIVMODE_9 	0x00000800
-#define TX4937_CCFG_PCIDIVMODE_4_5	0x00000c00
-#define TX4937_CCFG_PCIDIVMODE_10	0x00001000
-#define TX4937_CCFG_PCIDIVMODE_5	0x00001400
-#define TX4937_CCFG_PCIDIVMODE_11	0x00001800
-#define TX4937_CCFG_PCIDIVMODE_5_5	0x00001c00
-
-/* PCFG : Pin Configuration */
-#define TX4927_PCFG_PCICLKEN_ALL        0x003f0000
-#define TX4927_PCFG_PCICLKEN(ch)        (0x00010000<<(ch))
-
-/* CLKCTR : Clock Control */
-#define TX4927_CLKCTR_PCICKD    0x00400000
-#define TX4927_CLKCTR_PCIRST    0x00000040
-
-
-#ifndef _LANGUAGE_ASSEMBLY
-
-#define tx4927_sdramcptr        ((struct tx4927_sdramc_reg *)TX4927_SDRAMC_REG)
-#define tx4927_pcicptr          ((struct tx4927_pcic_reg *)TX4927_PCIC_REG)
-#define tx4927_ccfgptr          ((struct tx4927_ccfg_reg *)TX4927_CCFG_REG)
-#define tx4927_ebuscptr         ((struct tx4927_ebusc_reg *)TX4927_EBUSC_REG)
-
-#endif /* _LANGUAGE_ASSEMBLY */
-
-#endif /* __ASM_TX4927_TX4927_PCI_H */
