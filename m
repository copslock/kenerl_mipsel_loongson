Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 06:14:07 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:59341 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990434AbeKAFN7zhx99 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Nov 2018 06:13:59 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 954DA6F9B7; Thu,  1 Nov 2018 06:13:59 +0100 (CET)
Date:   Thu, 1 Nov 2018 06:13:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dma-mapping: merge direct and noncoherent ops
Message-ID: <20181101051359.GA4164@lst.de>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org> <20181031203206.GA28337@lst.de> <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67024
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

On Wed, Oct 31, 2018 at 08:50:53PM +0000, Maciej W. Rozycki wrote:
> On Wed, 31 Oct 2018, Christoph Hellwig wrote:
> 
> > Can you send me your .config?
> 
>  Sure, attached.
> 
>  This is an updated 4.19 defconfig I was going to submit as I tripped over 
> this problem, so just rename it to .config and use `make olddefconfig' to 
> regenerate a full version.

Fails to compile for me with:

cc1: error: ‘-march=r3000’ requires ‘-mfp32’

using the x86_64 corss gcc 8 from Debian testing.

Either way the config looks like we have all the required bits for
non-coherent dma support.  The only guess is that somehow
dma_cache_wback_inv aren't hooked up to the right functions for some
reason, but I can't really think off why.
