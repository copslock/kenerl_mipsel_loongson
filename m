Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA06551 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Apr 1999 14:19:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA98561
	for linux-list;
	Thu, 22 Apr 1999 14:15:27 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA89709
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Apr 1999 14:15:25 -0700 (PDT)
	mail_from (kuhns@abbatech.com)
Received: from abbasvr1.abbatech.com (www.abbatech.com [38.184.81.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA07489
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Apr 1999 17:15:23 -0400 (EDT)
	mail_from (kuhns@abbatech.com)
Received: from abbasvr1.abbatech.com ([38.184.81.2])
          by abbasvr1.abbatech.com (Netscape Messaging Server 3.01)
           with SMTP id AAA6394 for <linux@cthulhu.engr.sgi.com>;
          Thu, 22 Apr 1999 15:08:12 -0500
Message-ID: <371F81AC.3F54@abbatech.com>
Date: Thu, 22 Apr 1999 15:08:12 -0500
From: Victor Kuhns <kuhns@abbatech.com>
Organization: Abba Technologies
X-Mailer: Mozilla 3.01SGoldC-SGI (X11; I; IRIX64 6.4 IP27)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: 320 Linux problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Group,

I dont think I've seen many people write questions about the 320 here? 
How many people have one?

I have red hat loaded up on a second disk, followed the instructions,
got the newest and greatest kernal, but cant get the system completely
up and running.  When prom loads up ext2load.exe on my floppy disk, it
sees the kernal on the Hard drive, starts to load up but stops right
after the parition check line and says:

VFS: Cannot open root device 9a:e6
Kernal panic: VFS: Unable to mount root fs on 9a:e6
USB-HUBM: Ran out of hub queuing slots [with 5]
USB-HUBM: Ran out of hub queuing slots [with 5]
USB-HUBM: Ran out of hub queuing slots [with 5]
USB-HUBM: Ran out of hub queuing slots [with 5]
USB-HUBM: Ran out of hub queuing slots [with 5]


What did I do wrong?  If I put the disk back in my ol pc it gets a
"Unable to mount root on fs..." error too.  It worked before, so I dont
understand what happened.

Can anybody help out?

Regards,
Victor
