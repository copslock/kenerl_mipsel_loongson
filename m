Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA24268 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Apr 1999 08:08:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA79194
	for linux-list;
	Thu, 15 Apr 1999 08:07:19 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA97835
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Apr 1999 08:07:17 -0700 (PDT)
	mail_from (aj@arthur.rhein-neckar.de)
Received: from news-ma.rhein-neckar.de (news-ma.rhein-neckar.de [193.197.90.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA05296
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Apr 1999 08:07:07 -0700 (PDT)
	mail_from (aj@arthur.rhein-neckar.de)
Received: from arthur.rhein-neckar.de (uucp@localhost)
	by news-ma.rhein-neckar.de (8.8.8/8.8.8) with bsmtp id RAA18225;
	Thu, 15 Apr 1999 17:06:17 +0200 (CEST)
	(envelope-from aj@arthur.rhein-neckar.de)
Received: from aj by arthur.rhein-neckar.de with local (Exim 2.12 #3)
	id 10XnW7-0006jY-00; Thu, 15 Apr 1999 16:53:23 +0200
To: Ulf Carlsson <ulfc@bun.falkenberg.se>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: glibc 2.1
References: <Pine.LNX.3.96.990414213802.29768C-100000@lager.engsoc.carleton.ca> <19990415091041.A3402@ruvild.bun.falkenberg.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Andreas Jaeger <aj@arthur.rhein-neckar.de>
Date: 15 Apr 1999 16:53:21 +0200
In-Reply-To: Ulf Carlsson's message of "Thu, 15 Apr 1999 09:10:41 +0200"
Message-ID: <u84smi7x5q.fsf@arthur.rhein-neckar.de>
User-Agent: Gnus/5.07008 (Pterodactyl Gnus v0.80) XEmacs/21.0(beta66) (20 minutes to Nikko)
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>>>>> Ulf Carlsson writes:

Ulf> Hi Alex,
>> Has anyone started work on glibc 2.1 for mips{eb|el}?  I'd like to start
>> on a port of Red Hat 6.0 ofor mipseb and mipsel.

Ulf> I tried to do this some time ago, but I never finished it. I have heard that
Ulf> Ralf has done some work here, maybe he can share his work with us. I've tried
Ulf> to persuade him to do this before without any success. I'd like to have these
Ulf> patches as well so that I may continue working with the D word. :-)

Ulf> Well, if we can't get these patches I'd like to help you with the porting work
Ulf> for glibc 2.1.

At the end of last year I tried to integrate Ralf's patches into
glibc 2.1.  A number of patches went into the glibc tree but some
problems are still open.  Ralf can certainly better comment this from
the mips side, I'm just a glibc developer without access to any mips
machine who used a cross compiler:
- glibc 2.1 needs symbol versioning but there're no binutils for mips
  that support symbol versioning
- there're some problems with the way glibc handles PIC which leads to 
  problems on mips.
- the system (mips) dependend part of the dynamic linker has to be
  updated.
- some minor discrepancies between the kernel headers in the official
  kernel and the glibc headers.  Ralf and I updated most (all?) but
  somebody should recheck this.

IMO the first two problems to tackle is to get it running at all,
meaning to fix the PIC problems (that's already planned by the glibc
folks for 2.2) and the dynamic linker.  Without symbol versioning you
loose binary compatibility with older and newer versions of glibc.
Therefore the binutils have to be fixed to use glibc 2.1.

Andreas
-- 
 Andreas Jaeger   aj@arthur.rhein-neckar.de    jaeger@informatik.uni-kl.de
  for pgp-key finger ajaeger@aixd1.rhrk.uni-kl.de
