Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5QLuunC021120
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 26 Jun 2002 14:56:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5QLuuS1021119
	for linux-mips-outgoing; Wed, 26 Jun 2002 14:56:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from kopretinka (mail@p001.as-l025.contactel.cz [212.65.234.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5QLtenC021096;
	Wed, 26 Jun 2002 14:55:44 -0700
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 17NJtj-0000Xx-00; Wed, 26 Jun 2002 23:00:19 +0200
Date: Wed, 26 Jun 2002 22:59:56 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Guido Guenther <agx@sigxcpu.org>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: [patch] GIO bus support
Message-ID: <20020626205956.GA2079@kopretinka>
References: <20020626140552.F19858@dea.linux-mips.net> <Pine.GSO.3.96.1020626150538.23599D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020626150538.23599D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@psi.cz>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 26, 2002 at 03:07:13PM +0200, Maciej W. Rozycki wrote:
> On Wed, 26 Jun 2002, Ralf Baechle wrote:
> 
> > Certainly looks saner than what we're having right now.  Please apply.
> 
>  Done.

You rock Maciej (but Jun is right ;-)) So here it is. This patch introduces
basic support for GIO bus found SGI IP22 machines. I put it into
arch/mips/sgi-ip22/ directory rather than to drivers/gio/, because the
only machine with GIO bus supported by linux is Indy and Indigo2. GIO
devices are detected early - this allows to use gio_find_device() in
newport_con.c to make it more robust.

Here is proc listing (I have Newport XL in gfx slot):
ladis@indy:~$ cat /proc/gio
GIO devices found:
  Slot GFX, DeviceId 0x04
      BaseAddr 0x1f000000, MapSize 0x00400000

I'd like to hear optinion from someone more experienced to make it as
well parseable as possible - it will be used by XFree driver.

Please see ip22_baddr() function, i did my best, but it still looks
ungly :-(

	ladis

Following patch is generated against linux_2_4 brach a while ago

--- /dev/null	Mon Mar  4 10:32:31 2002
+++ linux/include/asm/sgi/sgigio.h	Wed Jun 26 02:12:23 2002
@@ -0,0 +1,69 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * sgigio.h: Definitions for GIO bus found on SGI IP22 (and others by linux
+ *           unsupported) machines.
+ *
+ * Copyright (C) 2002 Ladislav Michl
+ */
+#ifndef _ASM_SGI_SGIGIO_H
+#define _ASM_SGI_SGIGIO_H
+
+/*
+ * There is 10MB of GIO address space for GIO64 slot devices
+ * slot#   slot type address range            size
+ * -----   --------- ----------------------- -----
+ *   0     GFX       0x1f000000 - 0x1f3fffff   4MB
+ *   1     EXP0      0x1f400000 - 0x1f5fffff   2MB
+ *   2     EXP1      0x1f600000 - 0x1f9fffff   4MB
+ *
+ * There are un-slotted devices, HPC, I/O and misc devices, which are grouped 
+ * into the HPC address space.
+ *   -     MISC      0x1fb00000 - 0x1fbfffff   1MB
+ *      
+ * Following space is reserved and unused
+ *   -     RESERVED  0x18000000 - 0x1effffff 112MB
+ *
+ * The GIO specification tends to use slot numbers while the MC specification 
+ * tends to use slot types.
+ *
+ * slot0  - the "graphics" (GFX) slot but there is no requirement that 
+ *          a graphics dev may only use this slot
+ * slot1  - this is the "expansion"-slot 0 (EXP0), do not confuse with 
+ *          slot 0 (GFX).
+ * slot2  - this is the "expansion"-slot 1 (EXP1), do not confuse with 
+ *          slot 1 (EXP0).
+ */
+
+#define GIO_SLOT_GFX	0
+#define GIO_SLOT_GIO1	1
+#define GIO_SLOT_GIO2	2
+#define GIO_NUM_SLOTS	3
+
+#define GIO_ANY_ID	0xff
+
+#define GIO_VALID_ID_ONLY	0x01
+#define GIO_IFACE_64		0x02
+#define GIO_HAS_ROM		0x04
+
+struct gio_dev {
+	unsigned char	device;
+	unsigned char	revision;
+	unsigned short	vendor;
+	unsigned char	flags;
+
+	unsigned char	slot_number;
+	unsigned long	base_addr;
+	unsigned int	map_size;
+	
+	char		*name;
+	char		slot_name[5];
+};
+
+extern struct gio_dev* gio_find_device(unsigned char device, const struct gio_dev *from);
+
+extern void sgigio_init(void);
+
+#endif /* _ASM_SGI_SGIGIO_H */
--- /dev/null	Mon Mar  4 10:32:31 2002
+++ linux/arch/mips/sgi-ip22/ip22-gio.c	Wed Jun 26 02:11:01 2002
@@ -0,0 +1,152 @@
+/* 
+ * ip22-gio.c: Support for GIO64 bus (inspired by PCI code)
+ * 
+ * Copyright (C) 2002 Ladislav Michl
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+
+#include <asm/sgi/sgimc.h>
+#include <asm/sgi/sgigio.h>
+
+#define GIO_PIO_MAP_BASE	0x1f000000L
+#define GIO_PIO_MAP_SIZE	(16 * 1024*1024)
+
+#define GIO_ADDR_GFX		0x1f000000L
+#define GIO_ADDR_GIO1		0x1f400000L
+#define GIO_ADDR_GIO2		0x1f600000L
+
+#define GIO_GFX_MAP_SIZE	(4 * 1024*1024)
+#define GIO_GIO1_MAP_SIZE	(2 * 1024*1024)
+#define GIO_GIO2_MAP_SIZE	(4 * 1024*1024)
+
+#define GIO_NO_DEVICE		0x80
+
+static struct gio_dev gio_slot[GIO_NUM_SLOTS] = {
+	{
+		0,
+		0,
+		0,
+		GIO_NO_DEVICE,
+		GIO_SLOT_GFX,
+		GIO_ADDR_GFX,
+		GIO_GFX_MAP_SIZE,
+		NULL,
+		"GFX"
+	},
+	{
+		0,
+		0,
+		0,
+		GIO_NO_DEVICE,
+		GIO_SLOT_GIO1,
+		GIO_ADDR_GIO1,
+		GIO_GIO1_MAP_SIZE,
+		NULL,
+		"EXP0"
+	},
+	{
+		0,
+		0,
+		0,
+		GIO_NO_DEVICE,
+		GIO_SLOT_GIO2,
+		GIO_ADDR_GIO2,
+		GIO_GIO2_MAP_SIZE,
+		NULL,
+		"EXP1"
+	}
+};
+
+static int gio_read_proc(char *buf, char **start, off_t off,
+			 int count, int *eof, void *data)
+{
+	int i;
+	char *p = buf;
+	
+	p += sprintf(p, "GIO devices found:\n");
+	for (i = 0; i < GIO_NUM_SLOTS; i++) {
+		if (gio_slot[i].flags & GIO_NO_DEVICE)
+			continue;
+		p += sprintf(p, "  Slot %s, DeviceId 0x%02x\n",
+			     gio_slot[i].slot_name, gio_slot[i].device);
+		p += sprintf(p, "    BaseAddr 0x%08lx, MapSize 0x%08x\n",
+			     gio_slot[i].base_addr, gio_slot[i].map_size);
+	}
+	
+	return p - buf;
+}
+
+void create_gio_proc_entry(void)
+{
+	create_proc_read_entry("gio", 0, NULL, gio_read_proc, NULL);
+}
+
+/**
+ * gio_find_device - begin or continue searching for a GIO device by device id
+ * @device: GIO device id to match, or %GIO_ANY_ID to match all device ids
+ * @from: Previous GIO device found in search, or %NULL for new search.
+ *
+ * Iterates through the list of known GIO devices. If a GIO device is found
+ * with a matching @device, a pointer to its device structure is returned. 
+ * Otherwise, %NULL is returned.
+ * A new search is initiated by passing %NULL to the @from argument.
+ * Otherwise if @from is not %NULL, searches continue from next device.
+ */
+struct gio_dev *
+gio_find_device(unsigned char device, const struct gio_dev *from)
+{
+	int i;
+	
+	for (i = (from) ? from->slot_number : 0; i < GIO_NUM_SLOTS; i++)
+		if (!(gio_slot[i].flags & GIO_NO_DEVICE) && 
+		   (device == GIO_ANY_ID || device == gio_slot[i].device))
+			return &gio_slot[i];
+	
+	return NULL;
+}
+
+#define GIO_IDCODE(x)		(x & 0x7f)
+#define GIO_ALL_BITS_VALID	0x80
+#define GIO_REV(x)		((x >> 8) & 0xff)
+#define GIO_GIO_SIZE_64		0x10000
+#define GIO_ROM_PRESENT		0x20000
+#define GIO_VENDOR_CODE(x)	((x >> 18) & 0x3fff)
+
+extern int ip22_baddr(unsigned int *val, unsigned long addr);
+
+/** 
+ * sgigio_init - scan the GIO space and figure out what hardware is actually
+ * present.
+ */
+void __init sgigio_init(void)
+{
+	unsigned int i, id, found = 0;
+
+	printk("GIO: Scanning for GIO cards...\n");
+	for (i = 0; i < GIO_NUM_SLOTS; i++) {
+		if (ip22_baddr(&id, KSEG1ADDR(gio_slot[i].base_addr)))
+			continue;
+
+		found = 1;
+		gio_slot[i].device = GIO_IDCODE(id);
+		if (id & GIO_ALL_BITS_VALID) {
+			gio_slot[i].revision = GIO_REV(id);
+			gio_slot[i].vendor = GIO_VENDOR_CODE(id);
+			gio_slot[i].flags =
+				(id & GIO_GIO_SIZE_64) ? GIO_IFACE_64 : 0 |
+				(id & GIO_ROM_PRESENT) ? GIO_HAS_ROM : 0;
+		} else
+			gio_slot[i].flags = GIO_VALID_ID_ONLY;
+
+		printk("GIO: Card 0x%02x @ 0x%08lx\n", gio_slot[i].device,
+			gio_slot[i].base_addr);
+	}
+	
+	if (!found)
+		printk("GIO: No GIO cards present.\n");
+}
--- /dev/null	Mon Mar  4 10:32:31 2002
+++ linux/arch/mips/sgi-ip22/ip22-berr.c	Wed Jun 26 02:06:56 2002
@@ -0,0 +1,78 @@
+/*
+ * ip22-berr.c: Bus error handling.
+ *
+ * Copyright (C) 2002 Ladislav Michl
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+
+#include <asm/addrspace.h>
+#include <asm/system.h>
+#include <asm/traps.h>
+#include <asm/branch.h>
+#include <asm/sgi/sgimc.h>
+#include <asm/sgi/sgihpc.h>
+
+unsigned int cpu_err_stat;	/* Status reg for CPU */
+unsigned int gio_err_stat;	/* Status reg for GIO */
+unsigned int cpu_err_addr;	/* Error address reg for CPU */
+unsigned int gio_err_addr;	/* Error address reg for GIO */
+
+volatile int nofault;
+
+static void save_and_clear_buserr(void)
+{
+	/* save memory controler's error status registers */ 
+	cpu_err_addr = mcmisc_regs->cerr;
+	cpu_err_stat = mcmisc_regs->cstat;
+	gio_err_addr = mcmisc_regs->gerr;
+	gio_err_stat = mcmisc_regs->gstat;
+
+	mcmisc_regs->cstat = mcmisc_regs->gstat = 0;
+}
+
+/*
+ * MC sends an interrupt whenever bus or parity errors occur. In addition, 
+ * if the error happened during a CPU read, it also asserts the bus error 
+ * pin on the R4K. Code in bus error handler save the MC bus error registers
+ * and then clear the interrupt when this happens.
+ */
+
+void be_ip22_interrupt(int irq, struct pt_regs *regs)
+{
+	save_and_clear_buserr();
+	printk(KERN_ALERT "Bus error, epc == %08lx, ra == %08lx\n",
+	       regs->cp0_epc, regs->regs[31]);
+	die_if_kernel("Oops", regs);
+	force_sig(SIGBUS, current);
+}
+
+int be_ip22_handler(struct pt_regs *regs, int is_fixup)
+{
+	save_and_clear_buserr();
+	if (nofault) {
+		nofault = 0;
+		compute_return_epc(regs);
+		return MIPS_BE_DISCARD;
+	}
+	return MIPS_BE_FIXUP;
+}
+
+int ip22_baddr(unsigned int *val, unsigned long addr)
+{
+	nofault = 1;
+	*val = *(volatile unsigned int *) addr;
+	__asm__ __volatile__("nop;nop;nop;nop");
+	if (nofault) {
+		nofault = 0;
+		return 0;
+	}
+	return -EFAULT;
+}
+
+void __init bus_error_init(void)
+{
+	be_board_handler = be_ip22_handler;
+}
Index: linux/arch/mips/sgi-ip22/ip22-int.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-int.c,v
retrieving revision 1.2.2.2
diff -u -r1.2.2.2 ip22-int.c
--- linux/arch/mips/sgi-ip22/ip22-int.c	2002/06/26 11:48:54	1.2.2.2
+++ linux/arch/mips/sgi-ip22/ip22-int.c	2002/06/26 20:41:03
@@ -16,8 +16,8 @@
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 
-#include <asm/irq.h>
 #include <asm/mipsregs.h>
 #include <asm/addrspace.h>
 #include <asm/gdb-stub.h>
@@ -279,6 +279,8 @@
 	return;	
 }
 
+extern void be_ip22_interrupt(int irq, struct pt_regs *regs);
+
 void indy_buserror_irq(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
@@ -286,9 +288,7 @@
 
 	irq_enter(cpu, irq);
 	kstat.irqs[cpu][irq]++;
-	die("Got a bus error IRQ, shouldn't happen yet\n", regs);
-	printk("Spinning...\n");
-	while(1);
+	be_ip22_interrupt(irq, regs);
 	irq_exit(cpu, irq);
 }
 
@@ -305,9 +305,8 @@
 	{ no_action, SA_INTERRUPT, 0, "mappable1 cascade", NULL, NULL };
 #endif
 
-extern int setup_irq(unsigned int irq, struct irqaction *irqaction);
-extern void mips_cpu_irq_init(u32 irq_base);
-	
+extern void mips_cpu_irq_init(unsigned int irq_base);
+
 void __init init_IRQ(void)
 {
 	int i;
Index: linux/arch/mips/sgi-ip22/ip22-mc.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-mc.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 ip22-mc.c
--- linux/arch/mips/sgi-ip22/ip22-mc.c	2002/06/26 11:44:49	1.1.2.2
+++ linux/arch/mips/sgi-ip22/ip22-mc.c	2002/06/26 20:42:55
@@ -4,20 +4,21 @@
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 1999 Andrew R. Baker (andrewb@uab.edu) - Indigo2 changes
  */
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 
 #include <asm/addrspace.h>
 #include <asm/ptrace.h>
+#include <asm/sgialib.h>
 #include <asm/sgi/sgimc.h>
 #include <asm/sgi/sgihpc.h>
-#include <asm/sgialib.h>
 
 /* #define DEBUG_SGIMC */
 
 struct sgimc_misc_ctrl *mcmisc_regs;
-u32 *rpsscounter;
 struct sgimc_dma_ctrl *dmactrlregs;
+u32 *rpsscounter;
 
 static inline char *mconfig_string(unsigned long val)
 {
@@ -42,7 +43,7 @@
 
 	default:
 		return "wheee, unknown";
-	};
+	}
 }
 
 void __init sgimc_init(void)
