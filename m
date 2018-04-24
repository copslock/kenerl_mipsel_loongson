Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 09:47:46 +0200 (CEST)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:57964
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992312AbeDXHrjHwEf4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Apr 2018 09:47:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kAqgNPfGFSv52tSbfK8aoHnIfi12rChPe2t+CQq8rvU=; b=hEQvZcIgauXAoTJtr6kS398BR
        sDiGmkWpjb0P7KozWqSjo0v9Gx2u8Cn0yusZm4F1zmUc+OcwiyROcenKsl67RX96SQ5dAMpf2k7sJ
        SxPZ9MyVrxsed2lPmXZ+KXdV9DBIoNV20sOQU+rVYZALK47heDGQvH3LuFiQlrdBbN+8U=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:37695)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fAsfj-0001Ll-9n; Tue, 24 Apr 2018 08:47:31 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fAsfg-0002dn-JM; Tue, 24 Apr 2018 08:47:28 +0100
Date:   Tue, 24 Apr 2018 08:47:27 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to
 lib/Kconfig
Message-ID: <20180424074726.GI16141@n2100.armlinux.org.uk>
References: <20180423170419.20330-1-hch@lst.de>
 <20180423170419.20330-12-hch@lst.de>
 <20180423235205.GH16141@n2100.armlinux.org.uk>
 <20180424065549.GA18468@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424065549.GA18468@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

On Tue, Apr 24, 2018 at 08:55:49AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 24, 2018 at 12:52:05AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Apr 23, 2018 at 07:04:18PM +0200, Christoph Hellwig wrote:
> > > This way we have one central definition of it, and user can select it as
> > > needed.  Note that we also add a second ARCH_HAS_SWIOTLB symbol to
> > > indicate the architecture supports swiotlb at all, so that we can still
> > > make the usage optional for a few architectures that want this feature
> > > to be user selectable.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Hmm, this looks like we end up with NEED_SG_DMA_LENGTH=y on ARM by
> > default, which probably isn't a good idea - ARM pre-dates the dma_length
> > parameter in scatterlists, and I don't think all code is guaranteed to
> > do the right thing if this is enabled.
> 
> We shouldn't end up with NEED_SG_DMA_LENGTH=y on ARM by default.

Your patch as sent would end up with:

ARM selects ARCH_HAS_SWIOTLB
SWIOTLB is defaulted to ARCH_HAS_SWIOTLB
SWIOTLB selects NEED_SG_DMA_LENGTH

due to:

@@ -106,6 +106,7 @@ config ARM
        select REFCOUNT_FULL
        select RTC_LIB
        select SYS_SUPPORTS_APM_EMULATION
+       select ARCH_HAS_SWIOTLB

and:

+config SWIOTLB
+       bool "SWIOTLB support"
+       default ARCH_HAS_SWIOTLB
+       select NEED_SG_DMA_LENGTH

Therefore, the default state for SWIOTLB and hence NEED_SG_DMA_LENGTH
becomes 'y' on ARM, and any defconfig file that does not mention SWIOTLB
explicitly ends up with both these enabled.

> It is only select by ARM_DMA_USE_IOMMU before the patch, and it will
> now also be selected by SWIOTLB, which for arm is never used or seleted
> directly by anything but xen-swiotlb.

See above.

> Then again looking at the series there shouldn't be any need to
> even select NEED_SG_DMA_LENGTH for swiotlb, as we'll never merge segments,
> so I'll fix that up.

That would help to avoid any regressions along the lines I've spotted
by review.

It does look a bit weird though - patch 10 arranged stuff so that we
didn't end up with SWIOTLB always enabled, but this patch reintroduces
that with the allowance that the user can disable if so desired.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
