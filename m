Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JH84Rw004218
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 10:08:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JH84ph004217
	for linux-mips-outgoing; Fri, 19 Jul 2002 10:08:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crisis.wild-wind.fr.eu.org (lopsy-lu.misterjones.org [62.4.18.26])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JH6mRw004129;
	Fri, 19 Jul 2002 10:06:49 -0700
Received: from hina.wild-wind.fr.eu.org ([192.168.70.139])
	by crisis.wild-wind.fr.eu.org with esmtp (Exim 3.35 #1 (Debian))
	id 17VbEJ-0007UC-00; Fri, 19 Jul 2002 19:07:47 +0200
Received: from maz by hina.wild-wind.fr.eu.org with local (Exim 3.35 #1 (Debian))
	id 17VbCU-0005E3-00; Fri, 19 Jul 2002 19:05:54 +0200
To: linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@oss.sgi.com>
Subject: [PATCH] EISA bus support on Indigo-2
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 19 Jul 2002 19:05:54 +0200
Message-ID: <wrpofd3y7f1.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

--=-=-=

Hi all,

I found some time to update my basic EISA support for the Indigo-2
patch, so here it is (only works in PIO mode).

Performance is much better that what it was two months ago, and is
stable for my very basic usage (Indigo-2 as a router... yeah right).

Here is a sample boot :

ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE 
CPU revision is: 00000450
FPU revision is: 00000500
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 128 bytes.
Linux version 2.4.19-rc1 (maz@lazy) (gcc version 2.95.4 20011002 (Debian prerelease)) #84 Thu Jul 18 20:52:19 CEST 2002
MC: SGI memory controller Revision 3
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 0020d000 @ 08002000 (usable)
 memory: 0000d000 @ 0820f000 (reserved)
 memory: 00524000 @ 0821c000 (usable)
 memory: 000c0000 @ 08740000 (ROM data)
 memory: 0b800000 @ 08800000 (usable)
On node 0 totalpages: 81920
zone(0): 36864 pages.
zone(1): 45056 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sdb1 
EISA: Probing bus...
EISA: slot 2 : HWP1940 detected.
EISA: slot 3 : TCM5093 detected.
EISA: Detected 2 cards.
ISA support compiled in.
Calibrating system timer... 750000 [150.00 MHz CPU]
GIO: Scanning for GIO cards...
GIO: Card 0x7f @ 0x1f000000
GIO: Card 0x04 @ 0x1f400000
Console: colour dummy device 80x25
zs0: console input
Console: ttyS0 (Zilog8530), 9600 baud
Calibrating delay loop... 74.75 BogoMIPS
Memory: 190348k/195780k available (1519k kernel code, 5432k reserved, 172k data, 56k init, 0k highmem)

The machine currently runs with a 3c579 (EISA counterpart of the
3c509), and a HP100 10/100VG whose driver is not very happy on the
Indigo-2... Anyway, the 3Com card is perfectly OK and runs with zero
modification to the driver.

I still have to try an ISA card in this beast, but at least I can now
compile with ISA support (which was crashing the machine before...).

Patch is against 2.4.19-rc1 from CVS as of yesterday. I'd really love
to hear from someone about this (that is, if anyone cares at all...).

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=ip22-eisa-2.4.19-rc1.patch
Content-Description: basic eisa support for Indigo-2

Index: arch/mips/config.in
===================================================================
RCS file: /cvs/linux/arch/mips/config.in,v
retrieving revision 1.154.2.23
diff -u -r1.154.2.23 config.in
--- arch/mips/config.in	2002/07/15 00:24:29	1.154.2.23
+++ arch/mips/config.in	2002/07/19 06:41:26
@@ -313,6 +313,7 @@
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_TIME_C y
    define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_SWAP_IO_SPACE y
 fi
 if [ "$CONFIG_SIBYTE_SB1250" = "y" ]; then
    define_bool CONFIG_NEW_IRQ y
@@ -467,6 +468,15 @@
 
 if [ "$CONFIG_ARC32" = "y" ]; then
    bool 'ARC console support' CONFIG_ARC_CONSOLE
+fi
+
+if [ "$CONFIG_SGI_IP22" = "y" ]; then
+   dep_bool 'Indigo-2 (IP22) EISA bus support' CONFIG_IP22_EISA $CONFIG_EXPERIMENTAL
+fi
+
+if [ "$CONFIG_IP22_EISA" = "y" ]; then
+   define_bool CONFIG_EISA y
+   bool '    ISA bus support' CONFIG_ISA
 fi
 
 bool 'Networking support' CONFIG_NET
Index: arch/mips/sgi-ip22/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/Makefile,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 Makefile
--- arch/mips/sgi-ip22/Makefile	2002/06/28 10:31:32	1.1.2.4
+++ arch/mips/sgi-ip22/Makefile	2002/07/19 06:41:37
@@ -18,6 +18,7 @@
          ip22-gio.o ip22-rtc.o ip22-reset.o ip22-system.o ip22-setup.o
 
 obj-$(CONFIG_BOARD_SCACHE)	+= ip22-sc.o
+obj-$(CONFIG_IP22_EISA) += ip22-eisa.o
 
 ip22-irq.o: ip22-irq.S
 
Index: arch/mips/sgi-ip22/ip22-int.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-int.c,v
retrieving revision 1.2.2.4
diff -u -r1.2.2.4 ip22-int.c
--- arch/mips/sgi-ip22/ip22-int.c	2002/07/02 12:02:00	1.2.2.4
+++ arch/mips/sgi-ip22/ip22-int.c	2002/07/19 06:41:38
@@ -40,6 +40,7 @@
 
 extern asmlinkage void indyIRQ(void);
 extern void do_IRQ(int irq, struct pt_regs *regs);
+extern int ip22_eisa_init (void);
 
 static void enable_local0_irq(unsigned int irq)
 {
@@ -413,5 +414,9 @@
 	setup_irq(SGI_MAP_0_IRQ, &map0_cascade);
 #ifdef I_REALLY_NEED_THIS_IRQ
 	setup_irq(SGI_MAP_1_IRQ, &map1_cascade);
+#endif
+#ifdef CONFIG_IP22_EISA
+	if (!sgi_guiness)	/* Only Indigo-2 have EISA stuff */
+	        ip22_eisa_init ();
 #endif
 }
Index: arch/mips/sgi-ip22/ip22-setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
retrieving revision 1.1.2.12
diff -u -r1.1.2.12 ip22-setup.c
--- arch/mips/sgi-ip22/ip22-setup.c	2002/07/03 11:51:42	1.1.2.12
+++ arch/mips/sgi-ip22/ip22-setup.c	2002/07/19 06:41:38
@@ -28,6 +28,7 @@
 #include <asm/sgi/sgint23.h>
 #include <asm/time.h>
 #include <asm/gdb-stub.h>
+#include <asm/io.h>
 #include <asm/traps.h>
 
 #ifdef CONFIG_REMOTE_DEBUG
@@ -152,6 +153,9 @@
 	indy_sc_init();
 #endif
 	conswitchp = NULL;
+
+	/* Set the IO space to some sane value */
+	set_io_port_base (KSEG1ADDR (0x00080000));
 
 	/* ARCS console environment variable is set to "g?" for
 	 * graphics console, it is set to "d" for the first serial
Index: include/asm-mips/dma.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/dma.h,v
retrieving revision 1.8.2.1
diff -u -r1.8.2.1 dma.h
--- include/asm-mips/dma.h	2002/06/30 12:36:35	1.8.2.1
+++ include/asm-mips/dma.h	2002/07/19 06:41:52
@@ -83,7 +83,13 @@
  * Deskstations or Acer PICA but not the much more versatile DMA logic used
  * for the local devices on Acer PICA or Magnums.
  */
+#ifdef CONFIG_SGI_IP22
+/* Horrible hack to have a correct DMA window on IP22 */
+#include <asm/sgi/sgimc.h>
+#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SGIMC_SEG0_BADDR + 0x01000000)
+#else
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
+#endif
 
 /* 8237 DMA controllers */
 #define IO_DMA1_BASE	0x00	/* 8 bit slave DMA, channels 0..3 */
Index: include/asm-mips/io.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/io.h,v
retrieving revision 1.29.2.12
diff -u -r1.29.2.12 io.h
--- include/asm-mips/io.h	2002/06/26 22:36:37	1.29.2.12
+++ include/asm-mips/io.h	2002/07/19 06:41:53
@@ -30,7 +30,13 @@
 #if defined(CONFIG_SWAP_IO_SPACE) && defined(__MIPSEB__)
 
 #define __ioswab8(x) (x)
+#ifdef CONFIG_SGI_IP22
+/* IP22 seems braindead enough to swap 16bits values in hardware, but
+   not 32bits.  Go figure... Can't tell without documentation. */
+#define __ioswab16(x) (x)
+#else
 #define __ioswab16(x) swab16(x)
+#endif
 #define __ioswab32(x) swab32(x)
 
 #else
Index: include/asm-mips/sgi/sgint23.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/sgi/sgint23.h,v
retrieving revision 1.5.2.1
diff -u -r1.5.2.1 sgint23.h
--- include/asm-mips/sgi/sgint23.h	2001/12/14 20:49:49	1.5.2.1
+++ include/asm-mips/sgi/sgint23.h	2002/07/19 06:41:58
@@ -21,12 +21,13 @@
  * HAL2 driver). This will prevent many complications, trust me ;-) 
  *	--ladis
  */
