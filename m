Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:33:23 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:37862 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993945AbeH2VdH0qJip (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2018 23:33:07 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 01/18] dt-bindings: jz4780-dma: Update bindings to reflect driver changes
Date:   Wed, 29 Aug 2018 23:32:43 +0200
Message-Id: <20180829213300.22829-2-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578386; bh=7/nF5ptTjLMFMBSK3el5ZN3TxvQ3NZOE4K7lOOvvJcw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZBOYPnnVlLW4Xp7VX0wUKJO1B9Si1wloj0ki23wtiDRdXsv9VJCn8LNPTDvSzhvwTkGFsJnvon/KZFAKJU5lpXI2Qxh7A/R2mWUK52FD+2bGlc9Lv4yG/0GTyHJwfuTeWbtw6OXuTUJt8aH91Yq6hW3xAp+yv//lp190CQQeGLE=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65780
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

The driver now expects the devicetree to supply a second memory
resource. This resource is mandatory on the newly supported SoCs.
For the JZ4780, new devicetree code must also provide it, although the
driver is still compatible with older devicetree binaries.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
     v2: New patch in this series; regroups the changes made to the
     jz4780-dma.txt doc file in the previous version of the patchset.
    
     v3: Updated example to comply with devicetree specification
    
     v4: Removed driver-specific comment in commit message
    
     v5: Remove 'doc' in patch title

 Documentation/devicetree/bindings/dma/jz4780-dma.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index 03e9cf7b42e0..636fcb26b164 100644
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
@@ -2,8 +2,13 @@
 
 Required properties:
 
-- compatible: Should be "ingenic,jz4780-dma"
-- reg: Should contain the DMA controller registers location and length.
+- compatible: Should be one of:
+  * ingenic,jz4740-dma
+  * ingenic,jz4725b-dma
+  * ingenic,jz4770-dma
+  * ingenic,jz4780-dma
+- reg: Should contain the DMA channel registers location and length, followed
+  by the DMA controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the DMA controller.
 - clocks: Should contain a clock specifier for the JZ4780 PDMA clock.
 - #dma-cells: Must be <2>. Number of integer cells in the dmas property of
@@ -19,9 +24,10 @@ Optional properties:
 
 Example:
 
-dma: dma@13420000 {
+dma: dma-controller@13420000 {
 	compatible = "ingenic,jz4780-dma";
-	reg = <0x13420000 0x10000>;
+	reg = <0x13420000 0x400
+	       0x13421000 0x40>;
 
 	interrupt-parent = <&intc>;
 	interrupts = <10>;
-- 
2.11.0
