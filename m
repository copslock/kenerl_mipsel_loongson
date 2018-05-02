Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2018 14:46:28 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:49248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992521AbeEBMqW1cYY9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 May 2018 14:46:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ub+lf3MEQrp13uhIMbv3Uzwn2AMVnK7UcD1pgs6ypeE=; b=kgkUQ3G9RVw9Pr88AvB9H4TX1
        pq8XpFRRtRjKKH81udIsifg2F7p/t9lkn/eQMWzRl0y+/8O5wb/cER4sfzgU/1zRnwYqXedWZA21m
        8MhuuivLxoZ2sMihzbwFhKb+pzOh+csMrAUiFlSZZ3Y2uk1DTHWl75Dysf+Kj63LI6nzjUd7b6dtd
        SsDDC4aKK54o/ViF92uB1Fi1NfJO08kTIo/Gatn0HFY5iCyzwplnZb1AKYV0hDgJEnmBjboi9rBOm
        MmiJIxVc9H7lHHGzylVYchgp8GDC6iF8hx6lsqJ4sYyKWNgjFpB9q3CHNqNAmXqKTl/WtUwMeM1T5
        N30Xlq8ng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fDr9F-00071x-W9; Wed, 02 May 2018 12:46:18 +0000
Date:   Wed, 2 May 2018 05:46:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        sstabellini@kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
        linux-mm@kvack.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: centralize SWIOTLB config symbol and misc other cleanups V3
Message-ID: <20180502124617.GA22001@infradead.org>
References: <20180425051539.1989-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425051539.1989-1-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+f4aaa1fcd02e82e68825+5365+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
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

Any more comments?  Especially from the x86, mips and powerpc arch
maintainers?  I'd like to merge this in a few days as various other
patches depend on it.

On Wed, Apr 25, 2018 at 07:15:26AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this seris aims for a single defintion of the Kconfig symbol.  To get
> there various cleanups, mostly about config symbols are included as well.
> 
> Changes since V2:
>  - swiotlb doesn't need the dma_length field by itself, so don't select it
>  - don't offer a user visible SWIOTLB choice
> 
> Chages since V1:
>  - fixed a incorrect Reviewed-by that should be a Signed-off-by.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
