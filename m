Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 11:41:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41396 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009880AbbGIJleTqEGh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 11:41:34 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4A1AA297B2365
        for <linux-mips@linux-mips.org>; Thu,  9 Jul 2015 10:41:26 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Jul 2015 10:41:28 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 9 Jul 2015 10:41:27 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 02/19] MIPS: Add cases for CPU_I6400
Date:   Thu, 9 Jul 2015 10:40:36 +0100
Message-ID: <1436434853-30001-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48139
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

Add a CPU_I6400 case to various switch statements, doing the same thing
as for CPU_P5600.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-type.h     | 4 ++++
 arch/mips/kernel/idle.c              | 1 +
 arch/mips/kernel/perf_event_mipsxx.c | 6 ++++++
 arch/mips/kernel/pm-cps.c            | 2 ++
 arch/mips/kernel/spram.c             | 1 +
 arch/mips/kernel/traps.c             | 1 +
 arch/mips/mm/c-r4k.c                 | 1 +
 arch/mips/oprofile/common.c          | 1 +
 arch/mips/oprofile/op_model_mipsxx.c | 4 ++++
 9 files changed, 21 insertions(+)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index d41e8e284825..abee2bfd10dc 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -77,6 +77,10 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	 */
 #endif
 
+#ifdef CONFIG_SYS_HAS_CPU_MIPS64_R6
+	case CPU_I6400:
+#endif
+
 #ifdef CONFIG_SYS_HAS_CPU_R3000
 	case CPU_R2000:
 	case CPU_R3000:
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index e4f62b7875d2..ab1478d5a4db 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -196,6 +196,7 @@ void __init check_wait(void)
 	case CPU_INTERAPTIV:
 	case CPU_M5150:
 	case CPU_QEMU_GENERIC:
+	case CPU_I6400:
 		cpu_wait = r4k_wait;
 		if (read_c0_config7() & MIPS_CONF7_WII)
 			cpu_wait = r4k_wait_irqoff;
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index cc1b6fadf089..d7b8dd43147a 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1556,6 +1556,7 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 #endif
 		break;
 	case CPU_P5600:
+	case CPU_I6400:
 		/* 8-bit event numbers */
 		raw_id = config & 0x1ff;
 		base_id = raw_id & 0xff;
@@ -1717,6 +1718,11 @@ init_hw_perf_events(void)
 		mipspmu.general_event_map = &mipsxxcore_event_map2;
 		mipspmu.cache_event_map = &mipsxxcore_cache_map2;
 		break;
+	case CPU_I6400:
+		mipspmu.name = "mips/I6400";
+		mipspmu.general_event_map = &mipsxxcore_event_map2;
+		mipspmu.cache_event_map = &mipsxxcore_cache_map2;
+		break;
 	case CPU_1004K:
 		mipspmu.name = "mips/1004K";
 		mipspmu.general_event_map = &mipsxxcore_event_map;
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 06147179a175..f63a289977cc 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -267,6 +267,7 @@ static int __init cps_gen_flush_fsb(u32 **pp, struct uasm_label **pl,
 
 	/* CPUs which do not require the workaround */
 	case CPU_P5600:
+	case CPU_I6400:
 		return 0;
 
 	default:
@@ -671,6 +672,7 @@ static int __init cps_pm_init(void)
 	case CPU_PROAPTIV:
 	case CPU_M5150:
 	case CPU_P5600:
+	case CPU_I6400:
 		stype_intervention = 0x2;
 		stype_memory = 0x3;
 		stype_ordering = 0x10;
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index d1168d7c31e8..8489c88f9932 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -209,6 +209,7 @@ void spram_config(void)
 	case CPU_PROAPTIV:
 	case CPU_P5600:
 	case CPU_QEMU_GENERIC:
+	case CPU_I6400:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
 		if (config0 & (1<<24)) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 2a7b38ed23f0..9aa265530b48 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1638,6 +1638,7 @@ static inline void parity_protection_init(void)
 	case CPU_PROAPTIV:
 	case CPU_P5600:
 	case CPU_QEMU_GENERIC:
+	case CPU_I6400:
 		{
 #define ERRCTL_PE	0x80000000
 #define ERRCTL_L2P	0x00800000
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 7f660dc67596..c3e777fc5e8b 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1266,6 +1266,7 @@ static void probe_pcache(void)
 	case CPU_PROAPTIV:
 	case CPU_M5150:
 	case CPU_QEMU_GENERIC:
+	case CPU_I6400:
 		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
 		    (c->icache.waysize > PAGE_SIZE))
 			c->icache.flags |= MIPS_CACHE_ALIASES;
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 81f58958cf08..3c9ec3ddca84 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -91,6 +91,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_P5600:
+	case CPU_I6400:
 	case CPU_M5150:
 	case CPU_LOONGSON1:
 	case CPU_SB1:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 6a6e2cc55b89..8f988a61b7a8 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -392,6 +392,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/P5600";
 		break;
 
+	case CPU_I6400:
+		op_model_mipsxx_ops.cpu_type = "mips/I6400";
+		break;
+
 	case CPU_M5150:
 		op_model_mipsxx_ops.cpu_type = "mips/M5150";
 		break;
-- 
2.4.5