@@ -50,8 +51,8 @@
 	unsigned long tmpreg;
 
 	mcmisc_regs = (struct sgimc_misc_ctrl *)(KSEG1+0x1fa00000);
-	rpsscounter = (unsigned int *) (KSEG1 + 0x1fa01004);
-	dmactrlregs = (struct sgimc_dma_ctrl *) (KSEG1+0x1fa02000);
+	rpsscounter = (unsigned int *)(KSEG1+0x1fa01004);
+	dmactrlregs = (struct sgimc_dma_ctrl *)(KSEG1+0x1fa02000);
 
 	printk(KERN_INFO "MC: SGI memory controller Revision %d\n",
 	       (int) mcmisc_regs->systemid & SGIMC_SYSID_MASKREV);
@@ -81,7 +82,7 @@
 	/* Place the MC into a known state.  This must be done before
 	 * interrupts are first enabled etc.
 	 */
-
+	
 	/* Step 0: Make sure we turn off the watchdog in case it's
 	 *         still running (which might be the case after a
 	 *         soft reboot).
@@ -137,7 +138,7 @@
 	 *       revision on this machine.  You have been warned.
 	 */
 
-	/* First the basic invariants across all gio64 implementations. */
+	/* First the basic invariants across all GIO64 implementations. */
 	tmpreg = SGIMC_GIOPARM_HPC64;    /* All 1st HPC's interface at 64bits. */
 	tmpreg |= SGIMC_GIOPARM_ONEBUS;  /* Only one physical GIO bus exists. */
 
