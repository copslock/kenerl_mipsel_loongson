Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 17:02:18 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:41710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993885AbeDOPAoyGHju (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 17:00:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NAs2y534DKewT+11nT4zOSJYQfr+O+EG5z0A94KFJYg=; b=BIoNkZYpNkGV/shEZ7o2ExoVA
        +94mf3mEWqaeILnjNNpLyo1SAK8LvvNh6yEF+WLSxwcz0Je68XRDNeb+vgwk3SjK9u7RsjF9Da8pR
        UsP3L4TXiW9OzQR8g/em/ptaaJU2WVbSwdl2VlqvsLgmNxRw4CYPY+0fkW/cZq5rsOgg3AIaZmZcW
        yhekR+B0O2M9EDtCMANBSVEsrJxx/TMqLEYaebbXAmvTDxAC747dZ/YMTI9i2yOz01+zeUw1EY6J4
        5m6cJ6SU+O7wD6EXnGMdCExQBZZiKuUEOhm2ofe8wilIVfadpIwWhuGtwJYn59/qn7Z60ESany9wc
        yve4UlgqQ==;
Received: from 089144200254.atnat0009.highway.a1.net ([89.144.200.254] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1f7j8i-00075g-7O; Sun, 15 Apr 2018 15:00:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/12] arm: don't build swiotlb by default
Date:   Sun, 15 Apr 2018 16:59:45 +0200
Message-Id: <20180415145947.1248-11-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415145947.1248-1-hch@lst.de>
References: <20180415145947.1248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+7d17fcac680d61fee2d2+5348+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63546
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
