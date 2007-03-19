Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 16:37:01 +0000 (GMT)
Received: from ag-out-0708.google.com ([72.14.246.241]:51015 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20021878AbXCSQg4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 16:36:56 +0000
Received: by ag-out-0708.google.com with SMTP id 26so8773071agb
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 09:36:49 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=aVZQRIGnqE0zMA7P27EOt492v6/Y2eEQS8LDgRYY05E+IxFw9vJ2nIUV0U+fcz6dt/a3lLJRd0zOxZRf5anV3XafH2CzmrQ+la7ir3sZw/TvKi7plgLv0PtyyDJOS0WduKCx/Fv8U3SSZ6GRsHEv1IL7a6TWXj+HRNiZQTv6jLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=NTe/TENgAAtcswaOgywlrqfmgtQFrjYVKMpznREI6sSKsJy2I2piMIMU7lAtx+nhjY7egLIkOEg4wlSxm9f7Fr710HKVBPESO3OAykS1/ZqwBpSCV4V/QJsXvdoL0OHOY/7w/Nxt8Dy7UbxNFZjc69dqkWO5NoMKE10ACr/1iu0=
Received: by 10.90.87.5 with SMTP id k5mr4279550agb.1174322209074;
        Mon, 19 Mar 2007 09:36:49 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id z73sm14499022nfb.2007.03.19.09.36.47;
        Mon, 19 Mar 2007 09:36:48 -0700 (PDT)
Message-ID: <45FEBC1A.8070604@innova-card.com>
Date:	Mon, 19 Mar 2007 17:36:42 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
CC:	mbizon@freebox.fr, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Always use virt_to_phys() when translating kernel addresses
 [take #2]
References: <45FE5ADA.3030309@innova-card.com>	 <1174320169.32046.113.camel@sakura.staff.proxad.net> <cda58cb80703190916g7851000dn7defeaa09eb038f@mail.gmail.com>
In-Reply-To: <cda58cb80703190916g7851000dn7defeaa09eb038f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch fixes two places where we used plain 'x - PAGE_OFFSET' to
achieve virtual to physical address convertions. This type of convertion
is no more allowed since commit 6f284a2ce7b8bc49cb8455b1763357897a899abb.

Reported-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/dma-default.c                    |   10 +++++-----
 include/asm-mips/mach-generic/dma-coherence.h |    7 +++++++
 include/asm-mips/pgtable-64.h                 |    2 +-
 include/asm-mips/pgtable.h                    |    2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index f503d02..e1a58b5 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -140,7 +140,7 @@ void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 	enum dma_data_direction direction)
 {
 	if (cpu_is_noncoherent_r10000(dev))
-		__dma_sync(plat_dma_addr_to_phys(dma_addr) + PAGE_OFFSET, size,
+		__dma_sync(plat_dma_addr_to_virt(dma_addr), size,
 		           direction);
 
 	plat_unmap_dma_mem(dma_addr);
@@ -234,7 +234,7 @@ void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 	if (cpu_is_noncoherent_r10000(dev)) {
 		unsigned long addr;
 
-		addr = PAGE_OFFSET + plat_dma_addr_to_phys(dma_handle);
+		addr = plat_dma_addr_to_virt(dma_handle);
 		__dma_sync(addr, size, direction);
 	}
 }
@@ -249,7 +249,7 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
 	if (!plat_device_is_coherent(dev)) {
 		unsigned long addr;
 
-		addr = PAGE_OFFSET + plat_dma_addr_to_phys(dma_handle);
+		addr = plat_dma_addr_to_virt(dma_handle);
 		__dma_sync(addr, size, direction);
 	}
 }
@@ -264,7 +264,7 @@ void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 	if (cpu_is_noncoherent_r10000(dev)) {
 		unsigned long addr;
 
-		addr = PAGE_OFFSET + plat_dma_addr_to_phys(dma_handle);
+		addr = plat_dma_addr_to_virt(dma_handle);
 		__dma_sync(addr + offset, size, direction);
 	}
 }
@@ -279,7 +279,7 @@ void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 	if (!plat_device_is_coherent(dev)) {
 		unsigned long addr;
 
-		addr = PAGE_OFFSET + plat_dma_addr_to_phys(dma_handle);
+		addr = plat_dma_addr_to_virt(dma_handle);
 		__dma_sync(addr + offset, size, direction);
 	}
 }
diff --git a/include/asm-mips/mach-generic/dma-coherence.h b/include/asm-mips/mach-generic/dma-coherence.h
index 76e04e7..3a2ac54 100644
--- a/include/asm-mips/mach-generic/dma-coherence.h
+++ b/include/asm-mips/mach-generic/dma-coherence.h
@@ -28,6 +28,13 @@ static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 	return dma_addr;
 }
 
+static inline unsigned long plat_dma_addr_to_virt(dma_addr_t dma_addr)
+{
+	unsigned long addr = plat_dma_addr_to_phys(dma_addr);
+
+	return (unsigned long)phys_to_virt(addr);
+}
+
 static inline void plat_unmap_dma_mem(dma_addr_t dma_addr)
 {
 }
diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
index a5b1871..49f5a1a 100644
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -199,7 +199,7 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
 {
 	return pud_val(pud);
 }
-#define pud_phys(pud)		(pud_val(pud) - PAGE_OFFSET)
+#define pud_phys(pud)		virt_to_phys((void *)pud_val(pud))
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
 
 /* Find an entry in the second-level page table.. */
diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index 3fcfd79..0d3295f 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -75,7 +75,7 @@ extern void paging_init(void);
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
-#define pmd_phys(pmd)		(pmd_val(pmd) - PAGE_OFFSET)
+#define pmd_phys(pmd)		virt_to_phys((void *)pmd_val(pmd))
 #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pmd_page_vaddr(pmd)	pmd_val(pmd)
 
-- 
1.4.4.3.ge6d4
