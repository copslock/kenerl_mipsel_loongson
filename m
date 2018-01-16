Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 08:53:48 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:56230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990399AbeAPHxm2AKXV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 08:53:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lcUjYwVEhHIJ8LTAh1DGtOzV1t11I7pwhQF5AdhE/Ts=; b=Uydo6DI1e7FOow+3DR/4lSDQX
        wzPg4p5OqRRTmy3X+haCGJviXPpU0SbppHPybYAbVKh2lh19ObxVXtNO/x14C/aBRfm0RZyZJp6DZ
        UKOqOq4Dgs51SoyKSTCW9CE0zg2AfOleS+jHCuRmXUrL2vUduerzjgACl+cLOek7kjEmQakADwX6a
        Z03p7Z/ebaYeELdsOPQPm5DhDu92zWc7NnPDtC6N6h0Tea1mS8slrBkkIRjS30lGRyu7/Bsx0AAad
        gk6GcUu0wCXvkuDWWppfI7nEyEXjsjGdVdiZLxUrnuOnZy0++u0N84lLbTJ1p6VWerhbaq1iCwaPp
        UtMCKlCUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.89 #1 (Red Hat Linux))
        id 1ebM3v-0004KM-3t; Tue, 16 Jan 2018 07:53:39 +0000
Date:   Mon, 15 Jan 2018 23:53:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
        linux-ia64@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: consolidate swiotlb dma_map implementations
Message-ID: <20180116075338.GB12693@infradead.org>
References: <20180110080932.14157-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+a44557d646e720d5a26d+5259+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62157
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

I've pulled this into the dma-mapping for-next tree, including the
missing free_pages noted.  I'd be fine to rebase another day or two
for additional reviews or important fixes.
