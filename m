Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 21:12:31 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:35814 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1902756Ab2HNTM0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 21:12:26 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id BEEDC23C00D1;
        Tue, 14 Aug 2012 21:12:23 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: ath79: don't hardcode the unavailability of the DSP ASE
Date:   Tue, 14 Aug 2012 21:12:21 +0200
Message-Id: <1344971541-22465-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 34169
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

The ath79 platform code allows to run a single kernel image
on various SoCs which are based on the 24Kc and 74Kc cores.
The current code explicitely disables the DSP ASE, but that
is available in the 74Kc core.

Remove the override in order to let the kernel to detect the
availability of the DSP ASE at runtime.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

---
This is a replacement of the 'MIPS: ath79: don't override CPU ASE features' 
patch: https://patchwork.linux-mips.org/patch/4169/

I don't think that the issue is critical enough to include that in 
the stable trees.

Gabor

 arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
index 4476fa0..6ddae92 100644
--- a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
@@ -42,7 +42,6 @@
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 
-#define cpu_has_dsp		0
 #define cpu_has_mipsmt		0
 
 #define cpu_has_64bits		0
-- 
1.7.10
