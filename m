Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 15:11:55 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:10244 "EHLO
	hell") by linux-mips.org with ESMTP id <S1123891AbSJQNLy>;
	Thu, 17 Oct 2002 15:11:54 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 182AQl-0000SZ-00; Thu, 17 Oct 2002 15:11:15 +0200
Date: Thu, 17 Oct 2002 15:11:15 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021017131115.GA1689@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Gleb O. Raiko" <raiko@niisi.msk.ru>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <3DAE872E.D5EF0E4D@niisi.msk.ru> <Pine.GSO.3.96.1021017135738.24495B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021017135738.24495B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Thu, Oct 17, 2002 at 02:02:35PM +0200, Maciej W. Rozycki wrote:
> On Thu, 17 Oct 2002, Gleb O. Raiko wrote:
> 
> > Implement new sysmips then.
> 
>  I'm not sure if that's a good idea.  Glibc alone uses test_and_set(),
> exchange_and_add(), atomic_add() and compare_and_swap().  Do you want a
> separate syscall for each of these functions?  I think the ll/sc emulation
> may be the best solution after all.  At least it's most flexible and not
> much slower if at all.

Depends on your usage pattern. E.g. we don't run software that uses
atomicity.h (i.e. no C++ code), but heavily use pthread_mutex_lock() etc.
The few uses of atomicity.h internal to glibc don't warrant
any optimizations. So, if the beql-Method would not exist, I would
consider implementing a new sysmips for compare_and_swap().


Regards,
Johannes
