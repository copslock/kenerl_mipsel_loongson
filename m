Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2005 18:34:59 +0000 (GMT)
Received: from p3EE2BD6B.dip.t-dialin.net ([IPv6:::ffff:62.226.189.107]:59218
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224952AbVBNSen>; Mon, 14 Feb 2005 18:34:43 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1EIYf7i004678;
	Mon, 14 Feb 2005 19:34:41 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j1EIYfP0004677;
	Mon, 14 Feb 2005 19:34:41 +0100
Date:	Mon, 14 Feb 2005 19:34:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050214183441.GA4263@linux-mips.org>
References: <20050214035304Z8225242-1340+3175@linux-mips.org> <20050214153435.GD806@linux-mips.org> <Pine.LNX.4.61L.0502141557460.2566@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0502141557460.2566@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 14, 2005 at 04:06:51PM +0000, Maciej W. Rozycki wrote:

> > Bulletproofing 2.4 against newer tools is something that only makes limited
> > sense, especially wrt. to gcc 3.4 and newer.  Chances for any such changes
> > to be accepted upstream are slim - and the kernel has traditionally been
> > easily affected by overoptimization, so I recommend against gcc 3.4.  The
> > recommended compiler for 2.4 is still gcc 2.95.3 but except gcc 3.0 upto
> > gcc 3.3 is reasonable and can be considered well tested.
> 
>  I do agree in general, but given that the construct I've used has been 
> supported by gas since 1995, there is no point in keeping our code broken.  
> And binutils actually quite rarely trigger problems with Linux, while 
> they've got improved significantly with the last few releases; unlike with 
> GCC it's normally a good idea to use the latest version of binutils.

I wasn't objecting to your patch; it's just that I expect some users to
upgrade to a recent binutils and gcc at the same time and that has good
chances to end up in a nice firework ;-)

  Ralf
