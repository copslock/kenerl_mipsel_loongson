Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAGD14T27138
	for linux-mips-outgoing; Fri, 16 Nov 2001 05:01:04 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAGCxog27070
	for <linux-mips@oss.sgi.com>; Fri, 16 Nov 2001 04:59:50 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA03937
	for <linux-mips@oss.sgi.com>; Fri, 16 Nov 2001 04:59:40 -0800 (PST)
	mail_from (ladislav.michl@hlubocky.del.cz)
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 164iQt-0006wW-00
	for <linux-mips@oss.sgi.com>; Fri, 16 Nov 2001 13:49:23 +0100
Date: Fri, 16 Nov 2001 13:49:22 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: linux-mips@oss.sgi.com
Subject: [PATCH] indy_int clenaup
Message-ID: <Pine.LNX.4.21.0111161316240.26371-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

this will bring you following:

* Indy interrupt handling works now better. the only visible change is
  look of /proc/interrupts
           CPU0
  2:          0         CPU_irq  local0 cascade
  3:          0         CPU_irq  local1 cascade
  6:          0         CPU_irq  Bus Error
  9:       2758    IP22 local 0  SGI WD93
 11:       2197    IP22 local 0  SGI Seeq8003
 15:          0    IP22 local 0  mappable0 cascade
 17:          4    IP22 local 1  Front Panel
 28:       6754    IP22 local 2  keyboard
 29:          0    IP22 local 2  Zilog8530
ERR:          0
one question: should be cascade interrupts counted too?
note, that timer irqs are not present. i'll do so once i'll implement 
CONFIG_NEW_TIME_C for Indy.

* I removed irq 'space' for HPC and GIO interrupts. They weren't
  implemented and doing so will make interrupt routine _very_ slow. 
  Driver should register HPC/MC/GIO interrupt as shareable and look
  to the proper register to see what happened (currently there is no such 
  driver, except of HAL2 sitting on my hardisk)

* Various definitions of IP22 interrups were added to sgint23.h

* other minor fixes.

note for those, who are waiting for VINO driver: at the beginning I was
unable to start DMA transfer. now i'm unable to stop it... so to bring my
ego from dust, i decided to write HAL2 driver, which needs HPC interupts.
this patch is HAL2 driver by-product...

any comments and/or suggestions are welcome,
ladis

Index: linux/include/asm-mips/sgi/sgint23.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/sgi/sgint23.h,v
retrieving revision 1.4
diff -u -r1.4 sgint23.h
--- linux/include/asm-mips/sgi/sgint23.h	2001/10/06 22:33:12	1.4
+++ linux/include/asm-mips/sgi/sgint23.h	2001/11/16 12:10:02
@@ -8,100 +8,123 @@
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 1997, 98, 1999, 2000 Ralf Baechle
  * Copyright (C) 1999 Andrew R. Baker (andrewb@uab.edu) - INT2 corrections
+ * Copyright (C) 2001 Ladislav Michl (ladis@psi.cz)
  */
 #ifndef _ASM_SGI_SGINT23_H
 #define _ASM_SGI_SGINT23_H
 
 /* These are the virtual IRQ numbers, we divide all IRQ's into
  * 'spaces', the 'space' determines where and how to enable/disable
- * that particular IRQ on an SGI machine.  Add new 'spaces' as new
- * IRQ hardware is supported.
+ * that particular IRQ on an SGI machine. HPC DMA and MC DMA interrups
+ * are not supported this way. Driver is supposed to allocate HPC/MC 
+ * interrupt as shareable and then look to proper status bit (see
+ * HAL2 driver). This will prevent many complications, trust me ;-) 
+ *	--ladis
  */
-#define SGINT_LOCAL0   0   /* INDY has 8 local0 irq levels */
-#define SGINT_LOCAL1   8   /* INDY has 8 local1 irq levels */
-#define SGINT_LOCAL2   16  /* INDY has 8 local2 vectored irq levels */
-#define SGINT_LOCAL3   24  /* INDY has 8 local3 vectored irq levels */
-#define SGINT_GIO      32  /* INDY has 9 GIO irq levels */
-#define SGINT_HPCDMA   41  /* INDY has 11 HPCDMA irq _sources_ */
-#define SGINT_END      52  /* End of 'spaces' */
+#define SGINT_CPU	 0	/* MIPS CPU define 8 interrupt sources */
+#define SGINT_LOCAL0	 8	/* INDY has 8 local0 irq levels */
+#define SGINT_LOCAL1	16	/* INDY has 8 local1 irq levels */
+#define SGINT_LOCAL2	24	/* INDY has 8 local2 vectored irq levels */
+#define SGINT_LOCAL3	32	/* INDY has 8 local3 vectored irq levels */
+#define SGINT_END	40	/* End of 'spaces' */
 
 /*
  * Individual interrupt definitions for the INDY and Indigo2
  */
 
