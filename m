Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 15:20:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:51937 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022421AbXCWPUE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 15:20:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2NFK281019733;
	Fri, 23 Mar 2007 15:20:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2NFK1Ek019732;
	Fri, 23 Mar 2007 15:20:01 GMT
Date:	Fri, 23 Mar 2007 15:20:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Miklos Szeredi <miklos@szeredi.hu>, linux-mips@linux-mips.org,
	Ravi.Pratap@hillcrestlabs.com
Subject: Re: flush_anon_page for MIPS
Message-ID: <20070323152001.GA19477@linux-mips.org>
References: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu> <20070323141939.GB17311@linux-mips.org> <cda58cb80703230747w524409d7m3ee7753e676b0683@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80703230747w524409d7m3ee7753e676b0683@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 23, 2007 at 03:47:45PM +0100, Franck Bui-Huu wrote:

> On 3/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> >The other thing I still need to understand is why nobody actually seems
> >to have triggered this bug on MIPS so far.  I suppose our implementation
> >of flush_dcache_page() may have done a successful job at papering it
> >which means there might be some performance getting lost there as well.
> >
> 
> Just to understand, doesn't all mappings of shared anonymous pages and
> kernel addresses of them share the same cache lines ?

That's true only for all userspace mappings and an anonymous page should
normally have only a single mapping per mm anyway.  But to make things
more complicated a page of course also has a kernel space address in
KSEG0 or XKPHYS and on a VIPT cache there we frequently have the case
where the user address and the kernel address would map to a different
cache line.

Let me illustrate this with a little example.  Assume we have a page at
physical address 0x5000, a page size of 4kB, an 8kB direct mapped cache
and 32-byte cache lines.  Then address bits 0..4 will be the byte index
into the cache line, address bits 5..12 will index the cache array.  So
now let's map our page into userspace, at address 0x12340000.  In KSEG0
it is accessible at 0x80005000.  Now, compute the cache index for both
addresses compare and curse ...

  Ralf
