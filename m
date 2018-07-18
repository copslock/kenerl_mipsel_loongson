Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 20:20:55 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:53006 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993029AbeGRSUoeiyUK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2018 20:20:44 +0200
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 01/17] doc: dt-bindings: jz4780-dma: Update bindings to reflect driver changes
Date:   Wed, 18 Jul 2018 20:20:07 +0200
Message-Id: <20180718182023.8182-2-paul@crapouillou.net>
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
References: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938043; bh=JEY7wTY9g8xvyt09OImVTJKTC+KCcodY2IA2CuNSTaw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EnmPzBVo3Ob4JqOjY92OWwx2IMr6RLdHk43yHDtPutHjxpN+PpH1mY8JwKGP0fcN2cpb1Mxl6BYWDWvS7fsV3upacqN2dz+Zddyq31FKdxPvSpdFMLn6iB/RWND0i+n4EBhkHzZGOw62raYwaUkRKw5fSZAcUOsTOUzv5S1xmMs=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64923
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

The driver is now compatible with four SoCs: JZ4780, JZ4770, JZ4725B and
JZ4740.

Besides, it now expects the devicetree to supply a second memory
resource. This resource is mandatory on the newly supported SoCs.
For the JZ4780, new devicetree code must also provide it, although the
driver is still compatible with older devicetree binaries.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 Documentation/devicetree/bindings/dma/jz4780-dma.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

 v2: New patch in this series; regroups the changes made to the
 jz4780-dma.txt doc file in the previous version of the patchset.

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index f25feee62b15..5d302b488e88 100644
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
@@ -2,8 +2,13 @@
 
 Required properties:
 
-- compatible: Should be "ingenic,jz4780-dma"
-- reg: Should contain the DMA controller registers location and length.
+- compatible: Should be one of:
+  * ingenic,jz4780-dma
+  * ingenic,jz4770-dma
+  * ingenic,jz4725b-dma
+  * ingenic,jz4740-dma
+- reg: Should contain the DMA channel registers location and length, followed
+  by the DMA controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the DMA controller.
 - interrupt-parent: Should be the phandle of the interrupt controller that
 - clocks: Should contain a clock specifier for the JZ4780 PDMA clock.
@@ -22,7 +27,8 @@ Example:
 
 dma: dma@13420000 {
 	compatible = "ingenic,jz4780-dma";
-	reg = <0x13420000 0x10000>;
+	reg = <0x13420000 0x400
+	       0x13421000 0x40>;
 
 	interrupt-parent = <&intc>;
 	interrupts = <10>;
-- 
2.11.0
