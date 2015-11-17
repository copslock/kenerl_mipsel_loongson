Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2015 09:42:50 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:31140 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011355AbbKQImsiqQ8I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Nov 2015 09:42:48 +0100
Received: from localhost.localdomain (unknown [176.4.134.122])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 45E0BA623E;
        Tue, 17 Nov 2015 09:42:31 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, stable@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ath79: Fix the DDR control initialization on ar71xx and ar934x
Date:   Tue, 17 Nov 2015 09:40:07 +0100
Message-Id: <1447749659-9073-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

The DDR control initialization needs to know the SoC type, however
ath79_detect_sys_type() was called after ath79_ddr_ctrl_init().
Reverse the order to fix the DDR control initialization on ar71xx and
ar934x.

Signed-off-by: Alban Bedel <albeu@free.fr>
CC: stable@vger.kernel.org # v4.2+
---
 arch/mips/ath79/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 1ba2120..9a00137 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -216,9 +216,9 @@ void __init plat_mem_setup(void)
 					   AR71XX_RESET_SIZE);
 	ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
 					 AR71XX_PLL_SIZE);
-	ath79_ddr_ctrl_init();
-
 	ath79_detect_sys_type();
+	ath79_ddr_ctrl_init();
+
 	if (mips_machtype != ATH79_MACH_GENERIC_OF)
 		detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
 
-- 
2.0.0
