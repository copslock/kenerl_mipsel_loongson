Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 May 2006 04:24:26 +0200 (CEST)
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:22212 "EHLO
	rwcrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133382AbWEQCYQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 May 2006 04:24:16 +0200
Received: from [127.0.0.1] (unknown[69.140.185.48])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20060517022408m1400kgavke>; Wed, 17 May 2006 02:24:08 +0000
Message-ID: <446A893F.20600@gentoo.org>
Date:	Tue, 16 May 2006 22:23:59 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: Add support for R14K Processors
Content-Type: multipart/mixed;
 boundary="------------040002000400080604080905"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040002000400080604080905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is an updated patch that adds support for R14K processors.  Currently, 
the only system that can really make use of this is an Octane, but this allows 
the processor to at least be detectable.

Tested on a 2.6.16.13 kernel

# cat /proc/cpuinfo
system type             : SGI Octane
processor               : 0
cpu model               : R14000 V2.3  FPU V0.0
BogoMIPS                : 821.24
byteorder               : big endian
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 64
extra interrupt vector  : no
hardware watchpoint     : yes
ASEs implemented        :
VCED exceptions         : not available
VCEI exceptions         : not available


Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---

  arch/mips/kernel/cpu-probe.c |    9 +++++++++
  arch/mips/kernel/proc.c      |    1 +
  arch/mips/mm/c-r4k.c         |    4 ++++
  arch/mips/mm/pg-r4k.c        |    1 +
  arch/mips/mm/tlbex.c         |    1 +
  include/asm-mips/cpu.h       |    4 +++-
  6 files changed, 19 insertions(+), 1 deletion(-)




--------------040002000400080604080905
Content-Type: text/plain;
 name="r14k-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="r14k-support.patch"

diff -Naurp mipslinux/arch/mips/kernel/cpu-probe.c mipslinux.r14k/arch/mips/kernel/cpu-probe.c
--- mipslinux/arch/mips/kernel/cpu-probe.c	2006-05-11 16:54:33.000000000 -0400
+++ mipslinux.r14k/arch/mips/kernel/cpu-probe.c	2006-05-16 21:08:42.000000000 -0400
@@ -439,6 +439,15 @@ static inline void cpu_probe_legacy(stru
 		             MIPS_CPU_LLSC;
 		c->tlbsize = 64;
 		break;
+	case PRID_IMP_R14000:
+		c->cputype = CPU_R14000;
+		c->isa_level = MIPS_CPU_ISA_IV;
+		c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+		             MIPS_CPU_FPU | MIPS_CPU_32FPR |
+			     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
+		             MIPS_CPU_LLSC;
+		c->tlbsize = 64;
+		break;
 	}
 }
 
diff -Naurp mipslinux/arch/mips/kernel/proc.c mipslinux.r14k/arch/mips/kernel/proc.c
--- mipslinux/arch/mips/kernel/proc.c	2006-05-11 16:54:33.000000000 -0400
+++ mipslinux.r14k/arch/mips/kernel/proc.c	2006-05-16 21:08:42.000000000 -0400
@@ -42,6 +42,7 @@ static const char *cpu_name[] = {
 	[CPU_R8000]	= "R8000",
 	[CPU_R10000]	= "R10000",
 	[CPU_R12000]	= "R12000",
+	[CPU_R14000]	= "R14000",
 	[CPU_R4300]	= "R4300",
 	[CPU_R4650]	= "R4650",
 	[CPU_R4700]	= "R4700",
diff -Naurp mipslinux/arch/mips/mm/c-r4k.c mipslinux.r14k/arch/mips/mm/c-r4k.c
--- mipslinux/arch/mips/mm/c-r4k.c	2006-05-12 13:31:39.000000000 -0400
+++ mipslinux.r14k/arch/mips/mm/c-r4k.c	2006-05-16 21:08:42.000000000 -0400
@@ -343,6 +343,7 @@ static inline void local_r4k___flush_cac
 	case CPU_R4400MC:
 	case CPU_R10000:
 	case CPU_R12000:
+	case CPU_R14000:
 		r4k_blast_scache();
 	}
 }
@@ -841,6 +842,7 @@ static void __init probe_pcache(void)
 
 	case CPU_R10000:
 	case CPU_R12000:
+	case CPU_R14000:
 		icache_size = 1 << (12 + ((config & R10K_CONF_IC) >> 29));
 		c->icache.linesz = 64;
 		c->icache.ways = 2;
@@ -994,6 +996,7 @@ static void __init probe_pcache(void)
 		c->dcache.flags |= MIPS_CACHE_PINDEX;
 	case CPU_R10000:
 	case CPU_R12000:
+	case CPU_R14000:
 	case CPU_SB1:
 		break;
 	case CPU_24K:
@@ -1121,6 +1124,7 @@ static void __init setup_scache(void)
 
 	case CPU_R10000:
 	case CPU_R12000:
+	case CPU_R14000:
 		scache_size = 0x80000 << ((config & R10K_CONF_SS) >> 16);
 		c->scache.linesz = 64 << ((config >> 13) & 1);
 		c->scache.ways = 2;
diff -Naurp mipslinux/arch/mips/mm/pg-r4k.c mipslinux.r14k/arch/mips/mm/pg-r4k.c
--- mipslinux/arch/mips/mm/pg-r4k.c	2006-05-05 20:49:54.000000000 -0400
+++ mipslinux.r14k/arch/mips/mm/pg-r4k.c	2006-05-16 21:08:42.000000000 -0400
@@ -357,6 +357,7 @@ void __init build_clear_page(void)
 
 		case CPU_R10000:
 		case CPU_R12000:
+		case CPU_R14000:
 			pref_src_mode = Pref_LoadStreamed;
 			pref_dst_mode = Pref_StoreStreamed;
 			break;
diff -Naurp mipslinux/arch/mips/mm/tlbex.c mipslinux.r14k/arch/mips/mm/tlbex.c
--- mipslinux/arch/mips/mm/tlbex.c	2006-05-11 16:54:33.000000000 -0400
+++ mipslinux.r14k/arch/mips/mm/tlbex.c	2006-05-16 21:08:42.000000000 -0400
@@ -875,6 +875,7 @@ static __init void build_tlb_write_entry
 
 	case CPU_R10000:
 	case CPU_R12000:
+	case CPU_R14000:
 	case CPU_4KC:
 	case CPU_SB1:
 	case CPU_SB1A:
diff -Naurp mipslinux/include/asm-mips/cpu.h mipslinux.r14k/include/asm-mips/cpu.h
--- mipslinux/include/asm-mips/cpu.h	2006-05-11 16:54:36.000000000 -0400
+++ mipslinux.r14k/include/asm-mips/cpu.h	2006-05-16 21:09:26.000000000 -0400
@@ -51,6 +51,7 @@
 #define PRID_IMP_R4300		0x0b00
 #define PRID_IMP_VR41XX		0x0c00
 #define PRID_IMP_R12000		0x0e00
+#define PRID_IMP_R14000		0x0f00
 #define PRID_IMP_R8000		0x1000
 #define PRID_IMP_PR4450		0x1200
 #define PRID_IMP_R4600		0x2000
@@ -198,7 +199,8 @@
 #define CPU_PR4450		61
 #define CPU_SB1A		62
 #define CPU_74K			63
-#define CPU_LAST		63
+#define CPU_R14000		64
+#define CPU_LAST		64
 
 /*
  * ISA Level encodings

--------------040002000400080604080905--
