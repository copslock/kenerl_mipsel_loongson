Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 16:13:24 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:21508 "EHLO
	hell") by linux-mips.org with ESMTP id <S1123891AbSJQONY>;
	Thu, 17 Oct 2002 16:13:24 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 182BOY-0000Xj-00; Thu, 17 Oct 2002 16:13:02 +0200
Date: Thu, 17 Oct 2002 16:13:02 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021017141302.GA2039@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Gleb O. Raiko" <raiko@niisi.msk.ru>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <3DAE872E.D5EF0E4D@niisi.msk.ru> <Pine.GSO.3.96.1021017135738.24495B-100000@delta.ds2.pg.gda.pl> <20021017131115.GA1689@convergence.de> <3DAEBBD3.333275FC@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAEBBD3.333275FC@niisi.msk.ru>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Thu, Oct 17, 2002 at 05:32:03PM +0400, Gleb O. Raiko wrote:
> Johannes Stezenbach wrote:
> > 
> > On Thu, Oct 17, 2002 at 02:02:35PM +0200, Maciej W. Rozycki wrote:
> > > On Thu, 17 Oct 2002, Gleb O. Raiko wrote:
> > >
> > > > Implement new sysmips then.
> > >
> > >  I'm not sure if that's a good idea.  Glibc alone uses test_and_set(),
> > > exchange_and_add(), atomic_add() and compare_and_swap().  Do you want a
> > > separate syscall for each of these functions?  I think the ll/sc emulation
> > > may be the best solution after all.  At least it's most flexible and not
> > > much slower if at all.
> > 
> > Depends on your usage pattern. E.g. we don't run software that uses
> > atomicity.h (i.e. no C++ code), but heavily use pthread_mutex_lock() etc.
> > The few uses of atomicity.h internal to glibc don't warrant
> > any optimizations. So, if the beql-Method would not exist, I would
> > consider implementing a new sysmips for compare_and_swap().
> 
> I didn't look at newer glibc sources (read: greater than 2.0.6), so the
> question. Why  is the difference between compare_and_swap and
> test_and_set so huge that it eats an exception penalty? ;-)

It is not. I wrote:
  ... But with LL/SC glibc can use compare-and-swap
  which enables a more efficient linux-threads mutex implementation.

This is what makes the difference, at least for glibc-2.2.5. Just
grep for HAS_COMPARE_AND_SWAP in your linuxthreads sources.

Current glibc from CVS (both HEAD an 2.2 branch) doesn't use sysmips
anymore, they rely on LL/SC (emulated or not).


Regards,
Johannes
