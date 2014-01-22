Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2014 17:21:05 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:21299 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825866AbaAVQUYS2vyc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jan 2014 17:20:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 2/5] MIPS: Add cases for CPU_P5600
Date:   Wed, 22 Jan 2014 16:19:38 +0000
Message-ID: <1390407581-24238-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1390407581-24238-1-git-send-email-james.hogan@imgtec.com>
References: <1390407581-24238-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2014_01_22_16_20_18
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Add a CPU_P5600 case to various switch statements, doing the same thing
as for CPU_PROAPTIV.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cpu-type.h | 1 +
 arch/mips/kernel/idle.c          | 1 +
 arch/mips/kernel/spram.c         | 1 +
 arch/mips/kernel/traps.c         | 1 +
 arch/mips/mm/c-r4k.c             | 1 +
 arch/mips/mm/sc-mips.c           | 1 +
 arch/mips/mm/tlbex.c             | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 02f591bd95ca..61f803be4c2e 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -46,6 +46,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_M14KEC:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
+	case CPU_P5600:
 #endif
 
 #ifdef CONFIG_SYS_HAS_CPU_MIPS64_R1
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 3553243bf9d6..55020019bc34 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -186,6 +186,7 @@ void __init check_wait(void)
 	case CPU_1004K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
+	case CPU_P5600:
 		cpu_wait = r4k_wait;
 		if (read_c0_config7() & MIPS_CONF7_WII)
 			cpu_wait = r4k_wait_irqoff;
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index dfed8a41c696..b066c73073a9 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -208,6 +208,7 @@ void spram_config(void)
 	case CPU_1004K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
+	case CPU_P5600:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
 		if (config0 & (1<<24)) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e0b499694d18..06adb62fd752 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1339,6 +1339,7 @@ static inline void parity_protection_init(void)
 	case CPU_1004K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
+	case CPU_P5600:
 		{
 #define ERRCTL_PE	0x80000000
 #define ERRCTL_L2P	0x00800000
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 13b549a67a1e..26db302f48fd 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1108,6 +1108,7 @@ static void probe_pcache(void)
 	case CPU_1004K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
+	case CPU_P5600:
 		if (current_cpu_type() == CPU_74K)
 			alias_74k_erratum(c);
 		if ((read_c0_config7() & (1 << 16))) {
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 7a56aee5fce7..1c90d270e277 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -78,6 +78,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 	case CPU_1004K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
+	case CPU_P5600:
 	case CPU_BMIPS5000:
 		if (config2 & (1 << 12))
 			return 0;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 6fdfe1fadc91..4df2309fb940 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -511,6 +511,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		case CPU_M14KC:
 		case CPU_74K:
 		case CPU_PROAPTIV:
+		case CPU_P5600:
 			break;
 
 		default:
-- 
1.8.1.2
