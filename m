Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 15:42:11 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993923AbdCPOgoeTfR0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 15:36:44 +0100
Received: from localhost (unknown [183.98.136.252])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1413AA88;
        Thu, 16 Mar 2017 14:36:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John Crispin <john@phrozen.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 15/48] MIPS: ralink: Remove unused rt*_wdt_reset functions
Date:   Thu, 16 Mar 2017 23:29:59 +0900
Message-Id: <20170316142921.547172732@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170316142920.761502205@linuxfoundation.org>
References: <20170316142920.761502205@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 886f9c69fc68f56ddea34d3de51ac1fc2ac8dfbc upstream.

All pointers to these functions were removed, so now they produce
warnings:

arch/mips/ralink/rt305x.c:92:13: error: 'rt305x_wdt_reset' defined but not used [-Werror=unused-function]

This removes the functions. If we need them again, the patch can be
reverted later.

Fixes: f576fb6a0700 ("MIPS: ralink: cleanup the soc specific pinmux data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: John Crispin <john@phrozen.org>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15044/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/rt288x.c |   10 ----------
 arch/mips/ralink/rt305x.c |   11 -----------
 arch/mips/ralink/rt3883.c |   10 ----------
 3 files changed, 31 deletions(-)

--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -40,16 +40,6 @@ static struct rt2880_pmx_group rt2880_pi
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
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -89,17 +89,6 @@ static struct rt2880_pmx_group rt5350_pi
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
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -63,16 +63,6 @@ static struct rt2880_pmx_group rt3883_pi
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
