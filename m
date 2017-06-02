Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 21:39:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5911 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993929AbdFBTjbGYb0n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 21:39:31 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id ABAEB8D855AB;
        Fri,  2 Jun 2017 20:39:20 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 20:39:24
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Probe the I6500 CPU
Date:   Fri, 2 Jun 2017 12:39:04 -0700
Message-ID: <20170602193904.26473-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Introduce the I6500 PRID & probe it just the same way as I6400. The MIPS
I6500 is the latest in Imagination Technologies' I-Class range of CPUs,
with a focus on scalability & heterogeneity. It introduces the notion of
multiple clusters to the MIPS Coherent Processing System, allowing for a
far higher total number of cores & threads in a system when compared
with its predecessors. Clusters don't need to be identical, and may
contain differing numbers of cores & IOCUs, or cores with differing
properties.

This patch alone adds the basic support for booting Linux on an I6500
CPU without support for any of its new functionality, for which support
will be introduced in further patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/include/asm/cpu-type.h | 1 +
 arch/mips/include/asm/cpu.h      | 3 ++-
 arch/mips/kernel/cpu-probe.c     | 5 +++++
 arch/mips/mm/c-r4k.c             | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index bdd6dc18e65c..175fe565f4e1 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -84,6 +84,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 
 #ifdef CONFIG_SYS_HAS_CPU_MIPS64_R6
 	case CPU_I6400:
+	case CPU_I6500:
 	case CPU_P6600:
 #endif
 
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 98f59307e6a3..3069359b0120 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -124,6 +124,7 @@
 #define PRID_IMP_P5600		0xa800
 #define PRID_IMP_I6400		0xa900
 #define PRID_IMP_M6250		0xab00
+#define PRID_IMP_I6500		0xb000
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
@@ -322,7 +323,7 @@ enum cpu_type_enum {
 	 */
 	CPU_5KC, CPU_5KE, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
 	CPU_LOONGSON3, CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
-	CPU_CAVIUM_OCTEON2, CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
+	CPU_CAVIUM_OCTEON2, CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP, CPU_I6500,
 
 	CPU_QEMU_GENERIC,
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 1aba27786bd5..353ade2c130a 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -564,6 +564,7 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, enum ftlb_flags flags)
 		back_to_back_c0_hazard();
 		break;
 	case CPU_I6400:
+	case CPU_I6500:
 		/* There's no way to disable the FTLB */
 		if (!(flags & FTLB_EN))
 			return 1;
@@ -1635,6 +1636,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_I6400;
 		__cpu_name[cpu] = "MIPS I6400";
 		break;
+	case PRID_IMP_I6500:
+		c->cputype = CPU_I6500;
+		__cpu_name[cpu] = "MIPS I6500";
+		break;
 	case PRID_IMP_M5150:
 		c->cputype = CPU_M5150;
 		__cpu_name[cpu] = "MIPS M5150";
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 3fe99cb271a9..81d6a15c93d0 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1453,6 +1453,7 @@ static void probe_pcache(void)
 	case CPU_20KC:
 	case CPU_25KF:
 	case CPU_I6400:
+	case CPU_I6500:
 	case CPU_SB1:
 	case CPU_SB1A:
 	case CPU_XLR:
@@ -1512,6 +1513,7 @@ static void probe_pcache(void)
 
 	case CPU_ALCHEMY:
 	case CPU_I6400:
+	case CPU_I6500:
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
 		break;
 
-- 
2.13.0
