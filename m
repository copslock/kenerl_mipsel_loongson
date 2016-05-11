Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 14:52:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1506 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028959AbcEKMvjkqnv2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 14:51:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id C14FB40190611;
        Wed, 11 May 2016 13:51:30 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 13:51:33 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 13:51:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 4/5] MIPS: Add defs & probing of [X]ContextConfig
Date:   Wed, 11 May 2016 13:50:52 +0100
Message-ID: <1462971053-25622-5-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53370
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

The CP0_[X]ContextConfig registers are present if CP0_Config3.CTXTC or
CP0_Config3.SM are set, and provide more control over which bits of
CP0_[X]Context are set to the faulting virtual address on a TLB
exception.

KVM/VZ will need to be able to save and restore these registers in the
guest context, so add the relevant definitions and probing of the
ContextConfig feature in the root context first.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cpu-features.h | 4 ++++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/include/asm/mipsregs.h     | 6 ++++++
 arch/mips/kernel/cpu-probe.c         | 4 +++-
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index f901bc35f9a4..04b91d624c81 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -444,4 +444,8 @@
 # define cpu_has_badinstrp	(cpu_data[0].options & MIPS_CPU_BADINSTRP)
 #endif
 
+#ifndef cpu_has_contextconfig
+# define cpu_has_contextconfig	(cpu_data[0].options & MIPS_CPU_CTXTC)
+#endif
+
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 8a8b029c545a..3a3848e2f481 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -406,6 +406,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_EBASE_WG	MBIT_ULL(42)	/* CPU has EBase.WG */
 #define MIPS_CPU_BADINSTR	MBIT_ULL(43)	/* CPU has BadInstr register */
 #define MIPS_CPU_BADINSTRP	MBIT_ULL(44)	/* CPU has BadInstrP register */
+#define MIPS_CPU_CTXTC		MBIT_ULL(45)	/* CPU has [X]ConfigContext registers */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index b1f8f8436fd1..08864cbbb27b 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1228,9 +1228,15 @@ do {									\
 #define read_c0_context()	__read_ulong_c0_register($4, 0)
 #define write_c0_context(val)	__write_ulong_c0_register($4, 0, val)
 
+#define read_c0_contextconfig()		__read_32bit_c0_register($4, 1)
+#define write_c0_contextconfig(val)	__write_32bit_c0_register($4, 1, val)
+
 #define read_c0_userlocal()	__read_ulong_c0_register($4, 2)
 #define write_c0_userlocal(val) __write_ulong_c0_register($4, 2, val)
 
+#define read_c0_xcontextconfig()	__read_ulong_c0_register($4, 3)
+#define write_c0_xcontextconfig(val)	__write_ulong_c0_register($4, 3, val)
+
 #define read_c0_pagemask()	__read_32bit_c0_register($5, 0)
 #define write_c0_pagemask(val)	__write_32bit_c0_register($5, 0, val)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 83c7f3d0fcd2..e9bbb0a18168 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -687,10 +687,12 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 
 	if (config3 & MIPS_CONF3_SM) {
 		c->ases |= MIPS_ASE_SMARTMIPS;
-		c->options |= MIPS_CPU_RIXI;
+		c->options |= MIPS_CPU_RIXI | MIPS_CPU_CTXTC;
 	}
 	if (config3 & MIPS_CONF3_RXI)
 		c->options |= MIPS_CPU_RIXI;
+	if (config3 & MIPS_CONF3_CTXTC)
+		c->options |= MIPS_CPU_CTXTC;
 	if (config3 & MIPS_CONF3_DSP)
 		c->ases |= MIPS_ASE_DSP;
 	if (config3 & MIPS_CONF3_DSP2P) {
-- 
2.4.10
