Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id VAA29831
	for <pstadt@stud.fh-heilbronn.de>; Thu, 15 Jul 1999 21:11:58 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA5898301; Thu, 15 Jul 1999 12:10:06 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA34443
	for linux-list;
	Thu, 15 Jul 1999 12:07:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA64373
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Jul 1999 12:07:02 -0700 (PDT)
	mail_from (ednes@zaphod.et.tudelft.nl)
Received: from zaphod.et.tudelft.nl (zaphod.et.tudelft.nl [130.161.38.84]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA02055
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jul 1999 12:07:00 -0700 (PDT)
	mail_from (ednes@zaphod.et.tudelft.nl)
Received: (from ednes@localhost)
	by zaphod.et.tudelft.nl (8.8.7/8.8.7) id VAA28323;
	Thu, 15 Jul 1999 21:06:59 +0200
Message-Id: <199907151906.VAA28323@zaphod.et.tudelft.nl>
Subject: updating 5.1 distro
To: linux@cthulhu.engr.sgi.com
Date: Thu, 15 Jul 1999 21:06:58 +0200 (CEST)
Cc: E.Hakkennes@et.tudelft.nl (Edwin Hakkennes)
From: Edwin Hakkennes <E.Hakkennes@et.tudelft.nl>
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

We are planning to use an old Indy with 9G of disk as an
ftp-mirror-site. As this will obviously attract hackers, our sys-admin
really wants to bring the machine in an up-to-date security state
before widely announing it. Right now it has RedHat 5.1 installed,
without any security updates. This seems to run fine.

I've seen some effort to produce redhat5.2 RPMS and even a message
about getting glibc2.1 to work on mipseb, but nothing further.

My (next) questions are:

1) Is there already someone building/maintaining a 5.2 or 6.0 distro?

2) Would supplying the right packages/hdlist to the 5.1 installer work?

3) Are the diffs needed to build the 5.1 distro backported in RedHat 6.0?
   (if not, are these stored somewhere?)

I'm running rpm --rebuild *redhat6.0.src.rpm right now. At least
glibc2.1 is giving errors, I'll see about some more tomorrow morning.

Thanks for any answers and 
Greetings,

Edwin Hakkennes

   
