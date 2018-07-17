Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 14:48:26 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:52990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993070AbeGQMsXA6YKd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2018 14:48:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kJU4mzvFgSyDMH0hHFRGGTEcAb8pljtaJg5m9yLMyMA=; b=RB1fUSUUgSA85D/CLNqdD7CwC
        mLZtofW/xI5hlv3i446QD6KaXqFBjQwYMFgRWFAsmDq2pK0z/4EwZkO/5Iy0JtOiy/8tjdVctcYpU
        dTnjNEcoDTg0YB4ygFHZqfV/vThJGed4idV29zzfhMWJ+0+PhfxBiPRoHG2UJhKcFz1M/I54iWEn3
        ZPWJWuJ9ASmsMfBGkhZDPuzckdbdBqES8AQ5WOGXX8Tl/cUavCswvuFbeDo7Y6xwLlMeCR5DCN0aU
        cO8I0BLeoYPQwQKwgdHZJKFrltvEsbIL0KCQnfDaUBy3b8CqSVUMlcs28OHdzesoYeKv3n7N6w9Ms
        SzUsZOoIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffPOs-0006Qr-V7; Tue, 17 Jul 2018 12:48:18 +0000
Date:   Tue, 17 Jul 2018 05:48:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180717124818.GC22099@infradead.org>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <20180711065631.GA21948@infradead.org>
 <20180711135210.GA18730@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711135210.GA18730@mobilestation>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+46ef037c8ead33cf991a+5441+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64884
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

On Wed, Jul 11, 2018 at 04:52:10PM +0300, Serge Semin wrote:
> Hello Christoph,
> 
> On Tue, Jul 10, 2018 at 11:56:31PM -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > > + * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
> > > + * requests a cachable mapping with CWB attribute enabled.
> > >   */
> > >  #define ioremap_cacheable_cow(offset, size)				\
> > >  	__ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
> > 
> > This isn't actually used anywhere in the kernel tree.  Please remove it
> > as well.
> 
> I don't really know whether it is necessary at this point. We discarded the 
> ioremap_uncached_accelerated() method, since the obvious alternative is now
> available: ioremap_wc(). While ioremap_cacheable_cow() hasn't got one.
> So if it was up to me, I'd leave it here. Anyway if the subsystem maintainers
> think otherwise, I won't refuse to submit a patch with this method removal.

The function is entirely unused in the kernel tree, please remove it.
