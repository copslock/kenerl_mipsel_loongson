Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2017 12:50:49 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:51984 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990482AbdLELujNt8U8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Dec 2017 12:50:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2jGlZFFaywE0POwpnV6LeYEh3/OOvDh06TxUBekN6NE=; b=qier0GfKvAwPR2gtwqPnRMueYy
        0lRIeJT9w2qn/1H4h9e0TYtJEZiFijFjA4KMxcOZaobK6vxcgiKRutNIHuzsvTumR8XBOwZnCPdPy
        d3UaOF2+t98FvJBNCD3pqmFtyZax7EmKHB0C0EVMWE35nq8zGU/t5AGdnw/o3MzKEhhw=;
Received: by maeck.lan (Postfix, from userid 501)
        id E1A7D8324BF; Tue,  5 Dec 2017 12:50:34 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-mips@linux-mips.org
Subject: [PATCH 1/2] MIPS: mm: remove mips_dma_mapping_error
Date:   Tue,  5 Dec 2017 12:50:33 +0100
Message-Id: <20171205115034.15078-1-nbd@nbd.name>
X-Mailer: git-send-email 2.14.2
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@nbd.name
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

dma_mapping_error() already checks if ops->mapping_error is a null
pointer

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/mips/mm/dma-default.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index e3e94d05f0fd..1af0cd90cc34 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -373,11 +373,6 @@ static void mips_dma_sync_sg_for_device(struct device *dev,
 	}
 }
 
-static int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 static int mips_dma_supported(struct device *dev, u64 mask)
 {
 	return plat_dma_supported(dev, mask);
@@ -404,7 +399,6 @@ static const struct dma_map_ops mips_default_dma_map_ops = {
 	.sync_single_for_device = mips_dma_sync_single_for_device,
 	.sync_sg_for_cpu = mips_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = mips_dma_sync_sg_for_device,
-	.mapping_error = mips_dma_mapping_error,
 	.dma_supported = mips_dma_supported,
 	.cache_sync = mips_dma_cache_sync,
 };
-- 
2.14.2
