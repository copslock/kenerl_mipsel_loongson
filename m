Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6ALvMRw021376
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 14:57:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6ALvM0Z021375
	for linux-mips-outgoing; Wed, 10 Jul 2002 14:57:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6ALt2Rw021316;
	Wed, 10 Jul 2002 14:55:02 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA16471;
	Wed, 10 Jul 2002 14:59:28 -0700
Message-ID: <3D2CAC86.9070809@mvista.com>
Date: Wed, 10 Jul 2002 14:52:06 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com, Ralf Baechle <ralf@oss.sgi.com>
Subject: [2.4 PATCH] DDB5xxx update and rockhopper II support
Content-Type: multipart/mixed;
 boundary="------------080905060902040806040503"
X-Spam-Status: No, hits=-4.9 required=5.0 tests=PORN_10,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------080905060902040806040503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ralf,

This patch is an update for DDB5xxx boards.  It adds support to the latest 
rockhopper II baseboard.  A couple of nice new features are added as well, 
such as automatical run-time board detection and bus frequency detection, etc.

Credits should go to Brad LeRonde and Alice Hennessy who did much of the work 
in this patch.

This patch does not apply to 2.5.  I will create one or more new patches later 
for 2.5.

Jun

--------------080905060902040806040503
Content-Type: text/plain;
 name="rockhopper2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rockhopper2.patch"

diff -Nru linux/arch/mips/ddb5xxx/common/irq.c.orig linux/arch/mips/ddb5xxx/common/irq.c
--- linux/arch/mips/ddb5xxx/common/irq.c.orig	Wed Dec 19 10:23:48 2001
+++ linux/arch/mips/ddb5xxx/common/irq.c	Tue Jul  9 18:18:46 2002
@@ -13,6 +13,7 @@
  */
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 void (*irq_setup)(void);
 
diff -Nru linux/arch/mips/ddb5xxx/common/prom.c.orig linux/arch/mips/ddb5xxx/common/prom.c
--- linux/arch/mips/ddb5xxx/common/prom.c.orig	Wed Dec 26 15:17:29 2001
+++ linux/arch/mips/ddb5xxx/common/prom.c	Tue Jul  9 18:43:47 2002
@@ -33,9 +33,15 @@
 	case MACH_NEC_DDB5476:		return "NEC DDB Vrc-5476";
 	case MACH_NEC_DDB5477:		return "NEC DDB Vrc-5477";
 	case MACH_NEC_ROCKHOPPER:	return "NEC Rockhopper";
+	case MACH_NEC_ROCKHOPPERII:	return "NEC RockhopperII";
+	default:			return "Unknown DDB machine";
 	}
 }
 
+#if defined(CONFIG_DDB5477)
+void ddb5477_runtime_detection(void);
+#endif
+
 /* [jsun@junsun.net] PMON passes arguments in C main() style */
 void __init prom_init(int argc, const char **arg)
 {
@@ -92,6 +98,13 @@
            around just after that.
          */
 
+	/* We can only use the PCI bus to distinquish between
+	   the Rockhopper and RockhopperII backplanes and this must
+	   wait until ddb5477_board_init() in setup.c after the 5477
+	   is initialized.  So, until then handle
+	   both Rockhopper and RockhopperII backplanes as Rockhopper 1
+	 */
+
         test_offset = (char *)KSEG1ADDR(DEFAULT_LCS1_BASE + 0x800);
         saved_test_byte = *test_offset;
 
diff -Nru linux/arch/mips/ddb5xxx/ddb5477/irq_5477.c.orig linux/arch/mips/ddb5xxx/ddb5477/irq_5477.c
--- linux/arch/mips/ddb5xxx/ddb5477/irq_5477.c.orig	Mon Dec 17 13:00:15 2001
+++ linux/arch/mips/ddb5xxx/ddb5477/irq_5477.c	Tue Jul  9 17:11:22 2002
@@ -18,6 +18,7 @@
  * This file exports one function:
  *	vrc5477_irq_init(u32 irq_base);
  */
+
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
@@ -115,15 +116,6 @@
 	vrc5477_irq_base = irq_base;
 }
 
-
-int vrc5477_irq_to_irq(int irq)
-{
-	db_assert(irq >= 0);
-	db_assert(irq < NUM_5477_IRQ);
-
-	return irq + vrc5477_irq_base;
-}
-
 void ll_vrc5477_irq_route(int vrc5477_irq, int ip)
 {
 	u32 reg_value;
diff -Nru linux/arch/mips/ddb5xxx/ddb5477/irq.c.orig linux/arch/mips/ddb5xxx/ddb5477/irq.c
--- linux/arch/mips/ddb5xxx/ddb5477/irq.c.orig	Mon Dec 17 13:00:15 2001
+++ linux/arch/mips/ddb5xxx/ddb5477/irq.c	Tue Jul  9 18:44:49 2002
@@ -19,6 +19,8 @@
 #include <asm/system.h>
 #include <asm/mipsregs.h>
 #include <asm/debug.h>
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
 
 #include <asm/ddb5xxx/ddb5xxx.h>
 
@@ -69,9 +71,12 @@
 	ddb_out32(pci, reg_value);
 }
 
+extern void init_i8259_irqs (void);
 extern void vrc5477_irq_init(u32 base);
 extern void mips_cpu_irq_init(u32 base);
 extern asmlinkage void ddb5477_handle_int(void);
+extern int setup_irq(unsigned int irq, struct irqaction *irqaction);  
+static struct irqaction irq_cascade = { no_action, 0, 0, "cascade", NULL, NULL };
 
 void
 ddb5477_irq_setup(void)
@@ -91,7 +96,10 @@
 	/* setup PCI interrupt attributes */
 	set_pci_int_attr(PCI0, INTA, ACTIVE_LOW, LEVEL_SENSE);
 	set_pci_int_attr(PCI0, INTB, ACTIVE_LOW, LEVEL_SENSE);
-	set_pci_int_attr(PCI0, INTC, ACTIVE_LOW, LEVEL_SENSE);
+	if (mips_machtype == MACH_NEC_ROCKHOPPERII) 
+		set_pci_int_attr(PCI0, INTC, ACTIVE_HIGH, LEVEL_SENSE);
+	else
+		set_pci_int_attr(PCI0, INTC, ACTIVE_LOW, LEVEL_SENSE);
 	set_pci_int_attr(PCI0, INTD, ACTIVE_LOW, LEVEL_SENSE);
 	set_pci_int_attr(PCI0, INTE, ACTIVE_LOW, LEVEL_SENSE);
 
@@ -121,13 +129,34 @@
 	ll_vrc5477_irq_route(31, 1); ll_vrc5477_irq_enable(31);
 
 	/* init all controllers */
