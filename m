Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 15:28:54 +0200 (CEST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:11633 "EHLO
	t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S1123891AbSJQN2y>; Thu, 17 Oct 2002 15:28:54 +0200
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id QAA07029;
	Thu, 17 Oct 2002 16:28:45 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id QAA00434; Thu, 17 Oct 2002 16:48:40 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34])
	by niisi.msk.ru (8.12.5/8.12.5) with ESMTP id g9HDPhpa013526;
	Thu, 17 Oct 2002 17:25:43 +0400 (MSK)
Message-ID: <3DAEBBD3.333275FC@niisi.msk.ru>
Date: Thu, 17 Oct 2002 17:32:03 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Johannes Stezenbach <js@convergence.de>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
References: <3DAE872E.D5EF0E4D@niisi.msk.ru> <Pine.GSO.3.96.1021017135738.24495B-100000@delta.ds2.pg.gda.pl> <20021017131115.GA1689@convergence.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Johannes Stezenbach wrote:
> 
> On Thu, Oct 17, 2002 at 02:02:35PM +0200, Maciej W. Rozycki wrote:
> > On Thu, 17 Oct 2002, Gleb O. Raiko wrote:
> >
> > > Implement new sysmips then.
> >
> >  I'm not sure if that's a good idea.  Glibc alone uses test_and_set(),
> > exchange_and_add(), atomic_add() and compare_and_swap().  Do you want a
> > separate syscall for each of these functions?  I think the ll/sc emulation
> > may be the best solution after all.  At least it's most flexible and not
> > much slower if at all.
> 
> Depends on your usage pattern. E.g. we don't run software that uses
> atomicity.h (i.e. no C++ code), but heavily use pthread_mutex_lock() etc.
> The few uses of atomicity.h internal to glibc don't warrant
> any optimizations. So, if the beql-Method would not exist, I would
> consider implementing a new sysmips for compare_and_swap().

I didn't look at newer glibc sources (read: greater than 2.0.6), so the
question. Why  is the difference between compare_and_swap and
test_and_set so huge that it eats an exception penalty? ;-)

Regards,
Gleb.
