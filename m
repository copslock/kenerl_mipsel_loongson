Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 17:18:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2484 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011193AbbGOPR5p-CDK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 17:17:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5042FC1226A55;
        Wed, 15 Jul 2015 16:17:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 15 Jul 2015 16:17:51 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 15 Jul 2015 16:17:51 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 3/6] MIPS: Probe for small (1KiB) page support
Date:   Wed, 15 Jul 2015 16:17:44 +0100
Message-ID: <1436973467-3877-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1436973467-3877-1-git-send-email-james.hogan@imgtec.com>
References: <1436973467-3877-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48310
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

Probe Config3 for small page support. This will be useful to give clues
as to whether the PageGrain register exists.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cpu-features.h | 4 ++++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/kernel/cpu-probe.c         | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index f25de771f7ed..9801ac982655 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -411,4 +411,8 @@
 # define cpu_has_cdmm		(cpu_data[0].options & MIPS_CPU_CDMM)
 #endif
 
+#ifndef cpu_has_small_pages
+# define cpu_has_small_pages	(cpu_data[0].options & MIPS_CPU_SP)
+#endif
+
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index e46e40602af3..00424b630f27 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -382,6 +382,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_XPA		0x2000000000ull /* CPU supports Extended Physical Addressing */
 #define MIPS_CPU_CDMM		0x4000000000ull	/* CPU has Common Device Memory Map */
 #define MIPS_CPU_BP_GHIST	0x8000000000ull /* R12K+ Branch Prediction Global History */
+#define MIPS_CPU_SP		0x10000000000ull /* Small (1KB) page support */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index dbe0792fc9c1..4f716dd77734 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -524,6 +524,8 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 	}
 	if (config3 & MIPS_CONF3_CDMM)
 		c->options |= MIPS_CPU_CDMM;
+	if (config3 & MIPS_CONF3_SP)
+		c->options |= MIPS_CPU_SP;
 
 	return config3 & MIPS_CONF_M;
 }
-- 
2.3.6