-	mips_cpu_irq_init(0);
-	vrc5477_irq_init(8);
+	init_i8259_irqs();
+	mips_cpu_irq_init(CPU_IRQ_BASE);
+	vrc5477_irq_init(VRC5477_IRQ_BASE);
+
+
+	/* setup cascade interrupts */
+	setup_irq(VRC5477_IRQ_BASE + VRC5477_I8259_CASCADE, &irq_cascade);
+	setup_irq(CPU_IRQ_BASE + CPU_VRC5477_CASCADE, &irq_cascade);      
 
 	/* hook up the first-level interrupt handler */
 	set_except_vector(0, ddb5477_handle_int);
 }
 
+u8 i8259_interrupt_ack(void)
+{
+	u8 irq;
+	u32 reg;
+
+	/* Set window 0 for interrupt acknowledge */
+	reg = ddb_in32(DDB_PCIINIT10);
+
+	ddb_set_pmr(DDB_PCIINIT10, DDB_PCICMD_IACK, 0, DDB_PCI_ACCESS_32);
+	irq = *(volatile u8 *) KSEG1ADDR(DDB_PCI_IACK_BASE);
+	ddb_out32(DDB_PCIINIT10, reg);
+
+	/* i8259.c set the base vector to be 0x0 */
+	return irq + I8259_IRQ_BASE;
+}
 /*
  * the first level int-handler will jump here if it is a vrc5477 irq
  */
@@ -154,10 +183,21 @@
 	}
 
 	intStatus = ddb_in32(DDB_INT0STAT);
+
+	if (mips_machtype == MACH_NEC_ROCKHOPPERII) {
+		/* check for i8259 interrupts */
+		if (intStatus & (1 << VRC5477_I8259_CASCADE)) {
+			int i8259_irq = i8259_interrupt_ack();
+			do_IRQ(I8259_IRQ_BASE + i8259_irq, regs);
+			return;
+		}
+	}
+
 	for (i=0, bitmask=1; i<= NUM_5477_IRQS; bitmask <<=1, i++) {
 		/* do we need to "and" with the int mask? */
 		if (intStatus & bitmask) {
-			do_IRQ(8 + i, regs);
+			do_IRQ(VRC5477_IRQ_BASE + i, regs);
+			return;
 		}
 	}
 }
diff -Nru linux/arch/mips/ddb5xxx/ddb5477/pci.c.orig linux/arch/mips/ddb5xxx/ddb5477/pci.c
--- linux/arch/mips/ddb5xxx/ddb5477/pci.c.orig	Tue Jul  9 15:05:24 2002
+++ linux/arch/mips/ddb5xxx/ddb5477/pci.c	Tue Jul  9 18:11:44 2002
@@ -10,12 +10,14 @@
  * option) any later version.
  *
  */
+
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/pci.h>
 
+#include <asm/bootinfo.h>
 #include <asm/pci_channel.h>
 #include <asm/debug.h>
 
@@ -23,13 +25,13 @@
 
 static struct resource extpci_io_resource = {
 	"ext pci IO space", 
-	DDB_PCI0_IO_BASE - DDB_PCI_IO_BASE,
+	DDB_PCI0_IO_BASE - DDB_PCI_IO_BASE + 0x4000,
 	DDB_PCI0_IO_BASE - DDB_PCI_IO_BASE + DDB_PCI0_IO_SIZE -1,
 	IORESOURCE_IO};
 
 static struct resource extpci_mem_resource = {
 	"ext pci memory space", 
-	DDB_PCI0_MEM_BASE,
+	DDB_PCI0_MEM_BASE + 0x100000,
 	DDB_PCI0_MEM_BASE + DDB_PCI0_MEM_SIZE -1,
 	IORESOURCE_MEM};
 
@@ -59,79 +61,108 @@
  * we fix up irqs based on the slot number.
  * The first entry is at AD:11.
  * Fortunately this works because, although we have two pci buses,
- * they all have different slot numbers.
+ * they all have different slot numbers (except for rockhopper slot 20
+ * which is handled below).
  * 
- * This does not work for devices on sub-buses.
- *
- * Note that the irq number in the array is relative number in vrc5477.
- * We need to translate it to global irq number.
- */
-
-/*
- * irq mapping : PCI int # -> vrc5477 irq #
- * based on vrc5477 manual page 46
  */
-#define		PCI_EXT_INTA		8
-#define		PCI_EXT_INTB		9
-#define		PCI_EXT_INTC		10
-#define		PCI_EXT_INTD		11
-#define		PCI_EXT_INTE		12
-
-#define		PCI_IO_INTA		16
-#define		PCI_IO_INTB		17
-#define		PCI_IO_INTC		18
-#define		PCI_IO_INTD		19
 
 /* 
- * irq mapping : device -> pci int #, 
+ * irq mapping : device -> pci int # -> vrc4377 irq# , 
  * ddb5477 board manual page 4  and vrc5477 manual page 46
  */
