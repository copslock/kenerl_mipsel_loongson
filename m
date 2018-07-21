Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 13:10:50 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:33340 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992869AbeGULIBnZsUi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jul 2018 13:08:01 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v3 17/18] MIPS: JZ4770: DTS: Add DMA nodes
Date:   Sat, 21 Jul 2018 13:06:42 +0200
Message-Id: <20180721110643.19624-18-paul@crapouillou.net>
In-Reply-To: <20180721110643.19624-1-paul@crapouillou.net>
References: <20180721110643.19624-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532171281; bh=KhjzuRRfIhS4ZOXgMHZpO+37ba5PJ28n1J2o+yXOPfw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IMhu9lBSSp4CM3hglM1LOqzvaxATuuv9bX4hcZGX8+anMeQJMQlGEFbMZSH6oJsXjt5cHcCgTRFNG2n5M/V/8uNterD+I4ReMJQL4QImxYqq1nMV6TgyTbE2jNQUZlBPg71SSz16YbCgDhXJQ/ROYRdbgoir7pGcM64Ky+4ao1c=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65018
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

Add the two devicetree nodes for the two DMA cores of the JZ4770 SoC,
disabled by default, as currently there are no clients for the DMA
driver (until the MMC driver and/or others get a devicetree node).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/jz4770.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

 v2: No change

 v3: Modify nodes to comply with devicetree specification

diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
index 7c2804f3f5f1..49ede6c14ff3 100644
--- a/arch/mips/boot/dts/ingenic/jz4770.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
@@ -196,6 +196,36 @@
 		status = "disabled";
 	};
 
+	dmac0: dma-controller@13420000 {
+		compatible = "ingenic,jz4770-dma";
+		reg = <0x13420000 0xC0
+		       0x13420300 0x20>;
+
+		#dma-cells = <1>;
+
+		clocks = <&cgu JZ4770_CLK_DMA>;
+		interrupt-parent = <&intc>;
+		interrupts = <24>;
+
+		/* Disable dmac0 until we have something that uses it */
+		status = "disabled";
+	};
+
+	dmac1: dma-controller@13420100 {
+		compatible = "ingenic,jz4770-dma";
+		reg = <0x13420100 0xC0
+		       0x13420400 0x20>;
+
+		#dma-cells = <1>;
+
+		clocks = <&cgu JZ4770_CLK_DMA>;
+		interrupt-parent = <&intc>;
+		interrupts = <23>;
+
+		/* Disable dmac1 until we have something that uses it */
+		status = "disabled";
+	};
+
 	uhc: uhc@13430000 {
 		compatible = "generic-ohci";
 		reg = <0x13430000 0x1000>;
-- 
2.11.0
