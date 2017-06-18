Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jun 2017 09:09:39 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:42001 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdFRHJdQXT2Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jun 2017 09:09:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GLJ9MWRa5iSFHDHgMeqPS5qC6lxGLHkduureC37J84s=; b=o3WSYscRu94yDznMX81B/IkMn
        xNC30LRAlJGAuSUjIrTh1p9lupshPvLpxc/KSRQ4LX5WcGJVhpau5xThZK3lMRR66flbZ8T/j3AFV
        ka2Ujp4OMbzTPKLAjVkmO8AbZ5+rRL8FmVJ5fnattTMwlFVPFbUt3hU95ShDmG9TNWyCU4TWW29V8
        jEBpNwmqn7xjQ3jHp5mAKJK0KXVQKWAVQO+2l2DACf2jMITDi9KHMbU4RGoUyaXmUgU/VJFvTCmbZ
        JMmK5qVOx6/wDov94oruoTY2kb4lh816lNActDx4BkwU9SF0KbaYKwYqg3rFSxm7w4hgiHH6CKGkA
        b41eM9e/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1dMUKr-0004s6-2r; Sun, 18 Jun 2017 07:09:25 +0000
Date:   Sun, 18 Jun 2017 00:09:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/44] dmaengine: ioat: don't use DMA_ERROR_CODE
Message-ID: <20170618070925.GA18526@infradead.org>
References: <20170616181059.19206-1-hch@lst.de>
 <20170616181059.19206-4-hch@lst.de>
 <CAKgT0UdxrimWrxNVsLMQ9G6ABBJZwfWHTcP18qqd4rT0Fa-KWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdxrimWrxNVsLMQ9G6ABBJZwfWHTcP18qqd4rT0Fa-KWg@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+3740c4db088a71c572a8+5047+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58600
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

On Fri, Jun 16, 2017 at 01:40:24PM -0700, Alexander Duyck wrote:
> dma_unmap_page on dest_dma if "op == IOAT_OP_XOR"? Odds are it is what
> the compiler is already generating and will save a few lines of code
> so what you end up with is something like:

Honestly wanted to touch the code as little as possible :)  If we want
to make it prettier and more readable it needs to be refactored.

If you're interested I can take a stab at that, but I'd like to keep
it out of this already giant series.
