Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 14:41:49 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:53279 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992036AbdFTMllbTh6n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 14:41:41 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D580168D47; Tue, 20 Jun 2017 14:41:40 +0200 (CEST)
Date:   Tue, 20 Jun 2017 14:41:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
Subject: new dma-mapping tree, was Re: clean up and modularize arch
        dma_mapping interface V2
Message-ID: <20170620124140.GA27163@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58683
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

On Fri, Jun 16, 2017 at 08:10:15PM +0200, Christoph Hellwig wrote:
> I plan to create a new dma-mapping tree to collect all this work.
> Any volunteers for co-maintainers, especially from the iommu gang?

Ok, I've created the new tree:

   git://git.infradead.org/users/hch/dma-mapping.git for-next

Gitweb:

   http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/for-next

And below is the patch to add the MAINTAINERS entry, additions welcome.

Stephen, can you add this to linux-next?

---
From 335979c41912e6c101a20b719862b2d837370df1 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 20 Jun 2017 11:17:30 +0200
Subject: MAINTAINERS: add entry for dma mapping helpers
Content-Length: 1124
Lines: 38

This code has been spread between getting in through arch trees, the iommu
tree, -mm and the drivers tree.  There will be a lot of work in this area,
including consolidating various arch implementations into more common
code, so ensure we have a proper git tree that facilitates cooperation with
the architecture maintainers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b5ab6a8a5c..56859d53a424 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2595,6 +2595,19 @@ S:	Maintained
 F:	net/bluetooth/
 F:	include/net/bluetooth/
 
+DMA MAPPING HELPERS
+M:	Christoph Hellwig <hch@lst.de>
+L:	linux-kernel@vger.kernel.org
+T:	git git://git.infradead.org/users/hch/dma-mapping.git
+W:	http://git.infradead.org/users/hch/dma-mapping.git
+S:	Supported
+F:	lib/dma-debug.c
+F:	lib/dma-noop.c
+F:	lib/dma-virt.c
+F:	drivers/base/dma-mapping.c
+F:	drivers/base/dma-coherent.c
+F:	include/linux/dma-mapping.h
+
 BONDING DRIVER
 M:	Jay Vosburgh <j.vosburgh@gmail.com>
 M:	Veaceslav Falico <vfalico@gmail.com>
-- 
2.11.0
