Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA22667 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 12:12:21 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA10166
	for linux-list;
	Thu, 16 Jul 1998 12:11:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA21467
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 12:11:33 -0700 (PDT)
	mail_from (tomilepp@ousrvr2.oulu.fi)
Received: from ousrvr2.oulu.fi (ousrvr2.oulu.fi [130.231.240.7]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA05625
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 12:11:31 -0700 (PDT)
	mail_from (tomilepp@ousrvr2.oulu.fi)
Received: (from tomilepp@localhost)
	by ousrvr2.oulu.fi (8.8.5/8.8.5) id WAA29531
	for linux@cthulhu.engr.sgi.com; Thu, 16 Jul 1998 22:11:27 +0300 (EET DST)
From: Tomi Leppikangas <tomilepp@ousrvr2.oulu.fi>
Message-Id: <199807161911.WAA29531@ousrvr2.oulu.fi>
Subject: hardred install
To: linux@cthulhu.engr.sgi.com
Date: Thu, 16 Jul 1998 22:11:27 +0300 (EET DST)
Reply-To: Tomi.Leppikangas@oulu.fi
X-Mailer: ELM [version 2.4ME+ PL15 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

Fine work, i now get that installed without warnings of
anykind, last time i had problems with swap.

Actually i booted and installed with older kernel, becouse i was lazy to
setup bootp server, so i copied kernel to sgi-partition and booted with
vmlinux nfsaddrds=ip:server_ip
that doesnt work with new kernel, it got stuck when waiting
for bootp reply.

Now just waiting for x-server :)

-- 
##        Tomi.Leppikangas@oulu.fi         ##
##  http://www.student.oulu.fi/~tomilepp/  ##
