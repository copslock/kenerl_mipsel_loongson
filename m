Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA84785 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 20:28:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA87949
	for linux-list;
	Fri, 17 Jul 1998 20:27:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA22285
	for <linux@engr.sgi.com>;
	Fri, 17 Jul 1998 20:27:47 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA28213
	for <linux@engr.sgi.com>; Fri, 17 Jul 1998 20:27:45 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-04.uni-koblenz.de [141.26.249.4])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA22592
	for <linux@engr.sgi.com>; Sat, 18 Jul 1998 05:27:27 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id FAA02186;
	Sat, 18 Jul 1998 05:27:22 +0200
Message-ID: <19980718052722.H378@uni-koblenz.de>
Date: Sat, 18 Jul 1998 05:27:22 +0200
To: linux@cthulhu.engr.sgi.com
Subject: [lm@bitmover.com: Linux performance vs IRIX performance]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I forward this for all people who don't read linux-kernel and love the
again and again reapearing comparisons between Linux and IRIX ...

  Ralf

----- Forwarded message from Larry McVoy <lm@bitmover.com> -----

Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: from lappi (ralf@localhost [127.0.0.1])
	by uni-koblenz.de (8.8.7/8.8.7) with ESMTP id CAA01329
	for <ralf@localhost>; Sat, 18 Jul 1998 02:34:48 +0200
Received: from mailhost.uni-koblenz.de
	by lappi (fetchmail-4.3.2 IMAP run by ralf)
	for <ralf@localhost> (single-drop); Sat Jul 18 02:34:48 1998
Received: from ferret.lmh.ox.ac.uk (qmailr@ferret.lmh.ox.ac.uk [163.1.138.204])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id AAA21036
	for <ralf@uni-koblenz.de>; Sat, 18 Jul 1998 00:03:12 +0200 (MEST)
Received: (qmail 21935 invoked from network); 17 Jul 1998 22:02:41 -0000
Received: from vger.rutgers.edu (root@128.6.190.2)
  by ferret.lmh.ox.ac.uk with SMTP; 17 Jul 1998 22:02:41 -0000
Received: by vger.rutgers.edu id <971340-21206>; Fri, 17 Jul 1998 14:29:36 -0400
Received: from [207.181.251.162] ([207.181.251.162]:9430 "EHLO bitmover.com" ident: "root") by vger.rutgers.edu with ESMTP id <971531-21206>; Fri, 17 Jul 1998 13:21:32 -0400
Received: from bitmover.com (lm@work.bitmover.com [10.3.9.4])
	by bitmover.com (8.8.7/8.8.7) with ESMTP id LAA05852
	for <linux-kernel@vger.rutgers.edu>; Fri, 17 Jul 1998 11:40:23 -0700
Message-Id: <199807171840.LAA05852@bitmover.com>
To: linux-kernel@vger.rutgers.edu
Subject: Linux performance vs IRIX performance
From: lm@bitmover.com (Larry McVoy)
Date: 	Fri, 17 Jul 1998 11:40:23 -0600
X-Orcpt: rfc822;linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu
Precedence: bulk
X-Loop: majordomo@vger.rutgers.edu
Content-Length: 1883
Lines: 45

Hi folks,
	I thought you'd like this.  I have a regression test (1700 line
shell script) for a source code control system I'm building.  When I run
that test on an AMDK6@300 + 1MB L2$ + 100Mhz bus + SDRAM, it takes

	2.82user 3.40system 0:06.37elapsed

When I run the same thing on a SGI MP system, with 195Mhz R10K's + 4MB of
L2$, I get 

	1.357user 10.379sys 13.284elapsed

The interesting thing is that the user code ran almost twice as fast on
the SGI processor (not bad for a processer at 2/3 the Mhz).  That's the
good part.  The bad part is that SGI OS spent 3 times as long doing
exactly the same work.  The work is creating and deleting a bunch of
files, with some small amount of processing on the files.

So what does this mean?  What it means is that Linus' focus on latency,
while it seems pedantic at times to argue about one more cache miss or
one more function call in the code path, actually pays off in a big way.
If that SGI box were running Linux and we could assume the same ratios,
then the numbers should be about

	1.3user 1.6sys 3.0elapsed

A factor of 4.4 difference.  It's not fair to actually expect that good of
a result - the SGI OS is an SMP OS that scales up to approximately 128 
processors, has all sorts of useful and not so useful features that Linux
doesn't have, etc, etc.  None the less, it is likely that Linux on the same
hardware would be about 3 times faster than IRIX.  

I think that is pretty cool and that maybe you wanted to know that the
philosophy actually works and works well.  Kudos to Linus & team for
all the great work.

--lm

P.S.  The Linux was 2.0.34 - there are some changes in 2.1 that should make
this even better...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html

----- End forwarded message -----
