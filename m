Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 13:43:46 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:37842 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994689AbeHGLmdVI42B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2018 13:42:33 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v4 06/18] dmaengine: dma-jz4780: Don't depend on MACH_JZ4780
Date:   Tue,  7 Aug 2018 13:42:06 +0200
Message-Id: <20180807114218.20091-7-paul@crapouillou.net>
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
References: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642152; bh=04ny1OxuMbHmhpz/vkFc1aKgw4v319jUCoDc8CXK68U=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bIwSzl6uUStiraCtTSfepWMLa2XCXDF45CET2k/Tk34wlTKxUg2Pwo6xXXjwmc1Q22fKCL9eZH5AMr871iH3wt80kMgo4SY6z2g+Qm2EDo0/YiZcA8d2pL66+g3NKwjif+I73mT81JgatX/yoXQwX3h8Y9yHs/k8xW2gO2HfXnE=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65453
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

If we make this driver depend on MACH_JZ4780, that means it can be
enabled only if we're building a kernel specially crafted for a
JZ4780-based board, while most GNU/Linux distributions will want one
generic MIPS kernel that works on multiple boards.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v3: New patch

v4: No change

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ca1680afa20a..0680e1eb0d73 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -143,7 +143,7 @@ config DMA_JZ4740
 
 config DMA_JZ4780
 	tristate "JZ4780 DMA support"
-	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.11.0
