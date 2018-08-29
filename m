Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:37:14 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:41640 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994619AbeH2VdWHpQrp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2018 23:33:22 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 16/18] MIPS: JZ4780: DTS: Update DMA node to match driver changes
Date:   Wed, 29 Aug 2018 23:32:58 +0200
Message-Id: <20180829213300.22829-17-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578401; bh=+89+tAsgauTjZPoNWXUCE4GvHZ9D0R/Qb5ZaYzWIDwo=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=u9OxphtiYQ5/+M5u1xUdAIxGgj6mgl/cCHawuqflz/OeUpTeLI2ReiZIakJkj8LrZjo4/byqgfSnbAnInhsavdpMOuB5cdqPbgoQwvRXKopNquebCLoeP1ZUCgnHzZzCZe41hAXGs2cyKgiPpG61GKDI4Z9k/UypZRo9CBaZz3s=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65795
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

The driver now accepts two memory resources, the first one for the
channel-specific registers, the second one for the controller-specific
registers.

Note that older devicetrees, without this commit, will still work with
the jz4780-dma driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---

Notes:
     v2: Update info about devicetree ABI compatibility in commit message
    
     v3: No change
    
     v4: No change
    
     v5: No change

 arch/mips/boot/dts/ingenic/jz4780.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index ce93d57f1b4d..b03cdec56de9 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -266,7 +266,8 @@
 
 	dma: dma@13420000 {
 		compatible = "ingenic,jz4780-dma";
-		reg = <0x13420000 0x10000>;
+		reg = <0x13420000 0x400
+		       0x13421000 0x40>;
 		#dma-cells = <2>;
 
 		interrupt-parent = <&intc>;
-- 
2.11.0