-#define SGI_WD93_0_IRQ		SGINT_LOCAL0 + 1	/* 1st onboard WD93 */
-#define SGI_WD93_1_IRQ		SGINT_LOCAL0 + 2	/* 2nd onboard WD93 */
-#define SGI_ENET_IRQ		SGINT_LOCAL0 + 3	/* onboard ethernet */
-
-#define SGI_PANEL_IRQ		SGINT_LOCAL1 + 1	/* front panel */
-#define SGI_VINO_IRQ		SGINT_LOCAL1 + 6	/* Indy VINO */
-
-#define SGI_EISA_IRQ		SGINT_LOCAL2 + 3	/* EISA interrupts */
+#define SGI_LOCAL_0_IRQ	SGINT_CPU + 2
+#define SGI_LOCAL_1_IRQ	SGINT_CPU + 3
+#define SGI_BUSERR_IRQ	SGINT_CPU + 6
+#define SGI_TIMER_IRQ	SGINT_CPU + 7
+
+#define SGI_FIFO_IRQ	SGINT_LOCAL0 + 0	/* FIFO full */
+#define SGI_GIO_0_IRQ	SGI_FIFO_IRQ		/* GIO-0 */	
+#define SGI_WD93_0_IRQ	SGINT_LOCAL0 + 1	/* 1st onboard WD93 */
+#define SGI_WD93_1_IRQ	SGINT_LOCAL0 + 2	/* 2nd onboard WD93 */
+#define SGI_ENET_IRQ	SGINT_LOCAL0 + 3	/* onboard ethernet */
+#define SGI_MCDMA_IRQ	SGINT_LOCAL0 + 4	/* MC DMA done */
+#define SGI_PARPORT_IRQ	SGINT_LOCAL0 + 5	/* Parallel port */
+#define SGI_GIO_1_IRQ	SGINT_LOCAL0 + 6	/* GE / GIO-1 / 2nd-HPC */
+#define SGI_MAP_0_IRQ	SGINT_LOCAL0 + 7	/* Mappable interrupt 0 */
+
+#define SGI_GPL0_IRQ	SGINT_LOCAL1 + 0	/* General Purpose LOCAL1_N<0> */
+#define SGI_PANEL_IRQ	SGINT_LOCAL1 + 1	/* front panel */
+#define SGI_GPL2_IRQ	SGINT_LOCAL1 + 2	/* General Purpose LOCAL1_N<2> */
+#define SGI_MAP_1_IRQ	SGINT_LOCAL1 + 3	/* Mappable interrupt 1 */
+#define SGI_HPCDMA_IRQ	SGINT_LOCAL1 + 4	/* HPC DMA done */
+#define SGI_ACFAIL_IRQ	SGINT_LOCAL1 + 5	/* AC fail */
+#define SGI_VINO_IRQ	SGINT_LOCAL1 + 6	/* Indy VINO */
+#define SGI_GIO_2_IRQ	SGINT_LOCAL1 + 7	/* Vert retrace / GIO-2 */
+
+/* Mapped interrupts. These interrupts may be mapped to either 0, or 1
+ * We map them to 0 */
+#define SGI_VERT_IRQ	SGINT_LOCAL2 + 0	/* INT3: newport vertical status */
+#define SGI_EISA_IRQ	SGINT_LOCAL2 + 3	/* EISA interrupts */
 #define SGI_KEYBOARD_IRQ	SGINT_LOCAL2 + 4	/* keyboard */
-#define SGI_SERIAL_IRQ		SGINT_LOCAL2 + 5	/* onboard serial */
+#define SGI_SERIAL_IRQ	SGINT_LOCAL2 + 5	/* onboard serial */
 
 /* INT2 occupies HPC PBUS slot 4, INT3 uses slot 6. */
