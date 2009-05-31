Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 17:19:29 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38127 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023836AbZEaQTV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 31 May 2009 17:19:21 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4VGIjlK004660;
	Sun, 31 May 2009 17:18:45 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4VGIgIt004657;
	Sun, 31 May 2009 17:18:42 +0100
Date:	Sun, 31 May 2009 17:18:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver
Message-ID: <20090531161842.GB30640@linux-mips.org>
References: <1243350141-883-1-git-send-email-anemo@mba.ocn.ne.jp> <20090529162907.9cb1bba2.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090529162907.9cb1bba2.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 29, 2009 at 04:29:07PM -0700, Andrew Morton wrote:

> > +static u64 read_rng(void __iomem *base, unsigned int offset)
> > +{
> > +	/* Caller must disable interrupts */
> > +	return ____raw_readq(base + offset);
> > +}
> 
> What is the reasoning behind the local_irq_disable() requirement?
> 
> Because I'm wondering whether this is safe on SMP?

The problem are interrupts, not SMP.  readq is reading a 64-bit register
using a 64-bit load.  On a 32-bit kernel however interrupts or any
other processor exception would clobber the upper 32-bit of the processor
register so interrupts need to be disabled.  The "normal" readq
functions disable interrupts as necessary on a platform.  This code does
multiple read accesses so for efficiency sake it relies on the caller
handling interrupts explicitly.

Also this platform does not do SMP.

  Ralf
