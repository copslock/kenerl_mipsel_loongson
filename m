Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id WAA251926 for <linux-archive@neteng.engr.sgi.com>; Fri, 19 Dec 1997 22:24:55 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA13928 for linux-list; Fri, 19 Dec 1997 22:24:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA13923 for <linux@engr.sgi.com>; Fri, 19 Dec 1997 22:24:04 -0800
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA11066
	for <linux@engr.sgi.com>; Fri, 19 Dec 1997 22:24:03 -0800
	env-from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id WAA13942
	for <linux@engr.sgi.com>; Fri, 19 Dec 1997 22:23:39 -0800 (PST)
Received: from netscape.com ([208.12.32.37]) by dredd.mcom.com
          (Netscape Messaging Server 3.0)  with ESMTP id AAA12930
          for <linux@engr.sgi.com>; Fri, 19 Dec 1997 22:23:39 -0800
Message-ID: <349B6479.81090131@netscape.com>
Date: Sat, 20 Dec 1997 06:23:53 +0000
From: Mike Shaver <shaver@netscape.com>
Organization: Package Reflectors
X-Mailer: Mozilla 4.03 [en] (X11; U; Linux 2.0.31 i686)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: back in the saddle
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Just booted my borrowed Indy to Linux, and then proceeded to destroy its
e2fs partition with some excessive use of Alan's installer.

It looks like it's a viable install setup though, so I'm going to try an
produce a more managable kit tonight:
- minimal root.cpio to boot to (no kernel source, for example, and no
compiler =) )
- rpm.cpio with everything you need to do further installs via
ftp://ftp.linux.sgi.com/pub/mips-linux/RPMS/...
- a handful of ext2tools (mke2fs, e2fsck -- you need to e2fsck at each
step, it seems)

I'll bundle it all up in a nice tarball and stick it on linus for people
to play with.  (There are a bunch of folks here at Netscape who are
interested in playing with it as well.)

Mike

-- 
346388.73 321677.24
