Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 07:16:14 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:60408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990392AbeDYFPwJOMap (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 07:15:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KE9nmR8I/4nBMSv3QU3/qguCBWhqYUBfDkJUnxhweig=; b=Oo4oq1OjTwrqkjt05sTMEXT7D
        iCXI75ghWEJrQ7EY7WABCTpCV802bpdxa7OTsD2nWSeAQOgHuvO1U3bXElC7LsrSOJ0pGA/FecwPH
        n1WKBtQwjOkTuGjvNGQkZSmjMdEtUaKychPNhZnLyf8B1Ul0KwuHtUCMZwnN3EvvGupt5XwllvkHE
        +t/v0hJ23phKrA3BTPqUzmO+8gbc/2q51lQ0ysnfwuP8vOPpnMDZzbO7eEYl3m2TQbQ67V2llprzM
        hxucs4aPZPCDNEU+2xpf8IYuIr0DRi/J/uFBe82S33OgkYRKehVqhtNz9WWPJzLyHv9eiPTTJxnYW
        DiBZu7zIA==;
Received: from [93.83.86.253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fBCmM-00051v-HH; Wed, 25 Apr 2018 05:15:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     sstabellini@kernel.org, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: centralize SWIOTLB config symbol and misc other cleanups V3
Date:   Wed, 25 Apr 2018 07:15:26 +0200
Message-Id: <20180425051539.1989-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63742
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

Hi all,

this seris aims for a single defintion of the Kconfig symbol.  To get
there various cleanups, mostly about config symbols are included as well.

Changes since V2:
 - swiotlb doesn't need the dma_length field by itself, so don't select it
 - don't offer a user visible SWIOTLB choice

Chages since V1:
 - fixed a incorrect Reviewed-by that should be a Signed-off-by.
