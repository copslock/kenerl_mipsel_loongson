Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:24:25 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993030AbeEYJVwG5LhA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:21:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5PsLllTje0cJbuTclZLuZ/VNuVNP+nekIzDSVarUjN4=; b=n0Xa3UDvJtfhMaOqXxX+e1eHk
        aa0JJ6fcwStr5472be6ktH87o0vKoeHLdgRn16LfrRQJk58xz3rThf/i75ZJmMd4w5NTQxT9mUd9/
        GqM/lXpZk9fdGBrcLJdd6nuVuFa4SIvbiwsSg0Gr/yAOwZDDDtOB+mBQmCINShayDHb9ButhmOKCd
        tGS14fhRkPohPldhHe/xNs8oE6SJgKIV2UBgGhLlg1HnJPaYqq5bSGx9oIxc6LmLpd4hLpuUZnxrM
        olEOG/EAOi1npDgvPWhidxQEdpvydWyLfgqOSY/31zbN5iiXt90PYH0Xyfqm892skl12jWdVNtzBW
        exPD4G/8A==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8v0-0001nh-7z; Fri, 25 May 2018 09:21:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 11/25] MIPS: Octeon: move swiotlb declarations out of dma-coherence.h
Date:   Fri, 25 May 2018 11:20:57 +0200
Message-Id: <20180525092111.18516-12-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64024
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

No need to pull them into a global header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../asm/mach-cavium-octeon/dma-coherence.h     | 18 ------------------
 arch/mips/include/asm/octeon/pci-octeon.h      |  3 +++
 arch/mips/pci/pci-octeon.c                     |  2 --
 arch/mips/pci/pcie-octeon.c                    |  2 --
 4 files changed, 3 insertions(+), 22 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h

diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
deleted file mode 100644
index 66eee98b8b8d..000000000000
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H
-#define __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H
-
-#include <linux/bug.h>
-
-struct device;
-
-extern void octeon_pci_dma_init(void);
-extern char *octeon_swiotlb;
-
-#endif /* __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/octeon/pci-octeon.h b/arch/mips/include/asm/octeon/pci-octeon.h
index 1884609741a8..b12d9a3fbfb6 100644
--- a/arch/mips/include/asm/octeon/pci-octeon.h
+++ b/arch/mips/include/asm/octeon/pci-octeon.h
@@ -63,4 +63,7 @@ enum octeon_dma_bar_type {
  */
 extern enum octeon_dma_bar_type octeon_dma_bar_type;
 
+void octeon_pci_dma_init(void);
+extern char *octeon_swiotlb;
+
 #endif
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index a20697df3539..5017d5843c5a 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -21,8 +21,6 @@
 #include <asm/octeon/cvmx-pci-defs.h>
 #include <asm/octeon/pci-octeon.h>
 
-#include <dma-coherence.h>
-
 #define USE_OCTEON_INTERNAL_ARBITER
 
 /*
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 87ba86bd8696..9cc5905860ef 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -94,8 +94,6 @@ union cvmx_pcie_address {
 
 static int cvmx_pcie_rc_initialize(int pcie_port);
 
-#include <dma-coherence.h>
-
 /**
  * Return the Core virtual base address for PCIe IO access. IOs are
  * read/written as an offset from this address.
-- 
2.17.0