-#define		INT_ONBOARD_TULIP	PCI_EXT_INTA
-#define		INT_SLOT1		PCI_EXT_INTB
-#define		INT_SLOT2		PCI_EXT_INTC
-#define		INT_SLOT3		PCI_EXT_INTD
-#define		INT_SLOT4		PCI_EXT_INTE
-
-#define		INT_USB_HOST		PCI_IO_INTA
-#define		INT_USB_PERI		PCI_IO_INTB
-#define		INT_AC97		PCI_IO_INTC
 
 /*
  * based on ddb5477 manual page 11
  */
 #define		MAX_SLOT_NUM		21
 static unsigned char irq_map[MAX_SLOT_NUM] = {
-	/* AD:11 */ 0xff, 0xff, 0xff, 0xff, 
-	/* AD:15 */ INT_ONBOARD_TULIP, INT_SLOT1, INT_SLOT2, INT_SLOT3,
-	/* AD:19 */ INT_SLOT4, 0xff, 0xff, 0xff,
-	/* AD:23 */ 0xff, 0xff, 0xff, 0xff,
-	/* AD:27 */ 0xff, 0xff, INT_AC97, INT_USB_PERI, 
-	/* AD:31 */ INT_USB_HOST
+	/* SLOT:  0, AD:11 */ 0xff,
+	/* SLOT:  1, AD:12 */ 0xff,
+	/* SLOT:  2, AD:13 */ 0xff,
+	/* SLOT:  3, AD:14 */ 0xff,
+	/* SLOT:  4, AD:15 */ VRC5477_IRQ_INTA,       /* onboard tulip */
+	/* SLOT:  5, AD:16 */ VRC5477_IRQ_INTB,       /* slot 1 */
+	/* SLOT:  6, AD:17 */ VRC5477_IRQ_INTC,       /* slot 2 */
+	/* SLOT:  7, AD:18 */ VRC5477_IRQ_INTD,       /* slot 3 */
+	/* SLOT:  8, AD:19 */ VRC5477_IRQ_INTE,       /* slot 4 */
+	/* SLOT:  9, AD:20 */ 0xff,
+	/* SLOT: 10, AD:21 */ 0xff,
+	/* SLOT: 11, AD:22 */ 0xff,
+	/* SLOT: 12, AD:23 */ 0xff,
+	/* SLOT: 13, AD:24 */ 0xff,
+	/* SLOT: 14, AD:25 */ 0xff,
+	/* SLOT: 15, AD:26 */ 0xff,
+	/* SLOT: 16, AD:27 */ 0xff,
+	/* SLOT: 17, AD:28 */ 0xff,
+	/* SLOT: 18, AD:29 */ VRC5477_IRQ_IOPCI_INTC, /* vrc5477 ac97 */
+	/* SLOT: 19, AD:30 */ VRC5477_IRQ_IOPCI_INTB, /* vrc5477 usb peri */
+	/* SLOT: 20, AD:31 */ VRC5477_IRQ_IOPCI_INTA, /* vrc5477 usb host */
+};
+static unsigned char rockhopperII_irq_map[MAX_SLOT_NUM] = {
+	/* SLOT:  0, AD:11 */ 0xff,
+	/* SLOT:  1, AD:12 */ VRC5477_IRQ_INTB,       /* onboard AMD PCNET */
+	/* SLOT:  2, AD:13 */ 0xff,
+	/* SLOT:  3, AD:14 */ 0xff,
+	/* SLOT:  4, AD:15 */ 14,                     /* M5229 ide ISA irq */
+	/* SLOT:  5, AD:16 */ VRC5477_IRQ_INTD,       /* slot 3 */
+	/* SLOT:  6, AD:17 */ VRC5477_IRQ_INTA,       /* slot 4 */
+	/* SLOT:  7, AD:18 */ VRC5477_IRQ_INTD,       /* slot 5 */
+	/* SLOT:  8, AD:19 */ 0,                      /* M5457 modem nop */
+	/* SLOT:  9, AD:20 */ VRC5477_IRQ_INTA,       /* slot 2 */
+	/* SLOT: 10, AD:21 */ 0xff,     
+	/* SLOT: 11, AD:22 */ 0xff,
+	/* SLOT: 12, AD:23 */ 0xff,
+	/* SLOT: 13, AD:24 */ 0xff,
+	/* SLOT: 14, AD:25 */ 0xff,
+	/* SLOT: 15, AD:26 */ 0xff,
+	/* SLOT: 16, AD:27 */ 0xff,
+	/* SLOT: 17, AD:28 */ 0,                      /* M7101 PMU nop */
+	/* SLOT: 18, AD:29 */ VRC5477_IRQ_IOPCI_INTC, /* vrc5477 ac97 */
+	/* SLOT: 19, AD:30 */ VRC5477_IRQ_IOPCI_INTB, /* vrc5477 usb peri */
+	/* SLOT: 20, AD:31 */ VRC5477_IRQ_IOPCI_INTA, /* vrc5477 usb host */
 };
 
-extern int vrc5477_irq_to_irq(int irq);
 void __init pcibios_fixup_irqs(void)
 {
         struct pci_dev *dev;
         int slot_num;
+        unsigned char *slot_irq_map;
+        unsigned char irq;
+
+	if (mips_machtype == MACH_NEC_ROCKHOPPERII)
+		slot_irq_map = rockhopperII_irq_map;
+	else
+		slot_irq_map = irq_map;
+
 
 	pci_for_each_dev(dev) {
 		slot_num = PCI_SLOT(dev->devfn);
-
-               /* we don't do IRQ fixup for sub-bus yet */
-               if (dev->bus->parent != NULL) {
-                       db_run(printk("Don't know how to fixup irq for PCI device %d on sub-bus %d\n",
-                                       slot_num, dev->bus->number));
-                       continue;
-               }
+		irq = slot_irq_map[slot_num];
 
 		db_assert(slot_num < MAX_SLOT_NUM);
-		db_assert(irq_map[slot_num] != 0xff);
+
+                db_assert(irq != 0xff);
 
 		pci_write_config_byte(dev, 
 				      PCI_INTERRUPT_LINE,
-				      irq_map[slot_num]);
-		dev->irq = vrc5477_irq_to_irq(irq_map[slot_num]);
+				      irq);
+
+		dev->irq = irq;
+
+		if (mips_machtype == MACH_NEC_ROCKHOPPERII) {
+			/* hack to distinquish overlapping slot 20s, one
+			 * on bus 0 (ALI USB on the M1535 on the backplane), 
+			 * and one on bus 2 (NEC USB controller on the CPU board)
+			 * Make the M1535 USB - ISA IRQ number 9.
+			 */
+			if (slot_num == 20 && dev->bus->number == 0) {
+				pci_write_config_byte(dev, 
+						      PCI_INTERRUPT_LINE,
+						      9);
+				dev->irq = 9;
+			}
+		}
+
 	}
 }
 
@@ -139,7 +170,7 @@
 extern void jsun_scan_pci_bus(void);
 extern void jsun_assign_pci_resource(void);
 #endif
