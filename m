Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA16147
	for <pstadt@stud.fh-heilbronn.de>; Sun, 22 Aug 1999 23:13:55 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA04849; Sun, 22 Aug 1999 14:04:04 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA24693
	for linux-list;
	Sun, 22 Aug 1999 13:57:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA53013
	for <linux@engr.sgi.com>;
	Sun, 22 Aug 1999 13:57:22 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03999
	for <linux@engr.sgi.com>; Sun, 22 Aug 1999 13:50:11 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id WAA26472
	for <linux@engr.sgi.com>; Sun, 22 Aug 1999 22:50:06 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id OAA15714;
	Sun, 22 Aug 1999 14:15:04 +0200
Date: Sun, 22 Aug 1999 14:15:04 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: MIPS64
Message-ID: <19990822141504.A15701@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

as those who are tracking the CVS archive or the commit mailing list
probably already have seen I've got started to work on a 64-bit kernel.
I'm also using the chance to do a major overhaul of various code which
over the years had turned into a major uglyness.

In particular the machine abstraction layer needs some overhaul.
Basically the attempt of doing generic kernels for MIPS is dead by now.
Given the number of different firmware implementations and memory layouts
makes it impossible to build a single generic kernel image that fits
more than a few machines.  In fact so far the only combo that was working
at all was Magnum 4000 / PICA / RM200C.  So I'm wiping out all that code
which makes things look significantly nicer.

As of now the MIPS64 code is still in it's very early stages; it doesn't
even compile.  However I'd like to invite other people to alreasy start
working on porting the machine specific bits to MIPS64.  I myself will
initially only implement support for the SGI IP22.  When this one is
running flawless I'll go on with IP27 and SMP support.

Even though I've invested a horrible amount of time int tracking down
the bugs in current binutils they're still in a rather sad state for
64-bit stuff.  Volunteers _urgently_ wanted.  Note that these problems
will also affect other operating system, so it doesn't necessarily have
to be a Linux volunteer.

Cheers,

  Ralf
