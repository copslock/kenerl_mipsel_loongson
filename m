Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA41109 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 10:41:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA76908
	for linux-list;
	Fri, 17 Jul 1998 10:41:19 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA10978
	for <linux@engr.sgi.com>;
	Fri, 17 Jul 1998 10:41:17 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA13712
	for <linux@engr.sgi.com>; Fri, 17 Jul 1998 10:40:48 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id TAA29492
	for <linux@engr.sgi.com>; Fri, 17 Jul 1998 19:40:43 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA01849; Fri, 17 Jul 1998 19:40:42 +0200
Message-ID: <19980717194042.18202@uni-koblenz.de>
Date: Fri, 17 Jul 1998 19:40:42 +0200
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com
Subject: Pthreads
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

for all those who don't get the CVS commit logs - I've fixed the problem
in the libc wrapper for the clone system call; kernel threads seem now
to be running almot perfect.

The only nit which I still observe is that for newly created threads the
stacks will be allocated from KSEG0 on downward.  When creating many
threads somewhen the address space for the stacks will collide with the
address space where libraries etc. are mmap(2)ed, resulting in a SIGSEGV.

This never seems to happen on Intel because there we have one 1gb more
of address space, so the process table will usually be filled (by default
1024 entries) before this collission happens.  Looks like a buglet in
pthreads which doesn't seem to be very critical for now, but which wants
to be researched.

There are some more libc things to be done and I'll provide an updated
libc asap.

  Ralf
