Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2007 00:20:20 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:12684 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20024572AbXGOXUR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2007 00:20:17 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1IADNr-000168-QS; Mon, 16 Jul 2007 01:20:11 +0200
Date:	Mon, 16 Jul 2007 01:20:11 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Cc:	Felix Fietkau <nbd@openwrt.org>
Subject: [PATCH] Preliminary support for the BCM947xx family
Message-ID: <20070715232011.GA3842@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Hi,

The patch below adds preliminary support for the BCM947xx family. It
originates from the OpenWrt patches, and I have made a few fixes. The
other parts of the BCM947xx patches needs support for the Sonic Silicon
Backplane bus, which is currently being merged in the -mm series, but 
this part is independent and could already be merged.

Note that the BCM4710 does not support the wait instruction, this is not
a mistake in the code.

Cheers,
Aurelien

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Cc: Felix Fietkau <nbd@openwrt.org>


--- linux-2.6.22.orig/arch/mips/kernel/cpu-probe.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22/arch/mips/kernel/cpu-probe.c	2007-07-12 23:38:02.000000000 +0200
@@ -139,6 +139,7 @@
 	case CPU_5KC:
 	case CPU_25KF:
  	case CPU_PR4450:
+ 	case CPU_BCM3302:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -732,6 +733,22 @@
 }
 
 
+static inline void cpu_probe_broadcom(struct cpuinfo_mips *c)
+{
+	decode_configs(c);
+	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_BCM3302:
+		c->cputype = CPU_BCM3302;
+		break;
+	case PRID_IMP_BCM4710:
+		c->cputype = CPU_BCM4710;
+		break;
+	default:
+		c->cputype = CPU_UNKNOWN;
+		break;
+	}
+}
+
 __init void cpu_probe(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -754,6 +771,9 @@
 	case PRID_COMP_SIBYTE:
 		cpu_probe_sibyte(c);
 		break;
+	case PRID_COMP_BROADCOM:
+		cpu_probe_broadcom(c);
+		break;
 	case PRID_COMP_SANDCRAFT:
 		cpu_probe_sandcraft(c);
 		break;
diff -Nurd linux-2.6.22.merge/arch/mips/kernel/proc.c linux-2.6.22/arch/mips/kernel/proc.c
--- linux-2.6.22.merge/arch/mips/kernel/proc.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22/arch/mips/kernel/proc.c	2007-07-12 23:38:02.000000000 +0200
@@ -83,6 +83,8 @@
 	[CPU_VR4181]	= "NEC VR4181",
 	[CPU_VR4181A]	= "NEC VR4181A",
 	[CPU_SR71000]	= "Sandcraft SR71000",
+	[CPU_BCM3302]	= "Broadcom BCM3302",
+	[CPU_BCM4710]	= "Broadcom BCM4710",
 	[CPU_PR4450]	= "Philips PR4450",
 };
 
diff -Nurd linux-2.6.22.merge/arch/mips/mm/tlbex.c linux-2.6.22/arch/mips/mm/tlbex.c
--- linux-2.6.22.merge/arch/mips/mm/tlbex.c	2007-07-12 23:45:55.000000000 +0200
+++ linux-2.6.22/arch/mips/mm/tlbex.c	2007-07-12 23:38:02.000000000 +0200
@@ -893,6 +893,8 @@
 	case CPU_4KSC:
 	case CPU_20KC:
 	case CPU_25KF:
+	case CPU_BCM3302:
+	case CPU_BCM4710:
 		tlbw(p);
 		break;
 
diff -Nurd linux-2.6.22.merge/include/asm-mips/bootinfo.h linux-2.6.22/include/asm-mips/bootinfo.h
--- linux-2.6.22.merge/include/asm-mips/bootinfo.h	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22/include/asm-mips/bootinfo.h	2007-07-12 23:38:02.000000000 +0200
@@ -213,6 +213,12 @@
 #define MACH_GROUP_NEC_EMMA2RH 25	/* NEC EMMA2RH (was 23)		*/
 #define  MACH_NEC_MARKEINS	0	/* NEC EMMA2RH Mark-eins	*/
 
+/*
+ * Valid machtype for group Broadcom
+ */
+#define MACH_GROUP_BRCM		23	/* Broadcom			*/
+#define  MACH_BCM47XX		1	/* Broadcom BCM47xx		*/
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
diff -Nurd linux-2.6.22.merge/include/asm-mips/cpu.h linux-2.6.22/include/asm-mips/cpu.h
--- linux-2.6.22.merge/include/asm-mips/cpu.h	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22/include/asm-mips/cpu.h	2007-07-12 23:38:02.000000000 +0200
@@ -104,6 +104,13 @@
 #define PRID_IMP_SR71000        0x0400
 
 /*
+ * These are the PRID's for when 23:16 == PRID_COMP_BROADCOM
+ */
+
+#define PRID_IMP_BCM4710	0x4000
+#define PRID_IMP_BCM3302	0x9000
+
+/*
  * Definitions for 7:0 on legacy processors
  */
 
@@ -211,7 +218,9 @@
 #define CPU_SB1A		62
 #define CPU_74K			63
 #define CPU_R14000		64
-#define CPU_LAST		64
+#define CPU_BCM3302		65
+#define CPU_BCM4710		66
+#define CPU_LAST		66
 
 /*
  * ISA Level encodings


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
