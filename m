Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 14:11:51 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:55757 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20038799AbYGNNLp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 14:11:45 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KINqC-0000MD-00; Mon, 14 Jul 2008 15:11:44 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 6B5E0DE7BA; Mon, 14 Jul 2008 15:11:40 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Remove mips_machtype from ARC based machines
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080714131140.6B5E0DE7BA@solo.franken.de>
Date:	Mon, 14 Jul 2008 15:11:40 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

This is the ARC part of the mips_machtype removal.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

This patch is against the queue tree.

 arch/mips/fw/arc/identify.c |   11 -----------
 arch/mips/jazz/setup.c      |    3 +--
 include/asm-mips/bootinfo.h |   21 ---------------------
 3 files changed, 1 insertions(+), 34 deletions(-)

diff --git a/arch/mips/fw/arc/identify.c b/arch/mips/fw/arc/identify.c
index 2306698..0ce9acf 100644
--- a/arch/mips/fw/arc/identify.c
+++ b/arch/mips/fw/arc/identify.c
@@ -22,7 +22,6 @@
 struct smatch {
 	char *arcname;
 	char *liname;
-	int type;
 	int flags;
 };
 
@@ -30,47 +29,38 @@ static struct smatch mach_table[] = {
 	{
 		.arcname	= "SGI-IP22",
 		.liname		= "SGI Indy",
-		.type		= MACH_SGI_IP22,
 		.flags		= PROM_FLAG_ARCS,
 	}, {
 		.arcname	= "SGI-IP27",
 		.liname		= "SGI Origin",
-		.type		= MACH_SGI_IP27,
 		.flags		= PROM_FLAG_ARCS,
 	}, {
 		.arcname	= "SGI-IP28",
 		.liname		= "SGI IP28",
-		.type		= MACH_SGI_IP28,
 		.flags		= PROM_FLAG_ARCS,
 	}, {
 		.arcname	= "SGI-IP30",
 		.liname		= "SGI Octane",
-		.type		= MACH_SGI_IP30,
 		.flags		= PROM_FLAG_ARCS,
 	}, {
 		.arcname	= "SGI-IP32",
 		.liname		= "SGI O2",
-		.type		= MACH_SGI_IP32,
 		.flags		= PROM_FLAG_ARCS,
 	}, {
 		.arcname	= "Microsoft-Jazz",
 		.liname		= "Jazz MIPS_Magnum_4000",
-		.type		= MACH_MIPS_MAGNUM_4000,
 		.flags		= 0,
 	}, {
 		.arcname	= "PICA-61",
 		.liname		= "Jazz Acer_PICA_61",
-		.type		= MACH_ACER_PICA_61,
 		.flags		= 0,
 	}, {
 		.arcname	= "RM200PCI",
 		.liname		= "SNI RM200_PCI",
-		.type		= MACH_SNI_RM200_PCI,
 		.flags		= PROM_FLAG_DONT_FREE_TEMP,
 	}, {
 		.arcname	= "RM200PCI-R5K",
 		.liname		= "SNI RM200_PCI-R5K",
-		.type		= MACH_SNI_RM200_PCI,
 		.flags		= PROM_FLAG_DONT_FREE_TEMP,
 	}
 };
@@ -121,6 +111,5 @@ void __init prom_identify_arch(void)
 	mach = string_to_mach(iname);
 	system_type = mach->liname;
 
-	mips_machtype = mach->type;
 	prom_flags = mach->flags;
 }
diff --git a/arch/mips/jazz/setup.c b/arch/mips/jazz/setup.c
index f136c8a..f60524e 100644
--- a/arch/mips/jazz/setup.c
+++ b/arch/mips/jazz/setup.c
@@ -76,8 +76,7 @@ void __init plat_mem_setup(void)
 
 	set_io_port_base(JAZZ_PORT_BASE);
 #ifdef CONFIG_EISA
-	if (mips_machtype == MACH_MIPS_MAGNUM_4000)
-		EISA_bus = 1;
+	EISA_bus = 1;
 #endif
 
 	/* request I/O space for devices used on all i[345]86 PCs */
diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
index c70848d..653096a 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -26,13 +26,6 @@
 #define  MACH_UNKNOWN		0	/* whatever...			*/
 
 /*
- * Valid machtype values for group JAZZ
- */
-#define  MACH_ACER_PICA_61	0	/* Acer PICA-61 (PICA1)		*/
-#define  MACH_MIPS_MAGNUM_4000	1	/* Mips Magnum 4000 "RC4030"	*/
-#define  MACH_OLIVETTI_M700	2	/* Olivetti M700-10 (-15 ??)    */
-
-/*
  * Valid machtype for group DEC
  */
 #define  MACH_DSUNKNOWN		0
@@ -48,20 +41,6 @@
 #define  MACH_DS5900		10	/* DECsystem 5900		*/
 
 /*
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
  * Valid machtype for group LASAT
  */
 #define  MACH_LASAT_100		0	/* Masquerade II/SP100/SP50/SP25 */
