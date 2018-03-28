Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 23:05:10 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3]:44056
        "EHLO bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeC1VChMAqeC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 23:02:37 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 601CB260844
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v4 11/15] MIPS: dts: jz4780: Add DMA controller node to the devicetree
Date:   Wed, 28 Mar 2018 18:00:53 -0300
Message-Id: <20180328210057.31148-12-ezequiel@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328210057.31148-1-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com>
Return-Path: <ezequiel@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@collabora.com
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

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Add the devicetree node to support the DMA controller found
in JZ480 SoCs.

Tested-by: Mathieu Malaterre <malat@debian.org>
Acked-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 12 +++++++++
 include/dt-bindings/dma/jz4780-dma.h   | 49 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 include/dt-bindings/dma/jz4780-dma.h

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9b5794667aee..15a9801430bd 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/clock/jz4780-cgu.h>
+#include <dt-bindings/dma/jz4780-dma.h>
 
 / {
 	#address-cells = <1>;
@@ -241,6 +242,17 @@
 		status = "disabled";
 	};
 
+	dma: dma@13420000 {
+		compatible = "ingenic,jz4780-dma";
+		reg = <0x13420000 0x10000>;
+		#dma-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <10>;
+
+		clocks = <&cgu JZ4780_CLK_PDMA>;
+	};
+
 	bch: bch@134d0000 {
 		compatible = "ingenic,jz4780-bch";
 		reg = <0x134d0000 0x10000>;
diff --git a/include/dt-bindings/dma/jz4780-dma.h b/include/dt-bindings/dma/jz4780-dma.h
new file mode 100644
index 000000000000..df017fdfb44e
--- /dev/null
+++ b/include/dt-bindings/dma/jz4780-dma.h
@@ -0,0 +1,49 @@
+#ifndef __DT_BINDINGS_DMA_JZ4780_DMA_H__
+#define __DT_BINDINGS_DMA_JZ4780_DMA_H__
+
+/*
+ * Request type numbers for the JZ4780 DMA controller (written to the DRTn
+ * register for the channel).
+ */
+#define JZ4780_DMA_I2S1_TX	0x4
+#define JZ4780_DMA_I2S1_RX	0x5
+#define JZ4780_DMA_I2S0_TX	0x6
+#define JZ4780_DMA_I2S0_RX	0x7
+#define JZ4780_DMA_AUTO		0x8
+#define JZ4780_DMA_SADC_RX	0x9
+#define JZ4780_DMA_UART4_TX	0xc
+#define JZ4780_DMA_UART4_RX	0xd
+#define JZ4780_DMA_UART3_TX	0xe
+#define JZ4780_DMA_UART3_RX	0xf
+#define JZ4780_DMA_UART2_TX	0x10
+#define JZ4780_DMA_UART2_RX	0x11
+#define JZ4780_DMA_UART1_TX	0x12
+#define JZ4780_DMA_UART1_RX	0x13
+#define JZ4780_DMA_UART0_TX	0x14
+#define JZ4780_DMA_UART0_RX	0x15
+#define JZ4780_DMA_SSI0_TX	0x16
+#define JZ4780_DMA_SSI0_RX	0x17
+#define JZ4780_DMA_SSI1_TX	0x18
+#define JZ4780_DMA_SSI1_RX	0x19
+#define JZ4780_DMA_MSC0_TX	0x1a
+#define JZ4780_DMA_MSC0_RX	0x1b
+#define JZ4780_DMA_MSC1_TX	0x1c
+#define JZ4780_DMA_MSC1_RX	0x1d
+#define JZ4780_DMA_MSC2_TX	0x1e
+#define JZ4780_DMA_MSC2_RX	0x1f
+#define JZ4780_DMA_PCM0_TX	0x20
+#define JZ4780_DMA_PCM0_RX	0x21
+#define JZ4780_DMA_SMB0_TX	0x24
+#define JZ4780_DMA_SMB0_RX	0x25
+#define JZ4780_DMA_SMB1_TX	0x26
+#define JZ4780_DMA_SMB1_RX	0x27
+#define JZ4780_DMA_SMB2_TX	0x28
+#define JZ4780_DMA_SMB2_RX	0x29
+#define JZ4780_DMA_SMB3_TX	0x2a
+#define JZ4780_DMA_SMB3_RX	0x2b
+#define JZ4780_DMA_SMB4_TX	0x2c
+#define JZ4780_DMA_SMB4_RX	0x2d
+#define JZ4780_DMA_DES_TX	0x2e
+#define JZ4780_DMA_DES_RX	0x2f
+
+#endif /* __DT_BINDINGS_DMA_JZ4780_DMA_H__ */
-- 
2.16.2
