Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 13:59:55 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:46226 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993497AbeGTL6vpxoGA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 13:58:51 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 06/25] MIPS: ath79: finetune cpu-overrides
Date:   Fri, 20 Jul 2018 13:58:23 +0200
Message-Id: <20180720115842.8406-7-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
References: <20180720115842.8406-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

From: Felix Fietkau <nbd@nbd.name>

This patch adds a few additional cpu feature overrides so that they do not
need to be probed at runtime.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
index 0089a740e5ae..026ad90c8ac0 100644
--- a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
@@ -36,6 +36,7 @@
 #define cpu_has_mdmx		0
 #define cpu_has_mips3d		0
 #define cpu_has_smartmips	0
+#define cpu_has_rixi		0
 
 #define cpu_has_mips32r1	1
 #define cpu_has_mips32r2	1
@@ -43,6 +44,7 @@
 #define cpu_has_mips64r2	0
 
 #define cpu_has_mipsmt		0
+#define cpu_has_userlocal	0
 
 #define cpu_has_64bits		0
 #define cpu_has_64bit_zero_reg	0
@@ -51,5 +53,9 @@
 
 #define cpu_dcache_line_size()	32
 #define cpu_icache_line_size()	32
+#define cpu_has_vtag_icache	0
+#define cpu_has_dc_aliases	1
+#define cpu_has_ic_fills_f_dc	0
+#define cpu_has_pindexed_dcache	0
 
 #endif /* __ASM_MACH_ATH79_CPU_FEATURE_OVERRIDES_H */
-- 
2.11.0
