Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2007 14:42:46 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:34635 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20028089AbXJZNmh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2007 14:42:37 +0100
Received: by mo.po.2iij.net (mo31) id l9QDgYNw081158; Fri, 26 Oct 2007 22:42:34 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox304) id l9QDgWka021263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 26 Oct 2007 22:42:33 +0900
Date:	Fri, 26 Oct 2007 22:42:31 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused mips_machtype
Message-Id: <20071026224231.1aaddf3e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Removed unused mips_machtype.
These are only set though are not used.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/db1x00/init.c mips/arch/mips/au1000/db1x00/init.c
--- mips-orig/arch/mips/au1000/db1x00/init.c	2007-10-14 17:06:38.150615000 +0900
+++ mips/arch/mips/au1000/db1x00/init.c	2007-10-14 17:06:43.750965000 +0900
@@ -57,17 +57,6 @@ void __init prom_init(void)
 	prom_argv = (char **) fw_arg1;
 	prom_envp = (char **) fw_arg2;
 
-	/* Set the platform # */
-#if	defined(CONFIG_MIPS_DB1550)
-	mips_machtype = MACH_DB1550;
-#elif	defined(CONFIG_MIPS_DB1500)
-	mips_machtype = MACH_DB1500;
-#elif	defined(CONFIG_MIPS_DB1100)
-	mips_machtype = MACH_DB1100;
-#else
-	mips_machtype = MACH_DB1000;
-#endif
-
 	prom_init_cmdline();
 
 	memsize_str = prom_getenv("memsize");
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/mtx-1/init.c mips/arch/mips/au1000/mtx-1/init.c
--- mips-orig/arch/mips/au1000/mtx-1/init.c	2007-10-14 17:06:38.158615500 +0900
+++ mips/arch/mips/au1000/mtx-1/init.c	2007-10-14 17:06:43.766966000 +0900
@@ -54,8 +54,6 @@ void __init prom_init(void)
 	prom_argv = (char **) fw_arg1;
 	prom_envp = (char **) fw_arg2;
 
-	mips_machtype = MACH_MTX1;	/* set the platform # */
-
 	prom_init_cmdline();
 
 	memsize_str = prom_getenv("memsize");
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1000/init.c mips/arch/mips/au1000/pb1000/init.c
--- mips-orig/arch/mips/au1000/pb1000/init.c	2007-10-14 17:06:38.170616250 +0900
+++ mips/arch/mips/au1000/pb1000/init.c	2007-10-14 17:06:43.782967000 +0900
@@ -52,8 +52,6 @@ void __init prom_init(void)
 	prom_argv = (char **) fw_arg1;
 	prom_envp = (char **) fw_arg2;
 
