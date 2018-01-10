Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:08:19 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:50495 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992079AbeAJIBfRSj6S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:01:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Afn0YIn1zKrL1IQlc79HRm4W+e1XRPY6Gc2rdlD9BfI=; b=ufs0dJF+MxFBZK7QJoCzF9Jmj
        v8Lw3t4ixT3u5NFcb9Zfy7XCdmdowN1dMQZWAOyeNcGbZk0g6GRAAXY+99XC9sRGZyYiO2IY82XLw
        Tnn3gc/qUlp4Q8J1KtvMXO4ih7u52LTOyybycAU/eAT36odBxmcAlIh61qOFq0Qx7ElVXoL9pwtX3
        cSbzqcQS9DdxhxT8HtAetE8ZqMuwYlayjFd3N1sYvyasTpe3u1yDpeVojMUWnVWoMdzrBn2s8mMLI
        eWquNPEprMhbFBhMPrGQgu6DRhTzBEAaSW32IcmTPVkqqt5TLo5ris/KSGZkI1FjdBf3KDw3U0grh
        lCgiKRrmQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBK9-0004wI-3m; Wed, 10 Jan 2018 08:01:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/33] s390: move s390_pci_dma_ops to asm/pci_dma.h
Date:   Wed, 10 Jan 2018 09:00:12 +0100
Message-Id: <20180110080027.13879-19-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61983
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

This is not needed in drivers, so move it to a private header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/include/asm/dma-mapping.h | 2 --
 arch/s390/include/asm/pci_dma.h     | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 2ec7240c1ada..bdc2455483f6 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -9,8 +9,6 @@
 #include <linux/dma-debug.h>
 #include <linux/io.h>
 
-extern const struct dma_map_ops s390_pci_dma_ops;
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &dma_noop_ops;
diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
index e8d9161fa17a..419fac7a62c0 100644
--- a/arch/s390/include/asm/pci_dma.h
+++ b/arch/s390/include/asm/pci_dma.h
@@ -201,4 +201,7 @@ void dma_cleanup_tables(unsigned long *);
 unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr);
 void dma_update_cpu_trans(unsigned long *entry, void *page_addr, int flags);
 
+extern const struct dma_map_ops s390_pci_dma_ops;
+
+
 #endif
-- 
2.14.2
