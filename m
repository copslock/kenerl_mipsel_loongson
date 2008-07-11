Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 14:57:24 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:531 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20031019AbYGKN5V (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 14:57:21 +0100
Received: by mo.po.2iij.net (mo31) id m6BDvI9a008928; Fri, 11 Jul 2008 22:57:18 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox301) id m6BDvHgJ006331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 Jul 2008 22:57:17 +0900
Date:	Fri, 11 Jul 2008 22:57:17 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] mips_machtype define as one group
Message-Id: <20080711225717.cbf55ccc.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

mips_machtype define as one group.

mips_machtype are defined for each machines group.
But firmware uses two or more groups. 
They should be defined as one group.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/dec/prom/identify.c linux/arch/mips/dec/prom/identify.c
--- linux-orig/arch/mips/dec/prom/identify.c	2008-06-08 00:10:22.951942195 +0900
+++ linux/arch/mips/dec/prom/identify.c	2008-06-07 22:16:54.037641315 +0900
@@ -27,7 +27,7 @@
 #include "dectypes.h"
 
 static const char *dec_system_strings[] = {
-	[MACH_DSUNKNOWN]	"unknown DECstation",
+	[MACH_UNKNOWN]		"unknown DECstation",
 	[MACH_DS23100]		"DECstation 2100/3100",
 	[MACH_DS5100]		"DECsystem 5100",
 	[MACH_DS5000_200]	"DECstation 5000/200",
@@ -174,11 +174,10 @@ void __init prom_identify_arch(u32 magic
 		mips_machtype = MACH_DS5500;
 		break;
 	default:
-		mips_machtype = MACH_DSUNKNOWN;
 		break;
 	}
 
-	if (mips_machtype == MACH_DSUNKNOWN)
+	if (mips_machtype == MACH_UNKNOWN)
 		printk("This is an %s, id is %x\n",
 		       dec_system_strings[mips_machtype], dec_systype);
 	else
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/dec/setup.c linux/arch/mips/dec/setup.c
--- linux-orig/arch/mips/dec/setup.c	2008-06-08 00:10:22.959942648 +0900
+++ linux/arch/mips/dec/setup.c	2008-06-07 22:16:54.037641315 +0900
@@ -142,6 +142,9 @@ static void __init dec_be_init(void)
 		busirq.handler = dec_ecc_be_interrupt;
 		dec_ecc_be_init();
 		break;
+	default:
+		panic("Don't know how to set this up!");
+		break;
 	}
 }
 
@@ -737,6 +740,9 @@ void __init arch_init_irq(void)
 	case MACH_DS5500:	/* DS5500 MIPSfair-2 */
 		panic("Don't know how to set this up!");
 		break;
+	default:
+		panic("Don't know how to set this up!");
+		break;
 	}
 
 	/* Free the FPU interrupt if the exception is present. */
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/emma2rh/common/prom.c linux/arch/mips/emma2rh/common/prom.c
--- linux-orig/arch/mips/emma2rh/common/prom.c	2008-06-08 00:10:22.963942877 +0900
+++ linux/arch/mips/emma2rh/common/prom.c	2008-06-07 22:16:54.037641315 +0900
@@ -32,16 +32,6 @@
 #include <asm/emma2rh/emma2rh.h>
 #include <asm/debug.h>
 
-const char *get_system_type(void)
-{
-	switch (mips_machtype) {
-	case MACH_NEC_MARKEINS:
-		return "NEC EMMA2RH Mark-eins";
-	default:
-		return "Unknown NEC board";
-	}
-}
-
 /* [jsun@junsun.net] PMON passes arguments in C main() style */
 void __init prom_init(void)
 {
@@ -63,7 +53,6 @@ void __init prom_init(void)
 	}
 
 #if defined(CONFIG_MARKEINS)
-	mips_machtype = MACH_NEC_MARKEINS;
 	add_memory_region(0, EMMA2RH_RAM_SIZE, BOOT_MEM_RAM);
 #endif
 
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/emma2rh/markeins/setup.c linux/arch/mips/emma2rh/markeins/setup.c
--- linux-orig/arch/mips/emma2rh/markeins/setup.c	2008-06-08 00:10:22.971943334 +0900
+++ linux/arch/mips/emma2rh/markeins/setup.c	2008-06-07 22:16:54.061642678 +0900
@@ -149,3 +149,8 @@ static void __init markeins_board_init(v
 
 	markeins_led("MVL E2RH");
 }
+
+const char *get_system_type(void)
+{
+	return "NEC EMMA2RH Mark-eins";
+}
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/kernel/setup.c linux/arch/mips/kernel/setup.c
--- linux-orig/arch/mips/kernel/setup.c	2008-06-08 00:10:22.975943558 +0900
+++ linux/arch/mips/kernel/setup.c	2008-06-08 00:12:16.370405542 +0900
@@ -52,7 +52,7 @@ EXPORT_SYMBOL(PCI_DMA_BUS_IS_PHYS);
  *
  * These are initialized so they are in the .data section
  */
