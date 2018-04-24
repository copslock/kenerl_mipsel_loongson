Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 09:55:24 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:48263 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992368AbeDXHzRXQE04 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Apr 2018 09:55:17 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CBFBA68DB3; Tue, 24 Apr 2018 09:56:45 +0200 (CEST)
Date:   Tue, 24 Apr 2018 09:56:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to
        lib/Kconfig
Message-ID: <20180424075645.GA19379@lst.de>
References: <20180423170419.20330-1-hch@lst.de> <20180423170419.20330-12-hch@lst.de> <20180423235205.GH16141@n2100.armlinux.org.uk> <20180424065549.GA18468@lst.de> <20180424074726.GI16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424074726.GI16141@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63720
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

On Tue, Apr 24, 2018 at 08:47:27AM +0100, Russell King - ARM Linux wrote:
> Therefore, the default state for SWIOTLB and hence NEED_SG_DMA_LENGTH
> becomes 'y' on ARM, and any defconfig file that does not mention SWIOTLB
> explicitly ends up with both these enabled.

Indeed, sorry.

> It does look a bit weird though - patch 10 arranged stuff so that we
> didn't end up with SWIOTLB always enabled, but this patch reintroduces
> that with the allowance that the user can disable if so desired.

I am not very happy with that patch, but I have a hard time coming
up with something saner.

Bascially x86_64 and mips/loongson default to SWIOTLB=y but allow to
deselect it, powerpc has it optional without any real dependency
and defaults to n and everyone just selects it otherwise.

I suspect the right thing is to just have it always one for x86_64
and loongson and have a ppc-specific option to enable it on powerpc
so that we can always use select statements.  I'll do that for the
next round.
