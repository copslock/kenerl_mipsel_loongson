Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:20:08 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:31759 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8126482AbWCTETo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:19:44 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 23E5664D3D; Mon, 20 Mar 2006 04:29:20 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id F3A2D66ED5; Mon, 20 Mar 2006 04:29:03 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:29:03 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [MIPS] Remove last portions of incomplete VR4181 support
Message-ID: <20060320042903.GA20088@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

[MIPS] Remove last portions of incomplete VR4181 support

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -503,7 +503,8 @@ config DDB5477
 	  ether port USB, AC97, PCI, etc.
 
 config MACH_VR41XX
-	bool "Support for NEC VR41XX-based machines"
+	bool "Support for NEC VR41XX based machines"
+	select SYS_HAS_CPU_VR41XX
 
 config PMC_YOSEMITE
 	bool "Support for PMC-Sierra Yosemite eval board"
@@ -1016,9 +1017,6 @@ config MIPS_L1_CACHE_SHIFT
 config HAVE_STD_PC_SERIAL_PORT
 	bool
 
-config VR4181
-	bool
-
 config ARC_CONSOLE
 	bool "ARC console support"
 	depends on SGI_IP22 || SNI_RM200_PCI
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -242,15 +242,9 @@ static inline void cpu_probe_legacy(stru
 		break;
 	case PRID_IMP_VR41XX:
 		switch (c->processor_id & 0xf0) {
-#ifndef CONFIG_VR4181
 		case PRID_REV_VR4111:
 			c->cputype = CPU_VR4111;
 			break;
-#else
-		case PRID_REV_VR4181:
-			c->cputype = CPU_VR4181;
-			break;
-#endif
 		case PRID_REV_VR4121:
 			c->cputype = CPU_VR4121;
 			break;
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -79,7 +79,6 @@ static const char *cpu_name[] = {
 	[CPU_VR4122]	= "NEC VR4122",
 	[CPU_VR4131]	= "NEC VR4131",
 	[CPU_VR4133]	= "NEC VR4133",
-	[CPU_VR4181]	= "NEC VR4181",
 	[CPU_VR4181A]	= "NEC VR4181A",
 	[CPU_SR71000]	= "Sandcraft SR71000",
 	[CPU_PR4450]	= "Philips PR4450",
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -840,7 +840,6 @@ static void __init probe_pcache(void)
 	case CPU_VR4111:
 	case CPU_VR4121:
 	case CPU_VR4122:
-	case CPU_VR4181:
 	case CPU_VR4181A:
 		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -908,7 +908,6 @@ static __init void build_tlb_write_entry
 	case CPU_VR4111:
 	case CPU_VR4121:
 	case CPU_VR4122:
-	case CPU_VR4181:
 	case CPU_VR4181A:
 		i_nop(p);
 		i_nop(p);
@@ -1054,9 +1053,8 @@ static __init void build_adjust_context(
 	case CPU_VR4121:
 	case CPU_VR4122:
 	case CPU_VR4131:
-	case CPU_VR4181:
-	case CPU_VR4181A:
 	case CPU_VR4133:
+	case CPU_VR4181A:
 		shift += 2;
 		break;
 
--- a/include/asm-mips/cpu.h
+++ b/include/asm-mips/cpu.h
@@ -116,7 +116,6 @@
 #define PRID_REV_TX3922 	0x0030
 #define PRID_REV_TX3927 	0x0040
 #define PRID_REV_VR4111		0x0050
-#define PRID_REV_VR4181		0x0050	/* Same as VR4111 */
 #define PRID_REV_VR4121		0x0060
 #define PRID_REV_VR4122		0x0070
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
@@ -183,7 +182,6 @@
 #define CPU_VR4121		47
 #define CPU_VR4122		48
 #define CPU_VR4131		49
-#define CPU_VR4181		50
 #define CPU_VR4181A		51
 #define CPU_AU1100		52
 #define CPU_SR71000		53

-- 
Martin Michlmayr
http://www.cyrius.com/
