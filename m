Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2005 09:42:52 +0100 (BST)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:35550
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225576AbVGZIm1>; Tue, 26 Jul 2005 09:42:27 +0100
Received: from localhost.localdomain (oreo.jp.mvista.com [10.200.16.31])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id j6Q8inS5027928;
	Tue, 26 Jul 2005 17:44:50 +0900
Date:	Tue, 26 Jul 2005 17:47:41 +0900
From:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: [PATCH 1/1] TX4938: formatted newly added files for Toshiba
 RBHMA4500(TX4938)
Message-Id: <20050726174741.07f111b1.Hiroshi_DOYU@montavista.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <Hiroshi_DOYU@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Hiroshi_DOYU@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hello,

This patch is against latest cvs. just formatted newly added files.

	Hiroshi DOYU

----
Reformatted newly added files for tx4938 along with Linux 
coding style.

Signed-off-by: Hiroshi DOYU <hdoyu@mvista.com>

 arch/mips/pci/fixup-tx4938.c                   |    8 
 arch/mips/pci/ops-tx4938.c                     |   81 +++---
 arch/mips/tx4938/common/dbgio.c                |    3 
 arch/mips/tx4938/common/irq.c                  |   57 +---
 arch/mips/tx4938/common/prom.c                 |    6 
 arch/mips/tx4938/common/rtc_rx5c348.c          |   27 --
 arch/mips/tx4938/common/setup.c                |   29 --
 arch/mips/tx4938/toshiba_rbtx4938/irq.c        |   40 +--
 arch/mips/tx4938/toshiba_rbtx4938/prom.c       |    8 
 arch/mips/tx4938/toshiba_rbtx4938/setup.c      |  327 +++++++++++++------------
 arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c |   18 -
 arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c   |   29 --
 include/asm-mips/tx4938/rbtx4938.h             |    7 
 include/asm-mips/tx4938/spi.h                  |   18 -
 include/asm-mips/tx4938/tx4938.h               |   65 ++--
 15 files changed, 352 insertions(+), 371 deletions(-)

Index: linux/arch/mips/tx4938/toshiba_rbtx4938/prom.c
===================================================================
--- linux.orig/arch/mips/tx4938/toshiba_rbtx4938/prom.c
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/prom.c
@@ -24,8 +24,8 @@
 
 void __init prom_init_cmdline(void)
 {
-	int argc = (int) fw_arg0;
-	char **argv = (char **) fw_arg1;
+	int argc = (int)fw_arg0;
+	char **argv = (char **)fw_arg1;
 	int i;
 
 	/* ignore all built-in args if any f/w args given */
@@ -57,7 +57,7 @@
 	return;
 }
 
-unsigned long  __init prom_free_prom_memory(void)
+unsigned long __init prom_free_prom_memory(void)
 {
 	return 0;
 }
@@ -72,7 +72,7 @@
 	return "Toshiba RBTX4938";
 }
 
-char * __init prom_getcmdline(void)
+char *__init prom_getcmdline(void)
 {
 	return &(arcs_cmdline[0]);
 }
Index: linux/include/asm-mips/tx4938/spi.h
===================================================================
--- linux.orig/include/asm-mips/tx4938/spi.h
+++ linux/include/asm-mips/tx4938/spi.h
@@ -17,13 +17,14 @@
 /* SPI */
 struct spi_dev_desc {
 	unsigned int baud;
-	unsigned short tcss, tcsh, tcsr; /* CS setup/hold/recovery time */
+	unsigned short tcss, tcsh, tcsr;	/* CS setup/hold/recovery time */
 	unsigned int byteorder:1;	/* 0:LSB-First, 1:MSB-First */
 	unsigned int polarity:1;	/* 0:High-Active */
-	unsigned int phase:1;		/* 0:Sample-Then-Shift */
+	unsigned int phase:1;	/* 0:Sample-Then-Shift */
 };
 
-extern void txx9_spi_init(unsigned long base, int (*cs_func)(int chipid, int on)) __init;
+extern void txx9_spi_init(unsigned long base,
+			  int (*cs_func) (int chipid, int on)) __init;
 extern void txx9_spi_irqinit(int irc_irq) __init;
 extern int txx9_spi_io(int chipid, struct spi_dev_desc *desc,
 		       unsigned char **inbufs, unsigned int *incounts,
@@ -31,9 +32,12 @@
 		       int cansleep);
 extern int spi_eeprom_write_enable(int chipid, int enable);
 extern int spi_eeprom_read_status(int chipid);
-extern int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len);
-extern int spi_eeprom_write(int chipid, int address, unsigned char *buf, int len);
-extern void spi_eeprom_proc_create(struct proc_dir_entry *dir, int chipid) __init;
+extern int spi_eeprom_read(int chipid, int address, unsigned char *buf,
+			   int len);
+extern int spi_eeprom_write(int chipid, int address, unsigned char *buf,
+			    int len);
+extern void spi_eeprom_proc_create(struct proc_dir_entry *dir,
+				   int chipid) __init;
 
 #define TXX9_IMCLK     (txx9_gbus_clock / 2)
 
@@ -71,4 +75,4 @@
 #define TXx9_SPSR_STRDY	0x0002
 #define TXx9_SPSR_SRRDY	0x0001
 
-#endif /* __ASM_TX_BOARDS_TX4938_SPI_H */
+#endif				/* __ASM_TX_BOARDS_TX4938_SPI_H */
Index: linux/arch/mips/tx4938/common/setup.c
===================================================================
--- linux.orig/arch/mips/tx4938/common/setup.c
+++ linux/arch/mips/tx4938/common/setup.c
@@ -44,24 +44,21 @@
 
 void (*__wbflush) (void);
 
-static void
-tx4938_write_buffer_flush(void)
+static void tx4938_write_buffer_flush(void)
 {
 	mmiowb();
 
-	__asm__ __volatile__(
-		".set	push\n\t"
-		".set	noreorder\n\t"
-		"lw	$0,%0\n\t"
-		"nop\n\t"
-		".set	pop"
-		: /* no output */
-		: "m" (*(int *)KSEG1)
-		: "memory");
+	__asm__ __volatile__(".set	push\n\t" 
+			     ".set	noreorder\n\t" 
+			     "lw	$0,%0\n\t" 
+			     "nop\n\t" 
+			     ".set	pop"
+			     :	/* no output */
+			     :"m"(*(int *)KSEG1)
+			     :"memory");
 }
 
-void __init
-plat_setup(void)
+void __init plat_setup(void)
 {
 	board_time_init = tx4938_time_init;
 	board_timer_setup = tx4938_timer_setup;
@@ -69,14 +66,12 @@
 	toshiba_rbtx4938_setup();
 }
 
-void __init
-tx4938_time_init(void)
+void __init tx4938_time_init(void)
 {
 	rbtx4938_time_init();
 }
 
