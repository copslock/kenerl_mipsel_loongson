Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 13:03:23 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:47077 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007228AbbKVMDViIsWw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 13:03:21 +0100
Received: from localhost.localdomain (unknown [78.54.96.206])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id CE09BA625C;
        Sun, 22 Nov 2015 13:02:59 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Weijie Gao <hackpascal@gmail.com>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 1/2] MIPS: ath79: Fix the ar724x clock calculation
Date:   Sun, 22 Nov 2015 13:03:04 +0100
Message-Id: <1448193785-31072-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50038
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

From: Weijie Gao <hackpascal@gmail.com>

According to the AR7242 datasheet section 2.8, AR724X CPUs use a 40MHz
input clock as the REF_CLK instead of 5MHz.

The correct CPU PLL calculation procedure is as follows:
CPU_PLL = (FB * REF_CLK) / REF_DIV / 2.

This patch is compatible with the current calculation procedure with
default FB and REF_DIV values.

Tested on AR7240, AR7241 and AR7242.

Signed-off-by: Weijie Gao <hackpascal@gmail.com>
Signed-off-by: Alban Bedel <albeu@free.fr>
[albeu@free.fr: Fixed the commit log message]
---
 arch/mips/ath79/clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index eb5117c..ed28465 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -26,7 +26,7 @@
 #include "common.h"
 
 #define AR71XX_BASE_FREQ	40000000
-#define AR724X_BASE_FREQ	5000000
+#define AR724X_BASE_FREQ	40000000
 #define AR913X_BASE_FREQ	5000000
 
 static struct clk *clks[3];
@@ -103,8 +103,8 @@ static void __init ar724x_clocks_init(void)
 	div = ((pll >> AR724X_PLL_FB_SHIFT) & AR724X_PLL_FB_MASK);
 	freq = div * ref_rate;
 
-	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK);
-	freq *= div;
+	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK) * 2;
+	freq /= div;
 
 	cpu_rate = freq;
 
-- 
2.0.0