-	mips_machtype = MACH_PB1000;
-
 	prom_init_cmdline();
 	memsize_str = prom_getenv("memsize");
 	if (!memsize_str) {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1100/init.c mips/arch/mips/au1000/pb1100/init.c
--- mips-orig/arch/mips/au1000/pb1100/init.c	2007-10-14 17:06:38.190617500 +0900
+++ mips/arch/mips/au1000/pb1100/init.c	2007-10-14 17:06:43.802968250 +0900
@@ -53,8 +53,6 @@ void __init prom_init(void)
 	prom_argv = (char **) fw_arg1;
 	prom_envp = (char **) fw_arg3;
 
-	mips_machtype = MACH_PB1100;
-
 	prom_init_cmdline();
 
 	memsize_str = prom_getenv("memsize");
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1200/init.c mips/arch/mips/au1000/pb1200/init.c
--- mips-orig/arch/mips/au1000/pb1200/init.c	2007-10-14 17:06:38.230620000 +0900
+++ mips/arch/mips/au1000/pb1200/init.c	2007-10-14 17:06:43.822969500 +0900
@@ -53,8 +53,6 @@ void __init prom_init(void)
 	prom_argv = (char **) fw_arg1;
 	prom_envp = (char **) fw_arg2;
 
-	mips_machtype = MACH_PB1200;
-
 	prom_init_cmdline();
 	memsize_str = prom_getenv("memsize");
 	if (!memsize_str) {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1500/init.c mips/arch/mips/au1000/pb1500/init.c
--- mips-orig/arch/mips/au1000/pb1500/init.c	2007-10-14 17:06:38.262622000 +0900
+++ mips/arch/mips/au1000/pb1500/init.c	2007-10-14 17:06:43.830970000 +0900
@@ -53,8 +53,6 @@ void __init prom_init(void)
 	prom_argv = (char **) fw_arg1;
 	prom_envp = (char **) fw_arg2;
 
-	mips_machtype = MACH_PB1500;
-
 	prom_init_cmdline();
 	memsize_str = prom_getenv("memsize");
 	if (!memsize_str) {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1550/init.c mips/arch/mips/au1000/pb1550/init.c
--- mips-orig/arch/mips/au1000/pb1550/init.c	2007-10-14 17:06:38.294624000 +0900
+++ mips/arch/mips/au1000/pb1550/init.c	2007-10-14 17:06:43.874972750 +0900
@@ -53,8 +53,6 @@ void __init prom_init(void)
 	prom_argv = (char **) fw_arg1;
 	prom_envp = (char **) fw_arg2;
 
-	mips_machtype = MACH_PB1550;
-
 	prom_init_cmdline();
 	memsize_str = prom_getenv("memsize");
 	if (!memsize_str) {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/xxs1500/init.c mips/arch/mips/au1000/xxs1500/init.c
--- mips-orig/arch/mips/au1000/xxs1500/init.c	2007-10-14 17:06:38.314625250 +0900
+++ mips/arch/mips/au1000/xxs1500/init.c	2007-10-14 17:06:43.934976500 +0900
@@ -52,8 +52,6 @@ void __init prom_init(void)
 	prom_argv = (char **) fw_arg1;
 	prom_envp = (char **) fw_arg2;
 
-	mips_machtype = MACH_XXS1500;	/* set the platform # */
-
 	prom_init_cmdline();
 
 	memsize_str = prom_getenv("memsize");
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/basler/excite/excite_prom.c mips/arch/mips/basler/excite/excite_prom.c
--- mips-orig/arch/mips/basler/excite/excite_prom.c	2007-10-14 16:25:10.399947250 +0900
+++ mips/arch/mips/basler/excite/excite_prom.c	2007-10-14 17:06:43.962978250 +0900
@@ -135,8 +135,6 @@ void __init prom_init(void)
 #ifdef CONFIG_64BIT
 #	error 64 bit support not implemented
 #endif /* CONFIG_64BIT */
-
-	mips_machtype = MACH_TITAN_EXCITE;
 }
 
 /* This is called from free_initmem(), so we need to provide it */
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/setup.c mips/arch/mips/gt64120/wrppmc/setup.c
--- mips-orig/arch/mips/gt64120/wrppmc/setup.c	2007-10-14 16:25:13.676152000 +0900
+++ mips/arch/mips/gt64120/wrppmc/setup.c	2007-10-14 17:06:43.990980000 +0900
@@ -121,8 +121,6 @@ const char *get_system_type(void)
  */
 void __init prom_init(void)
 {
-	mips_machtype = MACH_WRPPMC;
-
 	add_memory_region(WRPPMC_SDRAM_SCS0_BASE, WRPPMC_SDRAM_SCS0_SIZE, BOOT_MEM_RAM);
 	add_memory_region(WRPPMC_BOOTROM_BASE, WRPPMC_BOOTROM_SIZE, BOOT_MEM_ROM_DATA);
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/jmr3927/rbhma3100/init.c mips/arch/mips/jmr3927/rbhma3100/init.c
--- mips-orig/arch/mips/jmr3927/rbhma3100/init.c	2007-10-14 16:25:13.856163250 +0900
+++ mips/arch/mips/jmr3927/rbhma3100/init.c	2007-10-14 17:06:44.002980750 +0900
@@ -52,10 +52,6 @@ void __init prom_init(void)
 		puts("Warning: TX3927 TLB off\n");
 #endif
 
-#ifdef CONFIG_TOSHIBA_JMR3927
-	mips_machtype = MACH_TOSHIBA_JMR3927;
-#endif
-
 	prom_init_cmdline();
 	add_memory_region(0, JMR3927_SDRAM_SIZE, BOOT_MEM_RAM);
 }
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/lemote/lm2e/prom.c mips/arch/mips/lemote/lm2e/prom.c
--- mips-orig/arch/mips/lemote/lm2e/prom.c	2007-10-14 16:25:15.564270000 +0900
+++ mips/arch/mips/lemote/lm2e/prom.c	2007-10-14 17:06:44.034982750 +0900
@@ -57,8 +57,6 @@ void __init prom_init(void)
 	arg = (int *)fw_arg1;
 	env = (int *)fw_arg2;
 
-	mips_machtype = MACH_LEMOTE_FULONG;
-
 	prom_init_cmdline();
 
 	if ((strstr(arcs_cmdline, "console=")) == NULL)
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/philips/pnx8550/jbs/init.c mips/arch/mips/philips/pnx8550/jbs/init.c
--- mips-orig/arch/mips/philips/pnx8550/jbs/init.c	2007-10-14 16:25:18.972483000 +0900
+++ mips/arch/mips/philips/pnx8550/jbs/init.c	2007-10-14 17:06:44.054984000 +0900
@@ -45,11 +45,8 @@ const char *get_system_type(void)
 
 void __init prom_init(void)
 {
-
 	unsigned long memsize;
 
-	mips_machtype = MACH_PHILIPS_JBS;
-
 	//memsize = 0x02800000; /* Trimedia uses memory above */
 	memsize = 0x08000000; /* Trimedia uses memory above */
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/philips/pnx8550/stb810/prom_init.c mips/arch/mips/philips/pnx8550/stb810/prom_init.c
--- mips-orig/arch/mips/philips/pnx8550/stb810/prom_init.c	2007-10-14 16:25:19.016485750 +0900
+++ mips/arch/mips/philips/pnx8550/stb810/prom_init.c	2007-10-14 17:06:44.102987000 +0900
@@ -41,8 +41,6 @@ void __init prom_init(void)
 
 	prom_init_cmdline();
 
-	mips_machtype = MACH_PHILIPS_STB810;
-
 	memsize = 0x08000000; /* Trimedia uses memory above */
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pmc-sierra/yosemite/prom.c mips/arch/mips/pmc-sierra/yosemite/prom.c
--- mips-orig/arch/mips/pmc-sierra/yosemite/prom.c	2007-10-14 16:25:19.280502250 +0900
+++ mips/arch/mips/pmc-sierra/yosemite/prom.c	2007-10-14 17:06:44.162990750 +0900
@@ -126,8 +126,6 @@ void __init prom_init(void)
 		env++;
 	}
 
-	mips_machtype = MACH_TITAN_YOSEMITE;
-
 	prom_grab_secondary();
 }
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/tx4938/toshiba_rbtx4938/prom.c mips/arch/mips/tx4938/toshiba_rbtx4938/prom.c
--- mips-orig/arch/mips/tx4938/toshiba_rbtx4938/prom.c	2007-10-14 16:25:21.184621250 +0900
+++ mips/arch/mips/tx4938/toshiba_rbtx4938/prom.c	2007-10-14 17:06:44.174991500 +0900
@@ -47,7 +47,6 @@ void __init prom_init(void)
 #ifndef CONFIG_TX4938_NAND_BOOT
 	prom_init_cmdline();
 #endif
-	mips_machtype = MACH_TOSHIBA_RBTX4938;
 
 	msize = tx4938_get_mem_size();
 	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/nec-cmbvr4133/setup.c mips/arch/mips/vr41xx/nec-cmbvr4133/setup.c
--- mips-orig/arch/mips/vr41xx/nec-cmbvr4133/setup.c	2007-10-14 16:25:21.436637000 +0900
+++ mips/arch/mips/vr41xx/nec-cmbvr4133/setup.c	2007-10-14 17:06:44.186992250 +0900
@@ -64,8 +64,6 @@ static void __init nec_cmbvr4133_setup(v
 #endif
 	set_io_port_base(KSEG1ADDR(0x16000000));
 
-	mips_machtype = MACH_NEC_CMBVR4133;
-
 #ifdef CONFIG_PCI
 #ifdef CONFIG_ROCKHOPPER
 	ali_m5229_preinit();
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/bootinfo.h mips/include/asm-mips/bootinfo.h
--- mips-orig/include/asm-mips/bootinfo.h	2007-10-14 16:27:42.305440750 +0900
+++ mips/include/asm-mips/bootinfo.h	2007-10-14 17:06:44.186992250 +0900
@@ -48,22 +48,11 @@
 #define  MACH_DS5900		10	/* DECsystem 5900		*/
 
 /*
- * Valid machtype for group ARC
- */
-#define MACH_DESKSTATION_RPC44  0	/* Deskstation rPC44 */
-#define MACH_DESKSTATION_TYNE	1	/* Deskstation Tyne */
-
-/*
  * Valid machtype for group SNI_RM
  */
 #define  MACH_SNI_RM200_PCI	0	/* RM200/RM300/RM400 PCI series */
 
 /*
- * Valid machtype for group ACN
- */
-#define  MACH_ACN_MIPS_BOARD	0       /* ACN MIPS single board        */
-
-/*
  * Valid machtype for group SGI
  */
 #define  MACH_SGI_IP22		0	/* Indy, Indigo2, Challenge S	*/
@@ -73,44 +62,6 @@
 #define  MACH_SGI_IP30		4	/* Octane, Octane2              */
 
 /*
- * Valid machtype for group COBALT
- */
-#define  MACH_COBALT_27		0	/* Proto "27" hardware		*/
-
-/*
- * Valid machtype for group BAGET
- */
-#define  MACH_BAGET201		0	/* BT23-201 */
-#define  MACH_BAGET202		1	/* BT23-202 */
-
-/*
- * Cosine boards.
- */
-#define  MACH_COSINE_ORION	0
-
-/*
- * Valid machtype for group MOMENCO
- */
-#define  MACH_MOMENCO_OCELOT	0
-#define  MACH_MOMENCO_OCELOT_G	1	/* no more supported (may 2007) */
-#define  MACH_MOMENCO_OCELOT_C	2	/* no more supported (jun 2007) */
-#define  MACH_MOMENCO_JAGUAR_ATX 3	/* no more supported (may 2007) */
-#define  MACH_MOMENCO_OCELOT_3	4
-
-/*
- * Valid machtype for group PHILIPS
- */
-#define  MACH_PHILIPS_NINO	0	/* Nino */
-#define  MACH_PHILIPS_VELO	1	/* Velo */
-#define  MACH_PHILIPS_JBS	2	/* JBS */
-#define  MACH_PHILIPS_STB810	3	/* STB810 */
-
-/*
- * Valid machtype for group SIBYTE
- */
-#define  MACH_SWARM              0
-
-/*
  * Valid machtypes for group Toshiba
  */
 #define  MACH_PALLAS		0
@@ -122,64 +73,17 @@
 #define  MACH_TOSHIBA_RBTX4938	6
 
 /*
- * Valid machtype for group Alchemy
- */
-#define  MACH_PB1000		0	/* Au1000-based eval board */
-#define  MACH_PB1100		1	/* Au1100-based eval board */
-#define  MACH_PB1500		2	/* Au1500-based eval board */
-#define  MACH_DB1000		3       /* Au1000-based eval board */
-#define  MACH_DB1100		4       /* Au1100-based eval board */
-#define  MACH_DB1500		5       /* Au1500-based eval board */
-#define  MACH_XXS1500		6       /* Au1500-based eval board */
-#define  MACH_MTX1		7       /* 4G MTX-1 Au1500-based board */
-#define  MACH_PB1550		8       /* Au1550-based eval board */
-#define  MACH_DB1550		9       /* Au1550-based eval board */
-#define  MACH_PB1200		10       /* Au1200-based eval board */
-#define  MACH_DB1200		11       /* Au1200-based eval board */
-
-/*
- * Valid machtype for group NEC_VR41XX
- *
- * Various NEC-based devices.
- *
- * FIXME: MACH_GROUPs should be by _MANUFACTURER_ of * the device, not by
- *        technical properties, so no new additions to this group.
- */
-#define  MACH_NEC_OSPREY	0	/* Osprey eval board */
-#define  MACH_NEC_EAGLE		1	/* NEC Eagle/Hawk board */
-#define  MACH_ZAO_CAPCELLA	2	/* ZAO Networks Capcella */
-#define  MACH_VICTOR_MPC30X	3	/* Victor MP-C303/304 */
-#define  MACH_IBM_WORKPAD	4	/* IBM WorkPad z50 */
-#define  MACH_CASIO_E55		5	/* CASIO CASSIOPEIA E-10/15/55/65 */
-#define  MACH_TANBAC_TB0226	6	/* TANBAC TB0226 (Mbase) */
-#define  MACH_TANBAC_TB0229	7	/* TANBAC TB0229 (VR4131DIMM) */
-#define  MACH_NEC_CMBVR4133	8	/* CMB VR4133 Board */
-
-#define  MACH_HP_LASERJET	1
-
-/*
  * Valid machtype for group LASAT
  */
 #define  MACH_LASAT_100		0	/* Masquerade II/SP100/SP50/SP25 */
 #define  MACH_LASAT_200		1	/* Masquerade PRO/SP200 */
 
 /*
- * Valid machtype for group TITAN
- */
-#define  MACH_TITAN_YOSEMITE	1	/* PMC-Sierra Yosemite		*/
-#define  MACH_TITAN_EXCITE	2	/* Basler eXcite		*/
-
-/*
  * Valid machtype for group NEC EMMA2RH
  */
 #define  MACH_NEC_MARKEINS	0	/* NEC EMMA2RH Mark-eins	*/
 
 /*
- * Valid machtype for group LEMOTE
- */
-#define  MACH_LEMOTE_FULONG        0
-
-/*
  * Valid machtype for group PMC-MSP
  */
 #define MACH_MSP4200_EVAL       0	/* PMC-Sierra MSP4200 Evaluation */
@@ -190,14 +94,6 @@
 #define MACH_MSP7120_FPGA       5	/* PMC-Sierra MSP7120 Emulation */
 #define MACH_MSP_OTHER        255	/* PMC-Sierra unknown board type */
 
-#define MACH_WRPPMC             1
-
-/*
- * Valid machtype for group Broadcom
- */
-#define MACH_GROUP_BRCM		23	/* Broadcom			*/
-#define  MACH_BCM47XX		1	/* Broadcom BCM47XX		*/
-
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
