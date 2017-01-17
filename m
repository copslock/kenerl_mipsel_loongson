Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:23:21 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.135]:49440 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993905AbdAQPVOEQUXd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:21:14 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LhoIM-1cp2aa1Dxy-00nAnH; Tue, 17 Jan 2017 16:20:30 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        John Crispin <john@phrozen.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] MIPS: ralink: remove unused rt*_wdt_reset functions
Date:   Tue, 17 Jan 2017 16:18:43 +0100
Message-Id: <20170117151911.4109452-9-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:KOlk6hqQZV4jsHHZk9AOF+qZh2zBTJDbA2JxVV1UoZcMxXYfVUO
 P831vBaWHDbW5b4LoSOPhelzXAs1CqSkh22e5UqCJDIGq5PznPcIjBGbG+mb6jL4RnRpmyM
 kTeQ515o6hCZmBdIuXjfRMx2yhdz4fwKIUahCBHbR7SIRJ5Gof2rHBt/ukhzyqCqtF0eXjx
 T8QGmJZVYajozHotetegQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uFJxpLOn72A=:Lpizux2YU5PdYLV9AIUUB6
 V9YzWdDU/FCWzTArXGTq/mWKolkSuRNM9bpDs8AwoBholdfOhhhqQLrFu5WKLeKT0FbocVxcj
 4NRalr2RgbV3jAiTmVfQS8J0tDM6K3TDz4I7En5kqGA7V2HbrUlDvb8g5HT11it+LaeNFmWJv
 EzkF1x/MEdZ+IGKOB6qT5ENe2wFZCBy1ZJUVnIVsOQYXU47iEZWmo3CU/y53ftjgWVS2cdPvc
 08ume1SYrDsg8ls2VMLIGamLnntZ0PkOYhYO9yVFHftrfVLOyJu4xHYT+e5cgJeq6aMvnmQoa
 uWn0I8IO2CY8XDYqWFOj/g/HNaoxsUFTq41hi5I60M522uSZcX3R1uT16/mpSvMxoG9uguaBb
 gQtea7NufsKSQGHHYgIlY4R3Er464GXCsoS+uRfJb27Qb+82e3ie6PpgN5t8P/CBuHQzlRqam
 3TourmxYwElUBG/op0QoWW6Nc2cbLzIigdyKZbI8v5Eod3pZiZo8F067QdUpub0LOZLks5mKN
 QCgoPxbpyMRk5sBxofqVk7rXLvn3MkTSB/W8j8gD7m3J/ftoclvlzmsqN3bVitFX6oBzl/5b4
 C6qEc6/4707BYoPtilm4Z1EZY1pRCnJef+hqutPDGxtKLN8gjQDDqaQ3oN6aWZDvhcULUYUJE
 fPdLjw8NAGZX+AI/wvGVZ4jTSy0O1WWDYWcv1UmdiS5rNRPBfJTJ6R1+Aeem0SS0AwTg=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

All pointers to these functions were removed, so now they produce
warnings:

arch/mips/ralink/rt305x.c:92:13: error: 'rt305x_wdt_reset' defined but not used [-Werror=unused-function]

This removes the functions. If we need them again, the patch can be
reverted later.

Fixes: f576fb6a0700 ("MIPS: ralink: cleanup the soc specific pinmux data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/ralink/rt288x.c | 10 ----------
 arch/mips/ralink/rt305x.c | 11 -----------
 arch/mips/ralink/rt3883.c | 10 ----------
 3 files changed, 31 deletions(-)

diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index eeabd5119891..40d3a69c7016 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -40,16 +40,6 @@ static struct rt2880_pmx_group rt2880_pinmux_data_act[] = {
 	{ 0 }
 };
 
-static void rt288x_wdt_reset(void)
-{
-	u32 t;
-
-	/* enable WDT reset output on pin SRAM_CS_N */
-	t = rt_sysc_r32(SYSC_REG_CLKCFG);
-	t |= CLKCFG_SRAM_CS_N_WDT;
-	rt_sysc_w32(t, SYSC_REG_CLKCFG);
-}
-
 void __init ralink_clk_init(void)
 {
 	unsigned long cpu_rate, wmac_rate = 40000000;
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index f0b5ac444556..01f7cd38d631 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -89,17 +89,6 @@ static struct rt2880_pmx_group rt5350_pinmux_data[] = {
 	{ 0 }
 };
 
-static void rt305x_wdt_reset(void)
-{
-	u32 t;
-
-	/* enable WDT reset output on pin SRAM_CS_N */
-	t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
-	t |= RT305X_SYSCFG_SRAM_CS0_MODE_WDT <<
-		RT305X_SYSCFG_SRAM_CS0_MODE_SHIFT;
-	rt_sysc_w32(t, SYSC_REG_SYSTEM_CONFIG);
-}
-
 static unsigned long rt5350_get_mem_size(void)
 {
 	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT305X_SYSC_BASE);
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index f869052e4a0d..252b64114b48 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -63,16 +63,6 @@ static struct rt2880_pmx_group rt3883_pinmux_data[] = {
 	{ 0 }
 };
 
-static void rt3883_wdt_reset(void)
-{
-	u32 t;
-
-	/* enable WDT reset output on GPIO 2 */
-	t = rt_sysc_r32(RT3883_SYSC_REG_SYSCFG1);
-	t |= RT3883_SYSCFG1_GPIO2_AS_WDT_OUT;
-	rt_sysc_w32(t, RT3883_SYSC_REG_SYSCFG1);
-}
-
 void __init ralink_clk_init(void)
 {
 	unsigned long cpu_rate, sys_rate;
-- 
2.9.0
