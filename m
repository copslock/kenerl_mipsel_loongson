Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2014 14:35:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.115]:45751 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823121AbaCDNfLUTQ2C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Mar 2014 14:35:11 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AD73FE840FD7B
        for <linux-mips@linux-mips.org>; Tue,  4 Mar 2014 13:35:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 4 Mar 2014 13:35:05 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.47) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 4 Mar 2014 13:35:04 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/3] MIPS: Add support for the M5150 processor
Date:   Tue, 4 Mar 2014 13:34:43 +0000
Message-ID: <1393940084-29518-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1393940084-29518-1-git-send-email-markos.chandras@imgtec.com>
References: <1393940084-29518-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39404
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

The M5150 core is a 32-bit MIPS RISC which implements the
MIPS Architecture Release-5  in a 5-stage pipeline.
In addition, it includes the MIPS Architecture Virtualization Module
that enables virtualization of operating systems,
which provides a scalable, trusted, and secure execution environment.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-type.h     | 1 +
 arch/mips/include/asm/cpu.h          | 2 +-
 arch/mips/kernel/idle.c              | 1 +
 arch/mips/mm/c-r4k.c                 | 1 +
 arch/mips/mm/tlbex.c                 | 1 +
 arch/mips/oprofile/common.c          | 1 +
 arch/mips/oprofile/op_model_mipsxx.c | 4 ++++
 7 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 61f803b..760c9cf 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -47,6 +47,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_P5600:
+	case CPU_M5150:
 #endif
 
 #ifdef CONFIG_SYS_HAS_CPU_MIPS64_R1
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 1611132..64b4b69 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -298,7 +298,7 @@ enum cpu_type_enum {
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
 	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_LOONGSON1, CPU_M14KC,
-	CPU_M14KEC, CPU_INTERAPTIV, CPU_P5600, CPU_PROAPTIV, CPU_1074K,
+	CPU_M14KEC, CPU_INTERAPTIV, CPU_P5600, CPU_PROAPTIV, CPU_1074K, CPU_M5150,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 4b1554b..90d341f 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -189,6 +189,7 @@ void __init check_wait(void)
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_P5600:
+	case CPU_M5150:
 		cpu_wait = r4k_wait;
 		if (read_c0_config7() & MIPS_CONF7_WII)
 			cpu_wait = r4k_wait_irqoff;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index a62b637..3e53f1b 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1173,6 +1173,7 @@ static void probe_pcache(void)
 	case CPU_INTERAPTIV:
 	case CPU_P5600:
 	case CPU_PROAPTIV:
+	case CPU_M5150:
 		if ((c->cputype == CPU_74K) || (c->cputype == CPU_1074K))
 			alias_74k_erratum(c);
 		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ccae9a4..be407d5 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -512,6 +512,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		case CPU_1074K:
 		case CPU_PROAPTIV:
 		case CPU_P5600:
+		case CPU_M5150:
 			break;
 
 		default:
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index e4ca70b..e747324 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -90,6 +90,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_P5600:
+	case CPU_M5150:
 	case CPU_LOONGSON1:
 	case CPU_SB1:
 	case CPU_SB1A:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 9797493..42821ae 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -389,6 +389,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/P5600";
 		break;
 
+	case CPU_M5150:
+		op_model_mipsxx_ops.cpu_type = "mips/M5150";
+		break;
+
 	case CPU_5KC:
 		op_model_mipsxx_ops.cpu_type = "mips/5K";
 		break;
-- 
1.9.0
