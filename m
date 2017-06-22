Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2017 23:53:22 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:36065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991978AbdFVVxPpDnDa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Jun 2017 23:53:15 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3wtwLY732Hz9s9Y;
        Fri, 23 Jun 2017 07:53:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1498168390;
        bh=ywXrzY6bUrluSNE/4Wv2oLZ9q/yfzIcJiVfp+kW3Bm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K2q1nx3zGvlp4s3hl4RWhsuaNhYeX31vFbRXw6OKYj2ZN3QQbrt6t/Ia2EqJupiTO
         Utfw2kM6UlkFT1KXUS8E7ZWJwo1qAJXpLyDrA2VeFDXmRGf68mBhIANbLRO9/wQ3yk
         zClY5fQILPDASsPz0cj5eq7zRxPOvyxFcWYVbrs+CVWcru9VOrAR3wRqqD9/JcztRD
         /h/2octFNxg1tv0b6c+fM+giJ+nswmuvtMeI4dzkD+zlcPbZXreoTQwJSiVw9cYU6l
         3qf7domfYqdqP5P2p3cLgGAlgPJkxW9zAmq20eAzQmE8Qza6HSJUvpC1fvM9m+rdNW
         MnzL5eFfA25lw==
Date:   Fri, 23 Jun 2017 07:53:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
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
        linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: new dma-mapping tree, was Re: clean up and modularize arch
 dma_mapping interface V2
Message-ID: <20170623075309.1e679168@canb.auug.org.au>
In-Reply-To: <5425587c-73e8-e24a-86a3-8a65a7791dcb@samsung.com>
References: <20170616181059.19206-1-hch@lst.de>
        <20170620124140.GA27163@lst.de>
        <20170620230400.1a5ae889@canb.auug.org.au>
        <CGME20170620131628epcas1p4f21d821bd414cba7e2d49abcbe414365@epcas1p4.samsung.com>
        <20170620131623.GB30769@lst.de>
        <5425587c-73e8-e24a-86a3-8a65a7791dcb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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

On Wed, 21 Jun 2017 15:32:39 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 2017-06-20 15:16, Christoph Hellwig wrote:
> > On Tue, Jun 20, 2017 at 11:04:00PM +1000, Stephen Rothwell wrote:  
> >> git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git#dma-mapping-next
> >>
> >> Contacts: Marek Szyprowski and Kyungmin Park (cc'd)
> >>
> >> I have called your tree dma-mapping-hch for now.  The other tree has
> >> not been updated since 4.9-rc1 and I am not sure how general it is.
> >> Marek, Kyungmin, any comments?  
> > I'd be happy to join efforts - co-maintainers and reviers are always
> > welcome.  
> 
> I did some dma-mapping unification works in the past and my tree in 
> linux-next
> was a side effect of that. I think that for now it can be dropped in 
> favor of
> Christoph's tree. I can also do some review and help in maintainers work if
> needed, although I was recently busy with other stuff.

OK, so I have dropped the dma-mapping tree and renamed dma-mapping-hch
to dma-mapping.

-- 
Cheers,
Stephen Rothwell