Index: linux/arch/mips/sgi-ip22/ip22-time.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-time.c,v
retrieving revision 1.1.2.6
diff -u -r1.1.2.6 ip22-time.c
--- linux/arch/mips/sgi-ip22/ip22-time.c	2002/06/26 11:44:49	1.1.2.6
+++ linux/arch/mips/sgi-ip22/ip22-time.c	2002/06/26 20:47:22
@@ -20,6 +20,7 @@
 #include <asm/ds1286.h>
 #include <asm/sgialib.h>
 #include <asm/sgi/sgint23.h>
+#include <asm/sgi/sgigio.h>
 #include <asm/time.h>
 
 /*
@@ -179,6 +180,14 @@
 		(int) (r4k_tick / 5000), (int) (r4k_tick % 5000) / 50);
 
 	mips_counter_frequency = r4k_tick * HZ;	
+	
+	/* HACK ALERT! This get's called after traps initialization
+	 * We piggyback the initialization of GIO bus here even though
+	 * it is technically not related with the timer in any way.
+	 * Doing it from ip22_setup wouldn't work since traps aren't 
+	 * initialized yet.
+	 */
+	sgigio_init();
 }
 
 /* Generic SGI handler for (spurious) 8254 interrupts */
Index: linux/arch/mips/sgi-ip22/ip22-setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
retrieving revision 1.1.2.9
diff -u -r1.1.2.9 ip22-setup.c
--- linux/arch/mips/sgi-ip22/ip22-setup.c	2002/06/26 12:22:42	1.1.2.9
+++ linux/arch/mips/sgi-ip22/ip22-setup.c	2002/06/26 20:49:01
@@ -46,6 +46,7 @@
 extern struct rtc_ops indy_rtc_ops;
 extern void indy_reboot_setup(void);
 extern void sgi_volume_set(unsigned char);
