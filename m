Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 02:24:07 +0100 (BST)
Received: from p508B71D0.dip.t-dialin.net ([IPv6:::ffff:80.139.113.208]:2872
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225471AbUC3BYG>; Tue, 30 Mar 2004 02:24:06 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2U1O5oM012160;
	Tue, 30 Mar 2004 03:24:05 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2U1O3uT012159;
	Tue, 30 Mar 2004 03:24:03 +0200
Date: Tue, 30 Mar 2004 03:24:03 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	Brian Murphy <brian@murphy.dk>, linux-mips@linux-mips.org
Subject: Re: BUG in pcnet32.c?
Message-ID: <20040330012403.GB4068@linux-mips.org>
References: <4068809F.8070103@murphy.dk> <4068864D.1020209@realitydiluted.com> <008901c415d0$3a94d5f0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008901c415d0$3a94d5f0$10eca8c0@grendel>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 29, 2004 at 10:55:52PM +0200, Kevin D. Kissell wrote:

> Which reminds me of something I've been meaning to mention for a while.
> Back in the dark days of Linux 2.2 on MIPS, I discovered that a number
> of network drivers were subtly broken for MIPS because they allocated
> enough extra space for IP header alignment, but not for cache line alignment.
> Particularly on CPUs with write-back caches, it can be a Bad Thing if a cache 
> line straddles two packet buffers, as the flush of one can cause the other
> to be clobbered.  I had to redefine the alignment constant for MIPS to be
> a function of the line size to have 100% solid operation of the Tulip and
> pcnet32 drivers.
> 
> The whole network driver cache management paradigm was redone for 2.4,
> and I've often wondered whether the same potential problem exists, but never
> had the time to go in and check.

The change goes beyond just cache managment; the API also abstracts away
I/O MMUs which so far are quite rare on MIPS systems - but I really hope
they're going to establish themselves asap.

The Documentation/DMA-API.txt also documents how properly deal with cache
alignment when using this API.

Steven, maybe that we should add another assertion to make sure we don't
run into trouble with missaligned cachelines?

> There, I've mentioned it.  My conscience is clear.  ;o)

Ommmmm ;))

  Ralf