-#define SGI_INT2_BASE 0x1fbd9000 /* physical */
-#define SGI_INT3_BASE 0x1fbd9880 /* physical */
+#define SGI_INT2_BASE	0x1fbd9000	/* physical */
+#define SGI_INT3_BASE	0x1fbd9880	/* physical */
 
 struct sgi_ioc_ints {
 #ifdef __MIPSEB__
 	unsigned char _unused0[3];
-	volatile unsigned char istat0;    /* Interrupt status zero */
+	volatile unsigned char istat0;	/* Interrupt status zero */
 #else
-	volatile unsigned char istat0;    /* Interrupt status zero */
+	volatile unsigned char istat0;	/* Interrupt status zero */
 	unsigned char _unused0[3];
 #endif
-#define ISTAT0_FFULL           0x01
-#define ISTAT0_SCSI0           0x02
-#define ISTAT0_SCSI1           0x04
-#define ISTAT0_ENET            0x08
-#define ISTAT0_GFXDMA          0x10
-#define ISTAT0_LPR             0x20
-#define ISTAT0_HPC2            0x40
-#define ISTAT0_LIO2            0x80
-
+#define ISTAT0_FFULL	0x01
+#define ISTAT0_SCSI0	0x02
+#define ISTAT0_SCSI1	0x04
+#define ISTAT0_ENET	0x08
+#define ISTAT0_GFXDMA	0x10
+#define ISTAT0_LPR	0x20
+#define ISTAT0_HPC2	0x40
+#define ISTAT0_LIO2	0x80
+	
 #ifdef __MIPSEB__
 	unsigned char _unused1[3];
-	volatile unsigned char imask0;    /* Interrupt mask zero */
+	volatile unsigned char imask0;	/* Interrupt mask zero */
 	unsigned char _unused2[3];
-	volatile unsigned char istat1;    /* Interrupt status one */
+	volatile unsigned char istat1;	/* Interrupt status one */
 #else
-	volatile unsigned char imask0;    /* Interrupt mask zero */
+	volatile unsigned char imask0;	/* Interrupt mask zero */
 	unsigned char _unused1[3];
-	volatile unsigned char istat1;    /* Interrupt status one */
+	volatile unsigned char istat1;	/* Interrupt status one */
 	unsigned char _unused2[3];
 #endif
-#define ISTAT1_ISDNI           0x01
-#define ISTAT1_PWR             0x02
-#define ISTAT1_ISDNH           0x04
-#define ISTAT1_LIO3            0x08
-#define ISTAT1_HPC3            0x10
-#define ISTAT1_AFAIL           0x20
-#define ISTAT1_VIDEO           0x40
-#define ISTAT1_GIO2            0x80
-
+#define ISTAT1_ISDNI	0x01
+#define ISTAT1_PWR	0x02
+#define ISTAT1_ISDNH	0x04
+#define ISTAT1_LIO3	0x08
+#define ISTAT1_HPC3	0x10
+#define ISTAT1_AFAIL	0x20
+#define ISTAT1_VIDEO	0x40
+#define ISTAT1_GIO2	0x80
+	
 #ifdef __MIPSEB__
 	unsigned char _unused3[3];
-	volatile unsigned char imask1;    /* Interrupt mask one */
+	volatile unsigned char imask1;		/* Interrupt mask one */
 	unsigned char _unused4[3];
-	volatile unsigned char vmeistat;  /* VME interrupt status */
+	volatile unsigned char vmeistat;	/* VME interrupt status */
 	unsigned char _unused5[3];
-	volatile unsigned char cmeimask0; /* VME interrupt mask zero */
+	volatile unsigned char cmeimask0;	/* VME interrupt mask zero */
 	unsigned char _unused6[3];
-	volatile unsigned char cmeimask1; /* VME interrupt mask one */
+	volatile unsigned char cmeimask1;	/* VME interrupt mask one */
 	unsigned char _unused7[3];
-	volatile unsigned char cmepol;    /* VME polarity */
+	volatile unsigned char cmepol;		/* VME polarity */
 #else
-	volatile unsigned char imask1;    /* Interrupt mask one */
+	volatile unsigned char imask1;		/* Interrupt mask one */
 	unsigned char _unused3[3];
-	volatile unsigned char vmeistat;  /* VME interrupt status */
+	volatile unsigned char vmeistat;	/* VME interrupt status */
 	unsigned char _unused4[3];
-	volatile unsigned char cmeimask0; /* VME interrupt mask zero */
+	volatile unsigned char cmeimask0;	/* VME interrupt mask zero */
 	unsigned char _unused5[3];
-	volatile unsigned char cmeimask1; /* VME interrupt mask one */
+	volatile unsigned char cmeimask1;	/* VME interrupt mask one */
 	unsigned char _unused6[3];
-	volatile unsigned char cmepol;    /* VME polarity */
+	volatile unsigned char cmepol;		/* VME polarity */
 	unsigned char _unused7[3];
 #endif
 };
@@ -109,21 +132,21 @@
 struct sgi_ioc_timers {
 #ifdef __MIPSEB__
 	unsigned char _unused0[3];
-	volatile unsigned char tcnt0;  /* counter 0 */
+	volatile unsigned char tcnt0;	/* counter 0 */
 	unsigned char _unused1[3];
-	volatile unsigned char tcnt1;  /* counter 1 */
+	volatile unsigned char tcnt1;	/* counter 1 */
 	unsigned char _unused2[3];
-	volatile unsigned char tcnt2;  /* counter 2 */
+	volatile unsigned char tcnt2;	/* counter 2 */
 	unsigned char _unused3[3];
-	volatile unsigned char tcword; /* control word */
+	volatile unsigned char tcword;	/* control word */
 #else
-	volatile unsigned char tcnt0;  /* counter 0 */
+	volatile unsigned char tcnt0;	/* counter 0 */
 	unsigned char _unused0[3];
-	volatile unsigned char tcnt1;  /* counter 1 */
+	volatile unsigned char tcnt1;	/* counter 1 */
 	unsigned char _unused1[3];
-	volatile unsigned char tcnt2;  /* counter 2 */
+	volatile unsigned char tcnt2;	/* counter 2 */
 	unsigned char _unused2[3];
-	volatile unsigned char tcword; /* control word */
+	volatile unsigned char tcword;	/* control word */
 	unsigned char _unused3[3];
 #endif
 };