-void __init ddb_pci_reset_bus(void)
+void ddb_pci_reset_bus(void)
 {	
 	u32 temp;
 
@@ -175,5 +206,43 @@
 
 void __init pcibios_fixup(void)
 {
+	if (mips_machtype == MACH_NEC_ROCKHOPPERII) {
+		struct pci_dev *dev;
+
+#define M1535_CONFIG_PORT 0x3f0
+#define M1535_INDEX_PORT  0x3f0
+#define M1535_DATA_PORT   0x3f1
+
+		printk("Configuring ALI M1535 Super I/O mouse irq.\n");
+
+		request_region(M1535_CONFIG_PORT, 2, "M1535 Super I/O config");
+
+		/* Enter config mode. */
+		outb(0x51, M1535_CONFIG_PORT);
+		outb(0x23, M1535_CONFIG_PORT);
+
+		/* Select device 0x07. */
+		outb(0x07, M1535_INDEX_PORT);
+		outb(0x07, M1535_DATA_PORT);
+
+		/* Set mouse irq (register 0x72) to 12. */
+		outb(0x72, M1535_INDEX_PORT);
+		outb(0x0c, M1535_DATA_PORT);
+
+		/* Exit config mode. */
+		outb(0xbb, M1535_CONFIG_PORT);
+
+		pci_for_each_dev(dev) { 
+			if(dev->vendor == PCI_VENDOR_ID_AL)
+				if(dev->device == PCI_DEVICE_ID_AL_M1535
+				    || dev->device == PCI_DEVICE_ID_AL_M1533) {
+				u8 old;
+				printk("Enabling ALI M1533/35 PS2 keyboard/mouse.\n");
+				pci_read_config_byte(dev, 0x41, &old);
+				pci_write_config_byte(dev, 0x41, old | 0xd0);
+			}
+		}
+		
+	}
 }
 
diff -Nru linux/arch/mips/ddb5xxx/ddb5477/setup.c.orig linux/arch/mips/ddb5xxx/ddb5477/setup.c
--- linux/arch/mips/ddb5xxx/ddb5477/setup.c.orig	Tue Jul  9 15:05:24 2002
+++ linux/arch/mips/ddb5xxx/ddb5477/setup.c	Tue Jul  9 17:34:09 2002
@@ -24,6 +24,7 @@
 #include <linux/ioport.h>
 #include <linux/param.h>	/* for HZ */
 
+#include <asm/cpu.h>
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
 #include <asm/time.h>
@@ -31,8 +32,11 @@
 #include <asm/irq.h>
 #include <asm/reboot.h>
 #include <asm/gdb-stub.h>
-#include <asm/debug.h>
 #include <asm/traps.h>
+#include <asm/debug.h>
+#ifdef CONFIG_PC_KEYB
+#include <asm/keyboard.h> 
+#endif 
 
 #include <asm/ddb5xxx/ddb5xxx.h>
 
@@ -41,15 +45,13 @@
 
 // #define	USE_CPU_COUNTER_TIMER	/* whether we use cpu counter */
 
-#ifdef USE_CPU_COUNTER_TIMER
-#define	CPU_COUNTER_FREQUENCY		83000000
-#else
-/* otherwise we use special timer 1 */
-#define	SP_TIMER_FREQUENCY		83000000
+#ifndef USE_CPU_COUNTER_TIMER
 #define	SP_TIMER_BASE			DDB_SPT1CTRL_L
-#define	SP_TIMER_IRQ			(8 + 6)
+#define	SP_TIMER_IRQ			VRC5477_IRQ_SPT1
 #endif
 
+static int bus_frequency = CONFIG_DDB5477_BUS_FREQUENCY*1000;
+
 static void ddb_machine_restart(char *command)
 {
 	static void (*back_to_prom) (void) = (void (*)(void)) 0xbfc00000;
@@ -80,19 +82,71 @@
 	while (1);
 }
 
+static unsigned int __init detect_bus_frequency(unsigned long rtc_base)
+{
+	unsigned int freq;
+	unsigned char c;
+	unsigned int t1, t2;
+	unsigned i;
+	unsigned preset_freq[]={
+		0,        83330000, 100000000, 124000000,133300000, 0xffffffff};
+
+	ddb_out32(SP_TIMER_BASE, 0xffffffff);
+	ddb_out32(SP_TIMER_BASE+4, 0x1);
+	ddb_out32(SP_TIMER_BASE+8, 0xffffffff);
+	c= *(volatile unsigned char*)rtc_base;
+	for(i=0; (i<100000000) && (c == *(volatile unsigned char*)rtc_base); i++);
+
+	if (c == *(volatile unsigned char*)rtc_base) {
+		printk("Failed to detect bus frequency.  Use default 83.3MHz.\n");
+		return 83333000;
+	}
+
+	/* we are now at the turn of 1/100th second */
+	t1 = ddb_in32(SP_TIMER_BASE+8);
+
+	c= *(volatile unsigned char*)rtc_base;
+	while (c == *(volatile unsigned char*)rtc_base);
+
+	/* we are now at the turn of another 1/100th second */
+	t2 = ddb_in32(SP_TIMER_BASE+8);
+	ddb_out32(SP_TIMER_BASE+4, 0x0);	/* disable it again */
+	freq = (t1 - t2)*100;
+
+	/* find the nearest preset freq */
+	for (i=0; freq > preset_freq[i+1]; i++);
+	if ((freq - preset_freq[i]) >= (preset_freq[i+1]-freq)) 
+		i++;
+
+	printk("DDB bus frequency detection : %d -> %d\n", freq, preset_freq[i]);
+	return preset_freq[i];
+}
+
 extern void rtc_ds1386_init(unsigned long base);
 static void __init ddb_time_init(void)
 {
-#if defined(USE_CPU_COUNTER_TIMER)
-	mips_counter_frequency = CPU_COUNTER_FREQUENCY;
-#endif
+	unsigned long rtc_base;
+	unsigned int i;
 
 	/* we have ds1396 RTC chip */
-	if (mips_machtype == MACH_NEC_ROCKHOPPER) {
-		rtc_ds1386_init(KSEG1ADDR(DDB_LCS2_BASE));
+	if (mips_machtype == MACH_NEC_ROCKHOPPER
+	   ||  mips_machtype == MACH_NEC_ROCKHOPPERII) {
+		rtc_base = KSEG1ADDR(DDB_LCS2_BASE);
 	} else {
-		rtc_ds1386_init(KSEG1ADDR(DDB_LCS1_BASE));
+		rtc_base = KSEG1ADDR(DDB_LCS1_BASE);
+	}
+	rtc_ds1386_init(rtc_base);
+
+	/* do we need to do run-time detection of bus speed? */
+	if (bus_frequency == 0) {
+		bus_frequency = detect_bus_frequency(rtc_base);
 	}
+
+	/* mips_counter_frequency is 1/2 of the cpu core freq */
+	i =  (read_32bit_cp0_register(CP0_CONFIG) >> 28 ) & 7;
+	if ((mips_cpu.cputype == CPU_R5432) && (i == 3)) 
+		i = 4;
+	mips_counter_frequency = bus_frequency*(i+4)/4;
 }
 
 extern int setup_irq(unsigned int irq, struct irqaction *irqaction);
@@ -102,7 +156,7 @@
 	unsigned int count;
 
         /* we are using the cpu counter for timer interrupts */
-	setup_irq(7, irq);
+	setup_irq(CPU_IRQ_BASE + 7, irq);
 
         /* to generate the first timer interrupt */
         count = read_32bit_cp0_register(CP0_COUNT);
@@ -110,18 +164,16 @@
 
 #else
 
-	/* if we don't use Special purpose timer 1 */
-	ddb_out32(SP_TIMER_BASE, SP_TIMER_FREQUENCY/HZ);
+	/* if we use Special purpose timer 1 */
+	ddb_out32(SP_TIMER_BASE, bus_frequency/HZ);
 	ddb_out32(SP_TIMER_BASE+4, 0x1);
 	setup_irq(SP_TIMER_IRQ, irq);
 
 #endif
 }
 
-
 void __init bus_error_init(void) { /* nothing */ }
 
-
 static void ddb5477_board_init(void);
 extern void ddb5477_irq_setup(void);
 
@@ -132,6 +184,12 @@
 void __init ddb_setup(void)
 {
 	extern int panic_timeout;
+#ifdef CONFIG_BLK_DEV_IDE
+	extern struct ide_ops std_ide_ops;   
+#endif
+
+	/* initialize board - we don't trust the loader */
+        ddb5477_board_init();
 
 	irq_setup = ddb5477_irq_setup;
 	set_io_port_base(KSEG1ADDR(DDB_PCI_IO_BASE));
@@ -150,13 +208,15 @@
 	/* Reboot on panic */
 	panic_timeout = 180;
 
+#ifdef CONFIG_BLK_DEV_IDE
+	ide_ops = &std_ide_ops;
+#endif
+
+
 #ifdef CONFIG_FB
 	conswitchp = &dummy_con;
 #endif
 
-	/* initialize board - we don't trust the loader */
-	ddb5477_board_init();
-
 #if defined(CONFIG_BLK_DEV_INITRD)
 	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
 	initrd_start = (unsigned long)&__rd_start;
@@ -166,6 +226,9 @@
 
 static void __init ddb5477_board_init()
 {
+#ifdef CONFIG_PC_KEYB
+	extern struct kbd_ops std_kbd_ops;   
+#endif
 	/* ----------- setup PDARs ------------ */
 
 	/* SDRAM should have been set */
@@ -261,16 +324,117 @@
 	ddb_set_pdar(DDB_BARP01, DDB_PCI0_MEM_BASE, DDB_PCI0_MEM_SIZE, 32, 0, 1);
 	ddb_set_pdar(DDB_BARP11, DDB_PCI0_IO_BASE, DDB_PCI0_IO_SIZE, 32, 0, 1);
 
+	if (mips_machtype == MACH_NEC_ROCKHOPPER
+	   ||  mips_machtype == MACH_NEC_ROCKHOPPERII) {
+		/* Disable bus diagnostics. */ 
+		ddb_out32(DDB_PCICTL0_L, 0);
+		ddb_out32(DDB_PCICTL0_H, 0);
+		ddb_out32(DDB_PCICTL1_L, 0);
+		ddb_out32(DDB_PCICTL1_H, 0);         
+	}
+
+	if (mips_machtype == MACH_NEC_ROCKHOPPER) {
+		u16			vid;
+		struct pci_bus		bus;
+		struct pci_dev		dev_m1533;
+		extern struct pci_ops 	ddb5477_ext_pci_ops;
+
+		bus.parent      = NULL;    /* we scan the top level only */
+		bus.ops         = &ddb5477_ext_pci_ops;
+		dev_m1533.bus         = &bus;
+		dev_m1533.sysdata     = NULL;
+		dev_m1533.devfn       = 7*8;     // slot 7: M1533 SouthBridge.
+		pci_read_config_word(&dev_m1533, 0, &vid);
+		if (vid == PCI_VENDOR_ID_AL) {
+			printk("Changing mips_machtype to MACH_NEC_ROCKHOPPERII\n");
+			mips_machtype = MACH_NEC_ROCKHOPPERII;
+		}
+	}
+
 	/* enable USB input buffers */
 	ddb_out32(DDB_PIBMISC, 0x00000007);
 
 	/* For dual-function pins, make them all non-GPIO */
 	ddb_out32(DDB_GIUFUNSEL, 0x0);
 	// ddb_out32(DDB_GIUFUNSEL, 0xfe0fcfff);  /* NEC recommanded value */
+	
+	if (mips_machtype == MACH_NEC_ROCKHOPPERII) {
+#ifdef CONFIG_PC_KEYB
+	printk("kdb_ops is std\n");
+	kbd_ops = &std_kbd_ops;
+#endif                     
+	}
 
-	if (mips_machtype == MACH_NEC_ROCKHOPPER) {
+	if (mips_machtype == MACH_NEC_ROCKHOPPERII) {
+
+		/* enable IDE controller on Ali chip (south bridge) */
+		u8			temp8;
+		struct pci_bus		bus;
+		struct pci_dev		dev_m1533;
+		struct pci_dev		dev_m5229;
+		extern struct pci_ops 	ddb5477_ext_pci_ops;
+
+		/* Setup M1535 registers */
+		bus.parent      = NULL;    /* we scan the top level only */
+		bus.ops         = &ddb5477_ext_pci_ops;
+		dev_m1533.bus         = &bus;
+		dev_m1533.sysdata     = NULL;
+		dev_m1533.devfn       = 7*8;     // slot 7: M1533 SouthBridge.
+
+		/* setup IDE controller
+		 * enable IDE controller (bit 6 - 1)
+		 * IDE IDSEL to be addr:A15 (bit 4:5 - 11)
+		 * disable IDE ATA Secondary Bus Signal Pad Control (bit 3 - 0)
+		 * enable IDE ATA Primary Bus Signal Pad Control (bit 2 - 1)
+		 */
+		pci_write_config_byte(&dev_m1533, 0x58, 0x74);
+
+		/* 
+		 * positive decode (bit6 -0)
+		 * enable IDE controler interrupt (bit 4 -1)
+		 * setup SIRQ to point to IRQ 14 (bit 3:0 - 1101)
+		 */
+		pci_write_config_byte(&dev_m1533, 0x44, 0x1d);
+
+		/* Setup M5229 registers */
+		dev_m5229.bus = &bus;
+		dev_m5229.sysdata = NULL;
+		dev_m5229.devfn = 4*8;  	// slot 4 (AD15): M5229 IDE 
+
+		/*
+		 * enable IDE in the M5229 config register 0x50 (bit 0 - 1)
+		 * M5229 IDSEL is addr:15; see above setting 
+		 */
+		pci_read_config_byte(&dev_m5229, 0x50, &temp8);
+		pci_write_config_byte(&dev_m5229, 0x50, temp8 | 0x1);
+
+		/* 
+		 * enable bus master (bit 2)  and IO decoding  (bit 0) 
+		 */
+		pci_read_config_byte(&dev_m5229, 0x04, &temp8);
+		pci_write_config_byte(&dev_m5229, 0x04, temp8 | 0x5);
+
+		/*
+		 * enable native, copied from arch/ppc/k2boot/head.S
+		 * TODO - need volatile, need to be portable 
+		 */
+		pci_write_config_byte(&dev_m5229, 0x09, 0xef);
+
+		/* Set Primary Channel Command Block Timing */ 
+		pci_write_config_byte(&dev_m5229, 0x59, 0x31);
+
+		/* 
+		 * Enable primary channel 40-pin cable
+		 * M5229 register 0x4a (bit 0)
+		 */
+		pci_read_config_byte(&dev_m5229, 0x4a, &temp8);
+		pci_write_config_byte(&dev_m5229, 0x4a, temp8 | 0x1);
+	}
+
+	if (mips_machtype == MACH_NEC_ROCKHOPPER
+	   ||  mips_machtype == MACH_NEC_ROCKHOPPERII) {
 		printk("lcd44780: initializing\n");
 		lcd44780_init();
-		lcd44780_puts("Linux/MIPS rolls");
+		lcd44780_puts("MontaVista Linux");
 	}
 }
diff -Nru linux/arch/mips/ddb5xxx/ddb5477/pci_ops.c.orig linux/arch/mips/ddb5xxx/ddb5477/pci_ops.c
--- linux/arch/mips/ddb5xxx/ddb5477/pci_ops.c.orig	Fri Nov 16 02:54:42 2001
+++ linux/arch/mips/ddb5xxx/ddb5477/pci_ops.c	Tue Jul  9 18:45:53 2002
@@ -300,114 +300,3 @@
 	iopci_write_config_dword
 };
 
-#if defined(CONFIG_DEBUG)
-void jsun_scan_pci_bus(void)
-{
-	struct pci_bus bus;
-	struct pci_dev dev;
-	unsigned int devfn;
-	int j;
-
-	bus.parent = NULL;	/* we scan the top level only */
-	dev.bus = &bus;
-	dev.sysdata = NULL;
-
-	/* scan ext pci bus and io pci bus*/
-	for (j=0; j< 2; j++) {
-		if (j ==  0) {
-			printk("scan ddb5477 external PCI bus:\n");
-			bus.ops = &ddb5477_ext_pci_ops;
-		} else {
-			printk("scan ddb5477 IO PCI bus:\n");
-			bus.ops = &ddb5477_io_pci_ops;
-		}
-	
-		for (devfn = 0; devfn < 0x100; devfn += 8) {
-			u32 temp;
-			u16 temp16;
-			u8 temp8;
-			int i;
-
-			dev.devfn = devfn;
-			db_verify(pci_read_config_dword(&dev, 0, &temp),
-				  == PCIBIOS_SUCCESSFUL);
-			if (temp == 0xffffffff) continue;
-
-			printk("slot %d: (addr %d) \n", devfn/8, 11+devfn/8);
-
-			/* verify read word and byte */
-			db_verify(pci_read_config_word(&dev, 2, &temp16),
-				  == PCIBIOS_SUCCESSFUL);
-			db_assert(temp16 == (temp >> 16));
-			db_verify(pci_read_config_byte(&dev, 3, &temp8),
-				  == PCIBIOS_SUCCESSFUL);
-			db_assert(temp8 == (temp >> 24));
-			db_verify(pci_read_config_byte(&dev, 1, &temp8),
-				  == PCIBIOS_SUCCESSFUL);
-			db_assert(temp8 == ((temp >> 8) & 0xff));
-
-			for (i=0; i < 16; i++) {
-				db_verify(pci_read_config_dword(&dev, i*4, &temp),
-					  == PCIBIOS_SUCCESSFUL);
-				printk("\t%08X", temp);
-				if ((i%4) == 3) printk("\n");
-			}
-		}
-	}
-}
-
-
-static void jsun_hardcode_pci_resources_eepro(void)
-{
-	struct pci_bus bus;
-	struct pci_dev dev;
-	u32 temp;
-
-	bus.parent = NULL;	/* we scan the top level only */
-	bus.ops = &ddb5477_ext_pci_ops;
-	dev.bus = &bus;
-	dev.sysdata = NULL;
-
-	/* for slot 5 (ext pci 1) eepro card */
-	dev.devfn = 5*8;
-	pci_read_config_dword(&dev, 0, &temp);
-	db_assert(temp == 0x12298086);
-
-	pci_write_config_dword(&dev, PCI_BASE_ADDRESS_0, DDB_PCI0_MEM_BASE);
-	pci_write_config_dword(&dev, PCI_BASE_ADDRESS_1, 0);
-	pci_write_config_dword(&dev, PCI_BASE_ADDRESS_2, DDB_PCI0_MEM_BASE+0x100000);
-	pci_write_config_dword(&dev, PCI_INTERRUPT_LINE, 17);
-}
-
-static void jsun_hardcode_pci_resources_onboard_tulip(void)
-{
-	struct pci_bus bus;
-	struct pci_dev dev;
-	u32 temp;
-
-	bus.parent = NULL;	/* we scan the top level only */
-	bus.ops = &ddb5477_ext_pci_ops;
-	dev.bus = &bus;
-	dev.sysdata = NULL;
-
-	/* for slot 4 on board ether chip */
-	dev.devfn = 4*8;
-	pci_read_config_dword(&dev, 0, &temp);
-	db_assert(temp == 0x00191011);
-
-	pci_write_config_dword(&dev, PCI_BASE_ADDRESS_0, 0x1000);
-	pci_write_config_dword(&dev, PCI_BASE_ADDRESS_1, DDB_PCI0_MEM_BASE);
-	pci_write_config_dword(&dev, PCI_INTERRUPT_LINE, 16);
-}
-
-static void jsun_hardcode_pci_resources(void)
-{
-	jsun_hardcode_pci_resources_onboard_tulip();
-}
-
-void jsun_assign_pci_resource(void)
-{
-	jsun_hardcode_pci_resources();
-}
-
-#endif
diff -Nru linux/arch/mips/Makefile.orig linux/arch/mips/Makefile
--- linux/arch/mips/Makefile.orig	Tue Jul  9 15:05:23 2002
+++ linux/arch/mips/Makefile	Tue Jul  9 15:18:31 2002
@@ -294,7 +294,7 @@
 SUBDIRS		+= arch/mips/ddb5xxx/common arch/mips/ddb5xxx/ddb5477
 LIBS		+= arch/mips/ddb5xxx/common/ddb5xxx.o \
 		   arch/mips/ddb5xxx/ddb5477/ddb5477.o
-LOADADDR	:= 0x80080000
+LOADADDR	:= 0x80100000
 endif
 
 #
diff -Nru linux/arch/mips/config.in.orig linux/arch/mips/config.in
--- linux/arch/mips/config.in.orig	Tue Jul  9 15:05:23 2002
+++ linux/arch/mips/config.in	Tue Jul  9 18:21:21 2002
@@ -55,6 +55,9 @@
 dep_bool 'Support for NEC DDB Vrc-5074 (EXPERIMENTAL)' CONFIG_DDB5074 $CONFIG_EXPERIMENTAL
 bool 'Support for NEC DDB Vrc-5476' CONFIG_DDB5476
 bool 'Support for NEC DDB Vrc-5477' CONFIG_DDB5477
+if [ "$CONFIG_DDB5477" = "y" ]; then
+      int '   bus frequency (in kHZ, 0 for auto-detect)' CONFIG_DDB5477_BUS_FREQUENCY 0
+fi
 bool 'Support for NEC Osprey board' CONFIG_NEC_OSPREY
 bool 'Support for Olivetti M700-10' CONFIG_OLIVETTI_M700
 dep_bool 'Support for Philips Nino (EXPERIMENTAL)' CONFIG_NINO $CONFIG_EXPERIMENTAL
@@ -251,6 +254,7 @@
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI_AUTO y
    define_bool CONFIG_DUMMY_KEYB y
+   define_bool CONFIG_I8259 y
 fi
 if [ "$CONFIG_NEC_OSPREY" = "y" ]; then
    define_bool CONFIG_VR4181 y
diff -Nru linux/arch/mips/defconfig-ddb5477.orig linux/arch/mips/defconfig-ddb5477
--- linux/arch/mips/defconfig-ddb5477.orig	Tue Jul  9 15:05:23 2002
+++ linux/arch/mips/defconfig-ddb5477	Wed Jul 10 13:56:19 2002
@@ -36,6 +36,7 @@
 # CONFIG_DDB5074 is not set
 # CONFIG_DDB5476 is not set
 CONFIG_DDB5477=y
+CONFIG_DDB5477_BUS_FREQUENCY=0
 # CONFIG_NEC_OSPREY is not set
 # CONFIG_OLIVETTI_M700 is not set
 # CONFIG_NINO is not set
@@ -54,6 +55,7 @@
 CONFIG_NONCOHERENT_IO=y
 CONFIG_PCI_AUTO=y
 CONFIG_DUMMY_KEYB=y
+CONFIG_I8259=y
 # CONFIG_MIPS_AU1000 is not set
 
 #
@@ -264,7 +266,7 @@
 # CONFIG_HP100 is not set
 # CONFIG_NET_ISA is not set
 CONFIG_NET_PCI=y
-# CONFIG_PCNET32 is not set
+CONFIG_PCNET32=y
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_APRICOT is not set
 # CONFIG_CS89x0 is not set
diff -Nru linux/include/asm-mips/ddb5xxx/ddb5477.h.orig linux/include/asm-mips/ddb5xxx/ddb5477.h
--- linux/include/asm-mips/ddb5xxx/ddb5477.h.orig	Tue Jul  9 15:13:10 2002
+++ linux/include/asm-mips/ddb5xxx/ddb5477.h	Tue Jul  9 18:38:08 2002
@@ -216,6 +216,7 @@
 /*
  * DDB5477 specific functions
  */
+#ifndef __ASSEMBLY__
 extern void ddb5477_irq_setup(void);
 
 /* route irq to cpu int pin */
@@ -224,10 +225,110 @@
 /* low-level routine for enabling vrc5477 irq, bypassing high-level */
 extern void ll_vrc5477_irq_enable(int vrc5477_irq);
 extern void ll_vrc5477_irq_disable(int vrc5477_irq);
+#endif /* !__ASSEMBLY__ */
+
+/* PCI intr ack share PCIW0 with PCI IO */
+#define	DDB_PCI_IACK_BASE	DDB_PCI_IO_BASE
+
+/*
+ * Interrupt mapping
+ *
+ * We have three interrupt controllers:
+ *
+ *   . CPU itself - 8 sources
+ *   . i8259 - 16 sources
+ *   . vrc5477 - 32 sources
+ *
+ *  They connected as follows:
+ *    all vrc5477 interrupts are routed to cpu IP2 (by software setting)
+ *    all i8359 are routed to INTC in vrc5477 (by hardware connection)
+ *
+ *  All VRC5477 PCI interrupts are level-triggered (no ack needed).
+ *  All PCI irq but INTC are active low.
+ */
+
+/* 
+ * irq number block assignment
+ */
+
+#define	NUM_CPU_IRQ		8
+#define	NUM_I8259_IRQ		16
+#define	NUM_VRC5477_IRQ		32
+
+#define	DDB_IRQ_BASE		0
+
+#define	I8259_IRQ_BASE		DDB_IRQ_BASE
+#define	VRC5477_IRQ_BASE	(I8259_IRQ_BASE + NUM_I8259_IRQ)
+#define	CPU_IRQ_BASE		(VRC5477_IRQ_BASE + NUM_VRC5477_IRQ)
+
+/*
+ * vrc5477 irq defs
+ */
+
+#define VRC5477_IRQ_CPCE	(0 + VRC5477_IRQ_BASE)	/* cpu parity error */
+#define VRC5477_IRQ_CNTD	(1 + VRC5477_IRQ_BASE)	/* cpu no target */
+#define VRC5477_IRQ_I2C		(2 + VRC5477_IRQ_BASE)	/* I2C */
+#define VRC5477_IRQ_DMA		(3 + VRC5477_IRQ_BASE)	/* DMA */
+#define VRC5477_IRQ_UART0	(4 + VRC5477_IRQ_BASE)
+#define VRC5477_IRQ_WDOG	(5 + VRC5477_IRQ_BASE)	/* watchdog timer */
+#define VRC5477_IRQ_SPT1	(6 + VRC5477_IRQ_BASE)    /* special purpose timer 1 */
+#define VRC5477_IRQ_LBRT	(7 + VRC5477_IRQ_BASE)	/* local bus read timeout */
+#define VRC5477_IRQ_INTA	(8 + VRC5477_IRQ_BASE)	/* PCI INT #A */
+#define VRC5477_IRQ_INTB	(9 + VRC5477_IRQ_BASE)	/* PCI INT #B */
+#define VRC5477_IRQ_INTC	(10 + VRC5477_IRQ_BASE)	/* PCI INT #C */
+#define VRC5477_IRQ_INTD	(11 + VRC5477_IRQ_BASE)	/* PCI INT #D */
+#define VRC5477_IRQ_INTE	(12 + VRC5477_IRQ_BASE)	/* PCI INT #E */
+#define VRC5477_IRQ_RESERVED_13	(13 + VRC5477_IRQ_BASE)	/* reserved  */
+#define VRC5477_IRQ_PCIS	(14 + VRC5477_IRQ_BASE)	/* PCI SERR #  */
+#define VRC5477_IRQ_PCI		(15 + VRC5477_IRQ_BASE)	/* PCI internal error */
+#define VRC5477_IRQ_IOPCI_INTA	(16 + VRC5477_IRQ_BASE)      /* USB-H */
+#define VRC5477_IRQ_IOPCI_INTB	(17 + VRC5477_IRQ_BASE)      /* USB-P */
+#define VRC5477_IRQ_IOPCI_INTC	(18 + VRC5477_IRQ_BASE)      /* AC97 */
+#define VRC5477_IRQ_IOPCI_INTD	(19 + VRC5477_IRQ_BASE)      /* Reserved */
+#define VRC5477_IRQ_UART1	(20 + VRC5477_IRQ_BASE)     
+#define VRC5477_IRQ_SPT0	(21 + VRC5477_IRQ_BASE)      /* special purpose timer 0 */
+#define VRC5477_IRQ_GPT0	(22 + VRC5477_IRQ_BASE)      /* general purpose timer 0 */
+#define VRC5477_IRQ_GPT1	(23 + VRC5477_IRQ_BASE)      /* general purpose timer 1 */
+#define VRC5477_IRQ_GPT2	(24 + VRC5477_IRQ_BASE)      /* general purpose timer 2 */
+#define VRC5477_IRQ_GPT3	(25 + VRC5477_IRQ_BASE)      /* general purpose timer 3 */
+#define VRC5477_IRQ_GPIO	(26 + VRC5477_IRQ_BASE)
+#define VRC5477_IRQ_SIO0	(27 + VRC5477_IRQ_BASE)
+#define VRC5477_IRQ_SIO1        (28 + VRC5477_IRQ_BASE)
+#define VRC5477_IRQ_RESERVED_29 (29 + VRC5477_IRQ_BASE)      /* reserved */
+#define VRC5477_IRQ_IOPCISERR	(30 + VRC5477_IRQ_BASE)      /* IO PCI SERR # */
+#define VRC5477_IRQ_IOPCI	(31 + VRC5477_IRQ_BASE)
+
+/*
+ * i2859 irq assignment
+ */
+#define I8259_IRQ_RESERVED_0	(0 + I8259_IRQ_BASE)	
+#define I8259_IRQ_KEYBOARD	(1 + I8259_IRQ_BASE)	/* M1543 default */
+#define I8259_IRQ_CASCADE	(2 + I8259_IRQ_BASE)
+#define I8259_IRQ_UART_B	(3 + I8259_IRQ_BASE)	/* M1543 default, may conflict with RTC according to schematic diagram  */
+#define I8259_IRQ_UART_A	(4 + I8259_IRQ_BASE)	/* M1543 default */
+#define I8259_IRQ_PARALLEL	(5 + I8259_IRQ_BASE)	/* M1543 default */
+#define I8259_IRQ_RESERVED_6	(6 + I8259_IRQ_BASE)
+#define I8259_IRQ_RESERVED_7	(7 + I8259_IRQ_BASE)
+#define I8259_IRQ_RTC		(8 + I8259_IRQ_BASE)	/* who set this? */
+#define I8259_IRQ_USB		(9 + I8259_IRQ_BASE)	/* ddb_setup */
+#define I8259_IRQ_PMU		(10 + I8259_IRQ_BASE)	/* ddb_setup */
+#define I8259_IRQ_RESERVED_11	(11 + I8259_IRQ_BASE)
+#define I8259_IRQ_RESERVED_12	(12 + I8259_IRQ_BASE)	/* m1543_irq_setup */
+#define I8259_IRQ_RESERVED_13	(13 + I8259_IRQ_BASE)
+#define I8259_IRQ_HDC1		(14 + I8259_IRQ_BASE)	/* default and ddb_setup */
+#define I8259_IRQ_HDC2		(15 + I8259_IRQ_BASE)	/* default */
+
+
+/*
+ * misc
+ */
+#define	VRC5477_I8259_CASCADE	(VRC5477_IRQ_INTC - VRC5477_IRQ_BASE)
+#define	CPU_VRC5477_CASCADE	2
 
 /* 
  * debug routines
  */
+#ifndef __ASSEMBLY__
 #if defined(CONFIG_DEBUG)
 extern void vrc5477_show_pdar_regs(void);
 extern void vrc5477_show_pci_regs(void);
@@ -240,5 +341,6 @@
  * RAM size
  */
 extern int board_ram_size;
+#endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_DDB5XXX_DDB5477_H */
diff -Nru linux/include/asm-mips/bootinfo.h.orig linux/include/asm-mips/bootinfo.h
--- linux/include/asm-mips/bootinfo.h.orig	Tue Jul  9 15:13:03 2002
+++ linux/include/asm-mips/bootinfo.h	Tue Jul  9 17:57:18 2002
@@ -100,6 +100,7 @@
 #define MACH_NEC_DDB5476         1      /* NEC DDB Vrc-5476 */
 #define MACH_NEC_DDB5477         2      /* NEC DDB Vrc-5477 */
 #define MACH_NEC_ROCKHOPPER      3      /* Rockhopper base board */
+#define MACH_NEC_ROCKHOPPERII    4      /* Rockhopper II base board */
 
 /*
  * Valid machtype for group BAGET
diff -Nru linux/include/asm-mips/serial.h.orig linux/include/asm-mips/serial.h
--- linux/include/asm-mips/serial.h.orig	Tue Jul  9 18:22:04 2002
+++ linux/include/asm-mips/serial.h	Tue Jul  9 18:54:14 2002
@@ -268,12 +268,13 @@
 #endif
 
 #ifdef CONFIG_DDB5477
-#define DDB5477_SERIAL_PORT_DEFNS                                       \
-        { baud_base: BASE_BAUD, irq: 12, flags: STD_COM_FLAGS,          \
-          iomem_base: (u8*)0xbfa04200, iomem_reg_shift: 3,              \
+#include <asm/ddb5xxx/ddb5477.h>
+#define DDB5477_SERIAL_PORT_DEFNS                                             \
+        { baud_base: BASE_BAUD, irq: VRC5477_IRQ_UART0, flags: STD_COM_FLAGS, \
+          iomem_base: (u8*)0xbfa04200, iomem_reg_shift: 3,                    \
           io_type: SERIAL_IO_MEM},\
-        { baud_base: BASE_BAUD, irq: 28, flags: STD_COM_FLAGS,          \
-          iomem_base: (u8*)0xbfa04240, iomem_reg_shift: 3,              \
+        { baud_base: BASE_BAUD, irq: VRC5477_IRQ_UART1, flags: STD_COM_FLAGS, \
+          iomem_base: (u8*)0xbfa04240, iomem_reg_shift: 3,                    \
           io_type: SERIAL_IO_MEM},
 #else
 #define DDB5477_SERIAL_PORT_DEFNS
diff -Nru linux/include/linux/pci_ids.h.orig linux/include/linux/pci_ids.h
--- linux/include/linux/pci_ids.h.orig	Tue Jul  9 15:07:04 2002
+++ linux/include/linux/pci_ids.h	Tue Jul  9 18:14:36 2002
@@ -811,6 +811,7 @@
 #define PCI_DEVICE_ID_AL_M1523		0x1523
 #define PCI_DEVICE_ID_AL_M1531		0x1531
 #define PCI_DEVICE_ID_AL_M1533		0x1533
+#define PCI_DEVICE_ID_AL_M1535 		0x1535
 #define PCI_DEVICE_ID_AL_M1541		0x1541
 #define PCI_DEVICE_ID_AL_M1621          0x1621
 #define PCI_DEVICE_ID_AL_M1631          0x1631

--------------080905060902040806040503--
