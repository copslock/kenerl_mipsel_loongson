Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 12:33:34 +0100 (BST)
Received: from phoenix.infradead.org ([IPv6:::ffff:195.224.96.167]:23561 "EHLO
	phoenix.infradead.org") by linux-mips.org with ESMTP
	id <S8225073AbTE0Ldc>; Tue, 27 May 2003 12:33:32 +0100
Received: from hch by phoenix.infradead.org with local (Exim 4.10)
	id 19Kcht-00021B-00; Tue, 27 May 2003 12:33:29 +0100
Date: Tue, 27 May 2003 12:33:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, wgowcher@yahoo.com,
	linux-mips@linux-mips.org
Subject: Re: pci_alloc_consistent usage
Message-ID: <20030527123329.A7750@infradead.org>
References: <20030523215935.71373.qmail@web11901.mail.yahoo.com> <20030527091740.GA23296@linux-mips.org> <20030527.190749.39150100.nemoto@toshiba-tops.co.jp> <20030527115322.A7124@infradead.org> <20030527112237.GA24905@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030527112237.GA24905@linux-mips.org>; from ralf@linux-mips.org on Tue, May 27, 2003 at 01:22:37PM +0200
Return-Path: <hch@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
X-list: linux-mips

On Tue, May 27, 2003 at 01:22:37PM +0200, Ralf Baechle wrote:
> [...]
> portably refer to any piece of memory.  If you have a cpu pointer
> (which may be validly DMA'd too) you may easily obtain the page
> and offset using something like this:
>                                                                                 
>         struct page *page = virt_to_page(ptr);
>         unsigned long offset = ((unsigned long)ptr & ~PAGE_MASK);
> [...]
> 
> While it's officially documented I still don't like it.

Hmm, I remembered that some ports used vmalloc-like allocators for
this and virt_to_page doesn't work for those..
