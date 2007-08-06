Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 16:08:30 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:13468 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20026185AbXHFPI1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 16:08:27 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1II4Bx-0006RJ-UR; Mon, 06 Aug 2007 17:08:21 +0200
Date:	Mon, 6 Aug 2007 17:08:21 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Cc:	Michael Buesch <mb@bu3sch.de>, Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: [PATCH -mm 1/4] MIPS: Detect BCM947xx CPUs
Message-ID: <20070806150821.GF24308@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The patch below against 2.6.23-rc1-mm2 adds a few constants for BCM947xx
CPUs and detect them in cpu-probe.c and tlbex.c. Note that the BCM4710 
does not support the wait instruction, this is not a mistake in the 
code.

This part is not dependent of other patches (though useless without 
them), and could already be merged in the current linux-mips git tree.

Cc: Michael Buesch <mb@bu3sch.de>
Cc: Waldemar Brodkorb <wbx@openwrt.org>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Florian Schirmer <jolt@tuxbox.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -159,6 +159,7 @@
 	case CPU_5KC:
 	case CPU_25KF:
 	case CPU_PR4450:
+	case CPU_BCM3302:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -786,6 +787,22 @@
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
@@ -808,6 +825,9 @@
 	case PRID_COMP_SIBYTE:
 		cpu_probe_sibyte(c);
 		break;
+	case PRID_COMP_BROADCOM:
+		cpu_probe_broadcom(c);
+		break;
 	case PRID_COMP_SANDCRAFT:
 		cpu_probe_sandcraft(c);
 		break;
--- a/arch/mips/kernel/proc.c	
+++ b/arch/mips/kernel/proc.c
@@ -82,6 +82,8 @@
 	[CPU_VR4181]	= "NEC VR4181",
 	[CPU_VR4181A]	= "NEC VR4181A",
 	[CPU_SR71000]	= "Sandcraft SR71000",
+	[CPU_BCM3302]	= "Broadcom BCM3302",
+	[CPU_BCM4710]	= "Broadcom BCM4710",
 	[CPU_PR4450]	= "Philips PR4450",
 	[CPU_LOONGSON2]	= "ICT Loongson-2",
 };
--- a/arch/mips/mm/tlbex.c	
+++ b/arch/mips/mm/tlbex.c
@@ -893,6 +893,8 @@
 	case CPU_4KSC:
 	case CPU_20KC:
 	case CPU_25KF:
+ 	case CPU_BCM3302:
+ 	case CPU_BCM4710:
 	case CPU_LOONGSON2:
 		tlbw(p);
 		break;
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -221,6 +221,12 @@
 #define MACH_GROUP_WINDRIVER   28	/* Windriver boards */
 #define MACH_WRPPMC             1
 
+/*
+ * Valid machtype for group Broadcom
+ */
+#define MACH_GROUP_BRCM		23	/* Broadcom			*/
+#define  MACH_BCM947XX		1	/* Broadcom BCM947xx		*/
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
--- a/include/asm-mips/cpu.h	
+++ b/include/asm-mips/cpu.h
@@ -106,6 +106,13 @@
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
 
@@ -217,8 +224,9 @@
 #define CPU_R14000		64
 #define CPU_LOONGSON1           65
 #define CPU_LOONGSON2           66
-
-#define CPU_LAST		66
+#define CPU_BCM3302		67
+#define CPU_BCM4710		68
+#define CPU_LAST		68
 
 /*
  * ISA Level encodings

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
