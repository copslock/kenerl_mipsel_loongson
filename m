Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 16:29:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40185 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012500AbbBDPWoZS3pi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 16:22:44 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0F1E3DFAC193B;
        Wed,  4 Feb 2015 15:22:36 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 4 Feb 2015 15:22:38 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 4 Feb 2015 15:22:38 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>,
        <gregkh@linuxfoundation.org>, <mturquette@linaro.org>,
        <sboyd@codeaurora.org>, <ralf@linux-mips.org>, <jslaby@suse.cz>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <lars@metafoo.de>,
        <paul.burton@imgtec.com>
Subject: [PATCH_V2 18/34] MIPS: clk: move jz4740 UDC auto suspend functions to jz4740-cgu
Date:   Wed, 4 Feb 2015 15:21:47 +0000
Message-ID: <1423063323-19419-19-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

The jz4740-cgu driver already has access to the CGU, so it makes sense
to move the few remaining accesses to the CGU from arch/mips/jz4740
there too. Move the jz4740_clock_udc_{dis,en}able_auto_suspend functions
there for such consistency.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Turquette <mturquette@linaro.org>
---
 arch/mips/jz4740/clock.c        | 13 -------------
 drivers/clk/jz47xx/jz4740-cgu.c | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/mips/jz4740/clock.c b/arch/mips/jz4740/clock.c
index 90b44d7..2a10829 100644
--- a/arch/mips/jz4740/clock.c
+++ b/arch/mips/jz4740/clock.c
@@ -33,7 +33,6 @@
 
 #define JZ_CLOCK_GATE_UART0	BIT(0)
 #define JZ_CLOCK_GATE_TCU	BIT(1)
-#define JZ_CLOCK_GATE_UDC	BIT(11)
 #define JZ_CLOCK_GATE_DMAC	BIT(12)
 
 #define JZ_CLOCK_PLL_STABLE		BIT(10)
@@ -64,18 +63,6 @@ static void jz_clk_reg_clear_bits(int reg, uint32_t mask)
 	writel(val, jz_clock_base + reg);
 }
 
-void jz4740_clock_udc_disable_auto_suspend(void)
-{
-	jz_clk_reg_clear_bits(JZ_REG_CLOCK_GATE, JZ_CLOCK_GATE_UDC);
-}
-EXPORT_SYMBOL_GPL(jz4740_clock_udc_disable_auto_suspend);
-
-void jz4740_clock_udc_enable_auto_suspend(void)
-{
-	jz_clk_reg_set_bits(JZ_REG_CLOCK_GATE, JZ_CLOCK_GATE_UDC);
-}
-EXPORT_SYMBOL_GPL(jz4740_clock_udc_enable_auto_suspend);
-
 void jz4740_clock_suspend(void)
 {
 	jz_clk_reg_set_bits(JZ_REG_CLOCK_GATE,
diff --git a/drivers/clk/jz47xx/jz4740-cgu.c b/drivers/clk/jz47xx/jz4740-cgu.c
index ef559e7..46b6c1a 100644
--- a/drivers/clk/jz47xx/jz4740-cgu.c
+++ b/drivers/clk/jz47xx/jz4740-cgu.c
@@ -27,6 +27,7 @@
 #define CGU_REG_CPCCR		0x00
 #define CGU_REG_LCR		0x04
 #define CGU_REG_CPPCR		0x10
+#define CGU_REG_CLKGR		0x20
 #define CGU_REG_I2SCDR		0x60
 #define CGU_REG_LPCDR		0x64
 #define CGU_REG_MSCCDR		0x68
@@ -47,6 +48,9 @@
 /* bits within the LCR register */
 #define LCR_SLEEP		(1 << 0)
 
+/* bits within the CLKGR register */
+#define CLKGR_UDC		(1 << 11)
+
 static struct jz47xx_cgu *cgu;
 
 static const s8 pll_od_encoding[4] = {
@@ -239,3 +243,19 @@ void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode)
 
 	writel(lcr, cgu->base + CGU_REG_LCR);
 }
+
+void jz4740_clock_udc_disable_auto_suspend(void)
+{
+	uint32_t clkgr = readl(cgu->base + CGU_REG_CLKGR);
+	clkgr &= ~CLKGR_UDC;
+	writel(clkgr, cgu->base + CGU_REG_CLKGR);
+}
+EXPORT_SYMBOL_GPL(jz4740_clock_udc_disable_auto_suspend);
+
+void jz4740_clock_udc_enable_auto_suspend(void)
+{
+	uint32_t clkgr = readl(cgu->base + CGU_REG_CLKGR);
+	clkgr |= CLKGR_UDC;
+	writel(clkgr, cgu->base + CGU_REG_CLKGR);
+}
+EXPORT_SYMBOL_GPL(jz4740_clock_udc_enable_auto_suspend);
-- 
1.9.1