+extern void create_gio_proc_entry(void);
 
 #define sgi_kh ((struct hpc_keyb *) &(hpc3mregs->kbdmouse0))
 
@@ -61,12 +62,18 @@
 static int sgi_request_irq(void (*handler)(int, void *, struct pt_regs *))
 {
 	/* Dirty hack, this get's called as a callback from the keyboard
-	   driver.  We piggyback the initialization of the front panel
-	   button handling on it even though they're technically not
-	   related with the keyboard driver in any way.  Doing it from
-	   indy_setup wouldn't work since kmalloc isn't initialized yet.  */
+	 * driver.  We piggyback the initialization of the front panel
+	 * button handling on it even though they're technically not
+	 * related with the keyboard driver in any way.  Doing it from
+	 * ip22_setup wouldn't work since kmalloc isn't initialized yet.
+	 */
 	indy_reboot_setup();
 
+	/* Ehm, well... once David used hack above, let's add yet another.
+	 * Register GIO bus proc entry here.
+	 */
+	create_gio_proc_entry();
+
 	return request_irq(SGI_KEYBD_IRQ, handler, 0, "keyboard", NULL);
 }
 
@@ -123,10 +130,6 @@
 	sgi_write_command,
 	sgi_read_status
 };
-
-void __init bus_error_init(void)
-{
-}
 
 void __init ip22_setup(void)
 {
