Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 11:51:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14039 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010078AbbAPKvayUUh- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:51:30 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D20FB625D1FA1
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:51:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:51:24 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:51:24 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 02/70] MIPS: Add cases for CPU_QEMU_GENERIC
Date:   Fri, 16 Jan 2015 10:48:41 +0000
Message-ID: <1421405389-15512-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45146
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Add a CPU_QEMU_GENERIC case to various switch statements.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-type.h | 7 +++++++
 arch/mips/kernel/idle.c          | 1 +
 arch/mips/kernel/spram.c         | 1 +
 arch/mips/kernel/traps.c         | 1 +
 arch/mips/mm/c-r4k.c             | 1 +
 arch/mips/mm/sc-mips.c           | 1 +
 arch/mips/mm/tlbex.c             | 1 +
 7 files changed, 13 insertions(+)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index b4e2bd87df50..8245875f8b33 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -54,6 +54,13 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_M5150:
 #endif
 
+#if defined(CONFIG_SYS_HAS_CPU_MIPS32_R2) || \
+    defined(CONFIG_SYS_HAS_CPU_MIPS32_R6) || \
+    defined(CONFIG_SYS_HAS_CPU_MIPS64_R2) || \
+    defined(CONFIG_SYS_HAS_CPU_MIPS64_R6)
+	case CPU_QEMU_GENERIC:
+#endif
+
 #ifdef CONFIG_SYS_HAS_CPU_MIPS64_R1
 	case CPU_5KC:
 	case CPU_5KE:
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 0b9082b6b683..368c88b7eb6c 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -186,6 +186,7 @@ void __init check_wait(void)
 	case CPU_PROAPTIV:
 	case CPU_P5600:
 	case CPU_M5150:
+	case CPU_QEMU_GENERIC:
 		cpu_wait = r4k_wait;
 		if (read_c0_config7() & MIPS_CONF7_WII)
 			cpu_wait = r4k_wait_irqoff;
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index 67f2495def1c..d1168d7c31e8 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -208,6 +208,7 @@ void spram_config(void)
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_P5600:
+	case CPU_QEMU_GENERIC:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
 		if (config0 & (1<<24)) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d5fbfb51b9da..461653ea28c8 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1559,6 +1559,7 @@ static inline void parity_protection_init(void)
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_P5600:
+	case CPU_QEMU_GENERIC:
 		{
 #define ERRCTL_PE	0x80000000
 #define ERRCTL_L2P	0x00800000
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index dd261df005c2..b806deb29e63 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1255,6 +1255,7 @@ static void probe_pcache(void)
 	case CPU_P5600:
 	case CPU_PROAPTIV:
 	case CPU_M5150:
+	case CPU_QEMU_GENERIC:
 		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
 		    (c->icache.waysize > PAGE_SIZE))
 			c->icache.flags |= MIPS_CACHE_ALIASES;
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 99eb8fabab60..fd9b5d45e91b 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -81,6 +81,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 	case CPU_PROAPTIV:
 	case CPU_P5600:
 	case CPU_BMIPS5000:
+	case CPU_QEMU_GENERIC:
 		if (config2 & (1 << 12))
 			return 0;
 	}
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 3978a3d81366..ff8d99ce3b9b 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -514,6 +514,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		case CPU_PROAPTIV:
 		case CPU_P5600:
 		case CPU_M5150:
+		case CPU_QEMU_GENERIC:
 			break;
 
 		default:
-- 
2.2.1
