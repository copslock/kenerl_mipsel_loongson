Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 01:14:42 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:22798 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133729AbWBTBOc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 01:14:32 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 4BEFA64D3D; Mon, 20 Feb 2006 01:21:24 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id CFED58D5D; Mon, 20 Feb 2006 01:21:16 +0000 (GMT)
Date:	Mon, 20 Feb 2006 01:21:16 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: VR4181
Message-ID: <20060220012116.GB18438@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001126.GA17967@deprecation.cyrius.com> <200602200107.k1K17suB021247@mbox03.po.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602200107.k1K17suB021247@mbox03.po.2iij.net>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> [2006-02-20 10:07]:
> VR4181 has already been removed from the mainline and linux-mips. 
> I think linux-mips should synchronize with the mainline.

There are many references to VR4181 stil.  If VR4181 support is gone,
maybe we should do the following:

[MIPS] Remove last portions of incomplete VR4181 support

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4ca93ff..b89088e 100644
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
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c6363ff..19b84f4 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -242,23 +242,14 @@ static inline void cpu_probe_legacy(stru
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
 		case PRID_REV_VR4122:
-			if ((c->processor_id & 0xf) < 0x3)
-				c->cputype = CPU_VR4122;
-			else
-				c->cputype = CPU_VR4181A;
+			c->cputype = CPU_VR4122;
 			break;
 		case PRID_REV_VR4130:
 			if ((c->processor_id & 0xf) < 0x4)
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 86fe15b..b31cd90 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -79,8 +79,6 @@ static const char *cpu_name[] = {
 	[CPU_VR4122]	= "NEC VR4122",
 	[CPU_VR4131]	= "NEC VR4131",
 	[CPU_VR4133]	= "NEC VR4133",
-	[CPU_VR4181]	= "NEC VR4181",
-	[CPU_VR4181A]	= "NEC VR4181A",
 	[CPU_SR71000]	= "Sandcraft SR71000",
 	[CPU_PR4450]	= "Philips PR4450",
 };
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 1b71d91..2828a59 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -840,8 +840,6 @@ static void __init probe_pcache(void)
 	case CPU_VR4111:
 	case CPU_VR4121:
 	case CPU_VR4122:
-	case CPU_VR4181:
-	case CPU_VR4181A:
 		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 1;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 0f94858..f96d6e0 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -908,8 +908,6 @@ static __init void build_tlb_write_entry
 	case CPU_VR4111:
 	case CPU_VR4121:
 	case CPU_VR4122:
-	case CPU_VR4181:
-	case CPU_VR4181A:
 		i_nop(p);
 		i_nop(p);
 		tlbw(p);
@@ -1054,8 +1052,6 @@ static __init void build_adjust_context(
 	case CPU_VR4121:
 	case CPU_VR4122:
 	case CPU_VR4131:
-	case CPU_VR4181:
-	case CPU_VR4181A:
 	case CPU_VR4133:
 		shift += 2;
 		break;
diff --git a/include/asm-mips/cpu.h b/include/asm-mips/cpu.h
index 818b9a9..ab2476b 100644
--- a/include/asm-mips/cpu.h
+++ b/include/asm-mips/cpu.h
@@ -116,10 +116,8 @@
 #define PRID_REV_TX3922 	0x0030
 #define PRID_REV_TX3927 	0x0040
 #define PRID_REV_VR4111		0x0050
-#define PRID_REV_VR4181		0x0050	/* Same as VR4111 */
 #define PRID_REV_VR4121		0x0060
 #define PRID_REV_VR4122		0x0070
-#define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130		0x0080
 
 /*
@@ -183,8 +181,6 @@
 #define CPU_VR4121		47
 #define CPU_VR4122		48
 #define CPU_VR4131		49
-#define CPU_VR4181		50
-#define CPU_VR4181A		51
 #define CPU_AU1100		52
 #define CPU_SR71000		53
 #define CPU_RM9000		54
diff --git a/include/asm-mips/vr41xx/vr41xx.h b/include/asm-mips/vr41xx/vr41xx.h
index 70828d5..3ab7ad6 100644
--- a/include/asm-mips/vr41xx/vr41xx.h
+++ b/include/asm-mips/vr41xx/vr41xx.h
@@ -29,10 +29,6 @@
 #define PRID_VR4122_REV3_0	0x00000c71
 #define PRID_VR4122_REV3_1	0x00000c72
 
-/* VR4181A 0x00000c73-0x00000c7f */
-#define PRID_VR4181A_REV1_0	0x00000c73
-#define PRID_VR4181A_REV1_1	0x00000c74
-
 /* VR4131 0x00000c80-0x00000c83 */
 #define PRID_VR4131_REV1_2	0x00000c80
 #define PRID_VR4131_REV2_0	0x00000c81

-- 
Martin Michlmayr
http://www.cyrius.com/
