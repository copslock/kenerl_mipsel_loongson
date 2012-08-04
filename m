Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2012 18:03:02 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:42833 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903524Ab2HDQBr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Aug 2012 18:01:47 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 3B75623C009A;
        Sat,  4 Aug 2012 18:01:43 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 4/4] MIPS: ath79: don't override CPU ASE features
Date:   Sat,  4 Aug 2012 18:01:27 +0200
Message-Id: <1344096087-25044-5-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1344096087-25044-1-git-send-email-juhosg@openwrt.org>
References: <1344096087-25044-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 34056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The ath79 platform covers various SoCs which are based on
the 24Kc and 74Kc cores. Currently various ASEs are disabled
explicitely by the cpu-feature-overrides header, even those
which are present in the 74Kc core.

The kernel is able to detect the available ASEs, so remove
the overrides.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
index 4476fa0..edbf23e 100644
--- a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
@@ -32,19 +32,11 @@
 #define cpu_has_ejtag		1
 #define cpu_has_llsc		1
 
-#define cpu_has_mips16		1
-#define cpu_has_mdmx		0
-#define cpu_has_mips3d		0
-#define cpu_has_smartmips	0
-
 #define cpu_has_mips32r1	1
 #define cpu_has_mips32r2	1
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 
-#define cpu_has_dsp		0
-#define cpu_has_mipsmt		0
-
 #define cpu_has_64bits		0
 #define cpu_has_64bit_zero_reg	0
 #define cpu_has_64bit_gp_regs	0
-- 
1.7.10
