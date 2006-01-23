Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 23:00:35 +0000 (GMT)
Received: from smtp.gentoo.org ([134.68.220.30]:63678 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S3458400AbWAWXAR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 23:00:17 +0000
Received: from kumba by smtp.gentoo.org with local (Exim 4.54)
	id 1F1AjY-0007ki-PD
	for linux-mips@linux-mips.org; Mon, 23 Jan 2006 23:04:24 +0000
Date:	Mon, 23 Jan 2006 23:04:24 +0000
From:	Kumba <kumba@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH]: Add R14K Support (generic)
Message-ID: <20060123230424.GA31197@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch essentially just copies what R12K does for R14K, and should allow systems running an R14K CPU 
actually boot.  Granted, no machine currently in git can actually use R14K, but the patch is generic and 
non-invaisive, so I thought I'd shoot it to the list anyways.  Minor notes below.

1) Octane is the closest system that can run Linux that supports the
   R14K CPU, but due to exhorbant prices, no one has, as of yet, managed
   to get their hands on either a full R14K system or the CPU module
   itself.

2) Due to item #1 above, this patch hasn't even been tested.


Comments Welcome.


--Kumba


--
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands do them because they must, while the
eyes of the great are elsewhere." --Elrond


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="misc-2.6.15-r14k-cpu-prid.patch"

diff -Naurp linux-2.6.15.orig/arch/mips/kernel/cpu-probe.c linux-2.6.15/arch/mips/kernel/cpu-probe.c
--- linux-2.6.15.orig/arch/mips/kernel/cpu-probe.c	2006-01-09 23:47:01.000000000 -0500
+++ linux-2.6.15/arch/mips/kernel/cpu-probe.c	2006-01-10 00:28:45.000000000 -0500
@@ -494,6 +494,15 @@ static inline void cpu_probe_legacy(stru
 		             MIPS_CPU_LLSC;
 		c->tlbsize = 64;
 		break;
+	case PRID_IMP_R14000:
+		c->cputype = CPU_R14000;
+		c->isa_level = MIPS_CPU_ISA_IV;
+		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE | MIPS_CPU_4KEX |
+		             MIPS_CPU_FPU | MIPS_CPU_32FPR |
+			     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
+		             MIPS_CPU_LLSC;
+		c->tlbsize = 64;
+		break;
 	}
 }
 
diff -Naurp linux-2.6.15.orig/arch/mips/kernel/proc.c linux-2.6.15/arch/mips/kernel/proc.c
--- linux-2.6.15.orig/arch/mips/kernel/proc.c	2006-01-09 23:47:01.000000000 -0500
+++ linux-2.6.15/arch/mips/kernel/proc.c	2006-01-10 00:28:45.000000000 -0500
@@ -42,6 +42,7 @@ static const char *cpu_name[] = {
 	[CPU_R8000]	= "R8000",
 	[CPU_R10000]	= "R10000",
 	[CPU_R12000]	= "R12000",
+	[CPU_R14000]	= "R14000",
 	[CPU_R4300]	= "R4300",
 	[CPU_R4650]	= "R4650",
 	[CPU_R4700]	= "R4700",
diff -Naurp linux-2.6.15.orig/arch/mips/mm/c-r4k.c linux-2.6.15/arch/mips/mm/c-r4k.c
--- linux-2.6.15.orig/arch/mips/mm/c-r4k.c	2006-01-09 23:47:01.000000000 -0500
+++ linux-2.6.15/arch/mips/mm/c-r4k.c	2006-01-10 00:28:45.000000000 -0500
@@ -291,6 +291,7 @@ static inline void local_r4k___flush_cac
 	case CPU_R4400MC:
 	case CPU_R10000:
 	case CPU_R12000:
+	case CPU_R14000:
 		r4k_blast_scache();
 	}
 }
@@ -832,6 +833,7 @@ static void __init probe_pcache(void)
 
 	case CPU_R10000:
 	case CPU_R12000:
+	case CPU_R14000:
 		icache_size = 1 << (12 + ((config & R10K_CONF_IC) >> 29));
 		c->icache.linesz = 64;
 		c->icache.ways = 2;
@@ -984,6 +986,7 @@ static void __init probe_pcache(void)
 	case CPU_25KF:
 	case CPU_R10000:
 	case CPU_R12000:
+	case CPU_R14000:
 	case CPU_SB1:
 		break;
 	case CPU_24K:
@@ -1110,6 +1113,7 @@ static void __init setup_scache(void)
 
 	case CPU_R10000:
 	case CPU_R12000:
+	case CPU_R14000:
 		scache_size = 0x80000 << ((config & R10K_CONF_SS) >> 16);
 		c->scache.linesz = 64 << ((config >> 13) & 1);
 		c->scache.ways = 2;
diff -Naurp linux-2.6.15.orig/arch/mips/mm/pg-r4k.c linux-2.6.15/arch/mips/mm/pg-r4k.c
--- linux-2.6.15.orig/arch/mips/mm/pg-r4k.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/mips/mm/pg-r4k.c	2006-01-10 00:28:45.000000000 -0500
@@ -351,6 +351,7 @@ void __init build_clear_page(void)
 
 		case CPU_R10000:
 		case CPU_R12000:
+		case CPU_R14000:
 			pref_src_mode = Pref_LoadStreamed;
 			pref_dst_mode = Pref_StoreStreamed;
 			break;
diff -Naurp linux-2.6.15.orig/arch/mips/mm/tlbex.c linux-2.6.15/arch/mips/mm/tlbex.c
--- linux-2.6.15.orig/arch/mips/mm/tlbex.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/mips/mm/tlbex.c	2006-01-10 00:28:45.000000000 -0500
@@ -852,6 +852,7 @@ static __init void build_tlb_write_entry
 
 	case CPU_R10000:
 	case CPU_R12000:
+	case CPU_R14000:
 	case CPU_4KC:
 	case CPU_SB1:
 	case CPU_SB1A:
diff -Naurp linux-2.6.15.orig/include/asm-mips/cpu.h linux-2.6.15/include/asm-mips/cpu.h
--- linux-2.6.15.orig/include/asm-mips/cpu.h	2006-01-09 23:47:00.000000000 -0500
+++ linux-2.6.15/include/asm-mips/cpu.h	2006-01-10 00:28:45.000000000 -0500
@@ -51,6 +51,7 @@
 #define PRID_IMP_R4300		0x0b00
 #define PRID_IMP_VR41XX		0x0c00
 #define PRID_IMP_R12000		0x0e00
+#define PRID_IMP_R14000		0x0f00
 #define PRID_IMP_R8000		0x1000
 #define PRID_IMP_PR4450		0x1200
 #define PRID_IMP_R4600		0x2000
@@ -196,7 +197,8 @@
 #define CPU_34K			60
 #define CPU_PR4450		61
 #define CPU_SB1A		62
-#define CPU_LAST		62
+#define CPU_R14000		63
+#define CPU_LAST		63
 
 /*
  * ISA Level encodings

--gKMricLos+KVdGMg--
