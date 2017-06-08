Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:26:51 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:35793 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993911AbdFHN0XyvLST (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:26:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Upg6qmgAgoz90pdHIwlHGP0FFSKJz4qtmW6FFF27xeQ=; b=VMKLXK2URuK+YrF/PisUPTtvu
        i6+9BxsIC/tFnwFoJGATxdCXHQRFABE6SUwrnLb/IW+9emVzGW6CvkE2yW0kvaQOeIrc+aA16mlSi
        H7Jj5NKQ4cMYL9am9yJM7FzQzfgydMBYZumMxfzseK2TjTKjAmWRBqyaHKCzf/sVTSYNfLOo3Ji1n
        OarbEWlTi12HQZsmHx8E72+fZbuwlRSu8SuaNT+5cNjrTLn2xJpIusApxxeHTYoHp4GBcYyfNWd5H
        A/p62olbfZF69rIk1AlZIKDkQMxHL83jCSM/oiZqgji7RUnQ8Xdo+tNIH28tCkfOTgkPZYYWZJ6Yy
        vz0gmHrSQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxS6-0004mq-Vm; Thu, 08 Jun 2017 13:26:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/44] firmware/ivc: use dma_mapping_error
Date:   Thu,  8 Jun 2017 15:25:26 +0200
Message-Id: <20170608132609.32662-2-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

DMA_ERROR_CODE is not supposed to be used by drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/firmware/tegra/ivc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/tegra/ivc.c b/drivers/firmware/tegra/ivc.c
index 29ecfd815320..a01461d63f68 100644
--- a/drivers/firmware/tegra/ivc.c
+++ b/drivers/firmware/tegra/ivc.c
@@ -646,12 +646,12 @@ int tegra_ivc_init(struct tegra_ivc *ivc, struct device *peer, void *rx,
 	if (peer) {
 		ivc->rx.phys = dma_map_single(peer, rx, queue_size,
 					      DMA_BIDIRECTIONAL);
-		if (ivc->rx.phys == DMA_ERROR_CODE)
+		if (dma_mapping_error(peer, ivc->rx.phys))
 			return -ENOMEM;
 
 		ivc->tx.phys = dma_map_single(peer, tx, queue_size,
 					      DMA_BIDIRECTIONAL);
-		if (ivc->tx.phys == DMA_ERROR_CODE) {
+		if (dma_mapping_error(peer, ivc->tx.phys)) {
 			dma_unmap_single(peer, ivc->rx.phys, queue_size,
 					 DMA_BIDIRECTIONAL);
 			return -ENOMEM;
-- 
2.11.0
