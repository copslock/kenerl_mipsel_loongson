Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:13:43 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:45847 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994829AbdFPSLafrL4W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:11:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pwg3znQ/jRIAoC9Aa7lucF7QlnShJfVfmNX9YXBG9Q4=; b=T6ZjAtNBWx4OvBhZID2GJBmXN
        Q74M0QAsKOcHoTLj2UxX6vVbzqggCCElXYnR7QfO8/TA7bOhEXTorzqN22cO/gA268HlBmFPwRZMO
        un1B4XXZ7oExsoxttxEk6arti49666RF7XtLIkd1zwoUUH9alZGVkFo4X3D6qapnwapIeLjckMXo9
        X9pRFqdII7oKqkn7QLN/OqVR8XW7uDEDjt81B80FAGzpBradpkcsc5z5y9WLTIRljvPoyD8yAd+fn
        +90J+IWiPEznTUmR3/owY0jnnLkATTIPUnxhOIZmOWfQA/K2Qgf1FqKlX+wRsVnl+AMOWXlTsd+e0
        5i14mP/Zg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLviP-0004QN-DJ; Fri, 16 Jun 2017 18:11:26 +0000
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
Subject: [PATCH 05/44] drm/armada: don't abuse DMA_ERROR_CODE
Date:   Fri, 16 Jun 2017 20:10:20 +0200
Message-Id: <20170616181059.19206-6-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58536
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

dev_addr isn't even a dma_addr_t, and DMA_ERROR_CODE has never been
a valid driver API.  Add a bool mapped flag instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/armada/armada_fb.c  | 2 +-
 drivers/gpu/drm/armada/armada_gem.c | 5 ++---
 drivers/gpu/drm/armada/armada_gem.h | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/armada_fb.c
index 2a7eb6817c36..92e6b08ea64a 100644
--- a/drivers/gpu/drm/armada/armada_fb.c
+++ b/drivers/gpu/drm/armada/armada_fb.c
@@ -133,7 +133,7 @@ static struct drm_framebuffer *armada_fb_create(struct drm_device *dev,
 	}
 
 	/* Framebuffer objects must have a valid device address for scanout */
-	if (obj->dev_addr == DMA_ERROR_CODE) {
+	if (!obj->mapped) {
 		ret = -EINVAL;
 		goto err_unref;
 	}
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index d6c2a5d190eb..a76ca21d063b 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -175,6 +175,7 @@ armada_gem_linear_back(struct drm_device *dev, struct armada_gem_object *obj)
 
 		obj->phys_addr = obj->linear->start;
 		obj->dev_addr = obj->linear->start;
+		obj->mapped = true;
 	}
 
 	DRM_DEBUG_DRIVER("obj %p phys %#llx dev %#llx\n", obj,
@@ -205,7 +206,6 @@ armada_gem_alloc_private_object(struct drm_device *dev, size_t size)
 		return NULL;
 
 	drm_gem_private_object_init(dev, &obj->obj, size);
-	obj->dev_addr = DMA_ERROR_CODE;
 
 	DRM_DEBUG_DRIVER("alloc private obj %p size %zu\n", obj, size);
 
@@ -229,8 +229,6 @@ static struct armada_gem_object *armada_gem_alloc_object(struct drm_device *dev,
 		return NULL;
 	}
 
-	obj->dev_addr = DMA_ERROR_CODE;
-
 	mapping = obj->obj.filp->f_mapping;
 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER | __GFP_RECLAIMABLE);
 
@@ -610,5 +608,6 @@ int armada_gem_map_import(struct armada_gem_object *dobj)
 		return -EINVAL;
 	}
 	dobj->dev_addr = sg_dma_address(dobj->sgt->sgl);
+	dobj->mapped = true;
 	return 0;
 }
diff --git a/drivers/gpu/drm/armada/armada_gem.h b/drivers/gpu/drm/armada/armada_gem.h
index b88d2b9853c7..6e524e0676bb 100644
--- a/drivers/gpu/drm/armada/armada_gem.h
+++ b/drivers/gpu/drm/armada/armada_gem.h
@@ -16,6 +16,7 @@ struct armada_gem_object {
 	void			*addr;
 	phys_addr_t		phys_addr;
 	resource_size_t		dev_addr;
+	bool			mapped;
 	struct drm_mm_node	*linear;	/* for linear backed */
 	struct page		*page;		/* for page backed */
 	struct sg_table		*sgt;		/* for imported */
-- 
2.11.0
