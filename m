Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:37:39 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:42122 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994630AbeH2VdX7Fd9p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2018 23:33:23 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 18/18] MIPS: JZ4740: DTS: Add DMA nodes
Date:   Wed, 29 Aug 2018 23:33:00 +0200
Message-Id: <20180829213300.22829-19-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578403; bh=4ZMDlIEdF6HWrLwcHbIYcp/zmQ+d8Y1/lmjcE4wTz08=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TWck4qYe6xuM8veyK9VFqzE8CJ7O7AHEpgnGPFEd/d/68ff1zR3urwLoocOzDuyJS6JrlBDDlamVWW0DczdIX/2ZY5YonyjTov1ujbx0v7860KlqBjAMC2YkcHpkypmdKOtjbjN5b4JSTOnHpUunXaBXd2cZhBElvpU3phKH8v4=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65797
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

Add the devicetree nodes for the DMA core of the JZ4740 SoC, disabled
by default, as currently there are no clients for the DMA driver
(until the MMC driver and/or others get a devicetree node).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Acked-by: Paul Burton <paul.burton@mips.com>
---

Notes:
     v2: New patch in this series
    
     v3: Modify node to comply with devicetree specification
    
     v4: No change
    
     v5: No change

 arch/mips/boot/dts/ingenic/jz4740.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 26c6b561d6f7..6fb16fd24035 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -154,6 +154,21 @@
 		clock-names = "baud", "module";
 	};
 
+	dmac: dma-controller@13020000 {
+		compatible = "ingenic,jz4740-dma";
+		reg = <0x13020000 0xbc
+		       0x13020300 0x14>;
+		#dma-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <29>;
+
+		clocks = <&cgu JZ4740_CLK_DMA>;
+
+		/* Disable dmac until we have something that uses it */
+		status = "disabled";
+	};
+
 	uhc: uhc@13030000 {
 		compatible = "ingenic,jz4740-ohci", "generic-ohci";
 		reg = <0x13030000 0x1000>;
-- 
2.11.0