-#define SGINT_CPU	 0	/* MIPS CPU define 8 interrupt sources */
-#define SGINT_LOCAL0	 8	/* INDY has 8 local0 irq levels */
-#define SGINT_LOCAL1	16	/* INDY has 8 local1 irq levels */
-#define SGINT_LOCAL2	24	/* INDY has 8 local2 vectored irq levels */
-#define SGINT_LOCAL3	32	/* INDY has 8 local3 vectored irq levels */
-#define SGINT_END	40	/* End of 'spaces' */
+#define SGINT_EISA       0	/* INDIGO-2 has 16 EISA irq levels */
+#define SGINT_CPU	16	/* MIPS CPU define 8 interrupt sources */
+#define SGINT_LOCAL0	24	/* INDY has 8 local0 irq levels */
+#define SGINT_LOCAL1	32	/* INDY has 8 local1 irq levels */
+#define SGINT_LOCAL2	40	/* INDY has 8 local2 vectored irq levels */
+#define SGINT_LOCAL3	48	/* INDY has 8 local3 vectored irq levels */
+#define SGINT_END	56	/* End of 'spaces' */
 
 /*
  * Individual interrupt definitions for the INDY and Indigo2
--- /dev/null	Mon Dec 10 15:21:03 2001
+++ arch/mips/sgi-ip22/ip22-eisa.c	Thu May 30 14:33:51 2002
@@ -0,0 +1,303 @@
+/*
+ * Basic EISA bus support for the SGI Indigo-2.
+ *
+ * (C) 2002 Pascal Dameme <netinet@freesurf.fr>
+ *      and Marc Zyngier <mzyngier@freesurf.fr>
+ *
+ * This code is released under both the GPL version 2 and BSD
+ * licenses.  Either license may be used.
+ *
+ * This code offers a very basic support for this EISA bus present in
+ * the SGI Indigo-2. It currently only supports PIO (forget about DMA
+ * for the time being). This is enough for a low-end ethernet card,
+ * but forget about your favorite SCSI card...
+ *
+ * TODO :
+ * - Fix bugs...
+ * - Add ISA support
+ * - Add DMA (yeah, right...).
+ * - Fix more bugs.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <asm/irq.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/sgi/sgint23.h>
+
+extern int EISA_bus;
+extern void do_IRQ(int irq, struct pt_regs *regs);
+
+#define EISA_MAX_SLOTS		  4
+#define EISA_MAX_IRQ             16
+
+#define EISA_TO_PHYS(x)  (0x00080000 | (x))
+#define EISA_TO_KSEG1(x) ((void *) KSEG1ADDR(EISA_TO_PHYS((x))))
+
+#define EIU_MODE_REG     0x0009ffc0
+#define EIU_STAT_REG     0x0009ffc4
+#define EIU_PREMPT_REG   0x0009ffc8
+#define EIU_QUIET_REG    0x0009ffcc
+#define EIU_INTRPT_ACK   0x00090004
+
+#define EISA_DMA1_STATUS            8
+#define EISA_INT1_CTRL           0x20
+#define EISA_INT1_MASK           0x21
+#define EISA_INT2_CTRL           0xA0
+#define EISA_INT2_MASK           0xA1
+#define EISA_DMA2_STATUS         0xD0
+#define EISA_DMA2_WRITE_SINGLE   0xD4
+#define EISA_EXT_NMI_RESET_CTRL 0x461
+#define EISA_INT1_EDGE_LEVEL    0x4D0
+#define EISA_INT2_EDGE_LEVEL    0x4D1
+#define EISA_VENDOR_ID_OFFSET   0xC80
+
+#define EIU_WRITE_32(x,y) { *((u32 *) KSEG1ADDR(x)) = (u32) (y); mb(); }
+#define EIU_READ_8(x) *((u8 *) KSEG1ADDR(x))
+#define EISA_WRITE_8(x,y) { *((u8 *) EISA_TO_KSEG1(x)) = (u8) (y); mb(); }
+#define EISA_READ_8(x) *((u8 *) EISA_TO_KSEG1(x))
+
+static char *decode_eisa_sig (u8 *sig)
+{
+  static char sig_str[8];
+  u16 rev;
+
+  if (sig[0] & 0x80)
+    return NULL;
+
+  sig_str[0] = ((sig[0] >> 2) & 0x1f) + ('A' - 1);
+  sig_str[1] = (((sig[0] & 3) << 3) | (sig[1] >> 5)) + ('A' - 1);
+  sig_str[2] = (sig[1] & 0x1f) + ('A' - 1);
+  rev = (sig[2] << 8) | sig[3];
+  sprintf (sig_str + 3, "%04X", rev);
+
+  return sig_str;
+}
+
+static void ip22_eisa_intr (int irq, void *dev_id, struct pt_regs *regs)
+{
+  u8 eisa_irq;
+  u8 dma1, dma2;
+  
+  eisa_irq = EIU_READ_8 (EIU_INTRPT_ACK);
+  dma1 = EISA_READ_8 (EISA_DMA1_STATUS);
+  dma2 = EISA_READ_8 (EISA_DMA2_STATUS);
+  
+  if (eisa_irq >= EISA_MAX_IRQ)
+  {
+    /* Oops, Bad Stuff Happened... */
+    printk ("eisa_irq %d out of bound\n", eisa_irq);
+
+    EISA_WRITE_8 (EISA_INT2_CTRL, 0x20);
+    EISA_WRITE_8 (EISA_INT1_CTRL, 0x20);
+  }
+  else
+    do_IRQ (eisa_irq, regs);
+}
+
+static void enable_eisa1_irq(unsigned int irq)
+{
+  unsigned long flags;
+  u8 mask;
+
+  save_and_cli(flags);
+
+  mask = EISA_READ_8 (EISA_INT1_MASK);
+  mask &= ~((u8) (1 << irq));
+  EISA_WRITE_8 (EISA_INT1_MASK, mask);
+
+  restore_flags(flags);
+}
+
+static unsigned int startup_eisa1_irq(unsigned int irq)
+{
+  u8 edge;
+  
+  /* Only use edge interrupts for EISA */
+  
+  edge = EISA_READ_8 (EISA_INT1_EDGE_LEVEL);
+  edge &= ~((u8) (1 << irq));
+  EISA_WRITE_8 (EISA_INT1_EDGE_LEVEL, edge);
+  
+  enable_eisa1_irq(irq);
+  return 0;
+}
+
+static void disable_eisa1_irq(unsigned int irq)
+{
+  u8 mask;
+    
+  mask = EISA_READ_8 (EISA_INT1_MASK);
+  mask |= ((u8) (1 << irq));
+  EISA_WRITE_8 (EISA_INT1_MASK, mask);
+}
+
+#define shutdown_eisa1_irq	disable_eisa1_irq
+
+static void mask_and_ack_eisa1_irq (unsigned int irq)
+{
+  disable_eisa1_irq (irq);
+  
+  EISA_WRITE_8 (EISA_INT1_CTRL, 0x20);
+}
+
+static void end_eisa1_irq (unsigned int irq)
+{
+  if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+    enable_eisa1_irq(irq);
+}
+
+static struct hw_interrupt_type ip22_eisa1_irq_type =
+{
+  "IP22 EISA",
+  startup_eisa1_irq,
+  shutdown_eisa1_irq,
+  enable_eisa1_irq,
+  disable_eisa1_irq,
+  mask_and_ack_eisa1_irq,
+  end_eisa1_irq,
+  NULL
+};
+
+static void enable_eisa2_irq(unsigned int irq)
+{
+  unsigned long flags;
+  u8 mask;
+
+  save_and_cli(flags);
+
+  mask = EISA_READ_8 (EISA_INT2_MASK);
+  mask &= ~((u8) (1 << (irq - 8)));
+  EISA_WRITE_8 (EISA_INT2_MASK, mask);
+
+  restore_flags(flags);
+}
+
+static unsigned int startup_eisa2_irq(unsigned int irq)
+{
+  u8 edge;
+  
+  /* Only use edge interrupts for EISA */
+  
+  edge = EISA_READ_8 (EISA_INT2_EDGE_LEVEL);
+  edge &= ~((u8) (1 << (irq - 8)));
+  EISA_WRITE_8 (EISA_INT2_EDGE_LEVEL, edge);
+  
+  enable_eisa2_irq(irq);
+  return 0;
+}
+
+static void disable_eisa2_irq(unsigned int irq)
+{
+  u8 mask;
+    
+  mask = EISA_READ_8 (EISA_INT2_MASK);
+  mask |= ((u8) (1 << (irq - 8)));
+  EISA_WRITE_8 (EISA_INT2_MASK, mask);
+}
+
+#define shutdown_eisa2_irq	disable_eisa2_irq
+
+static void mask_and_ack_eisa2_irq (unsigned int irq)
+{
+  disable_eisa2_irq (irq);
+  
+  EISA_WRITE_8 (EISA_INT2_CTRL, 0x20);
+  EISA_WRITE_8 (EISA_INT1_CTRL, 0x20);
+}
+
+static void end_eisa2_irq (unsigned int irq)
+{
+  if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+    enable_eisa2_irq(irq);
+}
+
+static struct hw_interrupt_type ip22_eisa2_irq_type =
+{
+  "IP22 EISA",
+  startup_eisa2_irq,
+  shutdown_eisa2_irq,
+  enable_eisa2_irq,
+  disable_eisa2_irq,
+  mask_and_ack_eisa2_irq,
+  end_eisa2_irq,
+  NULL
+};
+
+static struct irqaction eisa_action =
+	{ ip22_eisa_intr, 0, 0, "EISA", NULL, NULL };
+
+static struct irqaction cascade_action =
+	{ no_action, 0, 0, "EISA cascade", NULL, NULL };
+
+int __init ip22_eisa_init (void)
+{
+  int i, c;
+  char *str;
+  u8 *slot_addr;
+
+  printk ("EISA: Probing bus...\n");
+  for (c = 0, i = 1; i <= EISA_MAX_SLOTS; i++)
+  {
+    slot_addr = (u8 *) EISA_TO_KSEG1 ((0x1000 * i) + EISA_VENDOR_ID_OFFSET);
+    if ((str = decode_eisa_sig (slot_addr)))
+    {
+      printk ("EISA: slot %d : %s detected.\n", i, str);
+      c++;
+    }
+  }
+  printk ("EISA: Detected %d card%s.\n", c, c < 2 ? "" : "s");
+#ifdef CONFIG_ISA
+  printk ("ISA support compiled in.\n");
+#endif
+  
+  /* Warning : BlackMagicAhead(tm).
+     Please wave your favorite dead chicken over the busses */
+
+  /* First say hello to the EIU */
+  EIU_WRITE_32 (EIU_PREMPT_REG, 0x0000FFFF);
+  EIU_WRITE_32 (EIU_QUIET_REG, 1);
+  EIU_WRITE_32 (EIU_MODE_REG, 0x40f3c07F);
+
+  /* Now be nice to the EISA chipset */
+  EISA_WRITE_8 (EISA_EXT_NMI_RESET_CTRL, 1);
+  for (i = 0; i < 10000; i++);	/* Wait long enough for the dust to settle */
+  EISA_WRITE_8 (EISA_EXT_NMI_RESET_CTRL, 0);
+  EISA_WRITE_8 (EISA_INT1_CTRL, 0x11);
+  EISA_WRITE_8 (EISA_INT2_CTRL, 0x11);
+  EISA_WRITE_8 (EISA_INT1_MASK, 0);
+  EISA_WRITE_8 (EISA_INT2_MASK, 8);
+  EISA_WRITE_8 (EISA_INT1_MASK, 4);
+  EISA_WRITE_8 (EISA_INT2_MASK, 2);
+  EISA_WRITE_8 (EISA_INT1_MASK, 1);
+  EISA_WRITE_8 (EISA_INT2_MASK, 1);
+  EISA_WRITE_8 (EISA_INT1_MASK, 0xfb);
+  EISA_WRITE_8 (EISA_INT2_MASK, 0xff);
+  EISA_WRITE_8 (EISA_DMA2_WRITE_SINGLE, 0);
+
+  for (i = SGINT_EISA; i < (SGINT_EISA + EISA_MAX_IRQ); i++)
+  {
+    irq_desc[i].status	= IRQ_DISABLED;
+    irq_desc[i].action	= 0;
+    irq_desc[i].depth	= 1;
+    if (i < (SGINT_EISA + 8))
+      irq_desc[i].handler = &ip22_eisa1_irq_type;
+    else
+      irq_desc[i].handler = &ip22_eisa2_irq_type;
+  }
+
+  /* Cannot use request_irq because of kmalloc not being ready at such
+   * an early stage. Yes, I've been bitten... */
+  setup_irq (SGI_EISA_IRQ, &eisa_action);
+  setup_irq (SGINT_EISA + 2 , &cascade_action);
+
+  EISA_bus = 1;
+  return 0;
+}

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
