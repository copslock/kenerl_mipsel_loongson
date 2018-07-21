Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 13:10:41 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:32938 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993997AbeGULIAznhSi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jul 2018 13:08:00 +0200
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
Subject: [PATCH v3 16/18] MIPS: JZ4780: DTS: Update DMA node to match driver changes
Date:   Sat, 21 Jul 2018 13:06:41 +0200
Message-Id: <20180721110643.19624-17-paul@crapouillou.net>
In-Reply-To: <20180721110643.19624-1-paul@crapouillou.net>
References: <20180721110643.19624-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532171279; bh=yeEV2YWzRSO+mEU/uLZ2nuRBfFyk54/gpaDm/wo7wTk=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pxiew6rA0sUUSuSQ/zMbMSfxAYyGJQuTh5wApEkKwEbOowTosV4i3gcUqxYdEseYMRXohN+zNvg5xBZIdXdEzcT/NtoC5wyJpFspcKQ7IKgWI9A48J3BEScd723ugHImddeWA8QPWdI6GwSGpKA9ygcSGVDhc+BUY2ZbxUiB/0g=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65017
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
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

 v2: Update info about devicetree ABI compatibility in commit message

 v3: No change

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index aa4e8f75ff5d..ad3b1f827cf5 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -247,7 +247,8 @@
 
 	dma: dma@13420000 {
 		compatible = "ingenic,jz4780-dma";
-		reg = <0x13420000 0x10000>;
+		reg = <0x13420000 0x400
+		       0x13421000 0x40>;
 		#dma-cells = <2>;
 
 		interrupt-parent = <&intc>;
-- 
2.11.0
