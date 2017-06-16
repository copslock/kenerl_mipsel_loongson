Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:13:14 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:55271 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994828AbdFPSL1JcqAW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:11:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VolBZDxS9ZQrQoHzmubjiZ2v8Rk+FgSixd/DX4o9p2E=; b=THVPuyuHTKM8ALqXwsIZqKBJZ
        SK3+dGgdzbAXPQeRkU6eFYuLB2ODWl9twiGUVkGVau4AyN1LdNLSJVhfMKYIyFA3r9yBqyAknCEO6
        n9YFfIM2GQJXnm/5VpIyRJXXOoYKhpLPv1PJfdLZU7lI0b9XYaxxmIl/Sc5tqTVfINjx5r/vBPwLE
        hf2G4UP+ZPYIndT+Ad+Xw42tQl724CLBzEcyMVg4dpuEIVmDadecp7yA4G1m+zUIGe1Q6HJi0RSMe
        9kpTabDT4+AJiaJcXcIfn8/s8oMbjIo88GmY42gJLQF2mpA9Im6RwC84Naq1m8py5sIwUU0cdZKH3
        5ORGslnRQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLviM-0004MA-4P; Fri, 16 Jun 2017 18:11:22 +0000
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
Subject: [PATCH 04/44] drm/exynos: don't use DMA_ERROR_CODE
Date:   Fri, 16 Jun 2017 20:10:19 +0200
Message-Id: <20170616181059.19206-5-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58535
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

DMA_ERROR_CODE already isn't a valid API to user for drivers and will
go away soon.  exynos_drm_fb_dma_addr uses it a an error return when
the passed in index is invalid, but the callers never check for it
but instead pass the address straight to the hardware.

Add a WARN_ON instead and just return 0.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/exynos/exynos_drm_fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index c77a5aced81a..d48fd7c918f8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -181,8 +181,8 @@ dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index)
 {
 	struct exynos_drm_fb *exynos_fb = to_exynos_fb(fb);
 
-	if (index >= MAX_FB_BUFFER)
-		return DMA_ERROR_CODE;
+	if (WARN_ON_ONCE(index >= MAX_FB_BUFFER))
+		return 0;
 
 	return exynos_fb->dma_addr[index];
 }
-- 
2.11.0
