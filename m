Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2008 09:02:27 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:63721 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28601299AbYCDJCZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Mar 2008 09:02:25 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2492LSJ030433;
	Tue, 4 Mar 2008 09:02:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2492KDF030432;
	Tue, 4 Mar 2008 09:02:20 GMT
Date:	Tue, 4 Mar 2008 09:02:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: drivers/net/wireless/b43legacy/ on mips
Message-ID: <20080304090220.GA2875@linux-mips.org>
References: <20080303233651.82c592a4.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080303233651.82c592a4.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 03, 2008 at 11:36:51PM -0800, Andrew Morton wrote:

> ERROR: "__ucmpdi2" [drivers/net/wireless/b43legacy/b43legacy.ko] undefined!
> ERROR: "__ucmpdi2" [drivers/net/wireless/b43/b43.ko] undefined!
> 
> int b43legacy_dma_init(struct b43legacy_wldev *dev)
> {
>         struct b43legacy_dma *dma = &dev->dma;
>         struct b43legacy_dmaring *ring;
>         int err;
>         u64 dmamask;
>         enum b43legacy_dmatype type;
> 
>         dmamask = supported_dma_mask(dev);
>         switch (dmamask) {
>         default:
>                 B43legacy_WARN_ON(1);
>         case DMA_30BIT_MASK:
>                 type = B43legacy_DMA_30BIT;
>                 break;
>         case DMA_32BIT_MASK:
>                 type = B43legacy_DMA_32BIT;
>                 break;
>         case DMA_64BIT_MASK:
>                 type = B43legacy_DMA_64BIT;
>                 break;
>         }
> 
> because some versions of gcc emit a __ucmpdi2 call for switch statements. 

Was this when optimizing for size btw?  It seems gcc is emitting alot more
calls to libgcc when optimizing for size.

> It might be fixable by switching to an open-coded if/compare/else sequence.

It was just a EXPORT_SYMBOL(__ucmpdi2) missing.

> Or maybe my mips compiler (gcc-3.4.5) is just too old..

I'm trying to keep the tools requirements the same as for x86.  So for
32-bit kernels gcc 3.2 is the minimum but 3.2 is broken beyond recovery
for 64-bit code so there a minimum of 3.3 is required.

In practive it is ages that I've last seen a compiler older than gcc 3.4
being used to build a modern kernel for any architecture and 3.2 and 3.3
are a sufficient special case that maybe we should think about deprecating
3.2 and 3.3?

  Ralf
