Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2008 09:19:42 +0000 (GMT)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39100 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S28588208AbYCDJTk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Mar 2008 09:19:40 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m249JHFf018416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Mar 2008 01:19:18 -0800
Received: from box (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m249J52w000967;
	Tue, 4 Mar 2008 01:19:06 -0800
Date:	Tue, 4 Mar 2008 01:19:05 -0800
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: drivers/net/wireless/b43legacy/ on mips
Message-Id: <20080304011905.22e6e6d9.akpm@linux-foundation.org>
In-Reply-To: <20080304090220.GA2875@linux-mips.org>
References: <20080303233651.82c592a4.akpm@linux-foundation.org>
	<20080304090220.GA2875@linux-mips.org>
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Tue, 4 Mar 2008 09:02:20 +0000 Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Mar 03, 2008 at 11:36:51PM -0800, Andrew Morton wrote:
> 
> > ERROR: "__ucmpdi2" [drivers/net/wireless/b43legacy/b43legacy.ko] undefined!
> > ERROR: "__ucmpdi2" [drivers/net/wireless/b43/b43.ko] undefined!
> > 
> > int b43legacy_dma_init(struct b43legacy_wldev *dev)
> > {
> >         struct b43legacy_dma *dma = &dev->dma;
> >         struct b43legacy_dmaring *ring;
> >         int err;
> >         u64 dmamask;
> >         enum b43legacy_dmatype type;
> > 
> >         dmamask = supported_dma_mask(dev);
> >         switch (dmamask) {
> >         default:
> >                 B43legacy_WARN_ON(1);
> >         case DMA_30BIT_MASK:
> >                 type = B43legacy_DMA_30BIT;
> >                 break;
> >         case DMA_32BIT_MASK:
> >                 type = B43legacy_DMA_32BIT;
> >                 break;
> >         case DMA_64BIT_MASK:
> >                 type = B43legacy_DMA_64BIT;
> >                 break;
> >         }
> > 
> > because some versions of gcc emit a __ucmpdi2 call for switch statements. 
> 
> Was this when optimizing for size btw?

mips allmodconfig.  So: yes.

>  It seems gcc is emitting alot more
> calls to libgcc when optimizing for size.
> 
> > It might be fixable by switching to an open-coded if/compare/else sequence.
> 
> It was just a EXPORT_SYMBOL(__ucmpdi2) missing.

doh.

> > Or maybe my mips compiler (gcc-3.4.5) is just too old..
> 
> I'm trying to keep the tools requirements the same as for x86.  So for
> 32-bit kernels gcc 3.2 is the minimum but 3.2 is broken beyond recovery
> for 64-bit code so there a minimum of 3.3 is required.
> 
> In practive it is ages that I've last seen a compiler older than gcc 3.4
> being used to build a modern kernel for any architecture and 3.2 and 3.3
> are a sufficient special case that maybe we should think about deprecating
> 3.2 and 3.3?

That would make life easier for us.  I don't know what the downstream
implications would be.  I'd need a new cross-compiler, for a start ;)
