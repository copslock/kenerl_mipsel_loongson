Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA29587 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Jun 1999 12:28:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA23968
	for linux-list;
	Thu, 24 Jun 1999 12:24:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA88956
	for <linux@engr.sgi.com>;
	Thu, 24 Jun 1999 12:24:56 -0700 (PDT)
	mail_from (crakrjak@xerxesinc.com)
Received: from mail.xerxes.com ([205.152.148.197]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08492
	for <linux@engr.sgi.com>; Thu, 24 Jun 1999 12:24:54 -0700 (PDT)
	mail_from (crakrjak@xerxesinc.com)
Received: from localhost (crakrjak@localhost)
	by mail.xerxes.com (8.8.8/8.8.7) with SMTP id OAA06620
	for <linux@engr.sgi.com>; Wed, 23 Jun 1999 14:41:31 -0400
Date: Wed, 23 Jun 1999 14:41:31 -0400 (EDT)
From: Michel Chamberland <crakrjak@xerxes.com>
To: linux@cthulhu.engr.sgi.com
Subject: XZ graphic card problems
Message-ID: <Pine.LNX.3.96.990623143755.6607A-100000@mail.xerxesinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi I was just having problems getting linux to boot on an Indy with a XZ
graphic card. I slaped a 8 bit Indy in and now it works great, got qmail
and named running, now the server is ready for real work.. When it'd boot
linux via bootp it would download the kernel via tftpd and then when it
would start loading the kernel it would print the letter 'n' then crash,
couldnt even move the mouse... unpluging the indy was the only way to
reboot. If anybody has any theories on what the problem could be please
let me know.

Mike
mike@xerxes.com
