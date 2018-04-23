Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 19:07:17 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994668AbeDWRFamzzKe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 19:05:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NAs2y534DKewT+11nT4zOSJYQfr+O+EG5z0A94KFJYg=; b=TEMpY5xS5CPPKutbrTL7lKZ9z
        hzlHkcF5Xri1rY6ODJl2TtbyBf3H9GotxFTJF121GVTNnsiywcfs+PohgNdMN8aYsG8HvDYBarxUg
        q+ApMhoBojBtJ0aADWCfikt4hgYlcTGFN8odxhU6QJzSRK2ED83yhhI25iY+uy7q+P/ohnQuqcFon
        +vDOnm/Bmi+PrRq9gAJl3iIR0eLKkxlPcixx7Ufw1/fu5ZpyOV97/UFO0ZJxPqMOkFbOEb1W0Z+iu
        A2AWHT6iTf13Uboh3uk3AEaE1NMt6cYdAs+fe5Yxf4ZbB6XSvmdYcq+0ptfAVJXJBHfsHwKDqtnAf
        vksEcUYmA==;
Received: from 089144198044.atnat0007.highway.a1.net ([89.144.198.44] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fAetb-0000GF-Ha; Mon, 23 Apr 2018 17:04:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/12] arm: don't build swiotlb by default
Date:   Mon, 23 Apr 2018 19:04:17 +0200
Message-Id: <20180423170419.20330-11-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423170419.20330-1-hch@lst.de>
References: <20180423170419.20330-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+de39c3f36ce265885e0e+5356+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63711
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

swiotlb is only used as a library of helper for xen-swiotlb if Xen support
is enabled on arm, so don't build it by default.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aa1c187d756d..90b81a3a28a7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1774,7 +1774,7 @@ config SECCOMP
 	  defined by each seccomp mode.
 
 config SWIOTLB
-	def_bool y
+	bool
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
@@ -1807,6 +1807,7 @@ config XEN
 	depends on MMU
 	select ARCH_DMA_ADDR_T_64BIT
 	select ARM_PSCI
+	select SWIOTLB
 	select SWIOTLB_XEN
 	select PARAVIRT
 	help
-- 
2.17.0