@@ -156,22 +179,22 @@
 struct sgi_int2_regs {
 	struct sgi_ioc_ints ints;
 
-	volatile u32 ledbits; 		  /* LED control bits */
-#define INT2_LED_TXCLK         0x01       /* GPI to TXCLK enable */
-#define INT2_LED_SERSLCT0      0x02       /* serial port0: 0=apple 1=pc */
-#define INT2_LED_SERSLCT1      0x04       /* serial port1: 0=apple 1=pc */
-#define INT2_LED_CHEAPER       0x08       /* 0=cheapernet 1=ethernet */
-#define INT2_LED_POWEROFF      0x10       /* Power-off request, active high */
+	volatile u32 ledbits;		/* LED control bits */
+#define INT2_LED_TXCLK		0x01	/* GPI to TXCLK enable */
+#define INT2_LED_SERSLCT0	0x02	/* serial port0: 0=apple 1=pc */
+#define INT2_LED_SERSLCT1	0x04	/* serial port1: 0=apple 1=pc */
+#define INT2_LED_CHEAPER	0x08	/* 0=cheapernet 1=ethernet */
+#define INT2_LED_POWEROFF	0x10	/* Power-off request, active high */
 
 #ifdef __MIPSEB__
 	unsigned char _unused0[3];
-	volatile unsigned char tclear;    /* Timer clear strobe address */
+	volatile unsigned char tclear;	/* Timer clear strobe address */
 #else
-	volatile unsigned char tclear;    /* Timer clear strobe address */
+	volatile unsigned char tclear;	/* Timer clear strobe address */
 	unsigned char _unused0[3];
 #endif
-#define INT2_TCLEAR_T0CLR      0x1        /* Clear timer0 IRQ */
-#define INT2_TCLEAR_T1CLR      0x2        /* Clear timer1 IRQ */
+#define INT2_TCLEAR_T0CLR	0x1	/* Clear timer0 IRQ */
+#define INT2_TCLEAR_T1CLR	0x2	/* Clear timer1 IRQ */
 /* I am guesing there are only two unused registers here 
  * but I could be wrong...			- andrewb
  */
@@ -185,12 +208,12 @@
 
 #ifdef __MIPSEB__
 	unsigned char _unused0[3];
-	volatile unsigned char tclear;		/* Timer clear strobe address */
+	volatile unsigned char tclear;	/* Timer clear strobe address */
 #else
-	volatile unsigned char tclear;		/* Timer clear strobe address */
+	volatile unsigned char tclear;	/* Timer clear strobe address */
 	unsigned char _unused0[3];
 #endif
-	volatile u32 estatus;			/* Error status reg */
+	volatile u32 estatus;		/* Error status reg */
 	u32 _unused1[2];
 	struct sgi_ioc_timers timers;
 };
Index: linux/arch/mips/sgi/kernel/indy_int.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi/kernel/indy_int.c,v
retrieving revision 1.30
diff -u -r1.30 indy_int.c
--- linux/arch/mips/sgi/kernel/indy_int.c	2001/11/14 02:40:09	1.30
+++ linux/arch/mips/sgi/kernel/indy_int.c	2001/11/16 12:10:03
@@ -7,54 +7,26 @@
  * Copyright (C) 1999 Andrew R. Baker (andrewb@uab.edu) 
  *                    - Indigo2 changes
  *                    - Interrupt handling fixes
+ * Copyright (C) 2001 Ladislav Michl (ladis@psi.cz)
  */
-#include <linux/init.h>
 
-#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/init.h>
 #include <linux/kernel_stat.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
-#include <linux/types.h>
 #include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/smp.h>
-#include <linux/smp_lock.h>
-
-#include <asm/bitops.h>
-#include <asm/bootinfo.h>
-#include <asm/io.h>
+
 #include <asm/irq.h>
 #include <asm/mipsregs.h>
-#include <asm/system.h>
-
-#include <asm/ptrace.h>
-#include <asm/processor.h>
-#include <asm/sgi/sgi.h>
-#include <asm/sgi/sgihpc.h>
-#include <asm/sgi/sgint23.h>
-#include <asm/sgialib.h>
+#include <asm/addrspace.h>
 #include <asm/gdb-stub.h>
 
