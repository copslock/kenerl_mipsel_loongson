Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Feb 2005 14:54:49 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:14209 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225756AbVBTOyb>; Sun, 20 Feb 2005 14:54:31 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1D2sTb-0006vf-00; Sun, 20 Feb 2005 14:54:27 +0000
Date:	Sun, 20 Feb 2005 14:54:27 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2.6] Cobalt fixes [1 of 6]
Message-ID: <20050220145427.GA26582@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Patch to add 2.6.x support for MIPs based Qubes/RaQs.

P.

--- linux-cvs/arch/mips/Makefile	2005-01-30 03:55:14.000000000 +0000
+++ linux-wip/arch/mips/Makefile	2005-02-20 13:48:22.000000000 +0000
@@ -324,6 +324,7 @@ load-$(CONFIG_MIPS_XXS1500)	+= 0xfffffff
 # Cobalt Server
 #
 core-$(CONFIG_MIPS_COBALT)	+= arch/mips/cobalt/
+cflags-$(CONFIG_MIPS_COBALT)	+= -Iinclude/asm-mips/cobalt
 load-$(CONFIG_MIPS_COBALT)	+= 0xffffffff80080000
 
 #
--- linux-cvs/include/asm-mips/cobalt/cobalt.h	2003-11-13 16:56:16.000000000 +0000
+++ linux-wip/include/asm-mips/cobalt/cobalt.h	2005-02-20 13:48:22.000000000 +0000
@@ -19,7 +19,10 @@
  *     9  - PCI
  *    14  - IDE0
  *    15  - IDE1
- *
+ */
+#define COBALT_QUBE_SLOT_IRQ	9
+
+/*
  * CPU IRQs  are 16 ... 23
  */
 #define COBALT_TIMER_IRQ	18
@@ -30,7 +33,6 @@
 #define COBALT_SERIAL_IRQ	21
 #define COBALT_SCSI_IRQ         21
 #define COBALT_VIA_IRQ		22		/* Chained to VIA ISA bridge */
-#define COBALT_QUBE_SLOT_IRQ	23
 
 /*
  * PCI configuration space manifest constants.  These are wired into
@@ -69,13 +71,16 @@
  * Most of this really should go into a separate GT64111 header file.
  */
 #define GT64111_IO_BASE		0x10000000UL
+#define GT64111_IO_END		0x11ffffffUL
+#define GT64111_MEM_BASE	0x12000000UL
+#define GT64111_MEM_END		0x13ffffffUL
 #define GT64111_BASE		0x14000000UL
-#define GALILEO_REG(ofs)	(KSEG0 + GT64111_BASE + (unsigned long)(ofs))
+#define GALILEO_REG(ofs)	CKSEG1ADDR(GT64111_BASE + (unsigned long)(ofs))
 
 #define GALILEO_INL(port)	(*(volatile unsigned int *) GALILEO_REG(port))
 #define GALILEO_OUTL(val, port)						\
 do {									\
-	*(volatile unsigned int *) GALILEO_REG(port) = (port);		\
+	*(volatile unsigned int *) GALILEO_REG(port) = (val);		\
 } while (0)
 
 #define GALILEO_T0EXP		0x0100
