Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4DIMTnC006630
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 13 May 2002 11:22:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4DIMT5h006629
	for linux-mips-outgoing; Mon, 13 May 2002 11:22:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4DILZnE006581
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 11:21:36 -0700
Received: from crisis.wild-wind.fr.eu.org (lopsy-lu.misterjones.org [62.4.18.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA05122
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 07:39:43 -0700 (PDT)
	mail_from (maz@misterjones.org)
Received: from hina.wild-wind.fr.eu.org ([192.168.70.139])
	by crisis.wild-wind.fr.eu.org with esmtp (Exim 3.35 #1 (Debian))
	id 177GsY-0003UD-00
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 16:32:46 +0200
Received: from maz by hina.wild-wind.fr.eu.org with local (Exim 3.35 #1 (Debian))
	id 177Gty-0004Y6-00; Mon, 13 May 2002 16:34:14 +0200
To: linux-mips@oss.sgi.com
Subject: [PATCH] Basic Indigo-2 EISA support
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 13 May 2002 16:34:14 +0200
Message-ID: <wrpk7q8nml5.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

--=-=-=

Hi all,

The included patch adds some very basic EISA support to the Indigo-2
(patch is against oss.sgi.com CVS from yesterday). It only supports
PIO mode at the moment, and enabling CONFIG_ISA crashes the
machine. Handle with care !

Anyway, I've been able to use an unmodified 3c509 driver (with a 3c579
card) on my 150MHz Indigo-2 for hours without problems :

lazy:/home/maz# dmesg|tail -4
eth1: 3c5x9 at 0x3000, BNC port, address  00 20 af eb 79 a3, IRQ 10.
3c509.c:1.18a 17Nov2001becker@scyld.com
http://www.scyld.com/network/3c509.html
eth1: Setting Rx mode to 1 addresses.
lazy:/home/maz# cat /proc/interrupts 
           CPU0       
 10:      17556       IP22 EISA  eth1
 18:          0            MIPS  local0 cascade
 19:          0            MIPS  local1 cascade
 22:          0            MIPS  Bus Error
 23:    2534068            MIPS  timer
 25:      10615    IP22 local 0  SGI WD93
 26:          7    IP22 local 0  SGI WD93
 27:      32701    IP22 local 0  SGI Seeq8003
 31:          0    IP22 local 0  mappable0 cascade
 33:          0    IP22 local 1  Front Panel
 43:      17556    IP22 local 2  IP22 EISA
 44:          2    IP22 local 2  keyboard
 45:       1402    IP22 local 2  Zilog8530
ERR:          0

Summary of changes :

- Add 16 to all IRQ numbers, so we can insert EISA irq from 0 to 15
and keep existing drivers happy,
- Set io_port_base to 0x80000, which is where the EISA bus lives on
the IP22,
- Swap 32bits accesses to the IO space (16bits IO are handled just
fine... One more IP22 mystery),
- Add arch/mips/sgi-ip22/ip22-eisa.c, which implements the eisa
hw_interrupt_type, and programs the EIU in a mysterious way...
- Add CONFIG_IP22_EISA configuration option.

TODO :

- Solve CONFIG_ISA crashes
- Add DMA

I'd be very happy if someone with EIU knowledge could enlight me with
details about the magic bits in ip22_eisa_init()... I'd also be glad to
receive any comment on this patch.

Regards,

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=eisa-irq.patch
Content-Description: Indigo-2 Eisa patch

Index: arch/mips/config.in
===================================================================
RCS file: /cvs/linux/arch/mips/config.in,v
retrieving revision 1.154.2.17
diff -u -r1.154.2.17 config.in
--- arch/mips/config.in	2002/05/12 07:13:04	1.154.2.17
+++ arch/mips/config.in	2002/05/13 11:51:23
@@ -178,6 +178,7 @@
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_TIME_C y
    define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_SWAP_IO_SPACE y
 fi
 if [ "$CONFIG_SNI_RM200_PCI" = "y" ]; then
    define_bool CONFIG_ARC32 y
@@ -447,6 +448,15 @@
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 if [ "$CONFIG_MIPS_AU1000" = "y" ]; then
 dep_bool 'Power Management support (experimental)' CONFIG_PM $CONFIG_EXPERIMENTAL
+fi
+
+if [ "$CONFIG_SGI_IP22" = "y" ]; then
+   bool 'Indigo-2 (IP22) EISA bus support' CONFIG_IP22_EISA
+fi
+
+if [ "$CONFIG_IP22_EISA" = "y" ]; then
+#   define_bool CONFIG_ISA y
+   define_bool CONFIG_EISA y
 fi
 
 bool 'Networking support' CONFIG_NET
Index: arch/mips/sgi-ip22/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/Makefile,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 Makefile
--- arch/mips/sgi-ip22/Makefile	2001/12/07 15:45:29	1.1.2.1
+++ arch/mips/sgi-ip22/Makefile	2002/05/13 11:51:25
@@ -20,6 +20,8 @@
 obj-y	+= ip22-mc.o ip22-sc.o ip22-hpc.o ip22-int.o ip22-time.o ip22-rtc.o \
 	   ip22-irq.o ip22-system.o ip22-reset.o ip22-setup.o
 
+obj-$(CONFIG_IP22_EISA) += ip22-eisa.o
+
 ip22-irq.o: ip22-irq.S
 
 include $(TOPDIR)/Rules.make
Index: arch/mips/sgi-ip22/ip22-int.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-int.c,v
retrieving revision 1.2.2.1
diff -u -r1.2.2.1 ip22-int.c
--- arch/mips/sgi-ip22/ip22-int.c	2001/12/19 18:23:48	1.2.2.1
+++ arch/mips/sgi-ip22/ip22-int.c	2002/05/13 11:51:26
@@ -41,6 +41,7 @@
 
 extern asmlinkage void indyIRQ(void);
 extern void do_IRQ(int irq, struct pt_regs *regs);
+extern int ip22_eisa_init (void);
 
 static void enable_local0_irq(unsigned int irq)
 {
@@ -415,5 +416,9 @@
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
retrieving revision 1.1.2.6
diff -u -r1.1.2.6 ip22-setup.c
--- arch/mips/sgi-ip22/ip22-setup.c	2002/05/12 07:25:39	1.1.2.6
+++ arch/mips/sgi-ip22/ip22-setup.c	2002/05/13 11:51:26
@@ -28,6 +28,7 @@
 #include <asm/sgi/sgint23.h>
 #include <asm/time.h>
 #include <asm/gdb-stub.h>
+#include <asm/io.h>
 
 #ifdef CONFIG_REMOTE_DEBUG
 extern void rs_kgdb_hook(int);
@@ -146,6 +147,9 @@
 
 	/* Now enable boardcaches, if any. */
 	indy_sc_init();
+
+	/* Set the IO space to some sane value */
+	set_io_port_base (KSEG1ADDR (0x00080000));
 
 #ifdef CONFIG_SERIAL_CONSOLE
 	/* ARCS console environment variable is set to "g?" for
Index: include/asm-mips/io.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/io.h,v
retrieving revision 1.29.2.10
diff -u -r1.29.2.10 io.h
--- include/asm-mips/io.h	2002/04/15 07:37:50	1.29.2.10
+++ include/asm-mips/io.h	2002/05/13 11:51:56
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
+++ include/asm-mips/sgi/sgint23.h	2002/05/13 11:51:59
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
--- /dev/null	Mon Mar 18 16:22:16 2002
+++ arch/mips/sgi-ip22/ip22-eisa.c	Mon May 13 13:52:16 2002
@@ -0,0 +1,224 @@
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
+#define EISA_MAX_IRQ             16
+
+#define EISA_TO_PHYS(x)  (0x00080000 | (x))
+#define EISA_TO_KSEG1(x) ((void *) KSEG1ADDR(EISA_TO_PHYS(x)))
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
+#define EIU_WRITE_32(x,y) { *((u32 *) KSEG1ADDR(x)) = (u32) (y); mb (); }
+#define EIU_READ_8(x) *((volatile u8 *) KSEG1ADDR(x))
+#define EISA_WRITE_8(x,y) { *((u8 *) EISA_TO_KSEG1(x)) = (u8) (y); mb(); }
+#define EISA_READ_8(x) *((volatile u8 *) EISA_TO_KSEG1(x))
+
+static void ip22_eisa_intr (int irq, void *dev_id, struct pt_regs *regs)
+{
+  u8 eisa_irq, dma1, dma2;
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
+    if (eisa_irq >= 8)
+      EISA_WRITE_8 (EISA_INT2_CTRL, 0x20);
+    EISA_WRITE_8 (EISA_INT1_CTRL, 0x20);
+    
+    return;
+  }
+
+  do_IRQ (eisa_irq, regs);
+}
+
+static void enable_eisa_irq(unsigned int irq)
+{
+  unsigned long flags;
+  u8 mask1, mask2;
+
+  save_and_cli(flags);
+  mask1 = EISA_READ_8 (EISA_INT1_MASK);
+  mask2 = EISA_READ_8 (EISA_INT2_MASK);
+
+  if (irq < 8)
+    mask1 &= ~((u8) (1 << irq));
+  else
+  {
+    mask1 &= ~((u8) (1 << 2));	/* Activate cascade */
+    mask2 &= ~((u8) (1 << (irq - 8)));
+  }
+
+  EISA_WRITE_8 (EISA_INT1_MASK, mask1);
+  EISA_WRITE_8 (EISA_INT2_MASK, mask2);
+  restore_flags(flags);
+}
+
+static unsigned int startup_eisa_irq(unsigned int irq)
+{
+  u8 edge1, edge2;
+  
+  /* Only use edge interrupts for EISA */
+  edge1 = EISA_READ_8 (EISA_INT1_EDGE_LEVEL);
+  edge2 = EISA_READ_8 (EISA_INT2_EDGE_LEVEL);
+
+  if (irq < 8)
+    edge1 &= ~((u8) (1 << irq));
+  else
+    edge2 &= ~((u8) (1 << (irq - 8)));
+  
+  EISA_WRITE_8 (EISA_INT2_EDGE_LEVEL, edge2);
+  EISA_WRITE_8 (EISA_INT1_EDGE_LEVEL, edge1);
+
+  enable_eisa_irq(irq);
+  return 0;
+}
+
+static void disable_eisa_irq(unsigned int irq)
+{
+  u8 mask1, mask2;
+    
+  mask1 = EISA_READ_8 (EISA_INT1_MASK);
+  mask2 = EISA_READ_8 (EISA_INT2_MASK);
+
+  if (irq < 8)
+    mask1 |= ((u8) (1 << irq));
+  else
+  {
+    mask2 |= ((u8) (1 << (irq - 8)));
+    if (mask2 == 0xff)
+      mask1 |= ((u8) (1 << 2));
+  }
+    
+  EISA_WRITE_8 (EISA_INT1_MASK, mask1);
+  EISA_WRITE_8 (EISA_INT2_MASK, mask2);
+}
+
+#define shutdown_eisa_irq	disable_eisa_irq
+
+static void mask_and_ack_eisa_irq (unsigned int irq)
+{
+  disable_eisa_irq (irq);
+  
+  if (irq >= 8)
+    EISA_WRITE_8 (EISA_INT2_CTRL, 0x20);
+  EISA_WRITE_8 (EISA_INT1_CTRL, 0x20);
+}
+
+static void end_eisa_irq (unsigned int irq)
+{
+  if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+    enable_eisa_irq(irq);
+}
+
+static struct hw_interrupt_type ip22_eisa_irq_type =
+{
+  "IP22 EISA",
+  startup_eisa_irq,
+  shutdown_eisa_irq,
+  enable_eisa_irq,
+  disable_eisa_irq,
+  mask_and_ack_eisa_irq,
+  end_eisa_irq,
+  NULL
+};
+
+static struct irqaction eisa_action =
+	{ ip22_eisa_intr, 0, 0, "IP22 EISA", NULL, NULL };
+
+int ip22_eisa_init (void)
+{
+  int i;
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
+  for (i = 0; i < 10000; i++);
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
+    irq_desc[i].handler	= &ip22_eisa_irq_type;
+  }
+
+  /* Cannot use request_irq because of kmalloc not being ready at such
+   * an early stage. Yes, I've been bitten... */
+  setup_irq(SGI_EISA_IRQ, &eisa_action);
+
+  EISA_bus = 1;
+  return 0;
+}

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