-void __init
-tx4938_timer_setup(struct irqaction *irq)
+void __init tx4938_timer_setup(struct irqaction *irq)
 {
 	u32 count;
 	u32 c1;
Index: linux/arch/mips/tx4938/common/dbgio.c
===================================================================
--- linux.orig/arch/mips/tx4938/common/dbgio.c
+++ linux/arch/mips/tx4938/common/dbgio.c
@@ -36,7 +36,7 @@
 #include <asm/tx4938/tx4938_mips.h>
 
 extern u8 txx9_sio_kdbg_rd(void);
-extern int txx9_sio_kdbg_wr( u8 ch );
+extern int txx9_sio_kdbg_wr(u8 ch);
 
 u8 getDebugChar(void)
 {
@@ -47,4 +47,3 @@
 {
 	return (txx9_sio_kdbg_wr(byte));
 }
-
Index: linux/include/asm-mips/tx4938/rbtx4938.h
===================================================================
--- linux.orig/include/asm-mips/tx4938/rbtx4938.h
+++ linux/include/asm-mips/tx4938/rbtx4938.h
@@ -153,8 +153,8 @@
 #define TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG   0
 #define TOSHIBA_RBTX4938_IRQ_IOC_RAW_END   7
 
-#define TOSHIBA_RBTX4938_IRQ_IOC_BEG  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG) /* 56 */
-#define TOSHIBA_RBTX4938_IRQ_IOC_END  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_END) /* 63 */
+#define TOSHIBA_RBTX4938_IRQ_IOC_BEG  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG)	/* 56 */
+#define TOSHIBA_RBTX4938_IRQ_IOC_END  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_END)	/* 63 */
 #define RBTX4938_IRQ_LOCAL	TX4938_IRQ_CP0_BEG
 #define RBTX4938_IRQ_IRC	(RBTX4938_IRQ_LOCAL + RBTX4938_NR_IRQ_LOCAL)
 #define RBTX4938_IRQ_IOC	(RBTX4938_IRQ_IRC + RBTX4938_NR_IRQ_IRC)
@@ -189,7 +189,6 @@
 #define RBTX4938_IRQ_IOC_MODEM	(RBTX4938_IRQ_IOC + RBTX4938_INTB_MODEM)
 #define RBTX4938_IRQ_IOC_SWINT	(RBTX4938_IRQ_IOC + RBTX4938_INTB_SWINT)
 
-
 /* IOC (PCI, etc) */
 #define RBTX4938_IRQ_IOCINT	(TX4938_IRQ_NEST_EXT_ON_PIC)
 /* Onboard 10M Ether */
@@ -204,4 +203,4 @@
 #define TX4938_IRCR_DOWN 0x00000002
 #define TX4938_IRCR_UP   0x00000003
 
-#endif /* __ASM_TX_BOARDS_RBTX4938_H */
+#endif				/* __ASM_TX_BOARDS_RBTX4938_H */
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/irq.c
===================================================================
--- linux.orig/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/irq.c
@@ -114,27 +114,25 @@
 #define TOSHIBA_RBTX4938_IOC_INTR_ENAB 0xb7f02000
 #define TOSHIBA_RBTX4938_IOC_INTR_STAT 0xb7f0200a
 
-u8
-last_bit2num(u8 num)
+u8 last_bit2num(u8 num)
 {
-	u8 i = ((sizeof(num)*8)-1);
+	u8 i = ((sizeof(num) * 8) - 1);
 
 	do {
-		if (num & (1<<i))
+		if (num & (1 << i))
 			break;
-	} while ( --i );
+	} while (--i);
 
 	return i;
 }
 
-int
-toshiba_rbtx4938_irq_nested(int sw_irq)
+int toshiba_rbtx4938_irq_nested(int sw_irq)
 {
 	u8 level3;
 
 	level3 = reg_rd08(TOSHIBA_RBTX4938_IOC_INTR_STAT) & 0xff;
 	if (level3) {
-                /* must use last_bit2num so onboard ATA has priority */
+		/* must use last_bit2num so onboard ATA has priority */
 		sw_irq = TOSHIBA_RBTX4938_IRQ_IOC_BEG + last_bit2num(level3);
 	}
 
@@ -152,8 +150,7 @@
 /**********************************************************************************/
 /* Functions for ioc                                                              */
 /**********************************************************************************/
-static void __init
-toshiba_rbtx4938_irq_ioc_init(void)
+static void __init toshiba_rbtx4938_irq_ioc_init(void)
 {
 	int i;
 
@@ -165,26 +162,22 @@
 		irq_desc[i].handler = &toshiba_rbtx4938_irq_ioc_type;
 	}
 
-	setup_irq(RBTX4938_IRQ_IOCINT,
-		  &toshiba_rbtx4938_irq_ioc_action);
+	setup_irq(RBTX4938_IRQ_IOCINT, &toshiba_rbtx4938_irq_ioc_action);
 }
 
-static unsigned int
-toshiba_rbtx4938_irq_ioc_startup(unsigned int irq)
+static unsigned int toshiba_rbtx4938_irq_ioc_startup(unsigned int irq)
 {
 	toshiba_rbtx4938_irq_ioc_enable(irq);
 
 	return 0;
 }
 
-static void
-toshiba_rbtx4938_irq_ioc_shutdown(unsigned int irq)
+static void toshiba_rbtx4938_irq_ioc_shutdown(unsigned int irq)
 {
 	toshiba_rbtx4938_irq_ioc_disable(irq);
 }
 
-static void
-toshiba_rbtx4938_irq_ioc_enable(unsigned int irq)
+static void toshiba_rbtx4938_irq_ioc_enable(unsigned int irq)
 {
 	unsigned long flags;
 	volatile unsigned char v;
@@ -200,8 +193,7 @@
 	spin_unlock_irqrestore(&toshiba_rbtx4938_ioc_lock, flags);
 }
 
-static void
-toshiba_rbtx4938_irq_ioc_disable(unsigned int irq)
+static void toshiba_rbtx4938_irq_ioc_disable(unsigned int irq)
 {
 	unsigned long flags;
 	volatile unsigned char v;
@@ -217,14 +209,12 @@
 	spin_unlock_irqrestore(&toshiba_rbtx4938_ioc_lock, flags);
 }
 
-static void
-toshiba_rbtx4938_irq_ioc_mask_and_ack(unsigned int irq)
+static void toshiba_rbtx4938_irq_ioc_mask_and_ack(unsigned int irq)
 {
 	toshiba_rbtx4938_irq_ioc_disable(irq);
 }
 
-static void
-toshiba_rbtx4938_irq_ioc_end(unsigned int irq)
+static void toshiba_rbtx4938_irq_ioc_end(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
 		toshiba_rbtx4938_irq_ioc_enable(irq);
@@ -253,7 +243,7 @@
 
 	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_SPI_SEL) {
 		txx9_spi_irqinit(RBTX4938_IRQ_IRC_SPI);
-        }
+	}
 
 	wbflush();
 }
Index: linux/arch/mips/pci/ops-tx4938.c
===================================================================
--- linux.orig/arch/mips/pci/ops-tx4938.c
+++ linux/arch/mips/pci/ops-tx4938.c
@@ -20,31 +20,31 @@
 
 /* initialize in setup */
 struct resource pci_io_resource = {
-	.name	= "pci IO space",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_IO
+	.name = "pci IO space",
+	.start = 0,
+	.end = 0,
+	.flags = IORESOURCE_IO
 };
 
 /* initialize in setup */
 struct resource pci_mem_resource = {
-	.name	= "pci memory space",
-	.start	= 0,
-	.end	= 0,
-	.flags	= IORESOURCE_MEM
+	.name = "pci memory space",
+	.start = 0,
+	.end = 0,
+	.flags = IORESOURCE_MEM
 };
 
 struct resource tx4938_pcic1_pci_io_resource = {
-       	.name	= "PCI1 IO",
-       	.start	= 0,
-       	.end	= 0,
-       	.flags	= IORESOURCE_IO
+	.name = "PCI1 IO",
+	.start = 0,
+	.end = 0,
+	.flags = IORESOURCE_IO
 };
 struct resource tx4938_pcic1_pci_mem_resource = {
-       	.name	= "PCI1 mem",
-       	.start	= 0,
-       	.end	= 0,
-       	.flags	= IORESOURCE_MEM
+	.name = "PCI1 mem",
+	.start = 0,
+	.end = 0,
+	.flags = IORESOURCE_MEM
 };
 
 static int mkaddr(int bus, int dev_fn, int where, int *flagsp)
@@ -74,8 +74,7 @@
 {
 	int code = PCIBIOS_SUCCESSFUL;
 	/* wait write cycle completion before checking error status */
-	while (tx4938_pcicptr->pcicstatus & TX4938_PCIC_PCICSTATUS_IWB)
-				;
+	while (tx4938_pcicptr->pcicstatus & TX4938_PCIC_PCICSTATUS_IWB) ;
 	if (tx4938_pcicptr->pcistatus & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
 		tx4938_pcicptr->pcistatus =
 		    (tx4938_pcicptr->
@@ -88,7 +87,7 @@
 }
 
 static int tx4938_pcibios_read_config(struct pci_bus *bus, unsigned int devfn,
-					int where, int size, u32 * val)
+				      int where, int size, u32 * val)
 {
 	int flags, retval, dev, busno, func;
 
@@ -107,19 +106,19 @@
 
 	switch (size) {
 	case 1:
-		*val = *(volatile u8 *) ((ulong) & tx4938_pcicptr->g2pcfgdata |
+		*val = *(volatile u8 *)((ulong) & tx4938_pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
-			      ((where & 3) ^ 3));
+					((where & 3) ^ 3));
 #else
-			      (where & 3));
+					(where & 3));
 #endif
 		break;
 	case 2:
-		*val = *(volatile u16 *) ((ulong) & tx4938_pcicptr->g2pcfgdata |
+		*val = *(volatile u16 *)((ulong) & tx4938_pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
-				((where & 3) ^ 2));
+					 ((where & 3) ^ 2));
 #else
-				(where & 3));
+					 (where & 3));
 #endif
 		break;
 	case 4:
@@ -134,8 +133,8 @@
 	return retval;
 }
 
-static int tx4938_pcibios_write_config(struct pci_bus *bus, unsigned int devfn, int where,
-						int size, u32 val)
+static int tx4938_pcibios_write_config(struct pci_bus *bus, unsigned int devfn,
+				       int where, int size, u32 val)
 {
 	int flags, dev, busno, func;
 
@@ -155,19 +154,19 @@
 
 	switch (size) {
 	case 1:
-		*(volatile u8 *) ((ulong) & tx4938_pcicptr->g2pcfgdata |
+		*(volatile u8 *)((ulong) & tx4938_pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
-			  ((where & 3) ^ 3)) = val;
+				 ((where & 3) ^ 3)) = val;
 #else
-			  (where & 3)) = val;
+				 (where & 3)) = val;
 #endif
 		break;
 	case 2:
-		*(volatile u16 *) ((ulong) & tx4938_pcicptr->g2pcfgdata |
+		*(volatile u16 *)((ulong) & tx4938_pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
-			((where & 0x3) ^ 0x2)) = val;
+				  ((where & 0x3) ^ 0x2)) = val;
 #else
-			(where & 3)) = val;
+				  (where & 3)) = val;
 #endif
 		break;
 	case 4:
@@ -186,14 +185,14 @@
 struct pci_controller tx4938_pci_controller[] = {
 	/* h/w only supports devices 0x00 to 0x14 */
 	{
-		.pci_ops        = &tx4938_pci_ops,
-		.io_resource    = &pci_io_resource,
-		.mem_resource   = &pci_mem_resource,
-	},
+	 .pci_ops = &tx4938_pci_ops,
+	 .io_resource = &pci_io_resource,
+	 .mem_resource = &pci_mem_resource,
+	 },
 	/* h/w only supports devices 0x00 to 0x14 */
 	{
-		.pci_ops        = &tx4938_pci_ops,
-		.io_resource    = &tx4938_pcic1_pci_io_resource,
-		.mem_resource   = &tx4938_pcic1_pci_mem_resource,
-        }
+	 .pci_ops = &tx4938_pci_ops,
+	 .io_resource = &tx4938_pcic1_pci_io_resource,
+	 .mem_resource = &tx4938_pcic1_pci_mem_resource,
+	 }
 };
Index: linux/include/asm-mips/tx4938/tx4938.h
===================================================================
--- linux.orig/include/asm-mips/tx4938/tx4938.h
+++ linux/include/asm-mips/tx4938/tx4938.h
@@ -33,8 +33,8 @@
 #define TX4938_PCIMEM_SIZE_0 0x08000000
 #define TX4938_PCIMEM_SIZE_1 0x00010000
 
