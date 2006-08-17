Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2006 15:12:01 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:55944 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20037472AbWHQOL7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 Aug 2006 15:11:59 +0100
Received: (qmail 22582 invoked from network); 17 Aug 2006 14:11:56 -0000
Received: from laja.dev.rtsoft.ru.dev.rtsoft.ru (HELO dev.rtsoft.ru.) (192.168.1.205)
  by mail.dev.rtsoft.ru with SMTP; 17 Aug 2006 14:11:56 -0000
Date:	Thu, 17 Aug 2006 18:11:37 +0400
From:	Vitaly Wool <vitalywool@gmail.com>
To:	ralf@linux-mips.org
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org
Subject: [PATCH/RFC] fix compilation breakage for PNX8550: conservative
 variant
Message-Id: <20060817181137.45680622.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

Hello folks,

taken into account what Sergey told me wrt kgdb code for pnx8550, I've made the second attempt to make it work. So, inlined is the patch that only restores the pnx8550 compilation and removes dependency on BROKEN for that target.
I've verified that the target will boot up to mounting the NFS filesystem if this patch is applied.

 Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

 arch/mips/Kconfig                           |    2 
 arch/mips/philips/pnx8550/common/Makefile   |    2 
 arch/mips/philips/pnx8550/common/int.c      |    9 ++-
 arch/mips/philips/pnx8550/common/mipsIRQ.S  |   76 ++++++++++++++++++++++++++++
 arch/mips/philips/pnx8550/common/platform.c |    4 -
 arch/mips/philips/pnx8550/common/setup.c    |    2 
 include/asm-mips/mach-pnx8550/uart.h        |   14 +++++
 7 files changed, 99 insertions(+), 10 deletions(-)
      
Index: powerpc.git/arch/mips/Kconfig
===================================================================
--- powerpc.git.orig/arch/mips/Kconfig
+++ powerpc.git/arch/mips/Kconfig
@@ -493,13 +493,11 @@ config MIPS_XXS1500
 
 config PNX8550_V2PCI
 	bool "Philips PNX8550 based Viper2-PCI board"
-	depends on BROKEN
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config PNX8550_JBS
 	bool "Philips PNX8550 based JBS board"
