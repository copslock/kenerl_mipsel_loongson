Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 11:52:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7858 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861346AbaGRJwDzmcMe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 11:52:03 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F2C236B73E3BF
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 10:51:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 10:51:55 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.100) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 10:51:55 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 3/4] MIPS: cpu-probe: Set the write-combine CCA value on per core basis
Date:   Fri, 18 Jul 2014 10:51:32 +0100
Message-ID: <1405677093-22591-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
References: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.100]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Different cores use different CCA values to achieve write-combine
memory writes. For cores that do not support write-combine we
set the default value to CCA:2 (uncached, non-coherent) which is the
default value as set by the kernel.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-info.h |  5 +++++
 arch/mips/kernel/cpu-probe.c     | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 47d5967ce7ef..7747bc7eafaa 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -78,6 +78,11 @@ struct cpuinfo_mips {
 #define NUM_WATCH_REGS 4
 	u16			watch_reg_masks[NUM_WATCH_REGS];
 	unsigned int		kscratch_mask; /* Usable KScratch mask. */
+	/*
+	 * Cache Coherency attribute for write-combine memory writes.
+	 * (shifted by _CACHE_SHIFT)
+	 */
+	unsigned int		writecombine;
 } __attribute__((aligned(SMP_CACHE_BYTES)));
 
 extern struct cpuinfo_mips cpu_data[];
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d74f957c561e..f85c2c6670f5 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -27,6 +27,7 @@
 #include <asm/msa.h>
 #include <asm/watch.h>
 #include <asm/elf.h>
+#include <asm/pgtable-bits.h>
 #include <asm/spram.h>
 #include <asm/uaccess.h>
 
@@ -737,6 +738,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			break;
 		case PRID_REV_LOONGSON3A:
 			c->cputype = CPU_LOONGSON3;
+			c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			break;
@@ -765,67 +767,83 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 
 static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 {
+	c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_4KC:
 		c->cputype = CPU_4KC;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 4Kc";
 		break;
 	case PRID_IMP_4KEC:
 	case PRID_IMP_4KECR2:
 		c->cputype = CPU_4KEC;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 4KEc";
 		break;
 	case PRID_IMP_4KSC:
 	case PRID_IMP_4KSD:
 		c->cputype = CPU_4KSC;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 4KSc";
 		break;
 	case PRID_IMP_5KC:
 		c->cputype = CPU_5KC;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 5Kc";
 		break;
 	case PRID_IMP_5KE:
 		c->cputype = CPU_5KE;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 5KE";
 		break;
 	case PRID_IMP_20KC:
 		c->cputype = CPU_20KC;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 20Kc";
 		break;
 	case PRID_IMP_24K:
 		c->cputype = CPU_24K;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 24Kc";
 		break;
 	case PRID_IMP_24KE:
 		c->cputype = CPU_24K;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 24KEc";
 		break;
 	case PRID_IMP_25KF:
 		c->cputype = CPU_25KF;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 25Kc";
 		break;
 	case PRID_IMP_34K:
 		c->cputype = CPU_34K;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 34Kc";
 		break;
 	case PRID_IMP_74K:
 		c->cputype = CPU_74K;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 74Kc";
 		break;
 	case PRID_IMP_M14KC:
 		c->cputype = CPU_M14KC;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS M14Kc";
 		break;
 	case PRID_IMP_M14KEC:
 		c->cputype = CPU_M14KEC;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS M14KEc";
 		break;
 	case PRID_IMP_1004K:
 		c->cputype = CPU_1004K;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 1004Kc";
 		break;
 	case PRID_IMP_1074K:
 		c->cputype = CPU_1074K;
+		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 1074Kc";
 		break;
 	case PRID_IMP_INTERAPTIV_UP:
@@ -899,6 +917,7 @@ static inline void cpu_probe_sibyte(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
 
+	c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_SB1:
 		c->cputype = CPU_SB1;
@@ -1030,6 +1049,7 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_JZRISC:
 		c->cputype = CPU_JZRISC;
+		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		__cpu_name[cpu] = "Ingenic JZRISC";
 		break;
 	default:
@@ -1136,6 +1156,7 @@ void cpu_probe(void)
 	c->processor_id = PRID_IMP_UNKNOWN;
 	c->fpu_id	= FPIR_IMP_NONE;
 	c->cputype	= CPU_UNKNOWN;
+	c->writecombine = _CACHE_UNCACHED;
 
 	c->processor_id = read_c0_prid();
 	switch (c->processor_id & PRID_COMP_MASK) {
-- 
2.0.0
