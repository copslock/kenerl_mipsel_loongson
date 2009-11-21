Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 00:31:12 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37516 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493374AbZKUXbG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Nov 2009 00:31:06 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nALNVI8L022881;
	Sat, 21 Nov 2009 23:31:18 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nALNVHl5022879;
	Sat, 21 Nov 2009 23:31:17 GMT
Date:	Sat, 21 Nov 2009 23:31:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	figo zhang <figo1802@gmail.com>, linux-mips@linux-mips.org
Subject: Re: how i can know the linux-mips implememt cache strategy?
Message-ID: <20091121233117.GA12502@linux-mips.org>
References: <c6ed1ac50911171859k24685b32m237afd68f63c626f@mail.gmail.com> <20091118114432.GA17418@linux-mips.org> <b2b2f2320911210718j5909c151s3286f715d0ab39db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2b2f2320911210718j5909c151s3286f715d0ab39db@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 21, 2009 at 09:18:26AM -0600, Shane McDonald wrote:

> > The kernel will always use cache stategy 3 for non-coherent systems and
> > caching strategy 5 for cache coherent systems.  These two select the most
> > aggressive caching strategy on all processors and that's what gives the
> > best performance.
> 
> OK, dumb question -- how is this implemented?  Poking through the code,
> it looks to me that the cache strategy used comes from the K0 field of the
> coprocessor 0 Config register, which I think is whatever gets set up by
> the bootloader, or if that wasn't done, the default value of that
> field for the processor.

The K0 field's value after reset is undefined btw.  The kernel assumes that
the firmware on a particular platforms knows the the right values and
just uses it.

> See function coherency_setup() in arch/mips/mm/c-r4k.c:
> 
>         if (cca < 0 || cca > 7)
>                 cca = read_c0_config() & CONF_CM_CMASK;
>         _page_cachable_default = cca << _CACHE_SHIFT;
> 
> This can be overridden on the kernel command line with the "cca" parameter,

This is a special feature for MTI's multi-core product.  Tbh, I can't quite
recall why it was added but I have faint memories of this being required
to work around a miss-features in early revisions of PMON for it.  In the
best spirit of free software the cca= command line argument however is
available for anybody to shoot themselves into their feet.  It'd probably
be quite interesting to try a few benchmarks.

> but as Ralf said in
> http://www.linux-mips.org/archives/linux-mips/2008-06/msg00186.html,
> "passing a CCA value on the command line is nothing a user should
> ever, ever have to do".

Because users almost certainly don't understand the implications.  I mean
having to know ISA interrupts was stupid yet comparably trivial ...

> I can see how this was implemented in 2.6.25, but commit 3513369
> [MIPS] Allow setting of the cache attribute at run time, seems to have changed
> from the behaviour Ralf described.

  Ralf
