Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA01761; Wed, 14 Aug 1996 15:58:52 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA03869 for linux-list; Wed, 14 Aug 1996 22:58:41 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA03860 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Aug 1996 15:58:39 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA01744; Wed, 14 Aug 1996 15:58:39 -0700
Date: Wed, 14 Aug 1996 15:58:39 -0700
Message-Id: <199608142258.PAA01744@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: bug in IRIX tftpd?
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Wonder if someone can help me fix this problem:

Seems that the IRIX tftpd daemon will not respond correctly to
requests in binary more. I can reproduce the problem at will and it
happens every time.

I can do the transfer just fine using ascii mode, but any attempt to
use binary mode fails.  What is funny is that TFTPD places a syslog
entry that says:

Aug 14 15:57:13 6D:tanya tftpd[1373]: sandra.engr.sgi.com: read request for /tftpboot/96A64B0F.SUN4C: success

Yet tftpd does not send one packet back.  It does not matter what
machine I try to do this tftp transfer from.  ASCII mode always works,
binary mode always fails.

dm@engr.sgi.com

'Ooohh.. "FreeBSD is faster over loopback, when compared to
Linux over the wire". Film at 11.' -Linus
