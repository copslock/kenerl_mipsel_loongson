Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Aug 2013 11:57:28 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:56187 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831922Ab3HVJ5TpmIsO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Aug 2013 11:57:19 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 858AB280328;
        Thu, 22 Aug 2013 11:56:51 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu, 22 Aug 2013 11:56:51 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: ath79: don't hardwire cpu_has_dsp{2} to 0
Date:   Thu, 22 Aug 2013 11:57:14 +0200
Message-Id: <1377165434-28926-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37641
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

The ath79 code supports various SoCs which are using either a 24Kc
or a 74Kc core. The 74Kc core has DSP support, so don't hardwire
the values to zero.

Commit 00dc5ce2a653a332190aa29b2e1f3bceaa7d5b8d (MIPS: ath79: don't
hardcode the unavailability of the DSP ASE) has fixed this already,
but that change got reverted by 475032564ed96c94c085e3e7a90e07d150a7cec9
(MIPS: Hardwire detection of DSP ASE Rev 2 for systems, as required.)

Reported-by: Helmut Schaa <helmut.schaa@googlemail.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
index ddb947e..0089a74 100644
--- a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
@@ -42,8 +42,6 @@
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 
-#define cpu_has_dsp		0
-#define cpu_has_dsp2		0
 #define cpu_has_mipsmt		0
 
 #define cpu_has_64bits		0
-- 
1.7.10
