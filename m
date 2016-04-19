Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 10:25:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38805 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027009AbcDSIZtkGjEY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 10:25:49 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id DBC031ED0C70F;
        Tue, 19 Apr 2016 09:25:40 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 19 Apr 2016 09:25:43 +0100
Received: from localhost (10.100.200.185) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 19 Apr
 2016 09:25:42 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        "Joshua Kinard" <kumba@gentoo.org>, <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v3 01/13] MIPS: Separate XPA CPU feature into LPA and MVH
Date:   Tue, 19 Apr 2016 09:24:59 +0100
Message-ID: <1461054311-387-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461054311-387-1-git-send-email-paul.burton@imgtec.com>
References: <1461054311-387-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.185]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

From: James Hogan <james.hogan@imgtec.com>

XPA (eXtended Physical Addressing) should be detected as a combination
of two architectural features:
- Large Physical Address (as per Config3.LPA). With XPA this will be set
  on MIPS32r5 cores, but it may also be set for MIPS64r2 cores too.
- MTHC0/MFHC0 instructions (as per Config5.MVH). With XPA this will be
  set, but it may also be set in VZ guest context even when Config3.LPA
  in the guest context has been cleared by the hypervisor.

As such, XPA is only usable if both bits are set. Update CPU features to
separate these two features, with cpu_has_xpa requiring both to be set.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v3: None
Changes in v2: None

 arch/mips/include/asm/cpu-features.h | 8 +++++++-
 arch/mips/include/asm/cpu.h          | 3 ++-
 arch/mips/kernel/cpu-probe.c         | 6 +++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index eeec8c8..3993a35 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -142,8 +142,14 @@
 # endif
 #endif
 
+#ifndef cpu_has_lpa
+#define cpu_has_lpa		(cpu_data[0].options & MIPS_CPU_LPA)
+#endif
+#ifndef cpu_has_mvh
+#define cpu_has_mvh		(cpu_data[0].options & MIPS_CPU_MVH)
+#endif
 #ifndef cpu_has_xpa
-#define cpu_has_xpa		(cpu_data[0].options & MIPS_CPU_XPA)
+#define cpu_has_xpa		(cpu_has_lpa && cpu_has_mvh)
 #endif
 #ifndef cpu_has_vtag_icache
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index a97ca97..32fa061 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -381,13 +381,14 @@ enum cpu_type_enum {
 #define MIPS_CPU_MAAR		0x400000000ull /* MAAR(I) registers are present */
 #define MIPS_CPU_FRE		0x800000000ull /* FRE & UFE bits implemented */
 #define MIPS_CPU_RW_LLB		0x1000000000ull /* LLADDR/LLB writes are allowed */
-#define MIPS_CPU_XPA		0x2000000000ull /* CPU supports Extended Physical Addressing */
+#define MIPS_CPU_LPA		0x2000000000ull /* CPU supports Large Physical Addressing */
 #define MIPS_CPU_CDMM		0x4000000000ull	/* CPU has Common Device Memory Map */
 #define MIPS_CPU_BP_GHIST	0x8000000000ull /* R12K+ Branch Prediction Global History */
 #define MIPS_CPU_SP		0x10000000000ull /* Small (1KB) page support */
 #define MIPS_CPU_FTLB		0x20000000000ull /* CPU has Fixed-page-size TLB */
 #define MIPS_CPU_NAN_LEGACY	0x40000000000ull /* Legacy NaN implemented */
 #define MIPS_CPU_NAN_2008	0x80000000000ull /* 2008 NaN implemented */
+#define MIPS_CPU_MVH		0x100000000000ull /* CPU supports MFHC0/MTHC0 */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b725b71..da21fbe 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -685,6 +685,8 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_VINT;
 	if (config3 & MIPS_CONF3_VEIC)
 		c->options |= MIPS_CPU_VEIC;
+	if (config3 & MIPS_CONF3_LPA)
+		c->options |= MIPS_CPU_LPA;
 	if (config3 & MIPS_CONF3_MT)
 		c->ases |= MIPS_ASE_MIPSMT;
 	if (config3 & MIPS_CONF3_ULRI)
@@ -792,10 +794,8 @@ static inline unsigned int decode_config5(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_MAAR;
 	if (config5 & MIPS_CONF5_LLB)
 		c->options |= MIPS_CPU_RW_LLB;
-#ifdef CONFIG_XPA
 	if (config5 & MIPS_CONF5_MVH)
-		c->options |= MIPS_CPU_XPA;
-#endif
+		c->options |= MIPS_CPU_MVH;
 
 	return config5 & MIPS_CONF_M;
 }
-- 
2.8.0
