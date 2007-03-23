Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 21:20:24 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:52396 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022480AbXCWVUX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 21:20:23 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2NLKJWk028036;
	Fri, 23 Mar 2007 21:20:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2NLKEU6028035;
	Fri, 23 Mar 2007 21:20:14 GMT
Date:	Fri, 23 Mar 2007 21:20:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
Message-ID: <20070323212014.GA27761@linux-mips.org>
References: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu> <20070323141939.GB17311@linux-mips.org> <cda58cb80703230747w524409d7m3ee7753e676b0683@mail.gmail.com> <20070323152001.GA19477@linux-mips.org> <cda58cb80703231400n24023fahca5dee9608f90bba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80703231400n24023fahca5dee9608f90bba@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 23, 2007 at 10:00:00PM +0100, Franck Bui-Huu wrote:

> On 3/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> >Let me illustrate this with a little example.  Assume we have a page at
> >physical address 0x5000, a page size of 4kB, an 8kB direct mapped cache
> >and 32-byte cache lines.  Then address bits 0..4 will be the byte index
> >into the cache line, address bits 5..12 will index the cache array.  So
> >now let's map our page into userspace, at address 0x12340000.  In KSEG0
> >it is accessible at 0x80005000.  Now, compute the cache index for both
> >addresses compare and curse ...
> >
> 
> Yes but since the kernel page address is fixed, why not choosing
> userspace page addresses to share the same kernel cache index ?

That would require turning the memory allocator upside down to support
allocation of pages of a certain "color" which due to memory fragmentation
issues is seriously non-trivial.  Some UNIX variants do this scheme but
it doesn't come for free either and anyway, so far Linus' answer has been
a clear no.

  Ralf