-#define TX4938_REG_BASE	0xff1f0000 /* == TX4937_REG_BASE */
-#define TX4938_REG_SIZE	0x00010000 /* == TX4937_REG_SIZE */
+#define TX4938_REG_BASE	0xff1f0000	/* == TX4937_REG_BASE */
+#define TX4938_REG_SIZE	0x00010000	/* == TX4937_REG_SIZE */
 
 /* NDFMC, SRAMC, PCIC1, SPIC: TX4938 only */
 #define TX4938_NDFMC_REG	(TX4938_REG_BASE + 0x5000)
@@ -74,7 +74,7 @@
 #define TX4938_RD( reg      ) TX4938_RD32( reg )
 #define TX4938_WR( reg, val ) TX4938_WR32( reg, val )
 
-#endif /* !__ASSEMBLY__ */
+#endif				/* !__ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
 #define _CONST64(c)	c
@@ -107,7 +107,6 @@
 	volatile unsigned char e4,e3,e2,e1
 #endif
 
-
 struct tx4938_sdramc_reg {
 	volatile unsigned long long cr[4];
 	volatile unsigned long long unused0[4];
@@ -126,16 +125,16 @@
 		volatile unsigned long long cha;
 		volatile unsigned long long sar;
 		volatile unsigned long long dar;
-		endian_def_l2(unused0, cntr);
-		endian_def_l2(unused1, sair);
-		endian_def_l2(unused2, dair);
-		endian_def_l2(unused3, ccr);
-		endian_def_l2(unused4, csr);
+		 endian_def_l2(unused0, cntr);
+		 endian_def_l2(unused1, sair);
+		 endian_def_l2(unused2, dair);
+		 endian_def_l2(unused3, ccr);
+		 endian_def_l2(unused4, csr);
 	} ch[4];
 	volatile unsigned long long dbr[8];
 	volatile unsigned long long tdhr;
 	volatile unsigned long long midr;
-	endian_def_l2(unused0, mcr);
+	 endian_def_l2(unused0, mcr);
 };
 
 struct tx4938_pcic_reg {
@@ -143,60 +142,60 @@
 	volatile unsigned long pcistatus;
 	volatile unsigned long pciccrev;
 	volatile unsigned long pcicfg1;
-	volatile unsigned long p2gm0plbase;		/* +10 */
+	volatile unsigned long p2gm0plbase;	/* +10 */
 	volatile unsigned long p2gm0pubase;
 	volatile unsigned long p2gm1plbase;
 	volatile unsigned long p2gm1pubase;
-	volatile unsigned long p2gm2pbase;		/* +20 */
+	volatile unsigned long p2gm2pbase;	/* +20 */
 	volatile unsigned long p2giopbase;
 	volatile unsigned long unused0;
 	volatile unsigned long pcisid;
-	volatile unsigned long unused1;		/* +30 */
+	volatile unsigned long unused1;	/* +30 */
 	volatile unsigned long pcicapptr;
 	volatile unsigned long unused2;
 	volatile unsigned long pcicfg2;
-	volatile unsigned long g2ptocnt;		/* +40 */
+	volatile unsigned long g2ptocnt;	/* +40 */
 	volatile unsigned long unused3[15];
-	volatile unsigned long g2pstatus;		/* +80 */
+	volatile unsigned long g2pstatus;	/* +80 */
 	volatile unsigned long g2pmask;
 	volatile unsigned long pcisstatus;
 	volatile unsigned long pcimask;
-	volatile unsigned long p2gcfg;		/* +90 */
+	volatile unsigned long p2gcfg;	/* +90 */
 	volatile unsigned long p2gstatus;
 	volatile unsigned long p2gmask;
 	volatile unsigned long p2gccmd;
-	volatile unsigned long unused4[24];		/* +a0 */
-	volatile unsigned long pbareqport;		/* +100 */
+	volatile unsigned long unused4[24];	/* +a0 */
+	volatile unsigned long pbareqport;	/* +100 */
 	volatile unsigned long pbacfg;
 	volatile unsigned long pbastatus;
 	volatile unsigned long pbamask;
-	volatile unsigned long pbabm;		/* +110 */
+	volatile unsigned long pbabm;	/* +110 */
 	volatile unsigned long pbacreq;
 	volatile unsigned long pbacgnt;
 	volatile unsigned long pbacstate;
-	volatile unsigned long long g2pmgbase[3];		/* +120 */
+	volatile unsigned long long g2pmgbase[3];	/* +120 */
 	volatile unsigned long long g2piogbase;
-	volatile unsigned long g2pmmask[3];		/* +140 */
+	volatile unsigned long g2pmmask[3];	/* +140 */
 	volatile unsigned long g2piomask;
-	volatile unsigned long long g2pmpbase[3];		/* +150 */
+	volatile unsigned long long g2pmpbase[3];	/* +150 */
 	volatile unsigned long long g2piopbase;
-	volatile unsigned long pciccfg;		/* +170 */
+	volatile unsigned long pciccfg;	/* +170 */
 	volatile unsigned long pcicstatus;
 	volatile unsigned long pcicmask;
 	volatile unsigned long unused5;
-	volatile unsigned long long p2gmgbase[3];		/* +180 */
+	volatile unsigned long long p2gmgbase[3];	/* +180 */
 	volatile unsigned long long p2giogbase;
-	volatile unsigned long g2pcfgadrs;		/* +1a0 */
+	volatile unsigned long g2pcfgadrs;	/* +1a0 */
 	volatile unsigned long g2pcfgdata;
 	volatile unsigned long unused6[8];
 	volatile unsigned long g2pintack;
 	volatile unsigned long g2pspc;
-	volatile unsigned long unused7[12];		/* +1d0 */
-	volatile unsigned long long pdmca;		/* +200 */
+	volatile unsigned long unused7[12];	/* +1d0 */
+	volatile unsigned long long pdmca;	/* +200 */
 	volatile unsigned long long pdmga;
 	volatile unsigned long long pdmpa;
 	volatile unsigned long long pdmctr;
-	volatile unsigned long long pdmcfg;		/* +220 */
+	volatile unsigned long long pdmcfg;	/* +220 */
 	volatile unsigned long long pdmsts;
 };
 
@@ -232,7 +231,6 @@
 	volatile unsigned long acrevid;
 };
 
-
 struct tx4938_tmr_reg {
 	volatile unsigned long tcr;
 	volatile unsigned long tisr;
@@ -333,7 +331,7 @@
 #undef endian_def_b2s
 #undef endian_def_b4
 
-#endif /* __ASSEMBLY__ */
+#endif				/* __ASSEMBLY__ */
 
 /*
  * NDFMC
@@ -368,7 +366,7 @@
 #define TX4938_NUM_IR_SIO	2
 #define TX4938_IR_SIO(n)	(8 + (n))
 #define TX4938_NUM_IR_DMA	4
-#define TX4938_IR_DMA(ch,n)	((ch ? 27 : 10) + (n)) /* 10-13,27-30 */
+#define TX4938_IR_DMA(ch,n)	((ch ? 27 : 10) + (n))	/* 10-13,27-30 */
 #define TX4938_IR_PIO	14
 #define TX4938_IR_PDMAC	15
 #define TX4938_IR_PCIC	16
@@ -671,7 +669,6 @@
 #define TX4938_IRC_IRCS                 0xf6a0
 #define TX4938_IRC_LIMIT                0xf6ff
 
-
 #ifndef __ASSEMBLY__
 
 #define tx4938_sdramcptr	((struct tx4938_sdramc_reg *)TX4938_SDRAMC_REG)
@@ -689,7 +686,6 @@
 #define tx4938_spiptr		((struct tx4938_spi_reg *)TX4938_SPI_REG)
 #define tx4938_sramcptr		((struct tx4938_sramc_reg *)TX4938_SRAMC_REG)
 
-
 #define TX4938_REV_MAJ_MIN()	((unsigned long)tx4938_ccfgptr->crir & 0x00ff)
 #define TX4938_REV_PCODE()	((unsigned long)tx4938_ccfgptr->crir >> 16)
 
@@ -700,7 +696,6 @@
 #define TX4938_EBUSC_SIZE(ch)	\
 	(0x00100000 << ((unsigned long)(tx4938_ebuscptr->cr[ch] >> 8) & 0xf))
 
-
-#endif /* !__ASSEMBLY__ */
+#endif				/* !__ASSEMBLY__ */
 
 #endif
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/setup.c
===================================================================
--- linux.orig/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -35,7 +35,7 @@
 #endif
 
 extern void rbtx4938_time_init(void) __init;
-extern char * __init prom_getcmdline(void);
+extern char *__init prom_getcmdline(void);
 static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr);
 
 /* These functions are used for rebooting or halting the machine*/
@@ -56,32 +56,30 @@
 static int tx4938_pcic_retryto = 0;	/* default: disabled */
 
 struct tx4938_pcic_reg *pcicptrs[4] = {
-       tx4938_pcicptr  /* default setting for TX4938 */
+	tx4938_pcicptr		/* default setting for TX4938 */
 };
 
 static struct {
 	unsigned long base;
 	unsigned long size;
 } phys_regions[16] __initdata;
-static int num_phys_regions  __initdata;
+static int num_phys_regions __initdata;
 
 #define PHYS_REGION_MINSIZE	0x10000
 
 void rbtx4938_machine_halt(void)
 {
-        printk(KERN_NOTICE "System Halted\n");
+	printk(KERN_NOTICE "System Halted\n");
 	local_irq_disable();
 
 	while (1)
-		__asm__(".set\tmips3\n\t"
-			"wait\n\t"
-			".set\tmips0");
+		__asm__(".set\tmips3\n\t" "wait\n\t" ".set\tmips0");
 }
 
 void rbtx4938_machine_power_off(void)
 {
-        rbtx4938_machine_halt();
-        /* no return */
+	rbtx4938_machine_halt();
+	/* no return */
 }
 
 void rbtx4938_machine_restart(char *command)
