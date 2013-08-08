Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 11:14:36 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50035 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822292Ab3HHJOdVMTal (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 11:14:33 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/4] MIPS: lantiq: adds 4dword burst length for dma
Date:   Thu,  8 Aug 2013 11:07:23 +0200
Message-Id: <1375952846-25812-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Comparing the upstream code with the Lantiq UGW kernel we see that burst length
should be set to 4 bytes.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/dma.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 08f7ebd..ccf1451 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -48,6 +48,7 @@
 #define DMA_IRQ_ACK		0x7e		/* IRQ status register */
 #define DMA_POLL		BIT(31)		/* turn on channel polling */
 #define DMA_CLK_DIV4		BIT(6)		/* polling clock divider */
+#define DMA_4W_BURST		BIT(2)		/* 4 word burst length */
 #define DMA_2W_BURST		BIT(1)		/* 2 word burst length */
 #define DMA_MAX_CHANNEL		20		/* the soc has 20 channels */
 #define DMA_ETOP_ENDIANNESS	(0xf << 8) /* endianness swap etop channels */
@@ -196,7 +197,8 @@ ltq_dma_init_port(int p)
 		 * Tell the DMA engine to swap the endianness of data frames and
 		 * drop packets if the channel arbitration fails.
 		 */
-		ltq_dma_w32_mask(0, DMA_ETOP_ENDIANNESS | DMA_PDEN,
+		ltq_dma_w32_mask(0, (DMA_4W_BURST << 4) | (DMA_4W_BURST << 2) |
+			DMA_ETOP_ENDIANNESS | DMA_PDEN,
 			LTQ_DMA_PCTRL);
 		break;
 
-- 
1.7.10.4