-/*
- * Linux has a controller-independent x86 interrupt architecture.
- * every controller has a 'controller-template', that is used
- * by the main code to do the right thing. Each driver-visible
- * interrupt source is transparently wired to the apropriate
- * controller. Thus drivers need not be aware of the
- * interrupt-controller.
- *
- * Various interrupt controllers we handle: 8259 PIC, SMP IO-APIC,
- * PIIX4's internal 8259 PIC and SGI's Visual Workstation Cobalt (IO-)APIC.
- * (IO-APICs assumed to be messaging to Pentium local-APICs)
- *
- * the code is designed to be easily extended with new/different
- * interrupt controllers, without having to do assembly magic.
- */
+#include <asm/sgi/sgint23.h>
+#include <asm/sgi/sgihpc.h>
 
 /* #define DEBUG_SGINT */
+#undef I_REALLY_NEED_THIS_IRQ
 
 struct sgi_int2_regs *sgi_i2regs;
 struct sgi_int3_regs *sgi_i3regs;
@@ -68,30 +40,23 @@
 static char lc3msk_to_irqnr[256];
 
 extern asmlinkage void indyIRQ(void);
+extern void do_IRQ(int irq, struct pt_regs *regs);
 
-/* Local IRQ's are layed out logically like this:
- *
- * 0  --> 7   ==   local 0 interrupts
- * 8  --> 15  ==   local 1 interrupts
- * 16 --> 23  ==   vectored level 2 interrupts
- * 24 --> 31  ==   vectored level 3 interrupts (not used)
- * 32 --> 40  ==   vectored GIO interrupts
- * 41 --> 52  ==   vectored HPCDMA interrupts
- */
-
 static void enable_local0_irq(unsigned int irq)
 {
 	unsigned long flags;
 
 	save_and_cli(flags);
-	ioc_icontrol->imask0 |= (1 << (irq - SGINT_LOCAL0));
+	/* don't allow mappable interrupt to be enabled from setup_irq,
+	 * we have our own way to do so */
+	if (irq != SGI_MAP_0_IRQ)
+		ioc_icontrol->imask0 |= (1 << (irq - SGINT_LOCAL0));
 	restore_flags(flags);
 }
 
 static unsigned int startup_local0_irq(unsigned int irq)
 {
 	enable_local0_irq(irq);
-
 	return 0;		/* Never anything pending  */
 }
 
@@ -129,14 +94,16 @@
 	unsigned long flags;
 
 	save_and_cli(flags);
-	ioc_icontrol->imask1 |= (1 << (irq - SGINT_LOCAL1));
+	/* don't allow mappable interrupt to be enabled from setup_irq,
+	 * we have our own way to do so */
+	if (irq != SGI_MAP_1_IRQ)
+		ioc_icontrol->imask1 |= (1 << (irq - SGINT_LOCAL1));
 	restore_flags(flags);
 }
 
 static unsigned int startup_local1_irq(unsigned int irq)
 {
 	enable_local1_irq(irq);
-
 	return 0;		/* Never anything pending  */
 }
 
@@ -145,7 +112,7 @@
 	unsigned long flags;
 
 	save_and_cli(flags);
-	ioc_icontrol->imask1 &= ~(1 << (irq- SGINT_LOCAL1));
+	ioc_icontrol->imask1 &= ~(1 << (irq - SGINT_LOCAL1));
 	restore_flags(flags);
 }
 
@@ -174,7 +141,7 @@
 	unsigned long flags;
 
 	save_and_cli(flags);
-	enable_local0_irq(7);
+	ioc_icontrol->imask0 |= (1 << (SGI_MAP_0_IRQ - SGINT_LOCAL0));
 	ioc_icontrol->cmeimask0 |= (1 << (irq - SGINT_LOCAL2));
 	restore_flags(flags);
 }
@@ -182,7 +149,6 @@
 static unsigned int startup_local2_irq(unsigned int irq)
 {
 	enable_local2_irq(irq);
-
 	return 0;		/* Never anything pending  */
 }
 
@@ -192,6 +158,8 @@
 
 	save_and_cli(flags);
 	ioc_icontrol->cmeimask0 &= ~(1 << (irq - SGINT_LOCAL2));
+	if (!ioc_icontrol->cmeimask0)
+		ioc_icontrol->imask0 &= ~(1 << (SGI_MAP_0_IRQ - SGINT_LOCAL0));
 	restore_flags(flags);
 }
 
@@ -217,18 +185,21 @@
 
 static void enable_local3_irq(unsigned int irq)
 {
+#ifdef I_REALLY_NEED_THIS_IRQ
 	unsigned long flags;
-
+	
 	save_and_cli(flags);
-	printk("Yeeee, got passed irq_nr %d at enable_local3_irq\n", irq);
-	panic("Invalid IRQ level!");
+	ioc_icontrol->imask1 |= (1 << (SGI_MAP_1_IRQ - SGINT_LOCAL1));
+	ioc_icontrol->cmeimask1 |= (1 << (irq - SGINT_LOCAL3));
 	restore_flags(flags);
+#else
+	panic("Who need local 3 irq? see indy_int.c\n");
+#endif
 }
 
 static unsigned int startup_local3_irq(unsigned int irq)
 {
 	enable_local3_irq(irq);
-
 	return 0;		/* Never anything pending  */
 }
 
