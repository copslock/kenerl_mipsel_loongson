Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 02:59:19 +0100 (BST)
Received: from sccrmhc15.comcast.net ([63.240.77.85]:44183 "EHLO
	sccrmhc15.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022573AbXGWB7R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jul 2007 02:59:17 +0100
Received: from [192.168.1.4] (c-69-140-18-238.hsd1.md.comcast.net[69.140.18.238])
          by comcast.net (sccrmhc15) with ESMTP
          id <20070723015833015002279le>; Mon, 23 Jul 2007 01:58:33 +0000
Message-ID: <46A40B44.6020406@gentoo.org>
Date:	Sun, 22 Jul 2007 21:58:28 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.5 (Windows/20070716)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: Allow plat_map_dma_mem_page to take a 'size' argument
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


This patch enables the plat_map_dma_mem_page function to take a 'size' argument 
for use by machines if needed (IP30 support will need this available).

Signed-off-by: Joshua Kinard <kumba@gentoo.org>

  arch/mips/mm/dma-default.c                    |    2 +-
  arch/mips/pci/pci-dac.c                       |    2 +-
  include/asm-mips/mach-generic/dma-coherence.h |    2 +-
  include/asm-mips/mach-ip27/dma-coherence.h    |    3 ++-
  include/asm-mips/mach-ip32/dma-coherence.h    |    3 ++-
  include/asm-mips/mach-jazz/dma-coherence.h    |    3 ++-
  6 files changed, 9 insertions(+), 6 deletions(-)


diff -Naurp linux-2.6.22.1-20070712.old/arch/mips/mm/dma-default.c 
linux-2.6.22.1-20070712.size/arch/mips/mm/dma-default.c
--- linux-2.6.22.1-20070712.old/arch/mips/mm/dma-default.c	2007-07-08 
19:32:17.000000000 -0400
+++ linux-2.6.22.1-20070712.size/arch/mips/mm/dma-default.c	2007-07-22 
12:54:08.000000000 -0400
@@ -190,7 +190,7 @@ dma_addr_t dma_map_page(struct device *d
  		dma_cache_wback_inv(addr, size);
  	}

-	return plat_map_dma_mem_page(dev, page) + offset;
+	return plat_map_dma_mem_page(dev, page, size) + offset;
  }

  EXPORT_SYMBOL(dma_map_page);
diff -Naurp linux-2.6.22.1-20070712.old/arch/mips/pci/pci-dac.c 
linux-2.6.22.1-20070712.size/arch/mips/pci/pci-dac.c
--- linux-2.6.22.1-20070712.old/arch/mips/pci/pci-dac.c	2007-07-08 
19:32:17.000000000 -0400
+++ linux-2.6.22.1-20070712.size/arch/mips/pci/pci-dac.c	2007-07-22 
12:54:31.000000000 -0400
@@ -35,7 +35,7 @@ dma64_addr_t pci_dac_page_to_dma(struct
  		dma_cache_wback_inv(addr, PAGE_SIZE);
  	}

-	return plat_map_dma_mem_page(dev, page) + offset;
+	return plat_map_dma_mem_page(dev, page, PAGE_SIZE) + offset;
  }

  EXPORT_SYMBOL(pci_dac_page_to_dma);
diff -Naurp 
linux-2.6.22.1-20070712.old/include/asm-mips/mach-generic/dma-coherence.h 
linux-2.6.22.1-20070712.size/include/asm-mips/mach-generic/dma-coherence.h
--- linux-2.6.22.1-20070712.old/include/asm-mips/mach-generic/dma-coherence.h 
2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22.1-20070712.size/include/asm-mips/mach-generic/dma-coherence.h 
2007-07-22 12:55:29.000000000 -0400
@@ -18,7 +18,7 @@ static inline dma_addr_t plat_map_dma_me
  }

  static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
+	struct page *page, size_t size)
  {
  	return page_to_phys(page);
  }
diff -Naurp 
linux-2.6.22.1-20070712.old/include/asm-mips/mach-ip27/dma-coherence.h 
linux-2.6.22.1-20070712.size/include/asm-mips/mach-ip27/dma-coherence.h
--- linux-2.6.22.1-20070712.old/include/asm-mips/mach-ip27/dma-coherence.h 
2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22.1-20070712.size/include/asm-mips/mach-ip27/dma-coherence.h 
2007-07-22 12:55:52.000000000 -0400
@@ -26,7 +26,8 @@ static inline dma_addr_t plat_map_dma_me
  	return pa;
  }

-static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
+static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page,
+					size_t size)
  {
  	dma_addr_t pa = dev_to_baddr(dev, page_to_phys(page));

diff -Naurp 
linux-2.6.22.1-20070712.old/include/asm-mips/mach-ip32/dma-coherence.h 
linux-2.6.22.1-20070712.size/include/asm-mips/mach-ip32/dma-coherence.h
--- linux-2.6.22.1-20070712.old/include/asm-mips/mach-ip32/dma-coherence.h 
2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22.1-20070712.size/include/asm-mips/mach-ip32/dma-coherence.h 
2007-07-22 12:56:09.000000000 -0400
@@ -37,7 +37,8 @@ static inline dma_addr_t plat_map_dma_me
  	return pa;
  }

-static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
+static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page,
+					size_t size)
  {
  	dma_addr_t pa;

diff -Naurp 
linux-2.6.22.1-20070712.old/include/asm-mips/mach-jazz/dma-coherence.h 
linux-2.6.22.1-20070712.size/include/asm-mips/mach-jazz/dma-coherence.h
--- linux-2.6.22.1-20070712.old/include/asm-mips/mach-jazz/dma-coherence.h 
2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22.1-20070712.size/include/asm-mips/mach-jazz/dma-coherence.h 
2007-07-22 12:56:30.000000000 -0400
@@ -17,7 +17,8 @@ static dma_addr_t plat_map_dma_mem(struc
  	return vdma_alloc(virt_to_phys(addr), size);
  }

-static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
+static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page,
+					size_t size)
  {
  	return vdma_alloc(page_to_phys(page), PAGE_SIZE);
  }
