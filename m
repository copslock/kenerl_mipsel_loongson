Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2003 02:07:16 +0100 (BST)
Received: from p508B5484.dip.t-dialin.net ([IPv6:::ffff:80.139.84.132]:31959
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225200AbTECBHN>; Sat, 3 May 2003 02:07:13 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h4316wv24644;
	Sat, 3 May 2003 03:06:58 +0200
Date: Sat, 3 May 2003 03:06:58 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jimmy Zhang <jzhang@elmic.com>
Cc: linux-mips@linux-mips.org
Subject: Re: How to make part of kseg0 uncached
Message-ID: <20030503030657.A1756@linux-mips.org>
References: <004f01c31106$7cb63de0$0300a8c0@riverside>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <004f01c31106$7cb63de0$0300a8c0@riverside>; from jzhang@elmic.com on Fri, May 02, 2003 at 04:56:44PM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 02, 2003 at 04:56:44PM -0700, Jimmy Zhang wrote:

> It is pretty simple to make the WHOLE kseg0 cached or uncached. However,
> I only want part of kseg0 uncached. 
> 
> I must uncache that region because it gives me too much trouble with DMA
> data, however, I don't want to uncache the whole kseg0 segment in order
> to get better performance.  Kseg0 is not mapped through TLB, so it seems
> I can't achieve my goal through TLB. 
> 
> Cite from the book See Mips Run, "if you feel that your system needs to
> make uncached references to cacheable memory, then I strongly recommand
> that you divide memory into regions that are always accessed uncached
> and regions that are always accessed through the cache - and don't let
> them overlap. " But how ?

By not using KSEG0 for all your data.  As you figured the caching mode only
can only modifed for the entire KSEG0.  And because some part of your
code such as exception handlers will always run in KSEG0 you never want
to switch KSEG0 to uncached.  Easy solution, KSEG1 maps the same address
space as KSEG0 but is always uncached.  The usual warning applies, using
uncached memory is a bad idea in most cases.

  Ralf