@@ -94,11 +92,10 @@
 	*rbtx4938_softreset_ptr = 1;
 	wbflush();
 
-	while(1);
+	while (1) ;
 }
 
-void __init
-txboard_add_phys_region(unsigned long base, unsigned long size)
+void __init txboard_add_phys_region(unsigned long base, unsigned long size)
 {
 	if (num_phys_regions >= ARRAY_SIZE(phys_regions)) {
 		printk("phys_region overflow\n");
@@ -118,8 +115,9 @@
 	for (base = begin / size * size; base < end; base += size) {
 		for (i = 0; i < num_phys_regions; i++) {
 			if (phys_regions[i].size &&
-			    base <= phys_regions[i].base + (phys_regions[i].size - 1) &&
-			    base + (size - 1) >= phys_regions[i].base)
+			    base <=
+			    phys_regions[i].base + (phys_regions[i].size - 1)
+			    && base + (size - 1) >= phys_regions[i].base)
 				break;
 		}
 		if (i == num_phys_regions)
@@ -151,8 +149,7 @@
 		txboard_add_phys_region(base, size);
 	return base;
 }
-unsigned long __init
-txboard_request_phys_region(unsigned long size)
+unsigned long __init txboard_request_phys_region(unsigned long size)
 {
 	unsigned long base;
 	unsigned long begin = 0, end = 0x20000000;	/* search low 512MB */
@@ -161,8 +158,7 @@
 		txboard_add_phys_region(base, size);
 	return base;
 }
-unsigned long __init
-txboard_request_phys_region_shrink(unsigned long *size)
+unsigned long __init txboard_request_phys_region_shrink(unsigned long *size)
 {
 	unsigned long base;
 	unsigned long begin = 0, end = 0x20000000;	/* search low 512MB */
@@ -176,26 +172,26 @@
 void __init
 tx4938_pcic_setup(struct tx4938_pcic_reg *pcicptr,
 		  struct pci_controller *channel,
-		  unsigned long pci_io_base,
-		  int extarb)
+		  unsigned long pci_io_base, int extarb)
 {
 	int i;
 
 	/* Disable All Initiator Space */
-	pcicptr->pciccfg &= ~(TX4938_PCIC_PCICCFG_G2PMEN(0)|
-			      TX4938_PCIC_PCICCFG_G2PMEN(1)|
-			      TX4938_PCIC_PCICCFG_G2PMEN(2)|
+	pcicptr->pciccfg &= ~(TX4938_PCIC_PCICCFG_G2PMEN(0) |
+			      TX4938_PCIC_PCICCFG_G2PMEN(1) |
+			      TX4938_PCIC_PCICCFG_G2PMEN(2) |
 			      TX4938_PCIC_PCICCFG_G2PIOEN);
 
 	/* GB->PCI mappings */
-	pcicptr->g2piomask = (channel->io_resource->end - channel->io_resource->start) >> 4;
+	pcicptr->g2piomask =
+	    (channel->io_resource->end - channel->io_resource->start) >> 4;
 	pcicptr->g2piogbase = pci_io_base |
 #ifdef __BIG_ENDIAN
-		TX4938_PCIC_G2PIOGBASE_ECHG
+	    TX4938_PCIC_G2PIOGBASE_ECHG
 #else
-		TX4938_PCIC_G2PIOGBASE_BSDIS
+	    TX4938_PCIC_G2PIOGBASE_BSDIS
 #endif
-		;
+	    ;
 	pcicptr->g2piopbase = 0;
 	for (i = 0; i < 3; i++) {
 		pcicptr->g2pmmask[i] = 0;
@@ -203,36 +199,37 @@
 		pcicptr->g2pmpbase[i] = 0;
 	}
 	if (channel->mem_resource->end) {
-		pcicptr->g2pmmask[0] = (channel->mem_resource->end - channel->mem_resource->start) >> 4;
+		pcicptr->g2pmmask[0] =
+		    (channel->mem_resource->end -
+		     channel->mem_resource->start) >> 4;
 		pcicptr->g2pmgbase[0] = channel->mem_resource->start |
 #ifdef __BIG_ENDIAN
-			TX4938_PCIC_G2PMnGBASE_ECHG
+		    TX4938_PCIC_G2PMnGBASE_ECHG
 #else
-			TX4938_PCIC_G2PMnGBASE_BSDIS
+		    TX4938_PCIC_G2PMnGBASE_BSDIS
 #endif
-			;
+		    ;
 		pcicptr->g2pmpbase[0] = channel->mem_resource->start;
 	}
 	/* PCI->GB mappings (I/O 256B) */
-	pcicptr->p2giopbase = 0; /* 256B */
+	pcicptr->p2giopbase = 0;	/* 256B */
 	pcicptr->p2giogbase = 0;
 	/* PCI->GB mappings (MEM 512MB (64MB on R1.x)) */
 	pcicptr->p2gm0plbase = 0;
 	pcicptr->p2gm0pubase = 0;
-	pcicptr->p2gmgbase[0] = 0 |
-		TX4938_PCIC_P2GMnGBASE_TMEMEN |
+	pcicptr->p2gmgbase[0] = 0 | TX4938_PCIC_P2GMnGBASE_TMEMEN |
 #ifdef __BIG_ENDIAN
-		TX4938_PCIC_P2GMnGBASE_TECHG
+	    TX4938_PCIC_P2GMnGBASE_TECHG
 #else
-		TX4938_PCIC_P2GMnGBASE_TBSDIS
+	    TX4938_PCIC_P2GMnGBASE_TBSDIS
 #endif
-		;
+	    ;
 	/* PCI->GB mappings (MEM 16MB) */
 	pcicptr->p2gm1plbase = 0xffffffff;
 	pcicptr->p2gm1pubase = 0xffffffff;
 	pcicptr->p2gmgbase[1] = 0;
 	/* PCI->GB mappings (MEM 1MB) */
-	pcicptr->p2gm2pbase = 0xffffffff; /* 1MB */
+	pcicptr->p2gm2pbase = 0xffffffff;	/* 1MB */
 	pcicptr->p2gmgbase[2] = 0;
 
 	pcicptr->pciccfg &= TX4938_PCIC_PCICCFG_GBWC_MASK;
@@ -244,8 +241,7 @@
 		pcicptr->pciccfg |= TX4938_PCIC_PCICCFG_G2PIOEN;
 	/* Enable Initiator Config */
 	pcicptr->pciccfg |=
-		TX4938_PCIC_PCICCFG_ICAEN |
-		TX4938_PCIC_PCICCFG_TCAR;
+	    TX4938_PCIC_PCICCFG_ICAEN | TX4938_PCIC_PCICCFG_TCAR;
 
 	/* Do not use MEMMUL, MEMINF: YMFPCI card causes M_ABORT. */
 	pcicptr->pcicfg1 = 0;
@@ -259,7 +255,7 @@
 
 	if (tx4938_pcic_retryto >= 0) {
 		pcicptr->g2ptocnt &= ~0xff00;
-		pcicptr->g2ptocnt |= ((tx4938_pcic_retryto<<8) & 0xff00);
+		pcicptr->g2ptocnt |= ((tx4938_pcic_retryto << 8) & 0xff00);
 	}
 
 	/* Clear All Local Bus Status */
@@ -272,8 +268,8 @@
 	pcicptr->g2pmask = TX4938_PCIC_G2PSTATUS_ALL;
 	/* Clear All PCI Status Error */
 	pcicptr->pcistatus =
-		(pcicptr->pcistatus & 0x0000ffff) |
-		(TX4938_PCIC_PCISTATUS_ALL << 16);
+	    (pcicptr->pcistatus & 0x0000ffff) |
+	    (TX4938_PCIC_PCISTATUS_ALL << 16);
 	/* Enable All PCI Status Error Interrupts */
 	pcicptr->pcimask = TX4938_PCIC_PCISTATUS_ALL;
 
@@ -285,17 +281,14 @@
 		pcicptr->pbacfg = TX4938_PCIC_PBACFG_PBAEN;
 	}
 
-      /* PCIC Int => IRC IRQ16 */
-	pcicptr->pcicfg2 =
-		    (pcicptr->pcicfg2 & 0xffffff00) | TX4938_IR_PCIC;
+	/* PCIC Int => IRC IRQ16 */
+	pcicptr->pcicfg2 = (pcicptr->pcicfg2 & 0xffffff00) | TX4938_IR_PCIC;
 
 	pcicptr->pcistatus = PCI_COMMAND_MASTER |
-		PCI_COMMAND_MEMORY |
-		PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+	    PCI_COMMAND_MEMORY | PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
 }
 
-int __init
-tx4938_report_pciclk(void)
+int __init tx4938_report_pciclk(void)
 {
 	unsigned long pcode = TX4938_REV_PCODE();
 	int pciclk = 0;
@@ -304,23 +297,32 @@
 	       (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI66) ? " PCI66" : "");
 	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_PCICLKEN_ALL) {
 
-		switch ((unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIDIVMODE_MASK) {
+		switch ((unsigned long)tx4938_ccfgptr->
+			ccfg & TX4938_CCFG_PCIDIVMODE_MASK) {
 		case TX4938_CCFG_PCIDIVMODE_4:
-			pciclk = txx9_cpu_clock / 4; break;
+			pciclk = txx9_cpu_clock / 4;
+			break;
 		case TX4938_CCFG_PCIDIVMODE_4_5:
-			pciclk = txx9_cpu_clock * 2 / 9; break;
+			pciclk = txx9_cpu_clock * 2 / 9;
+			break;
 		case TX4938_CCFG_PCIDIVMODE_5:
-			pciclk = txx9_cpu_clock / 5; break;
+			pciclk = txx9_cpu_clock / 5;
+			break;
 		case TX4938_CCFG_PCIDIVMODE_5_5:
-			pciclk = txx9_cpu_clock * 2 / 11; break;
+			pciclk = txx9_cpu_clock * 2 / 11;
+			break;
 		case TX4938_CCFG_PCIDIVMODE_8:
-			pciclk = txx9_cpu_clock / 8; break;
+			pciclk = txx9_cpu_clock / 8;
+			break;
 		case TX4938_CCFG_PCIDIVMODE_9:
-			pciclk = txx9_cpu_clock / 9; break;
+			pciclk = txx9_cpu_clock / 9;
+			break;
 		case TX4938_CCFG_PCIDIVMODE_10:
-			pciclk = txx9_cpu_clock / 10; break;
+			pciclk = txx9_cpu_clock / 10;
+			break;
 		case TX4938_CCFG_PCIDIVMODE_11:
-			pciclk = txx9_cpu_clock / 11; break;
+			pciclk = txx9_cpu_clock / 11;
+			break;
 		}
 		printk("Internal(%dMHz)", pciclk / 1000000);
 	} else {
@@ -338,11 +340,11 @@
 
 struct tx4938_pcic_reg *get_tx4938_pcicptr(int ch)
 {
-       return pcicptrs[ch];
+	return pcicptrs[ch];
 }
 
 static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
-                                    int top_bus, int busnr, int devfn)
+				    int top_bus, int busnr, int devfn)
 {
 	static struct pci_dev dev;
 	static struct pci_bus bus;
@@ -368,7 +370,8 @@
 
 EARLY_PCI_OP(read, word, u16 *)
 
-int txboard_pci66_check(struct pci_controller *hose, int top_bus, int current_bus)
+int txboard_pci66_check(struct pci_controller *hose, int top_bus,
+			int current_bus)
 {
 	u32 pci_devfn;
 	unsigned short vid;
@@ -379,20 +382,22 @@
 
 	printk("PCI: Checking 66MHz capabilities...\n");
 
-	for (pci_devfn=devfn_start; pci_devfn<devfn_stop; pci_devfn++) {
+	for (pci_devfn = devfn_start; pci_devfn < devfn_stop; pci_devfn++) {
 		early_read_config_word(hose, top_bus, current_bus, pci_devfn,
 				       PCI_VENDOR_ID, &vid);
 
-		if (vid == 0xffff) continue;
+		if (vid == 0xffff)
+			continue;
 
 		/* check 66MHz capability */
 		if (cap66 < 0)
 			cap66 = 1;
 		if (cap66) {
-			early_read_config_word(hose, top_bus, current_bus, pci_devfn,
-					       PCI_STATUS, &stat);
+			early_read_config_word(hose, top_bus, current_bus,
+					       pci_devfn, PCI_STATUS, &stat);
 			if (!(stat & PCI_STATUS_66MHZ)) {
-				printk(KERN_DEBUG "PCI: %02x:%02x not 66MHz capable.\n",
+				printk(KERN_DEBUG
+				       "PCI: %02x:%02x not 66MHz capable.\n",
 				       current_bus, pci_devfn);
 				cap66 = 0;
 				break;
@@ -402,8 +407,7 @@
 	return cap66 > 0;
 }
 
-int __init
-tx4938_pciclk66_setup(void)
+int __init tx4938_pciclk66_setup(void)
 {
 	int pciclk;
 
@@ -436,8 +440,8 @@
 			break;
 		}
 		tx4938_ccfgptr->ccfg =
-			(tx4938_ccfgptr->ccfg & ~TX4938_CCFG_PCIDIVMODE_MASK)
-			| pcidivmode;
+		    (tx4938_ccfgptr->ccfg & ~TX4938_CCFG_PCIDIVMODE_MASK)
+		    | pcidivmode;
 		printk(KERN_DEBUG "PCICLK: ccfg:%08lx\n",
 		       (unsigned long)tx4938_ccfgptr->ccfg);
 	} else {
@@ -450,9 +454,9 @@
 static int __init tx4938_pcibios_init(void)
 {
 	unsigned long mem_base[2];
-	unsigned long mem_size[2] = {TX4938_PCIMEM_SIZE_0,TX4938_PCIMEM_SIZE_1}; /* MAX 128M,64K */
+	unsigned long mem_size[2] = { TX4938_PCIMEM_SIZE_0, TX4938_PCIMEM_SIZE_1 };	/* MAX 128M,64K */
 	unsigned long io_base[2];
-	unsigned long io_size[2] = {TX4938_PCIIO_SIZE_0,TX4938_PCIIO_SIZE_1}; /* MAX 16M,64K */
+	unsigned long io_size[2] = { TX4938_PCIIO_SIZE_0, TX4938_PCIIO_SIZE_1 };	/* MAX 16M,64K */
 	/* TX4938 PCIC1: 64K MEM/IO is enough for ETH0,ETH1 */
 	int extarb = !(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB);
 
@@ -470,9 +474,11 @@
 
 	/* setup PCI area */
 	tx4938_pci_controller[0].io_resource->start = io_base[0];
-	tx4938_pci_controller[0].io_resource->end = (io_base[0] + io_size[0]) - 1;
+	tx4938_pci_controller[0].io_resource->end =
+	    (io_base[0] + io_size[0]) - 1;
 	tx4938_pci_controller[0].mem_resource->start = mem_base[0];
-	tx4938_pci_controller[0].mem_resource->end = mem_base[0] + mem_size[0] - 1;
+	tx4938_pci_controller[0].mem_resource->end =
+	    mem_base[0] + mem_size[0] - 1;
 
 	set_tx4938_pcicptr(0, tx4938_pcicptr);
 
@@ -480,7 +486,7 @@
 
 	if (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI66) {
 		printk("TX4938_CCFG_PCI66 already configured\n");
-		txboard_pci66_mode = -1; /* already configured */
+		txboard_pci66_mode = -1;	/* already configured */
 	}
 
 	/* Reset PCI Bus */
@@ -497,9 +503,10 @@
 	tx4938_report_pcic_status1(tx4938_pcicptr);
 
 	tx4938_report_pciclk();
-	tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
-	if (txboard_pci66_mode == 0 &&
-	    txboard_pci66_check(&tx4938_pci_controller[0], 0, 0)) {
+	tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0],
+			  extarb);
+	if (txboard_pci66_mode == 0
+	    && txboard_pci66_check(&tx4938_pci_controller[0], 0, 0)) {
 		/* Reset PCI Bus */
 		*rbtx4938_pcireset_ptr = 0;
 		/* Reset PCIC */
@@ -512,7 +519,8 @@
 		wbflush();
 		/* Reinitialize PCIC */
 		tx4938_report_pciclk();
-		tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
+		tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0],
+				  io_base[0], extarb);
 	}
 
 	mem_base[1] = txboard_request_phys_region_shrink(&mem_size[1]);
@@ -540,18 +548,18 @@
 	       1000000);
 
 	/* assumption: CPHYSADDR(mips_io_port_base) == io_base[0] */
-	tx4938_pci_controller[1].io_resource->start =
-		io_base[1] - io_base[0];
+	tx4938_pci_controller[1].io_resource->start = io_base[1] - io_base[0];
 	tx4938_pci_controller[1].io_resource->end =
-		io_base[1] - io_base[0] + io_size[1] - 1;
+	    io_base[1] - io_base[0] + io_size[1] - 1;
 	tx4938_pci_controller[1].mem_resource->start = mem_base[1];
 	tx4938_pci_controller[1].mem_resource->end =
-		mem_base[1] + mem_size[1] - 1;
+	    mem_base[1] + mem_size[1] - 1;
 	set_tx4938_pcicptr(1, tx4938_pcic1ptr);
 
 	register_pci_controller(&tx4938_pci_controller[1]);
 
-	tx4938_pcic_setup(tx4938_pcic1ptr, &tx4938_pci_controller[1], io_base[1], extarb);
+	tx4938_pcic_setup(tx4938_pcic1ptr, &tx4938_pci_controller[1],
+			  io_base[1], extarb);
 
 	/* map ioport 0 to PCI I/O space address 0 */
 	set_io_port_base(KSEG1 + io_base[0]);
@@ -561,7 +569,7 @@
 
 arch_initcall(tx4938_pcibios_init);
 
-#endif /* CONFIG_PCI */
+#endif				/* CONFIG_PCI */
 
 /* SPI support */
 
@@ -569,7 +577,7 @@
 #define	SEEPROM1_CS	7	/* PIO7 */
 #define	SEEPROM2_CS	0	/* IOC */
 #define	SEEPROM3_CS	1	/* IOC */
-#define	SRTC_CS	2	/* IOC */
+#define	SRTC_CS	2		/* IOC */
 
 static int rbtx4938_spi_cs_func(int chipid, int on)
 {
@@ -596,17 +604,19 @@
 	}
 	/* bit1,2,4 are low active, bit3 is high active */
 	*rbtx4938_spics_ptr =
-		(*rbtx4938_spics_ptr & ~bit) |
-		((on ? (bit ^ 0x0b) : ~(bit ^ 0x0b)) & bit);
+	    (*rbtx4938_spics_ptr & ~bit) |
+	    ((on ? (bit ^ 0x0b) : ~(bit ^ 0x0b)) & bit);
 	return 0;
 }
 
 #ifdef CONFIG_PCI
-extern int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len);
+extern int spi_eeprom_read(int chipid, int address, unsigned char *buf,
+			   int len);
 
 int rbtx4938_get_tx4938_ethaddr(struct pci_dev *dev, unsigned char *addr)
 {
-	struct pci_controller *channel = (struct pci_controller *)dev->bus->sysdata;
+	struct pci_controller *channel =
+	    (struct pci_controller *)dev->bus->sysdata;
 	static unsigned char dat[17];
 	static int read_dat = 0;
 	int ch = 0;
@@ -634,7 +644,8 @@
 			printk(KERN_ERR "seeprom: read error.\n");
 		} else {
 			if (strcmp(dat, "MAC") != 0)
-				printk(KERN_WARNING "seeprom: bad signature.\n");
+				printk(KERN_WARNING
+				       "seeprom: bad signature.\n");
 			for (i = 0, sum = 0; i < sizeof(dat); i++)
 				sum += dat[i];
 			if (sum)
@@ -644,9 +655,10 @@
 	memcpy(addr, &dat[4 + 6 * ch], 6);
 	return 0;
 }
-#endif /* CONFIG_PCI */
+#endif				/* CONFIG_PCI */
 
-extern void __init txx9_spi_init(unsigned long base, int (*cs_func)(int chipid, int on));
+extern void __init txx9_spi_init(unsigned long base,
+				 int (*cs_func) (int chipid, int on));
 static void __init rbtx4938_spi_setup(void)
 {
 	/* set SPI_SEL */
@@ -661,7 +673,8 @@
 
 static char pcode_str[8];
 static struct resource tx4938_reg_resource = {
-	pcode_str, TX4938_REG_BASE, TX4938_REG_BASE+TX4938_REG_SIZE, IORESOURCE_MEM
+	pcode_str, TX4938_REG_BASE, TX4938_REG_BASE + TX4938_REG_SIZE,
+	    IORESOURCE_MEM
 };
 
 void __init tx4938_board_setup(void)
@@ -681,40 +694,49 @@
 	for (i = 0; i < 8; i++) {
 		if (!(tx4938_ebuscptr->cr[i] & 0x8))
 			continue;	/* disabled */
- 		rbtx4938_ce_base[i] = (unsigned long)TX4938_EBUSC_BA(i);
-		txboard_add_phys_region(rbtx4938_ce_base[i], TX4938_EBUSC_SIZE(i));
+		rbtx4938_ce_base[i] = (unsigned long)TX4938_EBUSC_BA(i);
+		txboard_add_phys_region(rbtx4938_ce_base[i],
+					TX4938_EBUSC_SIZE(i));
 	}
 
 	/* clocks */
 	if (txx9_master_clock) {
 		/* calculate gbus_clock and cpu_clock from master_clock */
-		divmode = (unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_DIVMODE_MASK;
+		divmode =
+		    (unsigned long)tx4938_ccfgptr->
+		    ccfg & TX4938_CCFG_DIVMODE_MASK;
 		switch (divmode) {
 		case TX4938_CCFG_DIVMODE_8:
 		case TX4938_CCFG_DIVMODE_10:
 		case TX4938_CCFG_DIVMODE_12:
 		case TX4938_CCFG_DIVMODE_16:
 		case TX4938_CCFG_DIVMODE_18:
-			txx9_gbus_clock = txx9_master_clock * 4; break;
+			txx9_gbus_clock = txx9_master_clock * 4;
+			break;
 		default:
 			txx9_gbus_clock = txx9_master_clock;
 		}
 		switch (divmode) {
 		case TX4938_CCFG_DIVMODE_2:
 		case TX4938_CCFG_DIVMODE_8:
-			cpuclk = txx9_gbus_clock * 2; break;
+			cpuclk = txx9_gbus_clock * 2;
+			break;
 		case TX4938_CCFG_DIVMODE_2_5:
 		case TX4938_CCFG_DIVMODE_10:
-			cpuclk = txx9_gbus_clock * 5 / 2; break;
+			cpuclk = txx9_gbus_clock * 5 / 2;
+			break;
 		case TX4938_CCFG_DIVMODE_3:
 		case TX4938_CCFG_DIVMODE_12:
-			cpuclk = txx9_gbus_clock * 3; break;
+			cpuclk = txx9_gbus_clock * 3;
+			break;
 		case TX4938_CCFG_DIVMODE_4:
 		case TX4938_CCFG_DIVMODE_16:
-			cpuclk = txx9_gbus_clock * 4; break;
+			cpuclk = txx9_gbus_clock * 4;
+			break;
 		case TX4938_CCFG_DIVMODE_4_5:
 		case TX4938_CCFG_DIVMODE_18:
-			cpuclk = txx9_gbus_clock * 9 / 2; break;
+			cpuclk = txx9_gbus_clock * 9 / 2;
+			break;
 		}
 		txx9_cpu_clock = cpuclk;
 	} else {
@@ -723,23 +745,30 @@
 		}
 		/* calculate gbus_clock and master_clock from cpu_clock */
 		cpuclk = txx9_cpu_clock;
-		divmode = (unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_DIVMODE_MASK;
+		divmode =
+		    (unsigned long)tx4938_ccfgptr->
+		    ccfg & TX4938_CCFG_DIVMODE_MASK;
 		switch (divmode) {
 		case TX4938_CCFG_DIVMODE_2:
 		case TX4938_CCFG_DIVMODE_8:
-			txx9_gbus_clock = cpuclk / 2; break;
+			txx9_gbus_clock = cpuclk / 2;
+			break;
 		case TX4938_CCFG_DIVMODE_2_5:
 		case TX4938_CCFG_DIVMODE_10:
-			txx9_gbus_clock = cpuclk * 2 / 5; break;
+			txx9_gbus_clock = cpuclk * 2 / 5;
+			break;
 		case TX4938_CCFG_DIVMODE_3:
 		case TX4938_CCFG_DIVMODE_12:
-			txx9_gbus_clock = cpuclk / 3; break;
+			txx9_gbus_clock = cpuclk / 3;
+			break;
 		case TX4938_CCFG_DIVMODE_4:
 		case TX4938_CCFG_DIVMODE_16:
-			txx9_gbus_clock = cpuclk / 4; break;
+			txx9_gbus_clock = cpuclk / 4;
+			break;
 		case TX4938_CCFG_DIVMODE_4_5:
 		case TX4938_CCFG_DIVMODE_18:
-			txx9_gbus_clock = cpuclk * 2 / 9; break;
+			txx9_gbus_clock = cpuclk * 2 / 9;
+			break;
 		}
 		switch (divmode) {
 		case TX4938_CCFG_DIVMODE_8:
@@ -747,7 +776,8 @@
 		case TX4938_CCFG_DIVMODE_12:
 		case TX4938_CCFG_DIVMODE_16:
 		case TX4938_CCFG_DIVMODE_18:
-			txx9_master_clock = txx9_gbus_clock / 4; break;
+			txx9_master_clock = txx9_gbus_clock / 4;
+			break;
 		default:
 			txx9_master_clock = txx9_gbus_clock;
 		}
@@ -777,8 +807,7 @@
 	       pcode_str,
 	       cpuclk / 1000000, txx9_master_clock / 1000000,
 	       (unsigned long)tx4938_ccfgptr->crir,
-	       tx4938_ccfgptr->ccfg,
-	       tx4938_ccfgptr->pcfg);
+	       tx4938_ccfgptr->ccfg, tx4938_ccfgptr->pcfg);
 
 	printk("%s SDRAMC --", pcode_str);
 	for (i = 0; i < 4; i++) {
@@ -799,8 +828,8 @@
 	if (pcode == 0x4938 && tx4938_sramcptr->cr & 1) {
 		unsigned int size = 0x800;
 		unsigned long base =
-			(tx4938_sramcptr->cr >> (39-11)) & ~(size - 1);
-		 txboard_add_phys_region(base, size);
+		    (tx4938_sramcptr->cr >> (39 - 11)) & ~(size - 1);
+		txboard_add_phys_region(base, size);
 	}
 
 	/* IRC */
@@ -810,7 +839,7 @@
 	/* TMR */
 	/* disable all timers */
 	for (i = 0; i < TX4938_NR_TMR; i++) {
-		tx4938_tmrptr(i)->tcr  = 0x00000020;
+		tx4938_tmrptr(i)->tcr = 0x00000020;
 		tx4938_tmrptr(i)->tisr = 0;
 		tx4938_tmrptr(i)->cpra = 0xffffffff;
 		tx4938_tmrptr(i)->itmr = 0;
@@ -841,25 +870,25 @@
 		unsigned long flag;
 		const char *str;
 	} pcistat_tbl[] = {
-		{ PCI_STATUS_DETECTED_PARITY,	"DetectedParityError" },
-		{ PCI_STATUS_SIG_SYSTEM_ERROR,	"SignaledSystemError" },
-		{ PCI_STATUS_REC_MASTER_ABORT,	"ReceivedMasterAbort" },
-		{ PCI_STATUS_REC_TARGET_ABORT,	"ReceivedTargetAbort" },
-		{ PCI_STATUS_SIG_TARGET_ABORT,	"SignaledTargetAbort" },
-		{ PCI_STATUS_PARITY,	"MasterParityError" },
-	}, g2pstat_tbl[] = {
-		{ TX4938_PCIC_G2PSTATUS_TTOE,	"TIOE" },
-		{ TX4938_PCIC_G2PSTATUS_RTOE,	"RTOE" },
-	}, pcicstat_tbl[] = {
-		{ TX4938_PCIC_PCICSTATUS_PME,	"PME" },
-		{ TX4938_PCIC_PCICSTATUS_TLB,	"TLB" },
-		{ TX4938_PCIC_PCICSTATUS_NIB,	"NIB" },
-		{ TX4938_PCIC_PCICSTATUS_ZIB,	"ZIB" },
-		{ TX4938_PCIC_PCICSTATUS_PERR,	"PERR" },
-		{ TX4938_PCIC_PCICSTATUS_SERR,	"SERR" },
-		{ TX4938_PCIC_PCICSTATUS_GBE,	"GBE" },
-		{ TX4938_PCIC_PCICSTATUS_IWB,	"IWB" },
-	};
+		{
+		PCI_STATUS_DETECTED_PARITY, "DetectedParityError"}, {
+		PCI_STATUS_SIG_SYSTEM_ERROR, "SignaledSystemError"}, {
+		PCI_STATUS_REC_MASTER_ABORT, "ReceivedMasterAbort"}, {
+		PCI_STATUS_REC_TARGET_ABORT, "ReceivedTargetAbort"}, {
+		PCI_STATUS_SIG_TARGET_ABORT, "SignaledTargetAbort"}, {
+	PCI_STATUS_PARITY, "MasterParityError"},}, g2pstat_tbl[] = {
+		{
+		TX4938_PCIC_G2PSTATUS_TTOE, "TIOE"}, {
+	TX4938_PCIC_G2PSTATUS_RTOE, "RTOE"},}, pcicstat_tbl[] = {
+		{
+		TX4938_PCIC_PCICSTATUS_PME, "PME"}, {
+		TX4938_PCIC_PCICSTATUS_TLB, "TLB"}, {
+		TX4938_PCIC_PCICSTATUS_NIB, "NIB"}, {
+		TX4938_PCIC_PCICSTATUS_ZIB, "ZIB"}, {
+		TX4938_PCIC_PCICSTATUS_PERR, "PERR"}, {
+		TX4938_PCIC_PCICSTATUS_SERR, "SERR"}, {
+		TX4938_PCIC_PCICSTATUS_GBE, "GBE"}, {
+	TX4938_PCIC_PCICSTATUS_IWB, "IWB"},};
 	int i;
 
 	printk("pcistat:%04x(", pcistatus);
@@ -885,7 +914,7 @@
 		tx4938_report_pcic_status1(pcicptr);
 }
 
-#endif /* CONFIG_PCI */
+#endif				/* CONFIG_PCI */
 
 /* We use onchip r4k counter or TMR timer as our system wide timer
  * interrupt running at 100HZ. */
@@ -905,7 +934,7 @@
 	iomem_resource.end = 0xffffffff;	/* 4GB */
 
 	if (txx9_master_clock == 0)
-		txx9_master_clock = 25000000; /* 25MHz */
+		txx9_master_clock = 25000000;	/* 25MHz */
 	tx4938_board_setup();
 	/* setup irq stuff */
 	TX4938_WR(TX4938_MKA(TX4938_IRC_IRDM0), 0x00000000);	/* irq trigger */
@@ -923,23 +952,23 @@
 		extern int early_serial_txx9_setup(struct uart_port *port);
 		int i;
 		struct uart_port req;
-		for(i = 0; i < 2; i++) {
+		for (i = 0; i < 2; i++) {
 			memset(&req, 0, sizeof(req));
 			req.line = i;
 			req.iotype = UPIO_MEM;
 			req.membase = (char *)(0xff1ff300 + i * 0x100);
 			req.mapbase = 0xff1ff300 + i * 0x100;
 			req.irq = 32 + i;
-			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE */ ;
 			req.uartclk = 50000000;
 			early_serial_txx9_setup(&req);
 		}
 	}
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
-        argptr = prom_getcmdline();
-        if (strstr(argptr, "console=") == NULL) {
-                strcat(argptr, " console=ttyS0,38400");
-        }
+	argptr = prom_getcmdline();
+	if (strstr(argptr, "console=") == NULL) {
+		strcat(argptr, " console=ttyS0,38400");
+	}
 #endif
 #endif
 
@@ -968,7 +997,6 @@
 	}
 #endif
 
-
 #ifdef CONFIG_FB
 	{
 		conswitchp = &dummy_con;
@@ -981,12 +1009,10 @@
 	if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
 	    TX4938_PCFG_ATA_SEL) {
 		*rbtx4938_piosel_ptr = (*rbtx4938_piosel_ptr & 0x03) | 0x04;
-	}
-	else if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
-	    TX4938_PCFG_NDF_SEL) {
+	} else if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
+		   TX4938_PCFG_NDF_SEL) {
 		*rbtx4938_piosel_ptr = (*rbtx4938_piosel_ptr & 0x03) | 0x08;
-	}
-	else {
+	} else {
 		*rbtx4938_piosel_ptr &= ~(0x08 | 0x04);
 	}
 
