Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA18458; Sat, 12 Apr 1997 08:37:50 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA17868 for linux-list; Sat, 12 Apr 1997 08:36:14 -0700
Received: from heaven.newport.sgi.com (heaven.newport.sgi.com [169.238.102.134]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA17863 for <linux@engr.sgi.com>; Sat, 12 Apr 1997 08:36:11 -0700
Received: by heaven.newport.sgi.com (940816.SGI.8.6.9/940406.SGI)
	for linux@engr id IAA11066; Sat, 12 Apr 1997 08:36:11 -0700
From: "Christopher W. Carlson" <carlson@heaven.newport.sgi.com>
Message-Id: <9704120836.ZM11064@heaven.newport.sgi.com>
Date: Sat, 12 Apr 1997 08:36:11 -0700
X-Mailer: Z-Mail-SGI (3.2S.2 10apr95 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: EFS and XFS file systems support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I understand that the EFS and XFS file systems are proprietary to
SGI.  I don't really understand why SGI would care if the EFS file
system were divulged but I can understand the XFS file system.

What I wanted to suggest is that SGI provide a library (.a file) that
can be linked with Linux to provide EFS and XFS file support.  If
necessary, we could charge some nominal fee and require some kind of
non-disclosure or promise that the objects won't be reverse engineered
or something.

As a minimum, provide these drivers only to employees.  It would sure
make development easier if we could mount SGI file systems.  My
biggest reason for wanting them supported is to access SGI CD ROMs.

Anyway, just thought I'd add my $.02.

-- 

		Chris Carlson

	+------------------------------------------------------+
	| Also, carlson@sgi.com                                |
	|   Work:       (714) 756-5976     SGI vmail: 678-4530 |
	|   FAX:        (714) 833-9503                         |
	|                                                      |
	| Trivia fact: an electroencephalogram shows that a    |
	| human brain and a bowl of quivering lime Jell-O have |
	| the same waves.  [Time Magazine, Mar 17, 1997]       |
	+------------------------------------------------------+
