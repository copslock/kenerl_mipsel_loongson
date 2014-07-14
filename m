Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 11:14:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63386 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860096AbaGNJObFClti (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 11:14:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3AC8F123C69D1
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 10:14:21 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 14 Jul
 2014 10:14:23 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:14:23 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:14:22 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/5] MIPS: cpu-info: Change the cpu options variable to unsigned long long
Date:   Mon, 14 Jul 2014 10:14:02 +0100
Message-ID: <1405329246-21643-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405329246-21643-1-git-send-email-markos.chandras@imgtec.com>
References: <1405329246-21643-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41172
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

Long integers which are 4 bytes in MIPS32 can't hold new CPU
options anymore, so the type of the 'options' variable is changed
to unsigned long long which allows 32 more cpu options to be defined
for MIPS32

Also, re-arrange the 'options' struct member to avoid potential 4-byte
alignment gap in the middle of the struct.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-info.h |  2 +-
 arch/mips/include/asm/cpu.h      | 56 ++++++++++++++++++++--------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 47d5967ce7ef..4b001ca533a1 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -44,8 +44,8 @@ struct cpuinfo_mips {
 	/*
 	 * Capability and feature descriptor structure for MIPS CPU
 	 */
-	unsigned long		options;
 	unsigned long		ases;
+	unsigned long long	options;
 	unsigned int		udelay_val;
 	unsigned int		processor_id;
 	unsigned int		fpu_id;
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 129d08701e91..3b8d993d9d8d 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -335,34 +335,34 @@ enum cpu_type_enum {
 /*
  * CPU Option encodings
  */
-#define MIPS_CPU_TLB		0x00000001 /* CPU has TLB */
-#define MIPS_CPU_4KEX		0x00000002 /* "R4K" exception model */
-#define MIPS_CPU_3K_CACHE	0x00000004 /* R3000-style caches */
-#define MIPS_CPU_4K_CACHE	0x00000008 /* R4000-style caches */
-#define MIPS_CPU_TX39_CACHE	0x00000010 /* TX3900-style caches */
-#define MIPS_CPU_FPU		0x00000020 /* CPU has FPU */
-#define MIPS_CPU_32FPR		0x00000040 /* 32 dbl. prec. FP registers */
-#define MIPS_CPU_COUNTER	0x00000080 /* Cycle count/compare */
-#define MIPS_CPU_WATCH		0x00000100 /* watchpoint registers */
-#define MIPS_CPU_DIVEC		0x00000200 /* dedicated interrupt vector */
-#define MIPS_CPU_VCE		0x00000400 /* virt. coherence conflict possible */
-#define MIPS_CPU_CACHE_CDEX_P	0x00000800 /* Create_Dirty_Exclusive CACHE op */
-#define MIPS_CPU_CACHE_CDEX_S	0x00001000 /* ... same for seconary cache ... */
-#define MIPS_CPU_MCHECK		0x00002000 /* Machine check exception */
-#define MIPS_CPU_EJTAG		0x00004000 /* EJTAG exception */
-#define MIPS_CPU_NOFPUEX	0x00008000 /* no FPU exception */
-#define MIPS_CPU_LLSC		0x00010000 /* CPU has ll/sc instructions */
-#define MIPS_CPU_INCLUSIVE_CACHES	0x00020000 /* P-cache subset enforced */
-#define MIPS_CPU_PREFETCH	0x00040000 /* CPU has usable prefetch */
-#define MIPS_CPU_VINT		0x00080000 /* CPU supports MIPSR2 vectored interrupts */
-#define MIPS_CPU_VEIC		0x00100000 /* CPU supports MIPSR2 external interrupt controller mode */
-#define MIPS_CPU_ULRI		0x00200000 /* CPU has ULRI feature */
-#define MIPS_CPU_PCI		0x00400000 /* CPU has Perf Ctr Int indicator */
-#define MIPS_CPU_RIXI		0x00800000 /* CPU has TLB Read/eXec Inhibit */
-#define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
-#define MIPS_CPU_TLBINV		0x02000000 /* CPU supports TLBINV/F */
-#define MIPS_CPU_SEGMENTS	0x04000000 /* CPU supports Segmentation Control registers */
-#define MIPS_CPU_EVA		0x80000000 /* CPU supports Enhanced Virtual Addressing */
+#define MIPS_CPU_TLB		0x00000001ull /* CPU has TLB */
+#define MIPS_CPU_4KEX		0x00000002ull /* "R4K" exception model */
+#define MIPS_CPU_3K_CACHE	0x00000004ull /* R3000-style caches */
+#define MIPS_CPU_4K_CACHE	0x00000008ull /* R4000-style caches */
+#define MIPS_CPU_TX39_CACHE	0x00000010ull /* TX3900-style caches */
+#define MIPS_CPU_FPU		0x00000020ull /* CPU has FPU */
+#define MIPS_CPU_32FPR		0x00000040ull /* 32 dbl. prec. FP registers */
+#define MIPS_CPU_COUNTER	0x00000080ull /* Cycle count/compare */
+#define MIPS_CPU_WATCH		0x00000100ull /* watchpoint registers */
+#define MIPS_CPU_DIVEC		0x00000200ull /* dedicated interrupt vector */
+#define MIPS_CPU_VCE		0x00000400ull /* virt. coherence conflict possible */
+#define MIPS_CPU_CACHE_CDEX_P	0x00000800ull /* Create_Dirty_Exclusive CACHE op */
+#define MIPS_CPU_CACHE_CDEX_S	0x00001000ull /* ... same for seconary cache ... */
+#define MIPS_CPU_MCHECK		0x00002000ull /* Machine check exception */
+#define MIPS_CPU_EJTAG		0x00004000ull /* EJTAG exception */
+#define MIPS_CPU_NOFPUEX	0x00008000ull /* no FPU exception */
+#define MIPS_CPU_LLSC		0x00010000ull /* CPU has ll/sc instructions */
+#define MIPS_CPU_INCLUSIVE_CACHES	0x00020000ull /* P-cache subset enforced */
+#define MIPS_CPU_PREFETCH	0x00040000ull /* CPU has usable prefetch */
+#define MIPS_CPU_VINT		0x00080000ull /* CPU supports MIPSR2 vectored interrupts */
+#define MIPS_CPU_VEIC		0x00100000ull /* CPU supports MIPSR2 external interrupt controller mode */
+#define MIPS_CPU_ULRI		0x00200000ull /* CPU has ULRI feature */
+#define MIPS_CPU_PCI		0x00400000ull /* CPU has Perf Ctr Int indicator */
+#define MIPS_CPU_RIXI		0x00800000ull /* CPU has TLB Read/eXec Inhibit */
+#define MIPS_CPU_MICROMIPS	0x01000000ull /* CPU has microMIPS capability */
+#define MIPS_CPU_TLBINV		0x02000000ull /* CPU supports TLBINV/F */
+#define MIPS_CPU_SEGMENTS	0x04000000ull /* CPU supports Segmentation Control registers */
+#define MIPS_CPU_EVA		0x80000000ull /* CPU supports Enhanced Virtual Addressing */
 
 /*
  * CPU ASE encodings
-- 
2.0.0
