Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA43582 for <linux-archive@neteng.engr.sgi.com>; Sat, 29 May 1999 16:42:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA34620
	for linux-list;
	Sat, 29 May 1999 16:41:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA90150
	for <linux@engr.sgi.com>;
	Sat, 29 May 1999 16:41:19 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA02272
	for <linux@engr.sgi.com>; Sat, 29 May 1999 16:41:18 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-23.uni-koblenz.de [141.26.131.23])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA20787
	for <linux@engr.sgi.com>; Sun, 30 May 1999 01:41:15 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.8.7) id QAA01533;
	Sat, 29 May 1999 16:51:47 +0200
Date: Sat, 29 May 1999 16:51:47 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Vladimir A. Roganov" <roganov@niisi.msk.ru>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Platform-independent hack in ptrace.c
Message-ID: <19990529165147.B1517@uni-koblenz.de>
References: <374D37E6.59A6A9F3@niisi.msk.ru> <19990527212654.A4058@uni-koblenz.de> <374E5FB1.D3860089@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <374E5FB1.D3860089@niisi.msk.ru>; from Vladimir A. Roganov on Fri, May 28, 1999 at 01:19:45PM +0400
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, May 28, 1999 at 01:19:45PM +0400, Vladimir A. Roganov wrote:

> We implemented it by very interesting reason: old Baget uses special
> VIC register which exists on bus only (!!!) when interrupt is active.
> But interrupt can be deactivated by external reason. In such case
> IRQ handler catch SIGBUS, what crashes current process.
> 
> It was overwritten twice, and it looks debugged hardly :-)
> May be it can help here.
> 
> > The other bug is that memory accesses via ptrace for virtual addresses
> > which are uncached would be executed cached, trouble ahead.
> 
> YES, we obtained such effect.
> To avoid it we just moved to physical address space (high bits are ignored),
> but it is not good in general.
> 
> > Further complexity is added by handling write buffers for the R3000 and
> > virtual coherency for R4000.
>
> Yes, it should be tried to be fixed once for every arch.

That means we need something like read_phys() and write_phys() for all
CPU variants, even board variations.  The functions needs to get passed
an virtual address as well such that it can deal with virtual coherency
on R4000.

Then again R10k does this in hardware, so why bother ;-)

  Ralf