-unsigned long mips_machtype __read_mostly = MACH_UNKNOWN;
+enum mips_machtype mips_machtype __read_mostly = MACH_UNKNOWN;
 
 EXPORT_SYMBOL(mips_machtype);
 
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/pmc-sierra/msp71xx/msp_setup.c linux/arch/mips/pmc-sierra/msp71xx/msp_setup.c
--- linux-orig/arch/mips/pmc-sierra/msp71xx/msp_setup.c	2008-06-08 00:10:22.983944018 +0900
+++ linux/arch/mips/pmc-sierra/msp71xx/msp_setup.c	2008-06-07 22:16:54.061642678 +0900
@@ -171,12 +171,9 @@ void __init prom_init(void)
 
 	switch (family)	{
 	case FAMILY_FPGA:
-		if (FPGA_IS_MSP4200(revision)) {
+		if (FPGA_IS_MSP4200(revision))
 			/* Old-style revision ID */
 			mips_machtype = MACH_MSP4200_FPGA;
-		} else {
-			mips_machtype = MACH_MSP_OTHER;
-		}
 		break;
 
 	case FAMILY_MSP4200:
@@ -184,8 +181,6 @@ void __init prom_init(void)
 		mips_machtype  = MACH_MSP4200_EVAL;
 #elif defined(CONFIG_PMC_MSP4200_GW)
 		mips_machtype  = MACH_MSP4200_GW;
-#else
-		mips_machtype = MACH_MSP_OTHER;
 #endif
 		break;
 
@@ -198,8 +193,6 @@ void __init prom_init(void)
 		mips_machtype = MACH_MSP7120_EVAL;
 #elif defined(CONFIG_PMC_MSP7120_GW)
 		mips_machtype = MACH_MSP7120_GW;
-#else
-		mips_machtype = MACH_MSP_OTHER;
 #endif
 		break;
 
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/bootinfo.h linux/include/asm-mips/bootinfo.h
--- linux-orig/include/asm-mips/bootinfo.h	2008-06-08 00:10:22.991944475 +0900
+++ linux/include/asm-mips/bootinfo.h	2008-06-08 00:12:34.967465327 +0900
@@ -19,87 +19,75 @@
  * numbers do not necessarily reflect technical relations or similarities
  * between systems.
  */
-
-/*
- * Valid machtype values for group unknown
- */
-#define  MACH_UNKNOWN		0	/* whatever...			*/
-
-/*
- * Valid machtype values for group JAZZ
- */
-#define  MACH_ACER_PICA_61	0	/* Acer PICA-61 (PICA1)		*/
-#define  MACH_MIPS_MAGNUM_4000	1	/* Mips Magnum 4000 "RC4030"	*/
-#define  MACH_OLIVETTI_M700	2	/* Olivetti M700-10 (-15 ??)    */
-
-/*
- * Valid machtype for group DEC
- */
-#define  MACH_DSUNKNOWN		0
-#define  MACH_DS23100		1	/* DECstation 2100 or 3100	*/
-#define  MACH_DS5100		2	/* DECsystem 5100		*/
-#define  MACH_DS5000_200	3	/* DECstation 5000/200		*/
-#define  MACH_DS5000_1XX	4	/* DECstation 5000/120, 125, 133, 150 */
-#define  MACH_DS5000_XX		5	/* DECstation 5000/20, 25, 33, 50 */
-#define  MACH_DS5000_2X0	6	/* DECstation 5000/240, 260	*/
-#define  MACH_DS5400		7	/* DECsystem 5400		*/
-#define  MACH_DS5500		8	/* DECsystem 5500		*/
-#define  MACH_DS5800		9	/* DECsystem 5800		*/
-#define  MACH_DS5900		10	/* DECsystem 5900		*/
-
-/*
- * Valid machtype for group SNI_RM
- */
-#define  MACH_SNI_RM200_PCI	0	/* RM200/RM300/RM400 PCI series */
-
-/*
- * Valid machtype for group SGI
- */
-#define  MACH_SGI_IP22		0	/* Indy, Indigo2, Challenge S	*/
-#define  MACH_SGI_IP27		1	/* Origin 200, Origin 2000, Onyx 2 */
-#define  MACH_SGI_IP28		2	/* Indigo2 Impact		*/
-#define  MACH_SGI_IP32		3	/* O2				*/
-#define  MACH_SGI_IP30		4	/* Octane, Octane2              */
-
-/*
- * Valid machtypes for group Toshiba
- */
-#define  MACH_PALLAS		0
-#define  MACH_TOPAS		1
-#define  MACH_JMR		2
-#define  MACH_TOSHIBA_JMR3927	3	/* JMR-TX3927 CPU/IO board */
-#define  MACH_TOSHIBA_RBTX4927	4
-#define  MACH_TOSHIBA_RBTX4937	5
-#define  MACH_TOSHIBA_RBTX4938	6
-
-/*
- * Valid machtype for group LASAT
- */
-#define  MACH_LASAT_100		0	/* Masquerade II/SP100/SP50/SP25 */
-#define  MACH_LASAT_200		1	/* Masquerade PRO/SP200 */
-
-/*
- * Valid machtype for group NEC EMMA2RH
- */
-#define  MACH_NEC_MARKEINS	0	/* NEC EMMA2RH Mark-eins	*/
-
-/*
- * Valid machtype for group PMC-MSP
- */
-#define MACH_MSP4200_EVAL       0	/* PMC-Sierra MSP4200 Evaluation */
-#define MACH_MSP4200_GW         1	/* PMC-Sierra MSP4200 Gateway demo */
-#define MACH_MSP4200_FPGA       2	/* PMC-Sierra MSP4200 Emulation */
-#define MACH_MSP7120_EVAL       3	/* PMC-Sierra MSP7120 Evaluation */
-#define MACH_MSP7120_GW         4	/* PMC-Sierra MSP7120 Residential GW */
-#define MACH_MSP7120_FPGA       5	/* PMC-Sierra MSP7120 Emulation */
-#define MACH_MSP_OTHER        255	/* PMC-Sierra unknown board type */
+enum mips_machtype {
+	/*
+	 * Valid machtype values for group unknown
+	 */
+	MACH_UNKNOWN = 0,	/* whatever... */
+
+	/*
+	 * Valid machtype values for group JAZZ
+	 */
+	MACH_ACER_PICA_61,	/* Acer PICA-61 (PICA1) */
+	MACH_MIPS_MAGNUM_4000,	/* Mips Magnum 4000 "RC4030" */
+
+	/*
+	 * Valid machtype for group DEC
+	 */
+	MACH_DS23100,		/* DECstation 2100 or 3100 */
+	MACH_DS5100,		/* DECsystem 5100 */
+	MACH_DS5000_200,	/* DECstation 5000/200 */
+	MACH_DS5000_1XX,	/* DECstation 5000/120, 125, 133, 150 */
+	MACH_DS5000_XX,		/* DECstation 5000/20, 25, 33, 50 */
+	MACH_DS5000_2X0,	/* DECstation 5000/240, 260 */
+	MACH_DS5400,		/* DECsystem 5400 */
+	MACH_DS5500,		/* DECsystem 5500 */
+	MACH_DS5800,		/* DECsystem 5800 */
+	MACH_DS5900,		/* DECsystem 5900 */
+
+	/*
+	 * Valid machtype for group SNI_RM
+	 */
+	MACH_SNI_RM200_PCI,	/* RM200/RM300/RM400 PCI series */
+
+	/*
+	 * Valid machtype for group SGI
+	 */
+	MACH_SGI_IP22,		/* Indy, Indigo2, Challenge S */
+	MACH_SGI_IP27,		/* Origin 200, Origin 2000, Onyx 2 */
+	MACH_SGI_IP28,		/* Indigo2 Impact */
+	MACH_SGI_IP30,		/* Octane, Octane2 */
+	MACH_SGI_IP32,		/* O2 */
+
+	/*
+	 * Valid machtypes for group Toshiba
+	 */
+	MACH_TOSHIBA_RBTX4927,
+	MACH_TOSHIBA_RBTX4937,
+
+	/*
+	 * Valid machtype for group LASAT
+	 */
+	MACH_LASAT_100,		/* Masquerade II/SP100/SP50/SP25 */
+	MACH_LASAT_200,		/* Masquerade PRO/SP200 */
+
+	/*
+	 * Valid machtype for group PMC-MSP
+	 */
+	MACH_MSP4200_EVAL,	/* PMC-Sierra MSP4200 Evaluation */
+	MACH_MSP4200_GW,	/* PMC-Sierra MSP4200 Gateway demo */
+	MACH_MSP4200_FPGA,	/* PMC-Sierra MSP4200 Emulation */
+	MACH_MSP7120_EVAL,	/* PMC-Sierra MSP7120 Evaluation */
+	MACH_MSP7120_GW,	/* PMC-Sierra MSP7120 Residential GW */
+	MACH_MSP7120_FPGA,	/* PMC-Sierra MSP7120 Emulation */
+};
 
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 extern char *system_type;
 const char *get_system_type(void);
 
-extern unsigned long mips_machtype;
+extern enum mips_machtype mips_machtype;
 
 #define BOOT_MEM_MAP_MAX	32
 #define BOOT_MEM_RAM		1
