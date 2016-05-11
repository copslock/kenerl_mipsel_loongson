Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 14:52:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52777 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028957AbcEKMvi6A8h2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 14:51:38 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id BF286A67A71A3;
        Wed, 11 May 2016 13:51:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 13:51:32 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 13:51:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 3/5] MIPS: Add defs & probing of BadInstr[P] registers
Date:   Wed, 11 May 2016 13:50:51 +0100
Message-ID: <1462971053-25622-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1462971053-25622-1-git-send-email-james.hogan@imgtec.com>
References: <1462971053-25622-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53369
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

The optional CP0_BadInstr and CP0_BadInstrP registers are written with
the encoding of the instruction that caused a synchronous exception to
occur, and the prior branch instruction if in a delay slot.

These will be useful for instruction emulation in KVM, and especially
for VZ support where reading guest virtual memory is a bit more awkward.

Add CPU option numbers and cpu_has_* definitions to indicate the
presence of each registers, and add code to probe for them using bits in
the CP0_Config3 register.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cpu-features.h | 8 ++++++++
 arch/mips/include/asm/cpu.h          | 2 ++
 arch/mips/include/asm/mipsregs.h     | 3 +++
 arch/mips/kernel/cpu-probe.c         | 4 ++++
 4 files changed, 17 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 3d82a4043e80..f901bc35f9a4 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -436,4 +436,12 @@
 # define cpu_has_ebase_wg	(cpu_data[0].options & MIPS_CPU_EBASE_WG)
 #endif
 
+#ifndef cpu_has_badinstr
+# define cpu_has_badinstr	(cpu_data[0].options & MIPS_CPU_BADINSTR)
+#endif
+
+#ifndef cpu_has_badinstrp
+# define cpu_has_badinstrp	(cpu_data[0].options & MIPS_CPU_BADINSTRP)
+#endif
+
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 379beefefb5c..8a8b029c545a 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -404,6 +404,8 @@ enum cpu_type_enum {
 #define MIPS_CPU_VP		MBIT_ULL(40)	/* MIPSr6 Virtual Processors (multi-threading) */
 #define MIPS_CPU_LDPTE		MBIT_ULL(41)	 /* CPU has ldpte/lddir instructions */
 #define MIPS_CPU_EBASE_WG	MBIT_ULL(42)	/* CPU has EBase.WG */
+#define MIPS_CPU_BADINSTR	MBIT_ULL(43)	/* CPU has BadInstr register */
+#define MIPS_CPU_BADINSTRP	MBIT_ULL(44)	/* CPU has BadInstrP register */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 4e8ad9d6038a..b1f8f8436fd1 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1248,6 +1248,9 @@ do {									\
 #define read_c0_badvaddr()	__read_ulong_c0_register($8, 0)
 #define write_c0_badvaddr(val)	__write_ulong_c0_register($8, 0, val)
 
+#define read_c0_badinstr()	__read_32bit_c0_register($8, 1)
+#define read_c0_badinstrp()	__read_32bit_c0_register($8, 2)
+
 #define read_c0_count()		__read_32bit_c0_register($9, 0)
 #define write_c0_count(val)	__write_32bit_c0_register($9, 0, val)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c4795568c1f2..83c7f3d0fcd2 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -712,6 +712,10 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->ases |= MIPS_ASE_VZ;
 	if (config3 & MIPS_CONF3_SC)
 		c->options |= MIPS_CPU_SEGMENTS;
+	if (config3 & MIPS_CONF3_BI)
+		c->options |= MIPS_CPU_BADINSTR;
+	if (config3 & MIPS_CONF3_BP)
+		c->options |= MIPS_CPU_BADINSTRP;
 	if (config3 & MIPS_CONF3_MSA)
 		c->ases |= MIPS_ASE_MSA;
 	if (config3 & MIPS_CONF3_PW) {
-- 
2.4.10
