Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA57213 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Apr 1999 11:23:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA00948
	for linux-list;
	Tue, 13 Apr 1999 11:22:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA11210
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 13 Apr 1999 11:22:16 -0700 (PDT)
	mail_from (tnik@hol.gr)
Received: from mail.hol.gr (mail.hol.gr [194.30.192.21]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id LAA02539
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Apr 1999 11:22:14 -0700 (PDT)
	mail_from (tnik@hol.gr)
Received: (qmail 1094 invoked from network); 13 Apr 1999 18:21:53 -0000
Received: from vdp032.ath01.cas.hol.gr (HELO hol.gr) (firewall-user@195.97.0.32)
  by mail.hol.gr with SMTP; 13 Apr 1999 18:21:53 -0000
Message-ID: <3713A71F.D5C11A7E@hol.gr>
Date: Tue, 13 Apr 1999 23:20:48 +0300
From: Theodoros Nikitopoulos <tnik@hol.gr>
X-Mailer: Mozilla 4.05 [en] (X11; I; Linux 2.1.24 ppc)
MIME-Version: 1.0
To: Ulf Carlsson <ulfc@bun.falkenberg.se>
CC: linux@cthulhu.engr.sgi.com
Subject: Resources in X11 port #2
References: <199904130857.OAA23664@bhairavi.newdelhi.sgi.com> <19990413122357.A16312@ruvild.bun.falkenberg.se> <371371D7.A8187D38@hol.gr> <19990413192157.A25858@bun.falkenberg.se>
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

It seems I should make more clear some things concerning the page.
First of all, it doesn't reflect the way the port will be done..  This
will be decided by the developers (Ulf Carlsson and whoever else..)
I would be very glad if I could help too, but for the time being it's not
possible. The scope of the page is mainly to provide some resources
I've found and thought they could help :-)

About why recommending starting with a 6.3 tree and patching up to
XFree86 3.3.3 well it's a personal taste of how I would probably work
on it. Why someone should worry with the differences of his docume-
ntation and his actual sources?  Just make the port and then add the
patches. Anyways, the above seems to me a minor issue. The problem
exists in porting the device-dependent parts.

By the way, I haven't found any ASCII version of the documentation, but
in case anyone is interested there exists a converter utility pstotext,
available at:

  http://www.research.digital.com/SRC/virtualpaper/pstotext.html

However, the output of it might be vague.


Regards,
Theodore.