@@ -86,5 +91,21 @@ do {									\
 	GALILEO_OUTL((0x80000000 | (PCI_SLOT (devfn) << 11) |		\
 		(PCI_FUNC (devfn) << 8) | (where)), GT_PCI0_CFGADDR_OFS)
 
+#define COBALT_LED_PORT		(*(volatile unsigned char *) CKSEG1ADDR(0x1c000000))
+# define COBALT_LED_BAR_LEFT	(1 << 0)	/* Qube */
+# define COBALT_LED_BAR_RIGHT	(1 << 1)	/* Qube */
+# define COBALT_LED_WEB		(1 << 2)	/* RaQ */
+# define COBALT_LED_POWER_OFF	(1 << 3)	/* RaQ */
+# define COBALT_LED_RESET	0x0f
+
+#define COBALT_KEY_PORT		((~*(volatile unsigned int *) CKSEG1ADDR(0x1d000000) >> 24) & COBALT_KEY_MASK)
+# define COBALT_KEY_CLEAR	(1 << 1)
+# define COBALT_KEY_LEFT	(1 << 2)
+# define COBALT_KEY_UP		(1 << 3)
+# define COBALT_KEY_DOWN	(1 << 4)
+# define COBALT_KEY_RIGHT	(1 << 5)
+# define COBALT_KEY_ENTER	(1 << 6)
+# define COBALT_KEY_SELECT	(1 << 7)
+# define COBALT_KEY_MASK	0xfe
 
 #endif /* __ASM_COBALT_H */
--- linux-cvs/arch/mips/cobalt/reset.c	2002-12-02 00:27:43.000000000 +0000
+++ linux-wip/arch/mips/cobalt/reset.c	2005-02-20 13:48:22.000000000 +0000
@@ -16,48 +16,45 @@
 #include <asm/reboot.h>
 #include <asm/system.h>
 #include <asm/mipsregs.h>
+#include <asm/cobalt/cobalt.h>
 
-void cobalt_machine_restart(char *command)
+void cobalt_machine_halt(void)
 {
-	*(volatile char *)0xbc000000 = 0x0f;
+	int state, last, diff;
+	unsigned long mark;
 
 	/*
-	 * Ouch, we're still alive ... This time we take the silver bullet ...
-	 * ... and find that we leave the hardware in a state in which the
-	 * kernel in the flush locks up somewhen during of after the PCI
-	 * detection stuff.
+	 * turn off bar on Qube, flash power off LED on RaQ (0.5Hz)
+	 *
+	 * restart if ENTER and SELECT are pressed
 	 */
-	set_c0_status(ST0_BEV | ST0_ERL);
-	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-	flush_cache_all();
-	write_c0_wired(0);
-	__asm__ __volatile__(
-		"jr\t%0"
-		:
-		: "r" (0xbfc00000));
-}
 
-extern int led_state;
-#define kLED            0xBC000000
-#define LEDSet(x)       (*(volatile unsigned char *) kLED) = (( unsigned char)x)
+	last = COBALT_KEY_PORT;
 
-void cobalt_machine_halt(void)
-{
-	int mark;
+	for (state = 0;;) {
+
+		state ^= COBALT_LED_POWER_OFF;
+		COBALT_LED_PORT = state;
+
+		diff = COBALT_KEY_PORT ^ last;
+		last ^= diff;
 
-	/* Blink our cute? little LED (number 3)... */
-	while (1) {
-		led_state = led_state | ( 1 << 3 );
-		LEDSet(led_state);
-		mark = jiffies;
-		while (jiffies<(mark+HZ));
-		led_state = led_state & ~( 1 << 3 );
-		LEDSet(led_state);
-		mark = jiffies;
-		while (jiffies<(mark+HZ));
+		if((diff & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)) && !(~last & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)))
+			COBALT_LED_PORT = COBALT_LED_RESET;
+
+		for (mark = jiffies; jiffies - mark < HZ;)
+			;
 	}
 }
 
+void cobalt_machine_restart(char *command)
+{
+	COBALT_LED_PORT = COBALT_LED_RESET;
+
+	/* we should never get here */
+	cobalt_machine_halt();
+}
+
 /*
  * This triggers the luser mode device driver for the power switch ;-)
  */
