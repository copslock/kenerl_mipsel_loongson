Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA16669 for <linux-archive@neteng.engr.sgi.com>; Wed, 26 May 1999 12:08:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA11306
	for linux-list;
	Wed, 26 May 1999 12:06:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA70490
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 26 May 1999 12:06:42 -0700 (PDT)
	mail_from (rck@corp.home.net)
Received: from poptart.corp.home.net (poptart.svr.home.net [24.0.26.24]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA04201
	for <linux@cthulhu.engr.sgi.com>; Wed, 26 May 1999 12:06:41 -0700 (PDT)
	mail_from (rck@corp.home.net)
Received: from rck-lap (nt-dhcp198.media.home.net [24.0.22.198])
          by poptart.corp.home.net (Netscape Messaging Server 3.54)
           with SMTP id AAA3303 for <linux@cthulhu.engr.sgi.com>;
          Wed, 26 May 1999 12:06:38 -0700
Message-Id: <4.1.19990526115716.03f65930@mail>
X-Sender: rck@mail
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1 
Date: Wed, 26 May 1999 12:05:33 -0700
To: linux@cthulhu.engr.sgi.com
From: "Robert Keller" <rck@corp.home.net>
Subject: after the kernel seems to live
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


It looks like I've finally been able to get the 2.2.1 kernel booting
and trying to access its root filesystem over NFS on an NEC
DDB-VRC5074 development board.  I'm at the point where the
kernel is trying to run /sbin/init and things die because of illegal
instructions in init (I'm using the little endian mips root from
linux.sgi.com)

Where do I get the code for init, ld.so and all those vital root 
filesystem friends so that I can be sure that they are compiled
the way I want them?

...robert
