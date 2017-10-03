Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 12:43:33 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:36407 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990487AbdJCKn0eqGH1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 12:43:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=emCznX6yJxogOle6cZDRDeMvOmYzsGRIypisoq7sRKQ=; b=paHuWpF4L7adu/smj/Ou4Ou6R
        C8kwgZu7zr4OoPgxF5X8HChDIrvNdi1IjPmO6CP8DTHX2uSe5pvTVh2+6GrjHL/thtwRBOjhaM+LT
        u87EzvVyQShZ2tHO2jK5TPtPYD38ocdT9s8YwuGbyu5ILZdtOMNIl9+re5736CUoQ+03wtXDeDZqf
        giHNnmEc4TmPfKZAYOMqMvw9ycWnuB6FjrGOnuFQD0debxGoDfTdZxmwcVmKjHH2B59ZMRifBXNnB
        r1fVVZqzd7XUA80D9oaf5qhRqpwT2Phk73kVgUAa/rzE+qrrZ4n+lxlwSeB/h9tf4diqOXhZm3019
        oYz/SVhfQ==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dzKfV-0000NP-H4; Tue, 03 Oct 2017 10:43:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        David Howells <dhowells@redhat.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] floppy: consolidate the dummy fd_cacheflush definition
Date:   Tue,  3 Oct 2017 12:43:01 +0200
Message-Id: <20171003104311.10058-2-hch@lst.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20171003104311.10058-1-hch@lst.de>
References: <20171003104311.10058-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60221
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

Only mips defines this helper, so remove all the other arch definitions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/floppy.h    | 2 --
 arch/powerpc/include/asm/floppy.h  | 2 --
 arch/sparc/include/asm/floppy_32.h | 1 -
 arch/sparc/include/asm/floppy_64.h | 1 -
 drivers/block/floppy.c             | 4 ++++
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/include/asm/floppy.h b/arch/alpha/include/asm/floppy.h
index bae97eb19d26..942924756cf2 100644
--- a/arch/alpha/include/asm/floppy.h
+++ b/arch/alpha/include/asm/floppy.h
@@ -24,7 +24,6 @@
 #define fd_set_dma_count(count) set_dma_count(FLOPPY_DMA,count)
 #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
-#define fd_cacheflush(addr,size) /* nothing */
 #define fd_request_irq()        request_irq(FLOPPY_IRQ, floppy_interrupt,\
 					    0, "floppy", NULL)
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL)
@@ -62,7 +61,6 @@ alpha_fd_dma_setup(char *addr, unsigned long size, int mode, int io)
 	prev_dir = dir;
 
 	fd_clear_dma_ff();
-	fd_cacheflush(addr, size);
 	fd_set_dma_mode(mode);
 	set_dma_addr(FLOPPY_DMA, bus_addr);
 	fd_set_dma_count(size);
diff --git a/arch/powerpc/include/asm/floppy.h b/arch/powerpc/include/asm/floppy.h
index 936a904ae78c..167c44b58848 100644
--- a/arch/powerpc/include/asm/floppy.h
+++ b/arch/powerpc/include/asm/floppy.h
@@ -25,7 +25,6 @@
 #define fd_get_dma_residue()    fd_ops->_get_dma_residue(FLOPPY_DMA)
 #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
-#define fd_cacheflush(addr,size) /* nothing */
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL);
 
 #include <linux/pci.h>
@@ -152,7 +151,6 @@ static int hard_dma_setup(char *addr, unsigned long size, int mode, int io)
 	prev_dir = dir;
 
 	fd_clear_dma_ff();
-	fd_cacheflush(addr, size);
 	fd_set_dma_mode(mode);
 	set_dma_addr(FLOPPY_DMA, bus_addr);
 	fd_set_dma_count(size);
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index 071b83e52f15..dab58525229e 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -70,7 +70,6 @@ static struct sun_floppy_ops sun_fdops;
 #define fd_set_dma_count(count)   sun_fd_set_dma_count(count)
 #define fd_enable_irq()           /* nothing... */
 #define fd_disable_irq()          /* nothing... */
-#define fd_cacheflush(addr, size) /* nothing... */
 #define fd_request_irq()          sun_fd_request_irq()
 #define fd_free_irq()             /* nothing... */
 #if 0  /* P3: added by Alain, these cause a MMU corruption. 19960524 XXX */
diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index 625756406a7e..a1db35a22c99 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -72,7 +72,6 @@ static struct sun_floppy_ops sun_fdops;
 #define fd_set_dma_addr(addr)     sun_fdops.fd_set_dma_addr(addr)
 #define fd_set_dma_count(count)   sun_fdops.fd_set_dma_count(count)
 #define get_dma_residue(x)        sun_fdops.get_dma_residue()
-#define fd_cacheflush(addr, size) /* nothing... */
 #define fd_request_irq()          sun_fdops.fd_request_irq()
 #define fd_free_irq()             sun_fdops.fd_free_irq()
 #define fd_eject(drive)           sun_fdops.fd_eject(drive)
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 60c086a53609..a54183935aa1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -275,6 +275,10 @@ static int set_next_request(void);
 #define fd_dma_mem_alloc(size) __get_dma_pages(GFP_KERNEL, get_order(size))
 #endif
 
+#ifndef fd_cacheflush
+#define fd_cacheflush(addr, size) /* nothing... */
+#endif
+
 static inline void fallback_on_nodma_alloc(char **addr, size_t l)
 {
 #ifdef FLOPPY_CAN_FALLBACK_ON_NODMA
-- 
2.14.1
