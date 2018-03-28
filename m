Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 23:04:03 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47218 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994619AbeC1VCYxUT-C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 23:02:24 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 4C759260844
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 07/15] mmc: dt-bindings: add MMC support to JZ4740 SoC
Date:   Wed, 28 Mar 2018 18:00:49 -0300
Message-Id: <20180328210057.31148-8-ezequiel@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328210057.31148-1-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com>
Return-Path: <ezequiel@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63310
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

Add the devicetree binding for JZ4740/JZ4780 SoC MMC/SD controller.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 Documentation/devicetree/bindings/mmc/jz4740.txt | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/jz4740.txt

diff --git a/Documentation/devicetree/bindings/mmc/jz4740.txt b/Documentation/devicetree/bindings/mmc/jz4740.txt
new file mode 100644
index 000000000000..7cd8c432d7c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/jz4740.txt
@@ -0,0 +1,38 @@
+* Ingenic JZ47xx MMC controllers
+
+This file documents the device tree properties used for the MMC controller in
+Ingenic JZ4740/JZ4780 SoCs. These are in addition to the core MMC properties
+described in mmc.txt.
+
+Required properties:
+- compatible: Should be one of the following:
+  - "ingenic,jz4740-mmc" for the JZ4740
+  - "ingenic,jz4780-mmc" for the JZ4780
+- reg: Should contain the MMC controller registers location and length.
+- interrupts: Should contain the interrupt specifier of the MMC controller.
+- clocks: Clock for the MMC controller.
+
+Optional properties:
+- dmas: List of DMA specifiers with the controller specific format
+        as described in the generic DMA client binding. A tx and rx
+        specifier is required.
+- dma-names: RX and TX  DMA request names.
+        Should be "rx" and "tx", in that order.
+
+For additional details on DMA client bindings see ../dma/dma.txt.
+
+Example:
+
+mmc0: mmc@13450000 {
+	compatible = "ingenic,jz4780-mmc";
+	reg = <0x13450000 0x1000>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <37>;
+
+	clocks = <&cgu JZ4780_CLK_MSC0>;
+	clock-names = "mmc";
+
+	dmas = <&dma JZ4780_DMA_MSC0_RX 0xffffffff>, <&dma JZ4780_DMA_MSC0_TX 0xffffffff>;
+	dma-names = "rx", "tx";
+};
-- 
2.16.2
