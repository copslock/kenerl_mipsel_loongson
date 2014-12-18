Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:11:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30858 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009138AbaLRPKwDytOM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:10:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5EF14FF9F1E2C
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:10:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:10:45 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:10:44 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 02/67] MIPS: Add cases for CPU_QEMUR6
Date:   Thu, 18 Dec 2014 15:09:11 +0000
Message-ID: <1418915416-3196-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44737
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

Add a CPU_QEMUR6 case to various switch statements.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-type.h | 5 +++++
 arch/mips/kernel/idle.c          | 1 +
 arch/mips/kernel/spram.c         | 1 +
 arch/mips/kernel/traps.c         | 1 +
 arch/mips/mm/c-r4k.c             | 1 +
 arch/mips/mm/sc-mips.c           | 1 +
 arch/mips/mm/tlbex.c             | 1 +
 7 files changed, 11 insertions(+)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index b4e2bd87df50..68fb94592ae3 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -54,6 +54,11 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_M5150:
 #endif
 
+#if defined(CONFIG_SYS_HAS_CPU_MIPS32_R6) || \
+    defined(CONFIG_SYS_HAS_CPU_MIPS64_R6)
+	case CPU_QEMUR6:
+#endif
+
 #ifdef CONFIG_SYS_HAS_CPU_MIPS64_R1
 	case CPU_5KC:
 	case CPU_5KE:
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 0b9082b6b683..8abb7336a3d0 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -186,6 +186,7 @@ void __init check_wait(void)
 	case CPU_PROAPTIV:
 	case CPU_P5600:
 	case CPU_M5150:
+	case CPU_QEMUR6:
 		cpu_wait = r4k_wait;
 		if (read_c0_config7() & MIPS_CONF7_WII)
 			cpu_wait = r4k_wait_irqoff;
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index 67f2495def1c..35dbad02b040 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -208,6 +208,7 @@ void spram_config(void)
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_P5600:
+	case CPU_QEMUR6:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
 		if (config0 & (1<<24)) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 22b19c275044..b3568c049b72 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1486,6 +1486,7 @@ static inline void parity_protection_init(void)
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_P5600:
+	case CPU_QEMUR6:
 		{
 #define ERRCTL_PE	0x80000000
 #define ERRCTL_L2P	0x00800000
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index fbcd8674ff1d..a659770bc539 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1243,6 +1243,7 @@ static void probe_pcache(void)
 	case CPU_P5600:
 	case CPU_PROAPTIV:
 	case CPU_M5150:
+	case CPU_QEMUR6:
 		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
 		    (c->icache.waysize > PAGE_SIZE))
 			c->icache.flags |= MIPS_CACHE_ALIASES;
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 99eb8fabab60..6133b2de8a9c 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -81,6 +81,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 	case CPU_PROAPTIV:
 	case CPU_P5600:
 	case CPU_BMIPS5000:
+	case CPU_QEMUR6:
 		if (config2 & (1 << 12))
 			return 0;
 	}
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e3328a96e809..14e5fae71a06 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -514,6 +514,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		case CPU_PROAPTIV:
 		case CPU_P5600:
 		case CPU_M5150:
+		case CPU_QEMUR6:
 			break;
 
 		default:
-- 
2.2.0
