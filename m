Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 01:37:39 +0100 (CET)
Received: from p508B5AAD.dip.t-dialin.net ([80.139.90.173]:43661 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225218AbSLDAhi>; Wed, 4 Dec 2002 01:37:38 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB40bDc19447;
	Wed, 4 Dec 2002 01:37:13 +0100
Date: Wed, 4 Dec 2002 01:37:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Daniel Jacobowitz <dan@debian.org>,
	atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
Message-ID: <20021204013713.D18419@linux-mips.org>
References: <20021125160800.A22590@linux-mips.org> <Pine.GSO.3.96.1021125163423.8769I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021125163423.8769I-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Nov 25, 2002 at 04:47:33PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 25, 2002 at 04:47:33PM +0100, Maciej W. Rozycki wrote:

> > MIPS64 extends that to also support instruction address matches; the
> > granularity can be set anywhere from 8 bytes to 4kB; in addition ASID
> > matching and a global bit can be used for matching.  A MIPS64 CPU can
> > support anywhere from 0 to 4 such watch registers.
> 
>  Actually up to eight -- for all dmfc0/dmtc0 3-bit "sel" values, if I read
> it correctly.

Correct but I don't know of any CPU that actually uses more than 4 of the
possible 8 sets atm.  So we're both right :)

> > The global bit stuff would only be useful for in-kernel use, I think.  The
> > ASID thing could be used to implement watchpoints for an entire process, not
> > just per thread though I doubt there is much use for something like that.
> 
>  Well, there are two options only -- either use global matching or ASID
> matching.  What else would you expect?  Do you mean lazy vs immediate
> switching? 

Basically there would be two possibilities, associate the debugging state
of a process with it's thread_struct or with it's mm_struct.  The latter
would have a little less impact on the context switching performance,
the first be a bit more flexible.

  Ralf
