Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 14:09:37 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:159 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225202AbTDNNJg>; Mon, 14 Apr 2003 14:09:36 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA25906;
	Mon, 14 Apr 2003 15:10:02 +0200 (MET DST)
Date: Mon, 14 Apr 2003 15:10:02 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [patch] Board bus error handler clean-ups
Message-ID: <Pine.GSO.3.96.1030414144912.24742D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Here is a patch that replaces the current temporary hack for board bus
error handler initializers with the proper approach allowing platforms to
install them dynamically, similarly to timer initializers.  It also
trivially changes the names to follow other patterns. 

 As a side effect it nukes zillions of empty functions for platforms that
don't have extra bus error functionality. 

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-pre4-20030411-mips-be-1
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/au1000/db1x00/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/au1000/db1x00/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/au1000/db1x00/setup.c	2003-03-22 03:56:27.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/au1000/db1x00/setup.c	2003-04-13 17:53:02.000000000 +0000
@@ -73,8 +73,6 @@ extern phys_t (*fixup_bigphys_addr)(phys
 static phys_t db_fixup_bigphys_addr(phys_t phys_addr, phys_t size);
 #endif
 
-void __init bus_error_init(void) { /* nothing */ }
-
 void __init au1x00_setup(void)
 {
 	char *argptr;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/au1000/pb1000/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/au1000/pb1000/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/au1000/pb1000/setup.c	2003-03-22 03:56:27.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/au1000/pb1000/setup.c	2003-04-13 17:53:06.000000000 +0000
@@ -75,8 +75,6 @@ extern void au1000_power_off(void);
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
 
-void __init bus_error_init(void) { /* nothing */ }
-
 void __init au1x00_setup(void)
 {
 	char *argptr;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/au1000/pb1100/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/au1000/pb1100/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/au1000/pb1100/setup.c	2003-03-22 03:56:27.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/au1000/pb1100/setup.c	2003-04-13 17:53:12.000000000 +0000
@@ -79,8 +79,6 @@ extern struct resource ioport_resource;
 extern struct resource iomem_resource;
 
 
-void __init bus_error_init(void) { /* nothing */ }
-
 void __init au1x00_setup(void)
 {
 	char *argptr;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/au1000/pb1500/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/au1000/pb1500/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/au1000/pb1500/setup.c	2003-03-22 03:56:27.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/au1000/pb1500/setup.c	2003-04-13 17:53:17.000000000 +0000
@@ -83,8 +83,6 @@ static phys_t pb1500_fixup_bigphys_addr(
 #endif
 
 
-void __init bus_error_init(void) { /* nothing */ }
-
 void __init au1x00_setup(void)
 {
 	char *argptr;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/cobalt/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/cobalt/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/cobalt/setup.c	2003-03-10 03:56:27.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/cobalt/setup.c	2003-04-13 17:51:12.000000000 +0000
@@ -73,9 +73,6 @@ static void __init cobalt_timer_setup(st
 }
 
 
-void __init bus_error_init(void) { /* nothing */ }
-
-
 void __init cobalt_setup(void)
 {
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/ddb5xxx/ddb5074/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/ddb5xxx/ddb5074/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/ddb5xxx/ddb5074/setup.c	2003-02-27 03:56:30.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/ddb5xxx/ddb5074/setup.c	2003-04-13 17:51:33.000000000 +0000
@@ -81,10 +81,6 @@ extern void rtc_ds1386_init(unsigned lon
 
 extern void (*board_timer_setup) (struct irqaction * irq);
 
-void __init bus_error_init(void)
-{
-}
-
 static void __init ddb_timer_init(struct irqaction *irq)
 {
 	/* set the clock to 1 Hz */
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/ddb5xxx/ddb5476/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/ddb5xxx/ddb5476/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/ddb5xxx/ddb5476/setup.c	2003-02-27 03:56:30.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/ddb5xxx/ddb5476/setup.c	2003-04-13 17:51:33.000000000 +0000
@@ -140,9 +140,6 @@ static struct {
 };
 
 
-void __init bus_error_init(void) { /* nothing */ }
-
-
 static void ddb5476_board_init(void);
 extern void ddb5476_irq_setup(void);
 extern void (*irq_setup)(void);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/ddb5xxx/ddb5477/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/ddb5xxx/ddb5477/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/ddb5xxx/ddb5477/setup.c	2003-04-07 02:56:23.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/ddb5xxx/ddb5477/setup.c	2003-04-13 17:51:33.000000000 +0000
@@ -168,8 +168,6 @@ static void __init ddb_timer_setup(struc
 #endif
 }
 
-void __init bus_error_init(void) { /* nothing */ }
-
 static void ddb5477_board_init(void);
 extern void ddb5477_irq_setup(void);
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/galileo-boards/ev64120/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/galileo-boards/ev64120/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/galileo-boards/ev64120/setup.c	2002-12-04 03:56:25.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/galileo-boards/ev64120/setup.c	2003-04-11 17:47:10.000000000 +0000
@@ -107,9 +107,6 @@ struct rtc_ops galileo_rtc_ops = {
 };
 
 
-void __init bus_error_init(void) { /* nothing */ }
-
-
 /********************************************************************
  *ev64120_setup -
  *
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/galileo-boards/ev96100/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/galileo-boards/ev96100/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/galileo-boards/ev96100/setup.c	2002-12-04 03:56:25.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/galileo-boards/ev96100/setup.c	2003-04-11 17:46:49.000000000 +0000
@@ -65,10 +65,6 @@ extern struct resource ioport_resource;
 
 unsigned char mac_0_1[12];
 
-void __init bus_error_init(void)
-{
-}
-
 void __init ev96100_setup(void)
 {
 	unsigned int config = read_c0_config();
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/gt64120/momenco_ocelot/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/gt64120/momenco_ocelot/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/gt64120/momenco_ocelot/setup.c	2002-12-04 03:56:25.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/gt64120/momenco_ocelot/setup.c	2003-04-11 17:46:33.000000000 +0000
@@ -83,7 +83,6 @@ static char reset_reason;
 #define ENTRYLO(x) ((pte_val(mk_pte_phys((x), PAGE_KERNEL_UNCACHED)) >> 6)|1)
 
 static void __init setup_l3cache(unsigned long size);
-void __init bus_error_init(void) { /* nothing */ }
 
 /* setup code for a handoff from a version 1 PMON 2000 PROM */
 void PMON_v1_setup()
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/ite-boards/generic/it8172_setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/ite-boards/generic/it8172_setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/ite-boards/generic/it8172_setup.c	2002-12-04 03:56:26.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/ite-boards/generic/it8172_setup.c	2003-04-11 17:46:17.000000000 +0000
@@ -115,9 +115,6 @@ struct {
 #endif
 
 
-void __init bus_error_init(void) { /* nothing */ }
-
-
 void __init it8172_init_ram_resource(unsigned long memsize)
 {
 	it8172_resources.ram.end = memsize;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/jazz/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/jazz/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/jazz/setup.c	2002-12-04 03:56:26.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/jazz/setup.c	2003-04-11 17:46:00.000000000 +0000
@@ -82,9 +82,6 @@ static void __init jazz_irq_setup(void)
 }
 
 
-void __init bus_error_init(void) { /* nothing */ }
-
-
 void __init jazz_setup(void)
 {
 	/* Map 0xe0000000 -> 0x0:800005C0, 0xe0010000 -> 0x1:30000580 */
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/jmr3927/rbhma3100/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/jmr3927/rbhma3100/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/jmr3927/rbhma3100/setup.c	2002-12-04 03:56:26.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/jmr3927/rbhma3100/setup.c	2003-04-11 17:45:30.000000000 +0000
@@ -184,9 +184,6 @@ unsigned long jmr3927_do_gettimeoffset(v
 }
 
 
-void __init bus_error_init(void) { /* nothing */ }
-
-
 #if defined(CONFIG_BLK_DEV_INITRD)
 extern unsigned long __rd_start, __rd_end, initrd_start, initrd_end;
 #endif
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/kernel/traps.c linux-mips-2.4.21-pre4-20030411/arch/mips/kernel/traps.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/kernel/traps.c	2003-04-09 02:56:54.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/kernel/traps.c	2003-04-13 17:51:33.000000000 +0000
@@ -10,7 +10,7 @@
  *
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
- * Copyright (C) 2002  Maciej W. Rozycki
+ * Copyright (C) 2002, 2003  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -62,7 +62,8 @@ extern asmlinkage void handle_reserved(v
 extern int fpu_emulator_cop1Handler(int xcptno, struct pt_regs *xcp,
 	struct mips_fpu_soft_struct *ctx);
 
-int (*be_board_handler)(struct pt_regs *regs, int is_fixup);
+void (*board_be_init)(void);
+int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 
 int kstack_depth_to_print = 24;
 
@@ -472,8 +473,8 @@ asmlinkage void do_be(struct pt_regs *re
 	if (fixup)
 		action = MIPS_BE_FIXUP;
 
-	if (be_board_handler)
-		action = be_board_handler(regs, fixup != 0);
+	if (board_be_handler)
+		action = board_be_handler(regs, fixup != 0);
 
 	switch (action) {
 	case MIPS_BE_DISCARD:
@@ -960,7 +961,8 @@ void __init trap_init(void)
 	 * by external hardware.  Therefore these two exceptions
 	 * may have board specific handlers.
 	 */
-	bus_error_init();
+	if (board_be_init)
+		board_be_init();
 
 	set_except_vector(1, handle_mod);
 	set_except_vector(2, handle_tlbl);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/lasat/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/lasat/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/lasat/setup.c	2003-02-25 03:56:37.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/lasat/setup.c	2003-04-13 17:51:33.000000000 +0000
@@ -73,8 +73,6 @@ extern void pcisetup(void);
 extern void edhac_init(void *, void *, void *);
 extern void addrflt_init(void);
 
-void __init bus_error_init(void) { /* nothing */ }
-
 struct lasat_misc lasat_misc_info[N_MACHTYPES] = {
 	{(void *)KSEG1ADDR(0x1c840000), (void *)KSEG1ADDR(0x1c800000), 2},
 	{(void *)KSEG1ADDR(0x11080000), (void *)KSEG1ADDR(0x11000000), 6}
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/mips-boards/atlas/atlas_setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/mips-boards/atlas/atlas_setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/mips-boards/atlas/atlas_setup.c	2003-04-09 02:56:55.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/mips-boards/atlas/atlas_setup.c	2003-04-13 17:51:33.000000000 +0000
@@ -54,10 +54,6 @@ const char *get_system_type(void)
 	return "MIPS Atlas";
 }
 
-void __init bus_error_init(void)
-{
-}
-
 extern void mips_time_init(void);
 extern void mips_timer_setup(struct irqaction *irq);
 extern unsigned long mips_rtc_get_time(void);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/mips-boards/malta/malta_setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/mips-boards/malta/malta_setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/mips-boards/malta/malta_setup.c	2003-04-09 02:56:55.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/mips-boards/malta/malta_setup.c	2003-04-13 17:51:33.000000000 +0000
@@ -80,10 +80,6 @@ const char *get_system_type(void)
 	return "MIPS Malta";
 }
 
-void __init bus_error_init(void)
-{
-}
-
 void __init malta_setup(void)
 {
 #ifdef CONFIG_KGDB
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/mips-boards/sead/sead_setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/mips-boards/sead/sead_setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/mips-boards/sead/sead_setup.c	2003-04-09 02:56:55.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/mips-boards/sead/sead_setup.c	2003-04-13 17:51:33.000000000 +0000
@@ -45,10 +45,6 @@ const char *get_system_type(void)
 	return "MIPS SEAD";
 }
 
-void __init bus_error_init(void)
-{
-}
-
 void __init sead_setup(void)
 {
 	char *argptr;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/momentum/ocelot_c/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/momentum/ocelot_c/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/momentum/ocelot_c/setup.c	2002-11-11 23:05:46.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/momentum/ocelot_c/setup.c	2003-04-11 17:44:05.000000000 +0000
@@ -82,8 +82,6 @@ static char reset_reason;
 
 #define ENTRYLO(x) ((pte_val(mk_pte_phys((x), PAGE_KERNEL_UNCACHED)) >> 6)|1)
 
-void __init bus_error_init(void) { /* nothing */ }
-
 /* setup code for a handoff from a version 2 PMON 2000 PROM */
 void PMON_v2_setup(void)
 {
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/momentum/ocelot_g/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/momentum/ocelot_g/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/momentum/ocelot_g/setup.c	2002-12-04 03:56:37.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/momentum/ocelot_g/setup.c	2003-04-11 17:43:40.000000000 +0000
@@ -90,8 +90,6 @@ static char reset_reason;
 
 static void __init setup_l3cache(unsigned long size);
 
-void __init bus_error_init(void) { /* nothing */ }
-
 /* setup code for a handoff from a version 2 PMON 2000 PROM */
 void PMON_v2_setup(void)
 {
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/philips/nino/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/philips/nino/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/philips/nino/setup.c	2002-06-27 02:57:25.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/philips/nino/setup.c	2003-04-11 17:43:22.000000000 +0000
@@ -83,9 +83,6 @@ static __init void nino_timer_setup(stru
 }
 
 
-void __init bus_error_init(void) { /* nothing */ }
-
-
 void __init nino_setup(void)
 {
 	extern void nino_irq_setup(void);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip22/ip22-berr.c linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip22/ip22-berr.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip22/ip22-berr.c	2003-03-25 03:56:42.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip22/ip22-berr.c	2003-04-13 17:51:33.000000000 +0000
@@ -68,7 +68,7 @@ static void print_buserr(void)
  * and then clear the interrupt when this happens.
  */
 
-void be_ip22_interrupt(int irq, struct pt_regs *regs)
+void ip22_be_interrupt(int irq, struct pt_regs *regs)
 {
 	save_and_clear_buserr();
 	print_buserr();
@@ -76,7 +76,7 @@ void be_ip22_interrupt(int irq, struct p
 	      regs->cp0_epc, regs->regs[31]);
 }
 
-int be_ip22_handler(struct pt_regs *regs, int is_fixup)
+int ip22_be_handler(struct pt_regs *regs, int is_fixup)
 {
 	save_and_clear_buserr();
 	if (is_fixup)
@@ -85,7 +85,7 @@ int be_ip22_handler(struct pt_regs *regs
 	return MIPS_BE_FATAL;
 }
 
-void __init bus_error_init(void)
+void __init ip22_be_init(void)
 {
-	be_board_handler = be_ip22_handler;
+	board_be_handler = ip22_be_handler;
 }
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip22/ip22-int.c linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip22/ip22-int.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip22/ip22-int.c	2003-03-25 03:56:42.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip22/ip22-int.c	2003-04-13 17:51:33.000000000 +0000
@@ -266,7 +266,7 @@ void indy_local1_irqdispatch(struct pt_r
 	return;
 }
 
-extern void be_ip22_interrupt(int irq, struct pt_regs *regs);
+extern void ip22_be_interrupt(int irq, struct pt_regs *regs);
 
 void indy_buserror_irq(struct pt_regs *regs)
 {
@@ -275,7 +275,7 @@ void indy_buserror_irq(struct pt_regs *r
 
 	irq_enter(cpu, irq);
 	kstat.irqs[cpu][irq]++;
-	be_ip22_interrupt(irq, regs);
+	ip22_be_interrupt(irq, regs);
 	irq_exit(cpu, irq);
 }
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip22/ip22-setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip22/ip22-setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip22/ip22-setup.c	2003-03-29 03:56:31.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip22/ip22-setup.c	2003-04-13 17:51:33.000000000 +0000
@@ -128,7 +128,10 @@ void __init ip22_setup(void)
 #ifdef CONFIG_KGDB
 	char *kgdb_ttyd;
 #endif
+
+	board_be_init = ip22_be_init;
 	sgitime_init();
+
 	/* Init the INDY HPC I/O controller.  Need to call this before
 	 * fucking with the memory controller because it needs to know the
 	 * boardID and whether this is a Guiness or a FullHouse machine.
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip27/ip27-berr.c linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip27/ip27-berr.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip27/ip27-berr.c	2002-09-16 02:58:06.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip27/ip27-berr.c	2003-04-11 17:40:44.000000000 +0000
@@ -52,7 +52,7 @@ static void dump_hub_information(unsigne
 		? : "invalid");
 }
 
-int be_ip27_handler(struct pt_regs *regs, int is_fixup)
+int ip27_be_handler(struct pt_regs *regs, int is_fixup)
 {
 	unsigned long errst0, errst1;
 	int data = regs->cp0_cause & 4;
@@ -74,13 +74,13 @@ int be_ip27_handler(struct pt_regs *regs
 	force_sig(SIGBUS, current);
 }
 
-void __init bus_error_init(void)
+void __init ip27_be_init(void)
 {
 	/* XXX Initialize all the Hub & Bridge error handling here.  */
 	int cpu = LOCAL_HUB_L(PI_CPU_NUM);
 	int cpuoff = cpu << 8;
 
-	be_board_handler = be_ip27_handler;
+	board_be_handler = ip27_be_handler;
 
 	LOCAL_HUB_S(PI_ERR_INT_PEND,
 	            cpu ? PI_ERR_CLEAR_ALL_B : PI_ERR_CLEAR_ALL_A);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip27/ip27-setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip27/ip27-setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip27/ip27-setup.c	2002-11-30 03:57:35.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip27/ip27-setup.c	2003-04-11 18:04:07.000000000 +0000
@@ -29,6 +29,7 @@
 #include <asm/pci/bridge.h>
 #include <asm/paccess.h>
 #include <asm/sn/sn0/ip27.h>
+#include <asm/traps.h>
 
 /* Check against user dumbness.  */
 #ifdef CONFIG_VT
@@ -312,5 +313,7 @@ void __init ip27_setup(void)
 	per_cpu_init();
 
 	set_io_port_base(IO_BASE);
+
+	board_be_init = ip27_be_init;
 	board_time_init = ip27_time_init;
 }
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip32/ip32-berr.c linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip32/ip32-berr.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip32/ip32-berr.c	2002-09-29 02:56:24.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip32/ip32-berr.c	2003-04-11 17:39:24.000000000 +0000
@@ -15,7 +15,7 @@
 #include <asm/ptrace.h>
 #include <asm/tlbdebug.h>
 
-int be_ip32_handler(struct pt_regs *regs, int is_fixup)
+int ip32_be_handler(struct pt_regs *regs, int is_fixup)
 {
 	int data = regs->cp0_cause & 4;
 
@@ -29,7 +29,7 @@ int be_ip32_handler(struct pt_regs *regs
 	force_sig(SIGBUS, current);
 }
 
-void __init bus_error_init(void)
+void __init ip32_be_init(void)
 {
-	be_board_handler = be_ip32_handler;
+	board_be_handler = ip32_be_handler;
 }
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip32/ip32-setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip32/ip32-setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sgi-ip32/ip32-setup.c	2002-09-23 11:59:26.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/sgi-ip32/ip32-setup.c	2003-04-11 18:06:22.000000000 +0000
@@ -22,6 +22,7 @@
 #include <asm/ip32/mace.h>
 #include <asm/ip32/ip32_ints.h>
 #include <asm/sgialib.h>
+#include <asm/traps.h>
 
 extern struct rtc_ops ip32_rtc_ops;
 extern u32 cc_interval;
@@ -93,6 +94,7 @@ void __init ip32_setup(void)
 	ip32_reboot_setup();
 
 	rtc_ops = &ip32_rtc_ops;
+	board_be_init = ip32_be_init;
 	board_time_init = ip32_time_init;
 
 	crime_init ();
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sibyte/swarm/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/sibyte/swarm/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sibyte/swarm/setup.c	2003-02-08 03:56:26.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/sibyte/swarm/setup.c	2003-04-11 17:36:00.000000000 +0000
@@ -52,10 +52,6 @@ const char *get_system_type(void)
 }
 
 
-void __init bus_error_init(void)
-{
-}
-
 void __init swarm_timer_setup(struct irqaction *irq)
 {
         /*
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sni/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/sni/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/sni/setup.c	2002-06-27 02:57:26.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/sni/setup.c	2003-04-11 17:35:38.000000000 +0000
@@ -51,9 +51,6 @@ static void __init sni_rm200_pci_time_in
 }
 
 
-void __init bus_error_init(void) { /* nothing */ }
-
-
 extern unsigned char sni_map_isa_cache;
 
 /*
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr4181/osprey/setup.c linux-mips-2.4.21-pre4-20030411/arch/mips/vr4181/osprey/setup.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr4181/osprey/setup.c	2002-12-04 03:56:38.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/vr4181/osprey/setup.c	2003-04-11 17:35:15.000000000 +0000
@@ -32,10 +32,6 @@ extern void nec_osprey_power_off(void);
 extern void vr4181_init_serial(void);
 extern void vr4181_init_time(void);
 
-void __init bus_error_init(void)
-{
-}
-
 void __init nec_osprey_setup(void)
 {
 	set_io_port_base(VR4181_PORT_BASE);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/casio-e55/init.c linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/casio-e55/init.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/casio-e55/init.c	2002-10-03 16:58:02.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/casio-e55/init.c	2003-04-11 17:34:56.000000000 +0000
@@ -27,10 +27,6 @@ const char *get_system_type(void)
 	return "CASIO CASSIOPEIA E-11/15/55/65";
 }
 
-void __init bus_error_init(void)
-{
-}
-
 void __init prom_init(int argc, char **argv, unsigned long magic, int *prom_vec)
 {
 	int i;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/ibm-workpad/init.c linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/ibm-workpad/init.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/ibm-workpad/init.c	2002-10-03 16:58:02.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/ibm-workpad/init.c	2003-04-11 17:34:40.000000000 +0000
@@ -27,10 +27,6 @@ const char *get_system_type(void)
 	return "IBM WorkPad z50";
 }
 
-void __init bus_error_init(void)
-{
-}
-
 void __init prom_init(int argc, char **argv, unsigned long magic, int *prom_vec)
 {
 	int i;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/nec-eagle/init.c linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/nec-eagle/init.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/nec-eagle/init.c	2002-07-15 00:02:56.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/nec-eagle/init.c	2003-04-11 17:34:23.000000000 +0000
@@ -52,10 +52,6 @@ const char *get_system_type(void)
 	return "NEC Eagle/Hawk";
 }
 
-void __init bus_error_init(void)
-{
-}
-
 void __init prom_init(int argc, char **argv, unsigned long magic, int *prom_vec)
 {
 	int i;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/tanbac-tb0226/init.c linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/tanbac-tb0226/init.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/tanbac-tb0226/init.c	2003-04-07 02:56:30.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/tanbac-tb0226/init.c	2003-04-13 17:51:33.000000000 +0000
@@ -30,10 +30,6 @@ const char *get_system_type(void)
 	return "TANBAC TB0226";
 }
 
-void __init bus_error_init(void)
-{
-}
-
 void __init prom_init(int argc, char **argv, unsigned long magic, int *prom_vec)
 {
 	u32 config;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/victor-mpc30x/init.c linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/victor-mpc30x/init.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/victor-mpc30x/init.c	2002-10-03 16:58:02.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/victor-mpc30x/init.c	2003-04-11 17:33:48.000000000 +0000
@@ -30,10 +30,6 @@ const char *get_system_type(void)
 	return "Victor MP-C303/304";
 }
 
-void __init bus_error_init(void)
-{
-}
-
 void __init prom_init(int argc, char **argv, unsigned long magic, int *prom_vec)
 {
 	int i;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/zao-capcella/init.c linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/zao-capcella/init.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips/vr41xx/zao-capcella/init.c	2003-04-07 02:56:30.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips/vr41xx/zao-capcella/init.c	2003-04-13 17:51:33.000000000 +0000
@@ -30,10 +30,6 @@ const char *get_system_type(void)
 	return "ZAO Networks Capcella";
 }
 
-void __init bus_error_init(void)
-{
-}
-
 void __init prom_init(int argc, char **argv, unsigned long magic, int *prom_vec)
 {
 	u32 config;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/arch/mips64/kernel/traps.c linux-mips-2.4.21-pre4-20030411/arch/mips64/kernel/traps.c
--- linux-mips-2.4.21-pre4-20030411.macro/arch/mips64/kernel/traps.c	2003-04-09 02:56:57.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/arch/mips64/kernel/traps.c	2003-04-13 17:51:33.000000000 +0000
@@ -7,7 +7,7 @@
  * Copyright (C) 1995, 1996 Paul M. Antoine
  * Copyright (C) 1998 Ulf Carlsson
  * Copyright (C) 1999 Silicon Graphics, Inc.
- * Copyright (C) 2002  Maciej W. Rozycki
+ * Copyright (C) 2002, 2003  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -59,7 +59,8 @@ extern int fpu_emulator_cop1Handler(int 
 
 void fpu_emulator_init_fpu(void);
 
-int (*be_board_handler)(struct pt_regs *regs, int is_fixup);
+void (*board_be_init)(void);
+int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 
 int kstack_depth_to_print = 24;
 
@@ -366,8 +367,8 @@ asmlinkage void do_be(struct pt_regs *re
 	if (fixup)
 		action = MIPS_BE_FIXUP;
 
-	if (be_board_handler)
-		action = be_board_handler(regs, fixup != 0);
+	if (board_be_handler)
+		action = board_be_handler(regs, fixup != 0);
 
 	switch (action) {
 	case MIPS_BE_DISCARD:
@@ -708,7 +709,8 @@ void __init trap_init(void)
 	 * by external hardware.  Therefore these two exceptions
 	 * may have board specific handlers.
 	 */
-	bus_error_init();
+	if (board_be_init)
+		board_be_init();
 
 	set_except_vector(1, __xtlb_mod);
 	set_except_vector(2, __xtlb_tlbl);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/include/asm-mips/traps.h linux-mips-2.4.21-pre4-20030411/include/asm-mips/traps.h
--- linux-mips-2.4.21-pre4-20030411.macro/include/asm-mips/traps.h	2002-06-26 12:22:42.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/include/asm-mips/traps.h	2003-04-11 18:15:03.000000000 +0000
@@ -3,7 +3,7 @@
  *
  *	Trap handling definitions.
  *
- *	Copyright (C) 2002  Maciej W. Rozycki
+ *	Copyright (C) 2002, 2003  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -14,14 +14,13 @@
 #define __ASM_MIPS_TRAPS_H
 
 /*
- * Possible status responses for a be_board_handler backend.
+ * Possible status responses for a board_be_handler backend.
  */
 #define MIPS_BE_DISCARD	0		/* return with no action */
 #define MIPS_BE_FIXUP	1		/* return to the fixup code */
 #define MIPS_BE_FATAL	2		/* treat as an unrecoverable error */
 
-extern int (*be_board_handler)(struct pt_regs *regs, int is_fixup);
-
-extern void bus_error_init(void);
+extern void (*board_be_init)(void);
+extern int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 
 #endif /* __ASM_MIPS_TRAPS_H */
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030411.macro/include/asm-mips64/traps.h linux-mips-2.4.21-pre4-20030411/include/asm-mips64/traps.h
--- linux-mips-2.4.21-pre4-20030411.macro/include/asm-mips64/traps.h	2002-06-26 12:22:42.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030411/include/asm-mips64/traps.h	2003-04-11 18:15:09.000000000 +0000
@@ -3,7 +3,7 @@
  *
  *	Trap handling definitions.
  *
- *	Copyright (C) 2002  Maciej W. Rozycki
+ *	Copyright (C) 2002, 2003  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -14,14 +14,13 @@
 #define __ASM_MIPS64_TRAPS_H
 
 /*
- * Possible status responses for a be_board_handler backend.
+ * Possible status responses for a board_be_handler backend.
  */
 #define MIPS_BE_DISCARD	0		/* return with no action */
 #define MIPS_BE_FIXUP	1		/* return to the fixup code */
 #define MIPS_BE_FATAL	2		/* treat as an unrecoverable error */
 
-extern int (*be_board_handler)(struct pt_regs *regs, int is_fixup);
-
-extern void bus_error_init(void);
+extern void (*board_be_init)(void);
+extern int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 
 #endif /* __ASM_MIPS64_TRAPS_H */
