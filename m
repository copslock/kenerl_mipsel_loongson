Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 14:59:13 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:49588 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990508AbdL1N4xbT6a5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 14:56:53 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 05/15] dt-bindings: clock: Add jz4770-cgu.h header
Date:   Thu, 28 Dec 2017 14:56:24 +0100
Message-Id: <20171228135634.30000-6-paul@crapouillou.net>
In-Reply-To: <20171228135634.30000-1-paul@crapouillou.net>
References: <20170702163016.6714-2-paul@crapouillou.net>
 <20171228135634.30000-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514469412; bh=u40+FXbkBnQ4fIfvKU6CUjBoK8pYwRAOQhkD3EiLL3s=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=T3RiFlajBwIF4myOm9ywHDJmDT1qIPh1ALdaR9yzcRvLf/HuVdySpiuzd751UDeYsa6yn1L1JcJ1S/z3ZKATHLwK/dwPBATNm4Idl3MfVxo/iYgaTGO8Fj5HccQxczKM6CoM5Wby5yMQ1YEN89SKL9vNzsV1txgNCL3yaKlflBE=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

This will be used from the devicetree bindings to specify the clocks
that should be obtained from the jz4770-cgu driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/dt-bindings/clock/jz4770-cgu.h | 57 ++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 include/dt-bindings/clock/jz4770-cgu.h

 v3: New patch in this series
 v4: No change

diff --git a/include/dt-bindings/clock/jz4770-cgu.h b/include/dt-bindings/clock/jz4770-cgu.h
new file mode 100644
index 000000000000..54b8b2ae4a73
--- /dev/null
+++ b/include/dt-bindings/clock/jz4770-cgu.h
@@ -0,0 +1,57 @@
+/*
+ * This header provides clock numbers for the ingenic,jz4770-cgu DT binding.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_JZ4770_CGU_H__
+#define __DT_BINDINGS_CLOCK_JZ4770_CGU_H__
+
+#define JZ4770_CLK_EXT		0
+#define JZ4770_CLK_OSC32K	1
+#define JZ4770_CLK_PLL0		2
+#define JZ4770_CLK_PLL1		3
+#define JZ4770_CLK_CCLK		4
+#define JZ4770_CLK_H0CLK	5
+#define JZ4770_CLK_H1CLK	6
+#define JZ4770_CLK_H2CLK	7
+#define JZ4770_CLK_C1CLK	8
+#define JZ4770_CLK_PCLK		9
+#define JZ4770_CLK_MMC0_MUX	10
+#define JZ4770_CLK_MMC0		11
+#define JZ4770_CLK_MMC1_MUX	12
+#define JZ4770_CLK_MMC1		13
+#define JZ4770_CLK_MMC2_MUX	14
+#define JZ4770_CLK_MMC2		15
+#define JZ4770_CLK_CIM		16
+#define JZ4770_CLK_UHC		17
+#define JZ4770_CLK_GPU		18
+#define JZ4770_CLK_BCH		19
+#define JZ4770_CLK_LPCLK_MUX	20
+#define JZ4770_CLK_GPS		21
+#define JZ4770_CLK_SSI_MUX	22
+#define JZ4770_CLK_PCM_MUX	23
+#define JZ4770_CLK_I2S		24
+#define JZ4770_CLK_OTG		25
+#define JZ4770_CLK_SSI0		26
+#define JZ4770_CLK_SSI1		27
+#define JZ4770_CLK_SSI2		28
+#define JZ4770_CLK_PCM0		29
+#define JZ4770_CLK_PCM1		30
+#define JZ4770_CLK_DMA		31
+#define JZ4770_CLK_I2C0		32
+#define JZ4770_CLK_I2C1		33
+#define JZ4770_CLK_I2C2		34
+#define JZ4770_CLK_UART0	35
+#define JZ4770_CLK_UART1	36
+#define JZ4770_CLK_UART2	37
+#define JZ4770_CLK_UART3	38
+#define JZ4770_CLK_IPU		39
+#define JZ4770_CLK_ADC		40
+#define JZ4770_CLK_AIC		41
+#define JZ4770_CLK_AUX		42
+#define JZ4770_CLK_VPU		43
+#define JZ4770_CLK_UHC_PHY	44
+#define JZ4770_CLK_OTG_PHY	45
+#define JZ4770_CLK_EXT512	46
+#define JZ4770_CLK_RTC		47
+
+#endif /* __DT_BINDINGS_CLOCK_JZ4770_CGU_H__ */
-- 
2.11.0
