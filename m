Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 01:58:01 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:35223 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S8225218AbSLDA6A>;
	Wed, 4 Dec 2002 01:58:00 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18JPjw-0006Qw-00; Tue, 03 Dec 2002 20:58:20 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18JNrt-0002qI-00; Tue, 03 Dec 2002 19:58:25 -0500
Date: Tue, 3 Dec 2002 19:58:25 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
Message-ID: <20021204005825.GA10895@nevyn.them.org>
References: <20021125160800.A22590@linux-mips.org> <Pine.GSO.3.96.1021125163423.8769I-100000@delta.ds2.pg.gda.pl> <20021204013713.D18419@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204013713.D18419@linux-mips.org>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 04, 2002 at 01:37:13AM +0100, Ralf Baechle wrote:
> On Mon, Nov 25, 2002 at 04:47:33PM +0100, Maciej W. Rozycki wrote:
> 
> > > MIPS64 extends that to also support instruction address matches; the
> > > granularity can be set anywhere from 8 bytes to 4kB; in addition ASID
> > > matching and a global bit can be used for matching.  A MIPS64 CPU can
> > > support anywhere from 0 to 4 such watch registers.
> > 
> >  Actually up to eight -- for all dmfc0/dmtc0 3-bit "sel" values, if I read
> > it correctly.
> 
> Correct but I don't know of any CPU that actually uses more than 4 of the
> possible 8 sets atm.  So we're both right :)
> 
> > > The global bit stuff would only be useful for in-kernel use, I think.  The
> > > ASID thing could be used to implement watchpoints for an entire process, not
> > > just per thread though I doubt there is much use for something like that.
> > 
> >  Well, there are two options only -- either use global matching or ASID
> > matching.  What else would you expect?  Do you mean lazy vs immediate
> > switching? 
> 
> Basically there would be two possibilities, associate the debugging state
> of a process with it's thread_struct or with it's mm_struct.  The latter
> would have a little less impact on the context switching performance,
> the first be a bit more flexible.

Thread_struct, please.  Just because two processes have the same
mm_struct doesn't mean that we want watchpoints to trigger in both of
them, unless specifically requested.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