@@ -1006,8 +1032,7 @@
 
 	*rbtx4938_led_ptr = 0xff;
 	printk("RBTX4938 --- FPGA(Rev %02x)", *rbtx4938_fpga_rev_ptr);
-	printk(" DIPSW:%02x,%02x\n",
-	       *rbtx4938_dipsw_ptr, *rbtx4938_bdipsw_ptr);
+	printk(" DIPSW:%02x,%02x\n", *rbtx4938_dipsw_ptr, *rbtx4938_bdipsw_ptr);
 }
 
 #ifdef CONFIG_PROC_FS
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
===================================================================
--- linux.orig/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
@@ -20,14 +20,15 @@
 #include <asm/tx4938/spi.h>
 #include <asm/tx4938/tx4938.h>
 
-static int (*txx9_spi_cs_func)(int chipid, int on);
+static int (*txx9_spi_cs_func) (int chipid, int on);
 static spinlock_t txx9_spi_lock = SPIN_LOCK_UNLOCKED;
 
 extern unsigned int txx9_gbus_clock;
 
 #define SPI_FIFO_SIZE	4
 
-void __init txx9_spi_init(unsigned long base, int (*cs_func)(int chipid, int on))
+void __init txx9_spi_init(unsigned long base,
+			  int (*cs_func) (int chipid, int on))
 {
 	txx9_spi_cs_func = cs_func;
 	/* enter config mode */
@@ -52,8 +53,7 @@
 
 int txx9_spi_io(int chipid, struct spi_dev_desc *desc,
 		unsigned char **inbufs, unsigned int *incounts,
-		unsigned char **outbufs, unsigned int *outcounts,
-		int cansleep)
+		unsigned char **outbufs, unsigned int *outcounts, int cansleep)
 {
 	unsigned int incount, outcount;
 	unsigned char *inp, *outp;
@@ -68,13 +68,12 @@
 	/* enter config mode */
 	tx4938_spiptr->mcr = TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR;
 	tx4938_spiptr->cr0 =
-		(desc->byteorder ? TXx9_SPCR0_SBOS : 0) |
-		(desc->polarity ? TXx9_SPCR0_SPOL : 0) |
-		(desc->phase ? TXx9_SPCR0_SPHA : 0) |
-		0x08;
+	    (desc->byteorder ? TXx9_SPCR0_SBOS : 0) |
+	    (desc->polarity ? TXx9_SPCR0_SPOL : 0) |
+	    (desc->phase ? TXx9_SPCR0_SPHA : 0) | 0x08;
 	tx4938_spiptr->cr1 =
-		(((TXX9_IMCLK + desc->baud) / (2 * desc->baud) - 1) << 8) |
-		0x08 /* 8 bit only */;
+	    (((TXX9_IMCLK + desc->baud) / (2 * desc->baud) - 1) << 8) |
+	    0x08 /* 8 bit only */ ;
 	/* enter active mode */
 	tx4938_spiptr->mcr = TXx9_SPMCR_ACTIVE;
 	spin_unlock_irqrestore(&txx9_spi_lock, flags);
@@ -112,12 +111,11 @@
 			count = min(count, outcount);
 
 		/* now tx must be idle... */
-		while (!(tx4938_spiptr->sr & TXx9_SPSR_SIDLE))
-			;
+		while (!(tx4938_spiptr->sr & TXx9_SPSR_SIDLE)) ;
 
 		tx4938_spiptr->cr0 =
-			(tx4938_spiptr->cr0 & ~TXx9_SPCR0_RXIFL_MASK) |
-			((count - 1) << 12);
+		    (tx4938_spiptr->cr0 & ~TXx9_SPCR0_RXIFL_MASK) |
+		    ((count - 1) << 12);
 		if (cansleep) {
 			/* enable rx intr */
 			tx4938_spiptr->cr0 |= TXx9_SPCR0_RBSIE;
@@ -130,8 +128,7 @@
 			wait_event(txx9_spi_wait,
 				   tx4938_spiptr->sr & TXx9_SPSR_SRRDY);
 		} else {
-			while (!(tx4938_spiptr->sr & TXx9_SPSR_RBSI))
-				;
+			while (!(tx4938_spiptr->sr & TXx9_SPSR_RBSI)) ;
 		}
 		/* receive */
 		for (i = 0; i < count; i++) {
Index: linux/arch/mips/tx4938/common/irq.c
===================================================================
--- linux.orig/arch/mips/tx4938/common/irq.c
+++ linux/arch/mips/tx4938/common/irq.c
@@ -93,8 +93,7 @@
 
 #define tx4938_irq_cp0_mask(irq) ( 1 << ( irq-TX4938_IRQ_CP0_BEG+8 ) )
 
-static void __init
-tx4938_irq_cp0_init(void)
+static void __init tx4938_irq_cp0_init(void)
 {
 	int i;
 
@@ -108,22 +107,19 @@
 	return;
 }
 
-static unsigned int
-tx4938_irq_cp0_startup(unsigned int irq)
+static unsigned int tx4938_irq_cp0_startup(unsigned int irq)
 {
 	tx4938_irq_cp0_enable(irq);
 
 	return (0);
 }
 
-static void
-tx4938_irq_cp0_shutdown(unsigned int irq)
+static void tx4938_irq_cp0_shutdown(unsigned int irq)
 {
 	tx4938_irq_cp0_disable(irq);
 }
 
-static void
-tx4938_irq_cp0_enable(unsigned int irq)
+static void tx4938_irq_cp0_enable(unsigned int irq)
 {
 	unsigned long flags;
 
@@ -134,8 +130,7 @@
 	spin_unlock_irqrestore(&tx4938_cp0_lock, flags);
 }
 
-static void
-tx4938_irq_cp0_disable(unsigned int irq)
+static void tx4938_irq_cp0_disable(unsigned int irq)
 {
 	unsigned long flags;
 
@@ -148,16 +143,14 @@
 	return;
 }
 
-static void
-tx4938_irq_cp0_mask_and_ack(unsigned int irq)
+static void tx4938_irq_cp0_mask_and_ack(unsigned int irq)
 {
 	tx4938_irq_cp0_disable(irq);
 
 	return;
 }
 
-static void
-tx4938_irq_cp0_end(unsigned int irq)
+static void tx4938_irq_cp0_end(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
 		tx4938_irq_cp0_enable(irq);
@@ -170,8 +163,7 @@
 /* Functions for pic                                                              */
 /**********************************************************************************/
 
-u32
-tx4938_irq_pic_addr(int irq)
+u32 tx4938_irq_pic_addr(int irq)
 {
 	/* MVMCP -- need to formulize this */
 	irq -= TX4938_IRQ_PIC_BEG;
@@ -230,8 +222,7 @@
 	return (0);
 }
 
-u32
-tx4938_irq_pic_mask(int irq)
+u32 tx4938_irq_pic_mask(int irq)
 {
 	/* MVMCP -- need to formulize this */
 	irq -= TX4938_IRQ_PIC_BEG;
@@ -296,8 +287,7 @@
 	return;
 }
 
-static void __init
-tx4938_irq_pic_init(void)
+static void __init tx4938_irq_pic_init(void)
 {
 	unsigned long flags;
 	int i;
@@ -321,24 +311,21 @@
 	return;
 }
 
-static unsigned int
-tx4938_irq_pic_startup(unsigned int irq)
+static unsigned int tx4938_irq_pic_startup(unsigned int irq)
 {
 	tx4938_irq_pic_enable(irq);
 
 	return (0);
 }
 
-static void
-tx4938_irq_pic_shutdown(unsigned int irq)
+static void tx4938_irq_pic_shutdown(unsigned int irq)
 {
 	tx4938_irq_pic_disable(irq);
 
 	return;
 }
 
-static void
-tx4938_irq_pic_enable(unsigned int irq)
+static void tx4938_irq_pic_enable(unsigned int irq)
 {
 	unsigned long flags;
 
@@ -352,8 +339,7 @@
 	return;
 }
 
-static void
-tx4938_irq_pic_disable(unsigned int irq)
+static void tx4938_irq_pic_disable(unsigned int irq)
 {
 	unsigned long flags;
 
@@ -367,16 +353,14 @@
 	return;
 }
 
-static void
-tx4938_irq_pic_mask_and_ack(unsigned int irq)
+static void tx4938_irq_pic_mask_and_ack(unsigned int irq)
 {
 	tx4938_irq_pic_disable(irq);
 
 	return;
 }
 
-static void
-tx4938_irq_pic_end(unsigned int irq)
+static void tx4938_irq_pic_end(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
 		tx4938_irq_pic_enable(irq);
@@ -389,8 +373,7 @@
 /* Main init functions                                                            */
 /**********************************************************************************/
 
-void __init
-tx4938_irq_init(void)
+void __init tx4938_irq_init(void)
 {
 	extern asmlinkage void tx4938_irq_handler(void);
 
@@ -401,8 +384,7 @@
 	return;
 }
 
-int
-tx4938_irq_nested(void)
+int tx4938_irq_nested(void)
 {
 	int sw_irq = 0;
 	u32 level2;
@@ -413,7 +395,8 @@
 		sw_irq = TX4938_IRQ_PIC_BEG + level2;
 		if (sw_irq == 26) {
 			{
-				extern int toshiba_rbtx4938_irq_nested(int sw_irq);
+				extern int toshiba_rbtx4938_irq_nested(int
+								       sw_irq);
 				sw_irq = toshiba_rbtx4938_irq_nested(sw_irq);
 			}
 		}
Index: linux/arch/mips/tx4938/common/rtc_rx5c348.c
===================================================================
--- linux.orig/arch/mips/tx4938/common/rtc_rx5c348.c
+++ linux/arch/mips/tx4938/common/rtc_rx5c348.c
@@ -49,14 +49,14 @@
 #define Rx5C348_CMD_MR(addr)	(((addr) << 4) | 0x04)	/* burst read */
 
 static struct spi_dev_desc srtc_dev_desc = {
-	.baud 		= 1000000,	/* 1.0Mbps @ Vdd 2.0V */
-	.tcss		= 31,
-	.tcsh		= 1,
-	.tcsr		= 62,
+	.baud = 1000000,	/* 1.0Mbps @ Vdd 2.0V */
+	.tcss = 31,
+	.tcsh = 1,
+	.tcsr = 62,
 	/* 31us for Tcss (62us for Tcsr) is required for carry operation) */
-	.byteorder	= 1,		/* MSB-First */
-	.polarity	= 0,		/* High-Active */
-	.phase		= 1,		/* Shift-Then-Sample */
+	.byteorder = 1,		/* MSB-First */
+	.polarity = 0,		/* High-Active */
+	.phase = 1,		/* Shift-Then-Sample */
 
 };
 static int srtc_chipid;
@@ -90,8 +90,7 @@
 
 /* RTC-dependent code for time.c */
 
-static int
-rtc_rx5c348_set_time(unsigned long t)
+static int rtc_rx5c348_set_time(unsigned long t)
 {
 	unsigned char inbuf[8];
 	struct rtc_time tm;
@@ -101,7 +100,7 @@
 	to_tm(t, &tm);
 
 	year = tm.tm_year % 100;
-	month = tm.tm_mon+1;	/* tm_mon starts from 0 to 11 */
+	month = tm.tm_mon + 1;	/* tm_mon starts from 0 to 11 */
 	day = tm.tm_mday;
 	hour = tm.tm_hour;
 	minute = tm.tm_min;
@@ -126,7 +125,7 @@
 		BIN_TO_BCD(hour);
 		inbuf[3] |= hour;
 	}
-	inbuf[4] = 0;	/* ignore week */
+	inbuf[4] = 0;		/* ignore week */
 	BIN_TO_BCD(day);
 	inbuf[5] = day;
 	BIN_TO_BCD(month);
@@ -139,8 +138,7 @@
 	return spi_rtc_io(inbuf, NULL, 8);
 }
 
-static unsigned long
-rtc_rx5c348_get_time(void)
+static unsigned long rtc_rx5c348_get_time(void)
 {
 	unsigned char inbuf[8], outbuf[8];
 	unsigned int year, month, day, hour, minute, second;
@@ -175,8 +173,7 @@
 	return mktime(year, month, day, hour, minute, second);
 }
 
-void __init
-rtc_rx5c348_init(int chipid)
+void __init rtc_rx5c348_init(int chipid)
 {
 	unsigned char inbuf[2], outbuf[2];
 	srtc_chipid = chipid;
Index: linux/arch/mips/pci/fixup-tx4938.c
===================================================================
--- linux.orig/arch/mips/pci/fixup-tx4938.c
+++ linux/arch/mips/pci/fixup-tx4938.c
@@ -25,7 +25,8 @@
 {
 	int irq = pin;
 	u8 slot = PCI_SLOT(dev->devfn);
-	struct pci_controller *controller = (struct pci_controller *)dev->sysdata;
+	struct pci_controller *controller =
+	    (struct pci_controller *)dev->sysdata;
 
 	if (controller == &tx4938_pci_controller[1]) {
 		/* TX4938 PCIC1 */
@@ -43,7 +44,7 @@
 	}
 
 	/* IRQ rotation */
-	irq--;	/* 0-3 */
+	irq--;			/* 0-3 */
 	if (dev->bus->parent == NULL &&
 	    (slot == TX4938_PCIC_IDSEL_AD_TO_SLOT(23))) {
 		/* PCI CardSlot (IDSEL=A23) */
@@ -53,7 +54,7 @@
 		/* PCI Backplane */
 		irq = (irq + 33 - slot) % 4;
 	}
-	irq++;	/* 1-4 */
+	irq++;			/* 1-4 */
 
 	switch (irq) {
 	case 1:
@@ -92,4 +93,3 @@
 {
 	return 0;
 }
-
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
===================================================================
--- linux.orig/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
@@ -33,13 +33,13 @@
 DEFINE_SPINLOCK(spi_eeprom_lock);
 
 static struct spi_dev_desc seeprom_dev_desc = {
-	.baud 		= 1500000,	/* 1.5Mbps */
-	.tcss		= 1,
-	.tcsh		= 1,
-	.tcsr		= 1,
-	.byteorder	= 1,		/* MSB-First */
-	.polarity	= 0,		/* High-Active */
-	.phase		= 0,		/* Sample-Then-Shift */
+	.baud = 1500000,	/* 1.5Mbps */
+	.tcss = 1,
+	.tcsh = 1,
+	.tcsr = 1,
+	.byteorder = 1,		/* MSB-First */
+	.polarity = 0,		/* High-Active */
+	.phase = 0,		/* Sample-Then-Shift */
 
 };
 static inline int
@@ -166,7 +166,7 @@
 	if (i == 0)
 		return -EIO;
 	return len;
- unlock_return:
+      unlock_return:
 	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
 	return stat;
 }
@@ -216,4 +216,4 @@
 		entry->data = (void *)chipid;
 	}
 }
-#endif /* CONFIG_PROC_FS */
+#endif				/* CONFIG_PROC_FS */
Index: linux/arch/mips/tx4938/common/prom.c
===================================================================
--- linux.orig/arch/mips/tx4938/common/prom.c
+++ linux/arch/mips/tx4938/common/prom.c
@@ -21,8 +21,7 @@
 #include <asm/bootinfo.h>
 #include <asm/tx4938/tx4938.h>
 
-static unsigned int __init
-tx4938_process_sdccr(u64 * addr)
+static unsigned int __init tx4938_process_sdccr(u64 * addr)
 {
 	u64 val;
 	unsigned int sdccr_ce;
@@ -109,8 +108,7 @@
 	return (msize);
 }
 
-unsigned int __init
-tx4938_get_mem_size(void)
+unsigned int __init tx4938_get_mem_size(void)
 {
 	unsigned int c0;
 	unsigned int c1;
