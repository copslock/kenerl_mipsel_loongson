Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:43:11 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:58957 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994668AbdL2IX0AkhVP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:23:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6nE8RcLASbnBNDxopxGxGjrTcIXPIyO5wAhu2ciAri0=; b=OmHkTmyKnYK0lopdgOaCOnvBs
        GlBLaKLrGBb6R4AUdlBqaIk2mfdPc0Zww//xlMF0RhOgfISlHBO4/MufZNo/i5/l9Nfnh3f0axn80
        HExbnb0aDS3aE4boL9o8fMPLa+2XW5rJfd5apn4eJ23BIRbQUaGubTx1Tiq/Oq+ZqBKWFLavky1Ca
        6uZ7ntYNd3QpGxye9cornJag1ni5AFnP+7wqpGvxW3OZUOOlK8YJhPv96aQHX0i46TPWDfkNMKHK9
        UmcDzRCa8fOFv0NtExVlM5ghUI17mhu4Sh6HCBRFqVt45YZOmpMe3ozCu/mXadKLKVET97JIMrJ6X
        x0A4Vrk+g==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpwa-0003SJ-Sm; Fri, 29 Dec 2017 08:23:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 53/67] swiotlb: remove swiotlb_set_mem_attributes
Date:   Fri, 29 Dec 2017 09:18:57 +0100
Message-Id: <20171229081911.2802-54-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61750
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

Now that set_memory_decrypted is always available we can just call
it directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/mem_encrypt.h |  2 --
 arch/x86/mm/mem_encrypt.c          |  9 ---------
 lib/swiotlb.c                      | 12 ++++++------
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c9459a4c3c68..549894d496da 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,8 +48,6 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
 
-void swiotlb_set_mem_attributes(void *vaddr, unsigned long size);
-
 bool sme_active(void);
 bool sev_active(void);
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 93de36cc3dd9..b279e90c85cd 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -379,15 +379,6 @@ void __init mem_encrypt_init(void)
 			     : "Secure Memory Encryption (SME)");
 }
 
-void swiotlb_set_mem_attributes(void *vaddr, unsigned long size)
-{
-	WARN(PAGE_ALIGN(size) != size,
-	     "size is not page-aligned (%#lx)\n", size);
-
-	/* Make the SWIOTLB buffer area decrypted */
-	set_memory_decrypted((unsigned long)vaddr, size >> PAGE_SHIFT);
-}
-
 static void __init sme_clear_pgd(pgd_t *pgd_base, unsigned long start,
 				 unsigned long end)
 {
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 85b2ad9299e3..4ea0b5710618 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -31,6 +31,7 @@
 #include <linux/gfp.h>
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
+#include <linux/set_memory.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -156,8 +157,6 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
-void __weak swiotlb_set_mem_attributes(void *vaddr, unsigned long size) { }
-
 /* Note that this doesn't work with highmem page */
 static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
 				      volatile void *address)
@@ -202,12 +201,12 @@ void __init swiotlb_update_mem_attributes(void)
 
 	vaddr = phys_to_virt(io_tlb_start);
 	bytes = PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT);
-	swiotlb_set_mem_attributes(vaddr, bytes);
+	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
 	memset(vaddr, 0, bytes);
 
 	vaddr = phys_to_virt(io_tlb_overflow_buffer);
 	bytes = PAGE_ALIGN(io_tlb_overflow);
-	swiotlb_set_mem_attributes(vaddr, bytes);
+	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
 	memset(vaddr, 0, bytes);
 }
 
@@ -348,7 +347,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	io_tlb_start = virt_to_phys(tlb);
 	io_tlb_end = io_tlb_start + bytes;
 
-	swiotlb_set_mem_attributes(tlb, bytes);
+	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	memset(tlb, 0, bytes);
 
 	/*
@@ -359,7 +358,8 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	if (!v_overflow_buffer)
 		goto cleanup2;
 
-	swiotlb_set_mem_attributes(v_overflow_buffer, io_tlb_overflow);
+	set_memory_decrypted((unsigned long)v_overflow_buffer,
+			io_tlb_overflow >> PAGE_SHIFT);
 	memset(v_overflow_buffer, 0, io_tlb_overflow);
 	io_tlb_overflow_buffer = virt_to_phys(v_overflow_buffer);
 
-- 
2.14.2
