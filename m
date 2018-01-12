Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 09:48:48 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:35983 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992692AbeALImyZdamJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 09:42:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S/GH44cRGA0qPZti+sTqqqVKSE2/SlUTJm6LzCR7sTw=; b=W1/lECL7R5lo9HdLZeatJinP+
        wgT3hKDtIsfq9gqF1vb4UJzW7pEQr8BDKJJJBnBmBWTMVeeTfRDvYJ1UbbbSEqdwrbf7pkQ79pSuA
        Ik6w2EgzPLUsYrawrGpN3o4NmKzkmaKRHRfTp7NRMvEATc/n4tlFcCSXD7mBCWPYkywUG+rW6GcJD
        2SBaKMmc71CrTl7FrDptm1XauK3ZQiplQvl2VNckH9ob6QGdAIh3qgiyBwbrxf1Wdosx8jtCMUs55
        YnihDbfujfyirth/zPr9kaQhvudpX1VsdR3yj067UigRqMVzemz9JeTf/dWq7g6rL+pbZwEpw9UK3
        wf4BnE19Q==;
Received: from [188.21.167.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZuvE-00074c-Hn; Fri, 12 Jan 2018 08:42:45 +0000
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
Subject: [PATCH 03/34] m32r: remove unused flush_write_buffers definition
Date:   Fri, 12 Jan 2018 09:42:01 +0100
Message-Id: <20180112084232.2857-4-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+b628242e4f103a69f336+5255+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62065
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m32r/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
index 1b653bb16f9a..a4272d8f0d9c 100644
--- a/arch/m32r/include/asm/io.h
+++ b/arch/m32r/include/asm/io.h
@@ -191,8 +191,6 @@ static inline void _writel(unsigned long l, unsigned long addr)
 
 #define mmiowb()
 
-#define flush_write_buffers() do { } while (0)  /* M32R_FIXME */
-
 static inline void
 memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
-- 
2.14.2
