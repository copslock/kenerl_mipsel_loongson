Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA96223 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Apr 1999 21:21:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA04172
	for linux-list;
	Wed, 14 Apr 1999 21:20:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA20627
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Apr 1999 21:20:07 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (pr250.pheasantrun.net [208.140.225.250]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA00244
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Apr 1999 21:20:06 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (clepple@sprocket.foo.tho.org [206.223.45.3])
	by foo.tho.org (8.8.7/8.8.7) with ESMTP id AAA11388
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Apr 1999 00:20:05 -0400
Message-ID: <371568F3.FA1E916A@foo.tho.org>
Date: Thu, 15 Apr 1999 04:20:04 +0000
From: Charles Lepple <clepple@foo.tho.org>
X-Mailer: Mozilla 4.5 [en] (X11; U; Linux 2.0.36 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: kernel compilation problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

While configuring the kernel (2.2.5 from ftp.kernel.org), I get the
following message:

 Sound card support (CONFIG_SOUND) [N/y/m/?]
>scripts/Configure: drivers/sgi/char/Config.in: No such file or
directory
 *
 * Kernel hacking

Then, while executing 'make dep', I see a bunch of messages about
'SOCK_DGRAM' being redefined.

And when I try 'make zImage', it bombs compiling init/main.c -- there's
a "parse error" in linux/sched.h, and lots of stuff breaks. I have the
compile log if anyone can decipher it, but is this just a simple case of
me overlooking a patch? Or where can I find a preconfigured kernel
source tree?

Thanks in advance,

--
Charles Lepple
System Administrator, Virginia Tech EE Workstation Labs
clepple@ee.vt.edu || http://www.foo.tho.org/charles/
