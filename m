Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5QBnAnC000958
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 26 Jun 2002 04:49:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5QBnAcV000957
	for linux-mips-outgoing; Wed, 26 Jun 2002 04:49:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5QBlFnC000847
	for <linux-mips@oss.sgi.com>; Wed, 26 Jun 2002 04:47:16 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA25835;
	Wed, 26 Jun 2002 13:51:08 +0200 (MET DST)
Date: Wed, 26 Jun 2002 13:51:08 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@psi.cz>, Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@oss.sgi.com
Subject: [patch] linux: DBE/IBE handling rewrite
In-Reply-To: <Pine.GSO.3.96.1020625131229.29623A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1020626121553.23599A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 25 Jun 2002, Maciej W. Rozycki wrote:

>  This way, the fixup search is invoked first and a system-specific handler
> can judge whether to let the fixup be invoked or a serious failure
> happened and the system should act appropriately.  The handler can do
> whatever actions are needed (e.g. clear error status data in system
> registers, report ECC syndromes, etc.) for the system for both cases.

 OK, here is the code.  I wrote it a bit differently from what I
considered yesterday, as fixup doesn't seem useful for a system-specific
handler.  With the following code only a boolean flag is passed informing
whether a fixup is available and the handler can decide how to treat an
error, based on the state passed as arguments and possibly additional one
obtained from system-specific resources.  Both MIPS and MIPS64 are handled
in the same way.  For MIPS64 it means a removal of duplicated similar code
as well.  I adjusted some SGI-specific code appropriately, but platform
maintainers will have to check if bus_error_init() stubs are OK for them.

 Ralf, OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.18-20020625-be-5
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/cobalt/setup.c linux-mips-2.4.18-20020625/arch/mips/cobalt/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/cobalt/setup.c	2002-01-07 03:33:54.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/cobalt/setup.c	2002-06-26 11:21:15.000000000 +0000
@@ -25,6 +25,7 @@
 #include <asm/pci.h>
 #include <asm/processor.h>
 #include <asm/reboot.h>
+#include <asm/traps.h>
 
 extern void cobalt_machine_restart(char *command);
 extern void cobalt_machine_halt(void);
@@ -71,6 +72,10 @@ static void __init cobalt_timer_setup(st
 	*((volatile unsigned long *) GALILEO_CPU_MASK) = (unsigned long) 0x00000100; 
 }
 
+
+void __init bus_error_init(void) { /* nothing */ }
+
+
 int cobalt_serial_present;
 int cobalt_serial_type;
 int cobalt_is_raq;
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/ddb5074/setup.c linux-mips-2.4.18-20020625/arch/mips/ddb5074/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/ddb5074/setup.c	2001-11-26 05:25:59.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/ddb5074/setup.c	2002-06-26 11:21:24.000000000 +0000
@@ -25,6 +25,7 @@
 #include <asm/gdb-stub.h>
 #include <asm/nile4.h>
 #include <asm/ddb5074.h>
+#include <asm/traps.h>
 
 
 #ifdef CONFIG_REMOTE_DEBUG
@@ -91,6 +92,10 @@ static void __init ddb_time_init(struct 
 		          IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4);
 }
 