--- linux-cvs/arch/mips/cobalt/setup.c	2004-08-26 21:18:00.000000000 +0100
+++ linux-wip/arch/mips/cobalt/setup.c	2005-02-20 13:48:22.000000000 +0000
@@ -30,27 +30,25 @@ extern void cobalt_machine_power_off(voi
 
 int cobalt_board_id;
 
-static char my_cmdline[CL_SIZE] = {
- "console=ttyS0,115200 "
-#ifdef CONFIG_IP_PNP
- "ip=on "
-#endif
-#ifdef CONFIG_ROOT_NFS
- "root=/dev/nfs "
-#else
- "root=/dev/hda1 "
-#endif
- };
-
 const char *get_system_type(void)
 {
+	switch (cobalt_board_id) {
+		case COBALT_BRD_ID_QUBE1:
+			return "Cobalt Qube";
+		case COBALT_BRD_ID_RAQ1:
+			return "Cobalt RaQ";
+		case COBALT_BRD_ID_QUBE2:
+			return "Cobalt Qube2";
+		case COBALT_BRD_ID_RAQ2:
+			return "Cobalt RaQ2";
+	}
 	return "MIPS Cobalt";
 }
 
 static void __init cobalt_timer_setup(struct irqaction *irq)
 {
-	/* Load timer value for 150 Hz */
-	GALILEO_OUTL(500000, GT_TC0_OFS);
+	/* Load timer value for 1KHz */
+	GALILEO_OUTL(50*1000*1000 / 1000, GT_TC0_OFS);
 
 	/* Register our timer interrupt */
 	setup_irq(COBALT_TIMER_IRQ, irq);
@@ -58,17 +56,17 @@ static void __init cobalt_timer_setup(st
 	/* Enable timer ints */
 	GALILEO_OUTL((GALILEO_ENTC0 | GALILEO_SELTC0), GT_TC_CONTROL_OFS);
 	/* Unmask timer int */
-	GALILEO_OUTL(0x100, GT_INTRMASK_OFS);
+	GALILEO_OUTL(GALILEO_T0EXP, GT_INTRMASK_OFS);
 }
 
 extern struct pci_ops gt64111_pci_ops;
 
 static struct resource cobalt_mem_resource = {
-	"GT64111 PCI MEM", GT64111_IO_BASE, 0xffffffffUL, IORESOURCE_MEM
+	"GT64111 PCI MEM", GT64111_MEM_BASE, GT64111_MEM_END, IORESOURCE_MEM
 };
 
 static struct resource cobalt_io_resource = {
-	"GT64111 IO MEM", 0x00001000UL, 0x0fffffffUL, IORESOURCE_IO
+	"GT64111 IO MEM", 0x00001000UL, GT64111_IO_END - GT64111_IO_BASE, IORESOURCE_IO
 };
 
 static struct resource cobalt_io_resources[] = {
@@ -86,10 +84,10 @@ static struct pci_controller cobalt_pci_
 	.mem_resource	= &cobalt_mem_resource,
 	.mem_offset	= 0,
 	.io_resource	= &cobalt_io_resource,
-	.io_offset	= 0x00001000UL - GT64111_IO_BASE
+	.io_offset	= 0 - GT64111_IO_BASE
 };
 
-static void __init cobalt_setup(void)
+static int __init cobalt_setup(void)
 {
 	unsigned int devfn = PCI_DEVFN(COBALT_PCICONF_VIA, 0);
 	int i;
@@ -100,7 +98,10 @@ static void __init cobalt_setup(void)
 
 	board_timer_setup = cobalt_timer_setup;
 
-        set_io_port_base(KSEG1ADDR(GT64111_IO_BASE));
+        set_io_port_base(CKSEG1ADDR(GT64111_IO_BASE));
+
+	/* IO region should cover all Galileo IO */
+	ioport_resource.end = 0x0fffffff;
 
 	/*
 	 * This is a prom style console. We just poke at the
@@ -120,27 +121,50 @@ static void __init cobalt_setup(void)
         cobalt_board_id >>= ((VIA_COBALT_BRD_ID_REG & 3) * 8);
         cobalt_board_id = VIA_COBALT_BRD_REG_to_ID(cobalt_board_id);
 
+	printk("Cobalt board ID: %d\n", cobalt_board_id);
+
 #ifdef CONFIG_PCI
 	register_pci_controller(&cobalt_pci_controller);
 #endif
+
+	return 0;
 }
 
 early_initcall(cobalt_setup);
 
 /*
  * Prom init. We read our one and only communication with the firmware.
- * Grab the amount of installed memory
+ * Grab the amount of installed memory.
+ * Better boot loaders (CoLo) pass a command line too :-)
  */
 
 void __init prom_init(void)
 {
-	int argc = fw_arg0;
-
-	strcpy(arcs_cmdline, my_cmdline);
+	int narg, indx, posn, nchr;
+	unsigned long memsz;
+	char **argv;
 
 	mips_machgroup = MACH_GROUP_COBALT;
 
-	add_memory_region(0x0, argc & 0x7fffffff, BOOT_MEM_RAM);
+	memsz = fw_arg0 & 0x7fff0000;
+	narg = fw_arg0 & 0x0000ffff;
+
+	if (narg) {
+		arcs_cmdline[0] = '\0';
+		argv = (char **) fw_arg1;
+		posn = 0;
+		for (indx = 1; indx < narg; ++indx) {
+			nchr = strlen(argv[indx]);
+			if (posn + 1 + nchr + 1 > sizeof(arcs_cmdline))
+				break;
+			if (posn)
+				arcs_cmdline[posn++] = ' ';
+			strcpy(arcs_cmdline + posn, argv[indx]);
+			posn += nchr;
+		}
+	}
+
+	add_memory_region(0x0, memsz, BOOT_MEM_RAM);
 }
 
 unsigned long __init prom_free_prom_memory(void)
