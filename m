Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2008 00:06:04 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:5081 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23080067AbYKDAFk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2008 00:05:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mA404HSV007865;
	Tue, 4 Nov 2008 00:04:17 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mA404G1Z007863;
	Tue, 4 Nov 2008 00:04:16 GMT
Date:	Tue, 4 Nov 2008 00:04:16 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>, gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
Message-ID: <20081104000415.GB7291@linux-mips.org>
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org> <87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org> <87myggilk2.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87myggilk2.fsf@firetop.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 03, 2008 at 08:47:25PM +0000, Richard Sandiford wrote:

> >> Actually, I meant: I was wondering about the fact that there seems
> >> to be no online copy of the errata sheet that describes this problem.
> >> I've only ever seen a description of the workaround.  I've never seen
> >> a verbatim copy of the errata itself.
> >
> > I tried seeing whether archive.org had anything old off of the
> > mips.com site, but nothing close to the old directory structure seems
> > to exist.  If I new what the PDF file name was, it might be possible
> > to track something down on Google pertaining to the last publicly
> > released revision.  Bit surprised, too, on why NEC doesn't have
> > anything on necel.com.  They produced the actual silicon and had a
> > hand in designing it, if I'm not mistaken.  I'd think they would at
> > least have a copy if no one else.
> 
> Yeah.  Maybe they just want to erase bad memories ;)

The R10000 processor is not a MIPS Technologies but SGI product.  So
you've been looking at the wrong site.  However to shorten your search,
only some of the relativly early versions of the errata sheets were
published.

  Ralf
