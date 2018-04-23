Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 19:04:36 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:48352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993124AbeDWRE3hz1We (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 19:04:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VB/n3fh/vCmrVJBjYlk8oMTAvHjeacLkdr1SPfqOijs=; b=oZh3VGKUVwRXJpZAOW5+wWl6i
        u2Om1chF34nJ4RmP6JfTbCEvKSwrC7Guy3GlHlbJd7v341Ku/UZrrSODvbVKJbvnygccFPGmghPVi
        LBMQLeWW4Yx2CqhABNkQiwr1jRUNU4Tzt114G4yvr01qkZKpxY46hGjDU/r3ZGYPpLTE2kLlHT7mC
        HTIISPuR4rjTIkOQi8AO239dmq2JBVpZ8sHSdnZ5gyxQsWOtLg4ENY8V0y3Ln7+iXYBy5EaVqqi2r
        coyOfdz4Z+WPYeLMDZ6byUvGYQKBeI5oTwgqb8g7+GjnslktpIIHTsrTjcGvhh6u4BADoMUNfWQOr
        FsL0Ou0cg==;
Received: from 089144198044.atnat0007.highway.a1.net ([89.144.198.44] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fAet4-0008J4-Mk; Mon, 23 Apr 2018 17:04:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: centralize SWIOTLB config symbol and misc other cleanups V2
Date:   Mon, 23 Apr 2018 19:04:07 +0200
Message-Id: <20180423170419.20330-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+de39c3f36ce265885e0e+5356+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63701
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

Chances since V2 are a fixed s/Reviewed/Signed-Off/ for me, and a few
reviewed-by tags.  I'd like to start merging this into the dma-mapping
tree rather sooner than later given that quite a bit of material for
this series depends on it.
