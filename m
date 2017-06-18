Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jun 2017 09:14:01 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:51305 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdFRHNyfI7rQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jun 2017 09:13:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rAYYqrk64FxN2XKF6QAoiwkru24IBAXRQvqism9Zd74=; b=sdNKSxoxXbPt89eTWtBijCpKq
        dvIF5PUENBFFX+sAAXRskS9RBCgGMVfICoHf79P8cG5ZFZUYPm9Mq1bKUhsDBFvrVoqcXcvF7rqOM
        YvwEEWlI0LXnkzJPaCZHFRKTWuG6OgP+gDo9d/UnkFLRIuLA6LsAtd/YwMY2vRIC/pOjP5DXAFqYN
        08jqtMHw4KAUBbwtEf++55ZSRQVya37YvUpVnXJaewA0k7EktQUZXp3O1DieeDPtKa8E0BJFMNFRT
        MFGA51FlzdzZPzCiMVGwIdJCXBi5fefZSmJzrq88sufHuFMeXADfHdwEVfRdmG7udfbHIRNjSSArl
        6V8DyC3OA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1dMUP2-0006az-8z; Sun, 18 Jun 2017 07:13:44 +0000
Date:   Sun, 18 Jun 2017 00:13:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 42/44] powerpc/cell: use the dma_supported method for ops
 switching
Message-ID: <20170618071344.GB18526@infradead.org>
References: <20170616181059.19206-1-hch@lst.de>
 <20170616181059.19206-43-hch@lst.de>
 <1497732627.2897.128.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497732627.2897.128.camel@kernel.crashing.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+3740c4db088a71c572a8+5047+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58601
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

On Sun, Jun 18, 2017 at 06:50:27AM +1000, Benjamin Herrenschmidt wrote:
> What is your rationale here ? (I have missed patch 0 it seems).

Less code duplication, more modular dma_map_ops insteance.

> dma_supported() was supposed to be pretty much a "const" function
> simply informing whether a given setup is possible. Having it perform
> an actual switch of ops seems to be pushing it...

dma_supported() is already gone from the public DMA API as it doesn't
make sense to be called separately from set_dma_mask.  It will be
entirely gone in the next series after this one.

> What if a driver wants to test various dma masks and then pick one ?
> 
> Where does the API documents that if a driver calls dma_supported() it
> then *must* set the corresponding mask and use that ?

Where is the API document for _any_ of the dma routines? (A: work in
progress by me, but I need to clean up the mess of arch hooks before
it can make any sense)

> I don't like a function that is a "boolean query" like this one to have
> such a major side effect.
> 
> >From an API standpoint, dma_set_mask() is when the mask is established,
> and thus when the ops switch should happen.

And that's exactly what happens at the driver API level.  It just turns
out the dma_capable method is they way better place to actually
implement it, as the ->set_dma_mask method requires lots of code
duplication while not offering any actual benefit over ->dma_capable.
And because of that it's gone after this series.

In theory we could rename ->dma_capable now, but it would require a
_lot_ of churn.  Give me another merge window or two and we should
be down to be about 2 handful of dma_map_ops instance, at which point
we could do all this gratious renaming a lot more easily :)
