Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA01218 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 18:55:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA62875
	for linux-list;
	Wed, 17 Jun 1998 18:55:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA79234
	for <linux@engr.sgi.com>;
	Wed, 17 Jun 1998 18:55:03 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id SAA08914
	for <linux@engr.sgi.com>; Wed, 17 Jun 1998 18:55:00 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA14176
	for <linux@engr.sgi.com>; Thu, 18 Jun 1998 03:54:58 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id DAA00762;
	Thu, 18 Jun 1998 03:54:29 +0200
Message-ID: <19980618035423.A517@uni-koblenz.de>
Date: Thu, 18 Jun 1998 03:54:23 +0200
To: "Stuart Herbert, GNQS Maintainer" <stuart@gnqs.org>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Linux/SGI and processor sets
References: <000901bd9a2a$21972760$020110ac@myrddraal.octopus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <000901bd9a2a$21972760$020110ac@myrddraal.octopus.com>; from Stuart Herbert, GNQS Maintainer on Wed, Jun 17, 1998 at 08:57:17PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jun 17, 1998 at 08:57:17PM +0100, Stuart Herbert, GNQS Maintainer wrote:

> I've joined the Linux/SGI mailing list looking for (at first)
> information about a specific feature-set ... my apologies if I've come
> to the wrong place.

This is definately the right place.

> IRIX 5.x, and IRIX 6.0-6.3 provides support for 'processor sets'
> through the sysmp(2) system call, and the pset(1) binary.  This
> particular feature-set is popular amongst users of Generic NQS, a
> batch processing system I maintain.
> 
> It's so popular, in fact, that there's been a lot of interest amongst
> my users in adding this feature-set to Linux.  It occurred to me that
> the Linux/SGI port *might* include adding this support to Linux.
> 
> Is sysmp(2) and pset(1) on your TODO list?

We only support the uninteresting sysmp(2) operations MP_PGSIZE,
MP_NPROCS and MP_NAPROCS as part of the IRIX binary compatibility.

> If not, then I wrote a (crude - I'm not much of a kernel hacker) patch
> which implemented all the pset stuff for sysmp(2), and a basic pset(1)
> binary which may be of interest.  The patch is against an old 2.0
> kernel, and needs a small fix to actually work (I don't actually have
> a SMP box of my own).

We don't yet support SMP - nobody has so far provided a SMP machine to
me plus the hardware documentation.  However I think you might also
consult about sysmp(2) and pset(1) with the people from
linux-smp@vger.rutgers.edu, the stuff is definately of interest to the
users of Alpha, i386 and Sparc systems on which SMP is supported.

Linux/MIPS is so far not yet a very widespread OS, but if you nevertheless
wish to port your code to Linux/MIPS, then I as one of the core
developers would like to offer you my support.  I'd also like to point
out that Linux/MIPS as far as technically possible is binary compatible
beyond the machines of just one manufacturer.

  Ralf
