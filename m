Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2008 09:24:26 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:4536
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20033237AbYHHIYR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Aug 2008 09:24:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m788O6ja011509;
	Fri, 8 Aug 2008 09:24:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m788O4lk011506;
	Fri, 8 Aug 2008 09:24:04 +0100
Date:	Fri, 8 Aug 2008 09:24:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Anyone noticed that there are a lot of cache flushes after
	kunmap/kunmap_atomic is called?
Message-ID: <20080808082404.GA27519@linux-mips.org>
References: <489A5975.1000401@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489A5975.1000401@cisco.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 06, 2008 at 07:09:57PM -0700, David VomLehn wrote:

> On the MIPS processor, cache flushing is done based on virtual addresses. 
> However, in the Linux kernel, there are a lot of places where memory is 
> mapped with kmap or kmap_atomic, then unmapped with the corresponding 
> kunmap or kunmap_atomic and only *then* is the cache flushed. In other 
> words, we only flush the cache after we have dropped the mapping of 
> memory into a virtual address. I think this is generally wrong.
>
> This may really only affect those of us who have enabled high memory, but 
> it's pretty prevalent in kernel code. We noted this before, but have 
> apparently just been bitten by it. Is it just me or is there a fairly 
> widespread problem for processors that flush the cache using virtual 
> addresses?

Not all MIPS processors have virtually indexed caches; some have physically
indexed caches or caches which behave effectivly like physically indexed
and MIPS highmem only tries to support the latter kinds of caches.  Which
means most of the cache flushes turn into nops anyway.

  Ralf
