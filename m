Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA02423 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Jun 1998 10:40:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA78587
	for linux-list;
	Fri, 26 Jun 1998 10:40:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA73574
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Jun 1998 10:40:14 -0700 (PDT)
	mail_from (oliver@aec.at)
Received: from aec.at ([195.3.98.5]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA03559
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Jun 1998 10:40:11 -0700 (PDT)
	mail_from (oliver@aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id RAA21781 for <linux@cthulhu.engr.sgi.com>; Fri, 26 Jun 1998 17:58:52 +0200
Date: Fri, 26 Jun 1998 17:58:51 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: linux@cthulhu.engr.sgi.com
Subject: fs full on linus?
Message-ID: <Pine.LNX.3.96.980626175710.17397B-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

hi,

while trying to check out the kernel from linus.linux.sgi.com i got the 
following message:

[oliver@baal sgi]$ cvs -z 9 -d oliver@linus.linux.sgi.com:/src/cvs update linux
Enter passphrase for RSA key 'oliver@zero': 
cvs [server aborted]: cannot open /tmp/cvs-serv13160/linux/drivers/sbus/CVS: No
 space left on device

o.
