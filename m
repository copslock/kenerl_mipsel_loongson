Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA158739; Wed, 20 Aug 1997 18:13:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA23349 for linux-list; Wed, 20 Aug 1997 18:13:21 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA23344 for <linux@cthulhu.engr.sgi.com>; Wed, 20 Aug 1997 18:13:18 -0700
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA29470
	for <linux@cthulhu.engr.sgi.com>; Wed, 20 Aug 1997 18:13:16 -0700
	env-from (oliver@aec.at)
Received: (from oliver@localhost) by aec.at (8.8.3/8.7) id DAA12024; Thu, 21 Aug 1997 03:13:09 +0200
Date: Thu, 21 Aug 1997 03:13:07 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: linux@cthulhu.engr.sgi.com
Subject: "unable to handle kernel paging request" at boot
Message-ID: <Pine.LNX.3.91.970821030958.11978A-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

hi,

after i was finally able to free and Indy from useless tasks like DNS, mail, www
:) i have now problems booting the machine.
after/at start of the Ethernet driver i get the following message:

eth0 SGI Seeq ....
Unable to handle kernel paging request at 00000008, epc: 880d8a64

what's going wrong ?

oliver