+
+void __init bus_error_init(void) { /* nothing */ }
+
+
 void __init ddb_setup(void)
 {
 	extern int panic_timeout;
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/ddb5xxx/ddb5476/setup.c linux-mips-2.4.18-20020625/arch/mips/ddb5xxx/ddb5476/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/ddb5xxx/ddb5476/setup.c	2002-02-04 05:27:22.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/ddb5xxx/ddb5476/setup.c	2002-06-26 11:21:56.000000000 +0000
@@ -25,6 +25,7 @@
 #include <asm/gdb-stub.h>
 #include <asm/time.h>
 #include <asm/debug.h>
+#include <asm/traps.h>
 
 #include <asm/ddb5xxx/ddb5xxx.h>
 
@@ -138,6 +139,10 @@ static struct {
 	{ "Nile 4", DDB_BASE, DDB_BASE + DDB_SIZE - 1, IORESOURCE_BUSY}
 };
 
+
+void __init bus_error_init(void) { /* nothing */ }
+
+
 static void ddb5476_board_init(void);
 extern void ddb5476_irq_setup(void);
 extern void (*irq_setup)(void);
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/ddb5xxx/ddb5477/setup.c linux-mips-2.4.18-20020625/arch/mips/ddb5xxx/ddb5477/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/ddb5xxx/ddb5477/setup.c	2001-12-27 05:27:16.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/ddb5xxx/ddb5477/setup.c	2002-06-26 11:22:25.000000000 +0000
@@ -32,6 +32,7 @@
 #include <asm/reboot.h>
 #include <asm/gdb-stub.h>
 #include <asm/debug.h>
+#include <asm/traps.h>
 
 #include <asm/ddb5xxx/ddb5xxx.h>
 
@@ -117,6 +118,10 @@ static void __init ddb_timer_setup(struc
 #endif
 }
 
+
+void __init bus_error_init(void) { /* nothing */ }
+
+
 static void ddb5477_board_init(void);
 extern void ddb5477_irq_setup(void);
 
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/dec/setup.c linux-mips-2.4.18-20020625/arch/mips/dec/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/dec/setup.c	2002-05-30 02:57:37.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/dec/setup.c	2002-06-25 18:05:05.000000000 +0000
@@ -24,6 +24,7 @@
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
+#include <asm/traps.h>
 
 #include <asm/dec/interrupts.h>
 #include <asm/dec/kn01.h>
@@ -113,6 +114,16 @@ static void __init dec_time_init(struct 
 	setup_irq(dec_interrupt[DEC_IRQ_RTC], irq);
 }
 
+
+/*
+ * Bus error (DBE/IBE exceptions and memory interrupts) handling
+ * setup.  Nothing for now.
+ */
+void __init bus_error_init(void)
+{
+}
+
+
 void __init decstation_setup(void)
 {
 	board_time_init = dec_time_init;
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/galileo-boards/ev64120/setup.c linux-mips-2.4.18-20020625/arch/mips/galileo-boards/ev64120/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/galileo-boards/ev64120/setup.c	2001-12-13 05:27:47.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/galileo-boards/ev64120/setup.c	2002-06-26 11:25:04.000000000 +0000
@@ -51,6 +51,7 @@
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/mc146818rtc.h>
+#include <asm/traps.h>
 #include <linux/version.h>
 #include <linux/bootmem.h>
 
@@ -105,6 +106,10 @@ struct rtc_ops galileo_rtc_ops = {
 	&galileo_rtc_bcd_mode
 };
 
+
+void __init bus_error_init(void) { /* nothing */ }
+
+
 /********************************************************************
  *ev64120_setup -
  *
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/gt64120/momenco_ocelot/setup.c linux-mips-2.4.18-20020625/arch/mips/gt64120/momenco_ocelot/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/gt64120/momenco_ocelot/setup.c	2002-02-07 05:27:13.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/gt64120/momenco_ocelot/setup.c	2002-06-26 11:26:58.000000000 +0000
@@ -59,6 +59,7 @@
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/mc146818rtc.h>
+#include <asm/traps.h>
 #include <linux/version.h>
 #include <linux/bootmem.h>
 #include <linux/blk.h>
@@ -83,6 +84,10 @@ static char reset_reason;
 
 static void __init setup_l3cache(unsigned long size);
 
+
+void __init bus_error_init(void) { /* nothing */ }
+
+
 void __init momenco_ocelot_setup(void)
 {
 	void (*l3func)(unsigned long)=KSEG1ADDR(&setup_l3cache);
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/ite-boards/generic/it8172_setup.c linux-mips-2.4.18-20020625/arch/mips/ite-boards/generic/it8172_setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/ite-boards/generic/it8172_setup.c	2001-11-27 05:26:05.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/ite-boards/generic/it8172_setup.c	2002-06-26 11:32:13.000000000 +0000
@@ -40,6 +40,7 @@
 #include <asm/irq.h>
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
+#include <asm/traps.h>
 #include <asm/it8172/it8172.h>
 #include <asm/it8712.h>
 #ifdef CONFIG_PC_KEYB
@@ -114,6 +115,9 @@ struct {
 #endif
 
 
+void __init bus_error_init(void) { /* nothing */ }
+
+
 void __init it8172_init_ram_resource(unsigned long memsize)
 {
 	it8172_resources.ram.end = memsize;
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/jazz/setup.c linux-mips-2.4.18-20020625/arch/mips/jazz/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/jazz/setup.c	2001-12-12 05:27:26.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/jazz/setup.c	2002-06-26 11:32:42.000000000 +0000
@@ -28,6 +28,7 @@
 #include <asm/reboot.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
+#include <asm/traps.h>
 
 /*
  * Initial irq handlers.
@@ -80,6 +81,10 @@ static void __init jazz_irq_setup(void)
 	i8259_setup_irq(2, &irq2);
 }
 
+
+void __init bus_error_init(void) { /* nothing */ }
+
+
 void __init jazz_setup(void)
 {
 	/* Map 0xe0000000 -> 0x0:800005C0, 0xe0010000 -> 0x1:30000580 */
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/jmr3927/rbhma3100/setup.c linux-mips-2.4.18-20020625/arch/mips/jmr3927/rbhma3100/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/jmr3927/rbhma3100/setup.c	2002-02-23 05:28:27.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/jmr3927/rbhma3100/setup.c	2002-06-26 11:36:26.000000000 +0000
@@ -55,6 +55,7 @@
 #include <asm/gdb-stub.h>
 #include <asm/jmr3927/jmr3927.h>
 #include <asm/mipsregs.h>
+#include <asm/traps.h>
 
 /* Tick Timer divider */
 #define JMR3927_TIMER_CCD	0	/* 1/2 */
@@ -182,6 +183,10 @@ unsigned long jmr3927_do_gettimeoffset(v
        return res;
 }                                         
 
+
+void __init bus_error_init(void) { /* nothing */ }
+
+
 #if defined(CONFIG_BLK_DEV_INITRD)
 extern unsigned long __rd_start, __rd_end, initrd_start, initrd_end;
 #endif 
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/kernel/entry.S linux-mips-2.4.18-20020625/arch/mips/kernel/entry.S
--- linux-mips-2.4.18-20020625.macro/arch/mips/kernel/entry.S	2002-04-16 02:57:34.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/kernel/entry.S	2002-06-25 16:39:19.000000000 +0000
@@ -236,8 +236,8 @@ EXPORT(exception_count_##exception);    
 
 		BUILD_HANDLER(adel,ade,ade,silent)		/* #4  */
 		BUILD_HANDLER(ades,ade,ade,silent)		/* #5  */
-		BUILD_HANDLER(ibe,ibe,cli,silent)		/* #6  */
-		BUILD_HANDLER(dbe,dbe,cli,silent)		/* #7  */
+		BUILD_HANDLER(ibe,be,cli,silent)		/* #6  */
+		BUILD_HANDLER(dbe,be,cli,silent)		/* #7  */
 		BUILD_HANDLER(bp,bp,sti,silent)			/* #9  */
 		BUILD_HANDLER(ri,ri,sti,silent)			/* #10 */
 		BUILD_HANDLER(cpu,cpu,sti,silent)		/* #11 */
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/kernel/traps.c linux-mips-2.4.18-20020625/arch/mips/kernel/traps.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/kernel/traps.c	2002-05-28 10:13:03.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/kernel/traps.c	2002-06-25 19:38:02.000000000 +0000
@@ -10,6 +10,7 @@
  *
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
+ * Copyright (C) 2002  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -32,6 +33,7 @@
 #include <asm/siginfo.h>
 #include <asm/watch.h>
 #include <asm/system.h>
+#include <asm/traps.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 
@@ -66,8 +68,7 @@ extern int fpu_emulator_cop1Handler(stru
 
 char watch_available = 0;
 
-void (*ibe_board_handler)(struct pt_regs *regs);
-void (*dbe_board_handler)(struct pt_regs *regs);
+int (*be_board_handler)(struct pt_regs *regs, int is_fixup);
 
 int kstack_depth_to_print = 24;
 
@@ -417,20 +418,35 @@ search_dbe_table(unsigned long addr)
 #endif
 }
 
-static void default_be_board_handler(struct pt_regs *regs)
+asmlinkage void do_be(struct pt_regs *regs)
 {
 	unsigned long new_epc;
-	unsigned long fixup;
+	unsigned long fixup = 0;
 	int data = regs->cp0_cause & 4;
+	int action = MIPS_BE_FATAL;
 
-	if (data && !user_mode(regs)) {
+	if (data && !user_mode(regs))
 		fixup = search_dbe_table(regs->cp0_epc);
+
+	if (fixup)
+		action = MIPS_BE_FIXUP;
+
+	if (be_board_handler)
+		action = be_board_handler(regs, fixup != 0);
+
+	switch (action) {
+	case MIPS_BE_DISCARD:
+		return;
+	case MIPS_BE_FIXUP:
 		if (fixup) {
 			new_epc = fixup_exception(dpf_reg, fixup,
 						  regs->cp0_epc);
 			regs->cp0_epc = new_epc;
 			return;
 		}
+		break;
+	default:
+		break;
 	}
 
 	/*
@@ -443,16 +459,6 @@ static void default_be_board_handler(str
 	force_sig(SIGBUS, current);
 }
 
-asmlinkage void do_ibe(struct pt_regs *regs)
-{
-	ibe_board_handler(regs);
-}
-
-asmlinkage void do_dbe(struct pt_regs *regs)
-{
-	dbe_board_handler(regs);
-}
-
 asmlinkage void do_ov(struct pt_regs *regs)
 {
 	if (compute_return_epc(regs))
@@ -950,6 +956,13 @@ void __init trap_init(void)
 	 */
 	parity_protection_init();
 
+	/*
+	 * The Data Bus Errors / Instruction Bus Errors are signaled
+	 * by external hardware.  Therefore these two exceptions
+	 * may have board specific handlers.
+	 */
+	bus_error_init();
+
 	set_except_vector(1, handle_mod);
 	set_except_vector(2, handle_tlbl);
 	set_except_vector(3, handle_tlbs);
@@ -958,13 +971,11 @@ void __init trap_init(void)
 
 	/*
 	 * The Data Bus Error/ Instruction Bus Errors are signaled
-	 * by external hardware.  Therefore these two expection have
-	 * board specific handlers.
+	 * by external hardware.  Therefore these two exceptions
+	 * may have board specific handlers.
 	 */
 	set_except_vector(6, handle_ibe);
 	set_except_vector(7, handle_dbe);
-	ibe_board_handler = default_be_board_handler;
-	dbe_board_handler = default_be_board_handler;
 
 	set_except_vector(8, handle_sys);
 	set_except_vector(9, handle_bp);
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/mips-boards/atlas/atlas_setup.c linux-mips-2.4.18-20020625/arch/mips/mips-boards/atlas/atlas_setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/mips-boards/atlas/atlas_setup.c	2002-01-25 05:26:36.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/mips-boards/atlas/atlas_setup.c	2002-06-26 11:36:59.000000000 +0000
@@ -31,6 +31,7 @@
 #include <asm/mips-boards/atlasint.h>
 #include <asm/gt64120.h>
 #include <asm/time.h>
+#include <asm/traps.h>
 
 #if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_PROM_CONSOLE)
 extern void console_setup(char *, int *);
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/mips-boards/malta/malta_setup.c linux-mips-2.4.18-20020625/arch/mips/mips-boards/malta/malta_setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/mips-boards/malta/malta_setup.c	2002-05-09 02:57:10.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/mips-boards/malta/malta_setup.c	2002-06-26 11:37:27.000000000 +0000
@@ -37,6 +37,7 @@
 #endif
 #include <asm/dma.h>
 #include <asm/time.h>
+#include <asm/traps.h>
 #ifdef CONFIG_PC_KEYB
 #include <asm/keyboard.h>
 #endif
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/philips/nino/setup.c linux-mips-2.4.18-20020625/arch/mips/philips/nino/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/philips/nino/setup.c	2002-05-30 02:57:50.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/philips/nino/setup.c	2002-06-26 11:38:05.000000000 +0000
@@ -19,6 +19,7 @@
 #include <asm/irq.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
+#include <asm/traps.h>
 #include <asm/tx3912.h>
 
 static void nino_machine_restart(char *command)
@@ -81,6 +82,10 @@ static __init void nino_timer_setup(stru
 	setup_irq(0, irq);
 }
 
+
+void __init bus_error_init(void) { /* nothing */ }
+
+
 void __init nino_setup(void)
 {
 	extern void nino_irq_setup(void);
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/sgi-ip22/ip22-setup.c linux-mips-2.4.18-20020625/arch/mips/sgi-ip22/ip22-setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/sgi-ip22/ip22-setup.c	2002-05-13 02:57:38.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/sgi-ip22/ip22-setup.c	2002-06-26 11:41:03.000000000 +0000
@@ -28,6 +28,7 @@
 #include <asm/sgi/sgint23.h>
 #include <asm/time.h>
 #include <asm/gdb-stub.h>
+#include <asm/traps.h>
 
 #ifdef CONFIG_REMOTE_DEBUG
 extern void rs_kgdb_hook(int);
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips/sni/setup.c linux-mips-2.4.18-20020625/arch/mips/sni/setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips/sni/setup.c	2001-11-26 05:26:01.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips/sni/setup.c	2002-06-26 11:39:42.000000000 +0000
@@ -31,6 +31,7 @@
 #include <asm/reboot.h>
 #include <asm/sni.h>
 #include <asm/time.h>
+#include <asm/traps.h>
 
 extern void sni_machine_restart(char *command);
 extern void sni_machine_halt(void);
@@ -49,6 +50,10 @@ static void __init sni_rm200_pci_time_in
 	setup_irq(0, irq);
 }
 
+
+void __init bus_error_init(void) { /* nothing */ }
+
+
 extern unsigned char sni_map_isa_cache;
 
 /*
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips64/kernel/r4k_genex.S linux-mips-2.4.18-20020625/arch/mips64/kernel/r4k_genex.S
--- linux-mips-2.4.18-20020625.macro/arch/mips64/kernel/r4k_genex.S	2002-02-23 05:28:29.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips64/kernel/r4k_genex.S	2002-06-25 16:48:31.000000000 +0000
@@ -20,8 +20,8 @@
 
 	BUILD_HANDLER adel ade ade silent		/* #4  */
 	BUILD_HANDLER ades ade ade silent		/* #5  */
-	BUILD_HANDLER ibe ibe cli silent		/* #6  */
-	BUILD_HANDLER dbe dbe cli silent		/* #7  */
+	BUILD_HANDLER ibe be cli silent			/* #6  */
+	BUILD_HANDLER dbe be cli silent			/* #7  */
 	BUILD_HANDLER bp bp sti silent			/* #9  */
 	BUILD_HANDLER ri ri sti silent			/* #10 */
 	BUILD_HANDLER cpu cpu sti silent		/* #11 */
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips64/kernel/traps.c linux-mips-2.4.18-20020625/arch/mips64/kernel/traps.c
--- linux-mips-2.4.18-20020625.macro/arch/mips64/kernel/traps.c	2002-06-20 02:57:37.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips64/kernel/traps.c	2002-06-25 19:43:46.000000000 +0000
@@ -7,6 +7,7 @@
  * Copyright (C) 1995, 1996 Paul M. Antoine
  * Copyright (C) 1998 Ulf Carlsson
  * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2002  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -23,10 +24,10 @@
 #include <asm/module.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-#include <asm/paccess.h>
 #include <asm/ptrace.h>
 #include <asm/watch.h>
 #include <asm/system.h>
+#include <asm/traps.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/cachectl.h>
@@ -55,6 +56,8 @@ void fpu_emulator_init_fpu(void);
 char watch_available = 0;
 char dedicated_iv_available = 0;
 
+int (*be_board_handler)(struct pt_regs *regs, int is_fixup);
+
 int kstack_depth_to_print = 24;
 
 /*
@@ -272,7 +275,8 @@ search_one_table(const struct exception_
 
 extern spinlock_t modlist_lock;
 
-unsigned long search_dbe_table(unsigned long addr)
+static inline unsigned long
+search_dbe_table(unsigned long addr)
 {
 	unsigned long ret = 0;
 
@@ -308,26 +312,45 @@ unsigned long search_dbe_table(unsigned 
 #endif
 }
 
-/* Default data and instruction bus error handlers.  */
-void do_ibe(struct pt_regs *regs)
+asmlinkage void do_be(struct pt_regs *regs)
 {
-	die("Got ibe\n", regs);
-}
+	unsigned long new_epc;
+	unsigned long fixup = 0;
+	int data = regs->cp0_cause & 4;
+	int action = MIPS_BE_FATAL;
 
-void do_dbe(struct pt_regs *regs)
-{
-	unsigned long fixup;
+	if (data && !user_mode(regs))
+		fixup = search_dbe_table(regs->cp0_epc);
+
+	if (fixup)
+		action = MIPS_BE_FIXUP;
 
-	fixup = search_dbe_table(regs->cp0_epc);
-	if (fixup) {
-		long new_epc;
+	if (be_board_handler)
+		action = be_board_handler(regs, fixup != 0);
 
-		new_epc = fixup_exception(dpf_reg, fixup, regs->cp0_epc);
-		regs->cp0_epc = new_epc;
+	switch (action) {
+	case MIPS_BE_DISCARD:
 		return;
+	case MIPS_BE_FIXUP:
+		if (fixup) {
+			new_epc = fixup_exception(dpf_reg, fixup,
+						  regs->cp0_epc);
+			regs->cp0_epc = new_epc;
+			return;
+		}
+		break;
+	default:
+		break;
 	}
 
-	die("Got dbe\n", regs);
+	/*
+	 * Assume it would be too dangerous to continue ...
+	 */
+	printk(KERN_ALERT "%s bus error, epc == %08lx, ra == %08lx\n",
+	       data ? "Data" : "Instruction",
+	       regs->cp0_epc, regs->regs[31]);
+	die_if_kernel("Oops", regs);
+	force_sig(SIGBUS, current);
 }
 
 void do_ov(struct pt_regs *regs)
@@ -634,7 +657,6 @@ void __init trap_init(void)
 	extern char except_vec2_generic, except_vec2_sb1;
 	extern char except_vec3_generic, except_vec3_r4000;
 	extern char except_vec4;
-	extern void bus_error_init(void);
 	unsigned long i;
 	int dummy;
 
@@ -666,6 +688,13 @@ void __init trap_init(void)
 		set_except_vector(24, handle_mcheck);
 
 	/*
+	 * The Data Bus Errors / Instruction Bus Errors are signaled
+	 * by external hardware.  Therefore these two exceptions
+	 * may have board specific handlers.
+	 */
+	bus_error_init();
+
+	/*
 	 * Handling the following exceptions depends mostly of the cpu type
 	 */
 	switch(mips_cpu.cputype) {
@@ -713,18 +742,6 @@ void __init trap_init(void)
 		set_except_vector(6, handle_ibe);
 		set_except_vector(7, handle_dbe);
 
-		/*
-		 * If nothing uses the DBE protection mechanism this is
-		 * necessary to get the kernel to link.
-		 */
-		get_dbe(dummy, (int *)KSEG0);
-
-		/*
-		 * DBE / IBE handlers may be overridden by system specific
-		 * handlers.
-		 */
-		bus_error_init();
-
 		set_except_vector(8, handle_sys);
 		set_except_vector(9, handle_bp);
 		set_except_vector(10, handle_ri);
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip27/Makefile linux-mips-2.4.18-20020625/arch/mips64/sgi-ip27/Makefile
--- linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip27/Makefile	2002-01-25 05:27:27.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips64/sgi-ip27/Makefile	2002-06-25 18:07:47.000000000 +0000
@@ -11,9 +11,8 @@ O_TARGET = ip27.o
 
 export-objs		= ip27-rtc.o
 
-obj-y	:= ip27-berr.o ip27-console.o ip27-dbe-glue.o ip27-irq.o ip27-init.o \
-	   ip27-irq-glue.o ip27-klconfig.o ip27-klnuma.o ip27-memory.o \
-	   ip27-nmi.o ip27-pci.o ip27-pci-dma.o ip27-reset.o ip27-setup.o \
-	   ip27-timer.o
+obj-y	:= ip27-berr.o ip27-console.o ip27-irq.o ip27-init.o ip27-irq-glue.o \
+	   ip27-klconfig.o ip27-klnuma.o ip27-memory.o ip27-nmi.o ip27-pci.o \
+	   ip27-pci-dma.o ip27-reset.o ip27-setup.o ip27-timer.o
 
 include $(TOPDIR)/Rules.make
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip27/ip27-berr.c linux-mips-2.4.18-20020625/arch/mips64/sgi-ip27/ip27-berr.c
--- linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip27/ip27-berr.c	2002-01-25 05:27:27.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips64/sgi-ip27/ip27-berr.c	2002-06-25 19:45:12.000000000 +0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1994, 1995, 1996, 1999, 2000 by Ralf Baechle
  * Copyright (C) 1999, 2000 by Silicon Graphics
+ * Copyright (C) 2002  Maciej W. Rozycki
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -14,24 +15,12 @@
 #include <asm/sn/addrs.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/sn0/hub.h>
+#include <asm/traps.h>
 #include <asm/uaccess.h>
-#include <asm/paccess.h>
 
 extern void dump_tlb_addr(unsigned long addr);
 extern void dump_tlb_all(void);
 
-extern asmlinkage void handle_ip27_ibe(void);
-extern asmlinkage void handle_ip27_dbe(void);
-
-void do_ip27_ibe(struct pt_regs *regs)
-{
-	printk("Got ibe at 0x%lx\n", regs->cp0_epc);
-	show_regs(regs);
-	dump_tlb_addr(regs->cp0_epc);
-	force_sig(SIGBUS, current);
-	while(1);
-}
-
 static void dump_hub_information(unsigned long errst0, unsigned long errst1)
 {
 	static char *err_type[2][8] = {
@@ -65,21 +54,17 @@ static void dump_hub_information(unsigne
 		? : "invalid");
 }
 
-void do_ip27_dbe(struct pt_regs *regs)
+int be_ip27_handler(struct pt_regs *regs, int is_fixup)
 {
-	unsigned long fixup, errst0, errst1;
+	unsigned long errst0, errst1;
+	int data = regs->cp0_cause & 4;
 	int cpu = LOCAL_HUB_L(PI_CPU_NUM);
 
-	fixup = search_dbe_table(regs->cp0_epc);
-	if (fixup) {
-		long new_epc;
-
-		new_epc = fixup_exception(dpf_reg, fixup, regs->cp0_epc);
-		regs->cp0_epc = new_epc;
-		return;
-	}
+	if (is_fixup)
+		return MIPS_BE_FIXUP;
 
-	printk("Slice %c got dbe at 0x%lx\n", 'A' + cpu, regs->cp0_epc);
+	printk("Slice %c got %cbe at 0x%lx\n", 'A' + cpu, data ? 'd' : 'i',
+	       regs->cp0_epc);
 	printk("Hub information:\n");
 	printk("ERR_INT_PEND = 0x%06lx\n", LOCAL_HUB_L(PI_ERR_INT_PEND));
 	errst0 = LOCAL_HUB_L(cpu ? PI_ERR_STATUS0_B : PI_ERR_STATUS0_A);
@@ -97,8 +82,7 @@ void __init bus_error_init(void)
 	int cpu = LOCAL_HUB_L(PI_CPU_NUM);
 	int cpuoff = cpu << 8;
 
-	set_except_vector(6, handle_ip27_ibe);
-	set_except_vector(7, handle_ip27_dbe);
+	be_board_handler = be_ip27_handler;
 
 	LOCAL_HUB_S(PI_ERR_INT_PEND,
 	            cpu ? PI_ERR_CLEAR_ALL_B : PI_ERR_CLEAR_ALL_A);
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip27/ip27-dbe-glue.S linux-mips-2.4.18-20020625/arch/mips64/sgi-ip27/ip27-dbe-glue.S
--- linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip27/ip27-dbe-glue.S	2002-01-24 23:14:27.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips64/sgi-ip27/ip27-dbe-glue.S	1970-01-01 00:00:00.000000000 +0000
@@ -1,20 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1994 - 1999 by Ralf Baechle
- * Copyright (C) 1999 Silicon Graphics
- *
- * Low level exception handling
- */
-#define __ASSEMBLY__
-#include <linux/init.h>
-#include <asm/asm.h>
-#include <asm/regdef.h>
-#include <asm/fpregdef.h>
-#include <asm/mipsregs.h>
-#include <asm/exception.h>
-
-	BUILD_HANDLER ip27_ibe ip27_ibe cli silent		/* #6  */
-	BUILD_HANDLER ip27_dbe ip27_dbe cli silent		/* #7  */
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip32/Makefile linux-mips-2.4.18-20020625/arch/mips64/sgi-ip32/Makefile
--- linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip32/Makefile	2002-01-25 05:27:27.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips64/sgi-ip32/Makefile	2002-06-25 17:52:20.000000000 +0000
@@ -17,8 +17,8 @@ O_TARGET := ip32-kern.a
 
 all: ip32-kern.a ip32-irq-glue.o
 
-obj-y	+= ip32-rtc.o ip32-setup.o ip32-irq.o ip32-irq-glue.o ip32-timer.o \
-	   crime.o ip32-reset.o
+obj-y	+= ip32-berr.o ip32-rtc.o ip32-setup.o ip32-irq.o ip32-irq-glue.o \
+	   ip32-timer.o crime.o ip32-reset.o
 
 obj-$(CONFIG_PCI)   += ip32-pci.o
 
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip32/ip32-berr.c linux-mips-2.4.18-20020625/arch/mips64/sgi-ip32/ip32-berr.c
--- linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip32/ip32-berr.c	2001-08-24 18:10:59.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips64/sgi-ip32/ip32-berr.c	2002-06-25 19:46:03.000000000 +0000
@@ -5,78 +5,24 @@
  *
  * Copyright (C) 1994, 1995, 1996, 1999, 2000 by Ralf Baechle
  * Copyright (C) 1999, 2000 by Silicon Graphics
+ * Copyright (C) 2002  Maciej W. Rozycki
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <asm/traps.h>
 #include <asm/uaccess.h>
-#include <asm/paccess.h>
 #include <asm/addrspace.h>
 #include <asm/ptrace.h>
 
-/* XXX I have no idea what this does --kmw */
-
-extern asmlinkage void handle_ibe(void);
-extern asmlinkage void handle_dbe(void);
-
-extern const struct exception_table_entry __start___dbe_table[];
-extern const struct exception_table_entry __stop___dbe_table[];
-
-static inline unsigned long
-search_one_table(const struct exception_table_entry *first,
-                 const struct exception_table_entry *last,
-                 unsigned long value)
+int
+be_ip32_handler(struct pt_regs *regs, int is_fixup)
 {
-	while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
+	int data = regs->cp0_cause & 4;
 
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-		if (diff == 0)
-			return mid->nextinsn;
-		else if (diff < 0)
-			first = mid+1;
-		else
-			last = mid-1;
-	}
-	return 0;
-}
-
-static inline unsigned long
-search_dbe_table(unsigned long addr)
-{
-	unsigned long ret;
+	if (is_fixup)
+		return MIPS_BE_FIXUP;
 
-	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___dbe_table, __stop___dbe_table-1, addr);
-	if (ret) return ret;
-
-	return 0;
-}
-
-void do_ibe(struct pt_regs *regs)
-{
-	printk("Got ibe at 0x%lx\n", regs->cp0_epc);
-	show_regs(regs);
-	dump_tlb_addr(regs->cp0_epc);
-	force_sig(SIGBUS, current);
-	while(1);
-}
-
-void do_dbe(struct pt_regs *regs)
-{
-	unsigned long fixup;
-
-	fixup = search_dbe_table(regs->cp0_epc);
-	if (fixup) {
-		long new_epc;
-
-		new_epc = fixup_exception(dpf_reg, fixup, regs->cp0_epc);
-		regs->cp0_epc = new_epc;
-		return;
-	}
-
-	printk("Got dbe at 0x%lx\n", regs->cp0_epc);
+	printk("Got %cbe at 0x%lx\n", data ? 'd' : 'i', regs->cp0_epc);
 	show_regs(regs);
 	dump_tlb_all();
 	while(1);
@@ -86,12 +32,5 @@ void do_dbe(struct pt_regs *regs)
 void __init
 bus_error_init(void)
 {
-	int dummy;
-
-	set_except_vector(6, handle_ibe);
-	set_except_vector(7, handle_dbe);
-
-	/* At this time nothing uses the DBE protection mechanism on the
-	   O2, so this here is needed to make the kernel link.  */
-	get_dbe(dummy, (int *)KSEG0);
+	be_board_handler = be_ip27_handler;
 }
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip32/ip32-setup.c linux-mips-2.4.18-20020625/arch/mips64/sgi-ip32/ip32-setup.c
--- linux-mips-2.4.18-20020625.macro/arch/mips64/sgi-ip32/ip32-setup.c	2002-05-30 02:57:51.000000000 +0000
+++ linux-mips-2.4.18-20020625/arch/mips64/sgi-ip32/ip32-setup.c	2002-06-25 17:52:58.000000000 +0000
@@ -60,10 +60,6 @@ static inline void str2eaddr(unsigned ch
 
 extern void ip32_time_init(void);
 
-void __init bus_error_init(void)
-{
-}
-
 void __init ip32_setup(void)
 {
 #ifdef CONFIG_SERIAL_CONSOLE
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/include/asm-mips/traps.h linux-mips-2.4.18-20020625/include/asm-mips/traps.h
--- linux-mips-2.4.18-20020625.macro/include/asm-mips/traps.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.18-20020625/include/asm-mips/traps.h	2002-06-25 19:30:41.000000000 +0000
@@ -0,0 +1,27 @@
+/*
+ *	include/asm-mips/traps.h
+ *
+ *	Trap handling definitions.
+ *
+ *	Copyright (C) 2002  Maciej W. Rozycki
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_MIPS_TRAPS_H
+#define __ASM_MIPS_TRAPS_H
+
+/*
+ * Possible status responses for a be_board_handler backend.
+ */
+#define MIPS_BE_DISCARD	0		/* return with no action */
+#define MIPS_BE_FIXUP	1		/* return to the fixup code */
+#define MIPS_BE_FATAL	2		/* treat as an unrecoverable error */
+
+extern int (*be_board_handler)(struct pt_regs *regs, int is_fixup);
+
+extern void bus_error_init(void);
+
+#endif /* __ASM_MIPS_TRAPS_H */
diff -up --recursive --new-file linux-mips-2.4.18-20020625.macro/include/asm-mips64/traps.h linux-mips-2.4.18-20020625/include/asm-mips64/traps.h
--- linux-mips-2.4.18-20020625.macro/include/asm-mips64/traps.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.18-20020625/include/asm-mips64/traps.h	2002-06-25 19:31:45.000000000 +0000
@@ -0,0 +1,27 @@
+/*
+ *	include/asm-mips64/traps.h
+ *
+ *	Trap handling definitions.
+ *
+ *	Copyright (C) 2002  Maciej W. Rozycki
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_MIPS64_TRAPS_H
+#define __ASM_MIPS64_TRAPS_H
+
+/*
+ * Possible status responses for a be_board_handler backend.
+ */
+#define MIPS_BE_DISCARD	0		/* return with no action */
+#define MIPS_BE_FIXUP	1		/* return to the fixup code */
+#define MIPS_BE_FATAL	2		/* treat as an unrecoverable error */
+
+extern int (*be_board_handler)(struct pt_regs *regs, int is_fixup);
+
+extern void bus_error_init(void);
+
+#endif /* __ASM_MIPS64_TRAPS_H */