-	depends on BROKEN
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
Index: powerpc.git/arch/mips/philips/pnx8550/common/setup.c
===================================================================
--- powerpc.git.orig/arch/mips/philips/pnx8550/common/setup.c
+++ powerpc.git/arch/mips/philips/pnx8550/common/setup.c
@@ -56,7 +56,7 @@ extern char *prom_getcmdline(void);
 
 struct resource standard_io_resources[] = {
 	{
-		.start	= .0x00,
+		.start	= 0x00,
 		.end	= 0x1f,
 		.name	= "dma1",
 		.flags	= IORESOURCE_BUSY
Index: powerpc.git/arch/mips/philips/pnx8550/common/Makefile
===================================================================
--- powerpc.git.orig/arch/mips/philips/pnx8550/common/Makefile
+++ powerpc.git/arch/mips/philips/pnx8550/common/Makefile
@@ -22,6 +22,6 @@
 # under Linux.
 #
 
-obj-y := setup.o prom.o int.o reset.o time.o proc.o platform.o
+obj-y := setup.o prom.o int.o reset.o time.o proc.o platform.o mipsIRQ.o
 obj-$(CONFIG_PCI) += pci.o
 obj-$(CONFIG_KGDB) += gdb_hook.o
Index: powerpc.git/arch/mips/philips/pnx8550/common/int.c
===================================================================
--- powerpc.git.orig/arch/mips/philips/pnx8550/common/int.c
+++ powerpc.git/arch/mips/philips/pnx8550/common/int.c
@@ -52,7 +52,9 @@ static char gic_prio[PNX8550_INT_GIC_TOT
 	1			//  70
 };
 
-static void hw0_irqdispatch(int irq, struct pt_regs *regs)
+extern asmlinkage void cp0_irqdispatch(void);
+
+void hw0_irqdispatch(int irq, struct pt_regs *regs)
 {
 	/* find out which interrupt */
 	irq = PNX8550_GIC_VECTOR_0 >> 3;
@@ -65,7 +67,7 @@ static void hw0_irqdispatch(int irq, str
 }
 
 
-static void timer_irqdispatch(int irq, struct pt_regs *regs)
+void timer_irqdispatch(int irq, struct pt_regs *regs)
 {
 	irq = (0x01c0 & read_c0_config7()) >> 6;
 
@@ -234,6 +236,9 @@ void __init arch_init_irq(void)
 	int i;
 	int configPR;
 
+	/* init of cp0 interrupts */
+	set_except_vector(0, cp0_irqdispatch);
+
 	for (i = 0; i < PNX8550_INT_CP0_TOTINT; i++) {
 		irq_desc[i].chip = &level_irq_type;
 		pnx8550_ack(i);	/* mask the irq just in case  */
Index: powerpc.git/arch/mips/philips/pnx8550/common/mipsIRQ.S
===================================================================
--- /dev/null
+++ powerpc.git/arch/mips/philips/pnx8550/common/mipsIRQ.S
@@ -0,0 +1,76 @@
+/*
+ * Copyright (c) 2002 Philips, Inc. All rights.
+ * Copyright (c) 2002 Red Hat, Inc. All rights.
+ *
+ * This software may be freely redistributed under the terms of the
+ * GNU General Public License.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Based upon arch/mips/galileo-boards/ev64240/int-handler.S
+ *
+ */
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+/*
+ * cp0_irqdispatch
+ *
+ *    Code to handle in-core interrupt exception.
+ */
+
+		.align	5
+		.set	reorder
+		.set	noat
+		NESTED(cp0_irqdispatch, PT_SIZE, sp)
+		SAVE_ALL
+		CLI
+		.set	at
+		mfc0	t0,CP0_CAUSE
+		mfc0	t2,CP0_STATUS
+
+		and	t0,t2
+
+		andi	t1,t0,STATUSF_IP2 /* int0 hardware line */
+		bnez	t1,ll_hw0_irq
+		nop
+
+		andi	t1,t0,STATUSF_IP7 /* int5 hardware line */
+		bnez	t1,ll_timer_irq
+		nop
+
+		/* wrong alarm or masked ... */
+
+		j	spurious_interrupt
+		nop
+		END(cp0_irqdispatch)
+
+		.align	5
+		.set	reorder
+ll_hw0_irq:
+		li	a0,2
+		move	a1,sp
+		jal	hw0_irqdispatch
+		nop
+		j	ret_from_irq
+		nop
+
+		.align	5
+		.set	reorder
+ll_timer_irq:
+		mfc0	t3,CP0_CONFIG,7
+		andi	t4,t3,0x01c0
+		beqz	t4,ll_timer_out
+		nop
+		li	a0,7
+		move	a1,sp
+		jal	timer_irqdispatch
+		nop
+
+ll_timer_out:	j	ret_from_irq
+		nop
Index: powerpc.git/arch/mips/philips/pnx8550/common/platform.c
===================================================================
--- powerpc.git.orig/arch/mips/philips/pnx8550/common/platform.c
+++ powerpc.git/arch/mips/philips/pnx8550/common/platform.c
@@ -24,8 +24,6 @@
 #include <usb.h>
 #include <uart.h>
 
-extern struct uart_ops ip3106_pops;
-
 static struct resource pnx8550_usb_ohci_resources[] = {
 	[0] = {
 		.start		= PNX8550_USB_OHCI_OP_BASE,
@@ -73,7 +71,6 @@ struct ip3106_port ip3106_ports[] = {
 			.irq		= PNX8550_UART_INT(0),
 			.uartclk	= 3692300,
 			.fifosize	= 16,
-			.ops		= &ip3106_pops,
 			.flags		= UPF_BOOT_AUTOCONF,
 			.line		= 0,
 		},
@@ -87,7 +84,6 @@ struct ip3106_port ip3106_ports[] = {
 			.irq		= PNX8550_UART_INT(1),
 			.uartclk	= 3692300,
 			.fifosize	= 16,
-			.ops		= &ip3106_pops,
 			.flags		= UPF_BOOT_AUTOCONF,
 			.line		= 1,
 		},
Index: powerpc.git/include/asm-mips/mach-pnx8550/uart.h
===================================================================
--- powerpc.git.orig/include/asm-mips/mach-pnx8550/uart.h
+++ powerpc.git/include/asm-mips/mach-pnx8550/uart.h
@@ -13,4 +13,18 @@
 #define PNX8550_UART_INT(x)		(PNX8550_INT_GIC_MIN+19+x)
 #define IRQ_TO_UART(x)			(x-PNX8550_INT_GIC_MIN-19)
 
+/* early macros needed for prom/kgdb */
+
+#define ip3106_lcr(base,port)    *(volatile u32 *)(base+(port*0x1000) + 0x000)
+#define ip3106_mcr(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0x004)
+#define ip3106_baud(base, port)  *(volatile u32 *)(base+(port*0x1000) + 0x008)
+#define ip3106_cfg(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0x00C)
+#define ip3106_fifo(base, port)	 *(volatile u32 *)(base+(port*0x1000) + 0x028)
+#define ip3106_istat(base, port) *(volatile u32 *)(base+(port*0x1000) + 0xFE0)
+#define ip3106_ien(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0xFE4)
+#define ip3106_iclr(base, port)  *(volatile u32 *)(base+(port*0x1000) + 0xFE8)
+#define ip3106_iset(base, port)  *(volatile u32 *)(base+(port*0x1000) + 0xFEC)
+#define ip3106_pd(base, port)    *(volatile u32 *)(base+(port*0x1000) + 0xFF4)
+#define ip3106_mid(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0xFFC)
+
 #endif
