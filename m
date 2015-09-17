Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2015 18:50:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21218 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013661AbbIQQug1nFdP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Sep 2015 18:50:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BB0419A395A7B;
        Thu, 17 Sep 2015 17:50:27 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Sep 2015 17:50:30 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 17 Sep 2015 17:50:29 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/2] MIPS: cpu-features: Add cpu_has_ftlb
Date:   Thu, 17 Sep 2015 17:49:20 +0100
Message-ID: <1442508561-12260-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1442508561-12260-1-git-send-email-james.hogan@imgtec.com>
References: <1442508561-12260-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49228
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

Add cpu_has_ftlb, which specifies that an FTLB is present in addition to
the VTLB, probed based on whether Config.MT == 4 (rather than 1 for
standard JTLB).

This is necessary since MIPS release 6 removes Config4.MMUExtDef, so the
presence of the FTLB fields in Config4 must be determined from Config.MT
instead.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cpu-features.h | 3 +++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/include/asm/mipsregs.h     | 2 ++
 arch/mips/kernel/cpu-probe.c         | 8 +++++---
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 9801ac982655..fe67f12ac239 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -20,6 +20,9 @@
 #ifndef cpu_has_tlb
 #define cpu_has_tlb		(cpu_data[0].options & MIPS_CPU_TLB)
 #endif
+#ifndef cpu_has_ftlb
+#define cpu_has_ftlb		(cpu_data[0].options & MIPS_CPU_FTLB)
+#endif
 #ifndef cpu_has_tlbinv
 #define cpu_has_tlbinv		(cpu_data[0].options & MIPS_CPU_TLBINV)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index cd89e9855775..82ad15f11049 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -385,6 +385,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_CDMM		0x4000000000ull	/* CPU has Common Device Memory Map */
 #define MIPS_CPU_BP_GHIST	0x8000000000ull /* R12K+ Branch Prediction Global History */
 #define MIPS_CPU_SP		0x10000000000ull /* Small (1KB) page support */
+#define MIPS_CPU_FTLB		0x20000000000ull /* CPU has Fixed-page-size TLB */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index d3cd8eac81e3..c64781cf649f 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -487,6 +487,8 @@
 
 /* Bits specific to the MIPS32/64 PRA.	*/
 #define MIPS_CONF_MT		(_ULCAST_(7) <<	 7)
+#define MIPS_CONF_MT_TLB	(_ULCAST_(1) <<  7)
+#define MIPS_CONF_MT_FTLB	(_ULCAST_(4) <<  7)
 #define MIPS_CONF_AR		(_ULCAST_(7) << 10)
 #define MIPS_CONF_AT		(_ULCAST_(3) << 13)
 #define MIPS_CONF_M		(_ULCAST_(1) << 31)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 571a8e6ea5bd..397551cf2e7b 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -410,16 +410,18 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 static inline unsigned int decode_config0(struct cpuinfo_mips *c)
 {
 	unsigned int config0;
-	int isa;
+	int isa, mt;
 
 	config0 = read_c0_config();
 
 	/*
 	 * Look for Standard TLB or Dual VTLB and FTLB
 	 */
-	if ((((config0 & MIPS_CONF_MT) >> 7) == 1) ||
-	    (((config0 & MIPS_CONF_MT) >> 7) == 4))
+	mt = config0 & MIPS_CONF_MT;
+	if (mt == MIPS_CONF_MT_TLB)
 		c->options |= MIPS_CPU_TLB;
+	else if (mt == MIPS_CONF_MT_FTLB)
+		c->options |= MIPS_CPU_TLB | MIPS_CPU_FTLB;
 
 	isa = (config0 & MIPS_CONF_AT) >> 13;
 	switch (isa) {
-- 
2.4.6
