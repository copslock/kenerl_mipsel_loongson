Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:29:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3562 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009213AbaLRPNcFdIDf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:13:32 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8952854D109B4
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:13:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:13:26 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:13:25 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 61/67] MIPS: Add LLB bit and related feature for the Config 5 CP0 register
Date:   Thu, 18 Dec 2014 15:10:10 +0000
Message-ID: <1418915416-3196-62-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 44796
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

The LLBIT (bit 4) in the Config5 CP0 register indicates the software
availability of the Load-Linked bit. This bit is only set by hardware
and it has the following meaning:

0: LLB functionality is not supported
1: LLB functionality is supported. The following feature are also
supported:

- ERETNC instruction. Similar to ERET but it does not clear the LLB
bit in the LLAddr register.
- CP0 LLAddr/LLB bit must be set
- LLbit is software accessible through the LLAddr[0]

This will be used later on to emulate R2 LL/SC instructions.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h | 3 +++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/include/asm/mipsregs.h     | 1 +
 arch/mips/kernel/cpu-probe.c         | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 5830557539c0..1b88905f3e21 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -38,6 +38,9 @@
 #ifndef cpu_has_maar
 #define cpu_has_maar		(cpu_data[0].options & MIPS_CPU_MAAR)
 #endif
+#ifndef cpu_has_rw_llb
+#define cpu_has_rw_llb		(cpu_data[0].options & MIPS_CPU_RW_LLB)
+#endif
 
 /*
  * For the moment we don't consider R6000 and R8000 so we can assume that
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index c525f5060773..27a8dbce8a79 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -374,6 +374,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_HTW		0x100000000ull /* CPU support Hardware Page Table Walker */
 #define MIPS_CPU_RIXIEX		0x200000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
 #define MIPS_CPU_MAAR		0x400000000ull /* MAAR(I) registers are present */
+#define MIPS_CPU_RW_LLB		0x800000000ull /* LLADDR/LLB writes are allowed */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 22a135ac91de..8b27e17c1cad 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -653,6 +653,7 @@
 #define MIPS_CONF5_NF		(_ULCAST_(1) << 0)
 #define MIPS_CONF5_UFR		(_ULCAST_(1) << 2)
 #define MIPS_CONF5_MRP		(_ULCAST_(1) << 3)
+#define MIPS_CONF5_LLB		(_ULCAST_(1) << 4)
 #define MIPS_CONF5_MSAEN	(_ULCAST_(1) << 27)
 #define MIPS_CONF5_EVA		(_ULCAST_(1) << 28)
 #define MIPS_CONF5_CV		(_ULCAST_(1) << 29)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 3a0b6c11d34b..30253329aa48 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -452,6 +452,8 @@ static inline unsigned int decode_config5(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_EVA;
 	if (config5 & MIPS_CONF5_MRP)
 		c->options |= MIPS_CPU_MAAR;
+	if (config5 & MIPS_CONF5_LLB)
+		c->options |= MIPS_CPU_RW_LLB;
 
 	return config5 & MIPS_CONF_M;
 }
-- 
2.2.0