@@ -237,12 +208,9 @@
 	unsigned long flags;
 
 	save_and_cli(flags);
-	/*
-	 * This way we'll see if anyone would ever want vectored level 3
-	 * interrupts. Highly unlikely.
-	 */
-	printk("Yeeee, got passed irq_nr %d at disable_local3_irq\n", irq);
-	panic("Invalid IRQ level!");
+	ioc_icontrol->cmeimask1 &= ~(1 << (irq - SGINT_LOCAL3));
+	if (!ioc_icontrol->cmeimask1)
+		ioc_icontrol->imask1 &= ~(1 << (SGI_MAP_1_IRQ - SGINT_LOCAL1));
 	restore_flags(flags);
 }
 
@@ -266,80 +234,6 @@
 	NULL
 };
 
-void enable_gio_irq(unsigned int irq)
-{
-	/* XXX TODO XXX */
-}
-
-static unsigned int startup_gio_irq(unsigned int irq)
-{
-	enable_gio_irq(irq);
-
-	return 0;		/* Never anything pending  */
-}
-
-void disable_gio_irq(unsigned int irq)
-{
-	/* XXX TODO XXX */
-}
-
-#define shutdown_gio_irq	disable_gio_irq
-#define mask_and_ack_gio_irq	disable_gio_irq
-
-static void end_gio_irq (unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_gio_irq(irq);
-}
-
-static struct hw_interrupt_type ip22_gio_irq_type = {
-	"IP22 GIO",
-	startup_gio_irq,
-	shutdown_gio_irq,
-	enable_gio_irq,
-	disable_gio_irq,
-	mask_and_ack_gio_irq,
-	end_gio_irq,
-	NULL
-};
-
-void enable_hpcdma_irq(unsigned int irq)
-{
-	/* XXX TODO XXX */
-}
-
-static unsigned int startup_hpcdma_irq(unsigned int irq)
-{
-	enable_hpcdma_irq(irq);
-
-	return 0;		/* Never anything pending  */
-}
-
-void disable_hpcdma_irq(unsigned int irq)
-{
-	/* XXX TODO XXX */
-}
-
-#define shutdown_hpcdma_irq	disable_hpcdma_irq
-#define mask_and_ack_hpcdma_irq	disable_hpcdma_irq
-
-static void end_hpcdma_irq (unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_hpcdma_irq(irq);
-}
-
-static struct hw_interrupt_type ip22_hpcdma_irq_type = {
-	"IP22 HPC DMA",
-	startup_hpcdma_irq,
-	shutdown_hpcdma_irq,
-	enable_hpcdma_irq,
-	disable_hpcdma_irq,
-	mask_and_ack_hpcdma_irq,
-	end_hpcdma_irq,
-	NULL
-};
-
 void indy_local0_irqdispatch(struct pt_regs *regs)
 {
 	unsigned char mask = ioc_icontrol->istat0;
@@ -369,16 +263,17 @@
 
 	mask &= ioc_icontrol->imask1;
 	if (mask & ISTAT1_LIO3) {
-		printk("WHee: Got an LIO3 irq, winging it...\n");
+#ifndef I_REALLY_NEED_THIS_IRQ
+		printk("Whee: Got an LIO3 irq, winging it...\n");
+#endif
 		mask2 = ioc_icontrol->vmeistat;
 		mask2 &= ioc_icontrol->cmeimask1;
-		irq = lc3msk_to_irqnr[ioc_icontrol->vmeistat];
+		irq = lc3msk_to_irqnr[mask2];
 	} else {
 		irq = lc1msk_to_irqnr[mask];
 	}
 
 	/* if irq == 0, then the interrupt has already been cleared */
-	/* not sure if it is needed here, but it is needed for local0 */
 	if (irq)
 		do_IRQ(irq, regs);
 	return;	
@@ -387,16 +282,35 @@
 void indy_buserror_irq(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
-	int irq = 6;
+	int irq = SGI_BUSERR_IRQ;
 
 	irq_enter(cpu, irq);
-	kstat.irqs[0][irq]++;
+	kstat.irqs[cpu][irq]++;
 	die("Got a bus error IRQ, shouldn't happen yet\n", regs);
 	printk("Spinning...\n");
 	while(1);
 	irq_exit(cpu, irq);
 }
 
+static struct irqaction local0_cascade = 
+	{ no_action, SA_INTERRUPT, 0, "local0 cascade", NULL, NULL };
+static struct irqaction local1_cascade = 
+	{ no_action, SA_INTERRUPT, 0, "local1 cascade", NULL, NULL };
+static struct irqaction buserr = 
+	{ no_action, SA_INTERRUPT, 0, "Bus Error", NULL, NULL };
+static struct irqaction timer = 
+	{ no_action, SA_INTERRUPT, 0, "R4k Timer", NULL, NULL };
+static struct irqaction map0_cascade =
+	{ no_action, SA_INTERRUPT, 0, "mappable0 cascade", NULL, NULL };
+#ifdef I_REALLY_NEED_THIS_IRQ
+static struct irqaction map1_cascade =
+	{ no_action, SA_INTERRUPT, 0, "mappable1 cascade", NULL, NULL };
+#endif
+
+extern int setup_irq(unsigned int irq, struct irqaction *irqaction);
+extern void mips_cpu_irq_init(u32 irq_base);
+extern void init_generic_irq(void);
+	
 void __init init_IRQ(void)
 {
 	int i;
@@ -407,45 +321,45 @@
 	/* Init local mask --> irq tables. */
 	for (i = 0; i < 256; i++) {
 		if (i & 0x80) {
-			lc0msk_to_irqnr[i] = 7;
-			lc1msk_to_irqnr[i] = 15;
-			lc2msk_to_irqnr[i] = 23;
-			lc3msk_to_irqnr[i] = 31;
+			lc0msk_to_irqnr[i] = SGINT_LOCAL0 + 7;
+			lc1msk_to_irqnr[i] = SGINT_LOCAL1 + 7;
+			lc2msk_to_irqnr[i] = SGINT_LOCAL2 + 7;
+			lc3msk_to_irqnr[i] = SGINT_LOCAL3 + 7;
 		} else if (i & 0x40) {
-			lc0msk_to_irqnr[i] = 6;
-			lc1msk_to_irqnr[i] = 14;
-			lc2msk_to_irqnr[i] = 22;
-			lc3msk_to_irqnr[i] = 30;
+			lc0msk_to_irqnr[i] = SGINT_LOCAL0 + 6;
+			lc1msk_to_irqnr[i] = SGINT_LOCAL1 + 6;
+			lc2msk_to_irqnr[i] = SGINT_LOCAL2 + 6;
+			lc3msk_to_irqnr[i] = SGINT_LOCAL3 + 6;
 		} else if (i & 0x20) {
-			lc0msk_to_irqnr[i] = 5;
-			lc1msk_to_irqnr[i] = 13;
-			lc2msk_to_irqnr[i] = 21;
-			lc3msk_to_irqnr[i] = 29;
+			lc0msk_to_irqnr[i] = SGINT_LOCAL0 + 5;
+			lc1msk_to_irqnr[i] = SGINT_LOCAL1 + 5;
+			lc2msk_to_irqnr[i] = SGINT_LOCAL2 + 5;
+			lc3msk_to_irqnr[i] = SGINT_LOCAL3 + 5;
 		} else if (i & 0x10) {
-			lc0msk_to_irqnr[i] = 4;
-			lc1msk_to_irqnr[i] = 12;
-			lc2msk_to_irqnr[i] = 20;
-			lc3msk_to_irqnr[i] = 28;
+			lc0msk_to_irqnr[i] = SGINT_LOCAL0 + 4;
+			lc1msk_to_irqnr[i] = SGINT_LOCAL1 + 4;
+			lc2msk_to_irqnr[i] = SGINT_LOCAL2 + 4;
+			lc3msk_to_irqnr[i] = SGINT_LOCAL3 + 4;
 		} else if (i & 0x08) {
-			lc0msk_to_irqnr[i] = 3;
-			lc1msk_to_irqnr[i] = 11;
-			lc2msk_to_irqnr[i] = 19;
-			lc3msk_to_irqnr[i] = 27;
+			lc0msk_to_irqnr[i] = SGINT_LOCAL0 + 3;
+			lc1msk_to_irqnr[i] = SGINT_LOCAL1 + 3;
+			lc2msk_to_irqnr[i] = SGINT_LOCAL2 + 3;
+			lc3msk_to_irqnr[i] = SGINT_LOCAL3 + 3;
 		} else if (i & 0x04) {
-			lc0msk_to_irqnr[i] = 2;
-			lc1msk_to_irqnr[i] = 10;
-			lc2msk_to_irqnr[i] = 18;
-			lc3msk_to_irqnr[i] = 26;
+			lc0msk_to_irqnr[i] = SGINT_LOCAL0 + 2;
+			lc1msk_to_irqnr[i] = SGINT_LOCAL1 + 2;
+			lc2msk_to_irqnr[i] = SGINT_LOCAL2 + 2;
+			lc3msk_to_irqnr[i] = SGINT_LOCAL3 + 2;
 		} else if (i & 0x02) {
-			lc0msk_to_irqnr[i] = 1;
-			lc1msk_to_irqnr[i] = 9;
-			lc2msk_to_irqnr[i] = 17;
-			lc3msk_to_irqnr[i] = 25;
+			lc0msk_to_irqnr[i] = SGINT_LOCAL0 + 1;
+			lc1msk_to_irqnr[i] = SGINT_LOCAL1 + 1;
+			lc2msk_to_irqnr[i] = SGINT_LOCAL2 + 1;
+			lc3msk_to_irqnr[i] = SGINT_LOCAL3 + 1;
 		} else if (i & 0x01) {
-			lc0msk_to_irqnr[i] = 0;
-			lc1msk_to_irqnr[i] = 8;
-			lc2msk_to_irqnr[i] = 16;
-			lc3msk_to_irqnr[i] = 24;
+			lc0msk_to_irqnr[i] = SGINT_LOCAL0 + 0;
+			lc1msk_to_irqnr[i] = SGINT_LOCAL1 + 0;
+			lc2msk_to_irqnr[i] = SGINT_LOCAL2 + 0;
+			lc3msk_to_irqnr[i] = SGINT_LOCAL3 + 0;
 		} else {
 			lc0msk_to_irqnr[i] = 0;
 			lc1msk_to_irqnr[i] = 0;
@@ -474,6 +388,8 @@
 	set_except_vector(0, indyIRQ);
 
 	init_generic_irq();
+	/* init CPU irqs */
+	mips_cpu_irq_init(SGINT_CPU);
 
 	for (i = SGINT_LOCAL0; i < SGINT_END; i++) {
 		hw_irq_controller *handler;
@@ -484,16 +400,27 @@
 			handler		= &ip22_local1_irq_type;
 		else if (i < SGINT_LOCAL3)
 			handler		= &ip22_local2_irq_type;
-		else if (i < SGINT_GIO)
+		else
 			handler		= &ip22_local3_irq_type;
-		else if (i < SGINT_HPCDMA)
-			handler		= &ip22_gio_irq_type;
-		else if (i < SGINT_END)
-			handler		= &ip22_hpcdma_irq_type;
 
 		irq_desc[i].status	= IRQ_DISABLED;
 		irq_desc[i].action	= 0;
 		irq_desc[i].depth	= 1;
 		irq_desc[i].handler	= handler;
 	}
+
+	/* vector handler. this register the IRQ as non-sharable */
+	setup_irq(SGI_LOCAL_0_IRQ, &local0_cascade);
+	setup_irq(SGI_LOCAL_1_IRQ, &local1_cascade);
+	setup_irq(SGI_BUSERR_IRQ, &buserr);
+/* This can't be enabled yet. we need to use CONFIG_NEW_TIME_C
+ * hopefully i'll rewrite it in couple of days. --ladis
+	setup_irq(SGI_TIMER_IRQ,  &timer);
+*/
+	
+	/* cascade in cascade. i love Indy ;-) */
+	setup_irq(SGI_MAP_0_IRQ, &map0_cascade);
+#ifdef I_REALLY_NEED_THIS_IRQ
+	setup_irq(SGI_MAP_1_IRQ, &map1_cascade);
+#endif
 }
Index: linux/arch/mips/sgi/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi/kernel/setup.c,v
retrieving revision 1.46
diff -u -r1.46 setup.c
--- linux/arch/mips/sgi/kernel/setup.c	2001/08/23 22:24:24	1.46
+++ linux/arch/mips/sgi/kernel/setup.c	2001/11/16 12:10:08
@@ -302,7 +302,4 @@
 #ifdef CONFIG_PSMOUSE
 	aux_device_present = 0xaa;
 #endif
-#ifdef CONFIG_VIDEO_VINO
-	init_vino();
-#endif
 }
Index: linux/arch/mips/sgi/kernel/time.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi/kernel/time.c,v
retrieving revision 1.6
diff -u -r1.6 time.c
--- linux/arch/mips/sgi/kernel/time.c	2001/03/18 04:20:23	1.6
+++ linux/arch/mips/sgi/kernel/time.c	2001/11/16 12:10:08
@@ -13,7 +13,7 @@
 	int irq = 4;
 
 	irq_enter(cpu, irq);
-	kstat.irqs[0][irq]++;
+	kstat.irqs[cpu][irq]++;
 	printk("indy_8254timer_irq: Whoops, should not have gotten this IRQ\n");
 	prom_getchar();
 	ArcEnterInteractiveMode();
Index: linux/arch/mips/config.in
===================================================================
RCS file: /cvs/linux/arch/mips/config.in,v
retrieving revision 1.144
diff -u -r1.144 config.in
--- linux/arch/mips/config.in	2001/11/13 05:40:00	1.144
+++ linux/arch/mips/config.in	2001/11/16 12:43:33
@@ -177,6 +177,7 @@
    define_bool CONFIG_BOARD_SCACHE y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_SGI y
+   define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_OLD_TIME_C y
 fi
