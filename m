Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Nov 2002 21:28:43 +0100 (CET)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:48208 "EHLO
	brian.localnet") by linux-mips.org with ESMTP id <S1123966AbSKKU2m>;
	Mon, 11 Nov 2002 21:28:42 +0100
Received: from brm by brian.localnet with local (Exim 3.35 #1 (Debian))
	id 18BLAb-0005i7-00; Mon, 11 Nov 2002 21:28:29 +0100
To: linux-mips@linux-mips.org
Subject: [PATCH 2.4] explicit R5000 cpu controlled secondary cache support fix
Cc: ralf@linux-mips.org
Message-Id: <E18BLAb-0005i7-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Mon, 11 Nov 2002 21:28:29 +0100
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi,
	currently a MIPS board which has an R5000 cpu but does not
have a cpu controlled secondary cache will fail to build. This patch
fixes this by making an option which compiles secondary cache support
dependant on an explicit configure option and not on some hairy
heuristics.

Can you apply this Ralf? I have submitted a similar patch for 2.5
directly to you.

/Brian


Index: arch/mips/config-shared.in
===================================================================
RCS file: /home/cvs/linux/arch/mips/Attic/config-shared.in,v
retrieving revision 1.1.2.29
diff -u -r1.1.2.29 config-shared.in
--- arch/mips/config-shared.in	8 Nov 2002 01:39:44 -0000	1.1.2.29
+++ arch/mips/config-shared.in	11 Nov 2002 20:22:23 -0000
@@ -226,7 +226,6 @@
    define_bool CONFIG_SCSI n
 fi
 if [ "$CONFIG_LASAT" = "y" ]; then
-   define_bool CONFIG_BOARD_SCACHE y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_NEW_TIME_C y
@@ -464,6 +463,14 @@
 	 R10000	CONFIG_CPU_R10000 \
 	 RM7000	CONFIG_CPU_RM7000 \
 	 SB1	CONFIG_CPU_SB1" R4x00
+
+if [ "$CONFIG_CPU_R5000" = "y" -o "$CONFIG_CPU_NEVADA" = "y" ]; then
+   bool '  R5000 CPU controlled secondary cache' CONFIG_R5000_CPU_SCACHE
+fi
+
+if [ "$CONFIG_R5000_CPU_SCACHE" = "y" ]; then
+   define_bool CONFIG_BOARD_SCACHE y
+fi
 
 if [ "$CONFIG_SMP_CAPABLE" = "y" ]; then
    bool '  Multi-Processing support' CONFIG_SMP
Index: arch/mips/mm/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/Makefile,v
retrieving revision 1.27.2.3
diff -u -r1.27.2.3 Makefile
--- arch/mips/mm/Makefile	2 Oct 2002 13:08:16 -0000	1.27.2.3
+++ arch/mips/mm/Makefile	11 Nov 2002 20:22:24 -0000
@@ -20,16 +20,16 @@
 obj-$(CONFIG_CPU_R4300)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R4X00)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
-obj-$(CONFIG_CPU_R5000)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o \
-				   r5k-sc.o
-obj-$(CONFIG_CPU_NEVADA)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o \
-				   r5k-sc.o
+obj-$(CONFIG_CPU_R5000)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
+obj-$(CONFIG_CPU_NEVADA)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R5432)		+= pg-r5432.o c-r5432.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_RM7000)	+= pg-rm7k.o c-rm7k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R10000)	+= pg-andes.o c-andes.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_MIPS32)	+= pg-mips32.o c-mips32.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_MIPS64)	+= pg-mips32.o c-mips32.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_SB1)		+= pg-sb1.o c-sb1.o tlb-sb1.o tlbex-r4k.o
+
+obj-$(CONFIG_R5000_CPU_SCACHE)	+= r5k-sc.o
 
 obj-$(CONFIG_SB1_CACHE_ERROR)	+= cex-sb1.o cerr-sb1.o
 
Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.10
diff -u -r1.3.2.10 c-r4k.c
--- arch/mips/mm/c-r4k.c	17 Oct 2002 11:49:09 -0000	1.3.2.10
+++ arch/mips/mm/c-r4k.c	11 Nov 2002 20:22:25 -0000
@@ -1356,7 +1356,7 @@
 	case CPU_R5000:
 	case CPU_NEVADA:
 			setup_noscache_funcs();
-#if defined(CONFIG_CPU_R5000) || defined(CONFIG_CPU_NEVADA)
+#if defined(CONFIG_R5000_CPU_SCACHE)
 			r5k_sc_init();
 #endif
 			break;
