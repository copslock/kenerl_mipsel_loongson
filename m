Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA98023 for <linux-archive@neteng.engr.sgi.com>; Sat, 27 Feb 1999 03:30:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA28880
	for linux-list;
	Sat, 27 Feb 1999 03:29:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA12817
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 27 Feb 1999 03:29:41 -0800 (PST)
	mail_from (rjh@pixel.maths.monash.edu.au)
Received: from pixel.maths.monash.edu.au (pixel.maths.monash.edu.au [130.194.160.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA01967
	for <linux@cthulhu.engr.sgi.com>; Sat, 27 Feb 1999 03:29:38 -0800 (PST)
	mail_from (rjh@pixel.maths.monash.edu.au)
Received: (from rjh@localhost)
	by pixel.maths.monash.edu.au (8.8.8/8.8.8-ajr) id WAA18917;
	Sat, 27 Feb 1999 22:29:30 +1100 (EDT)
From: Robin Humble <rjh@pixel.maths.monash.edu.au>
Message-Id: <199902271129.WAA18917@pixel.maths.monash.edu.au>
Subject: Re: new to list - boot problem
To: milos@insync.net
Date: Sat, 27 Feb 1999 22:29:30 +1100 (EDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <36D7D1F6.506C5421@insync.net> from "Miles Lott" at Feb 27, 99 11:07:34 am
X-Mailer: ELM [version 2.4 PL23]
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>the "unable to open initial console" message( read: hang ).

There are a few things that this can be, but the most obvious is to
check that the dev/ directory in the HardHat distribution looks like:

crw-------   1 root     root       4,   0 Sep 14 19:39 console
crw-rw-rw-   1 root     root       1,   3 Sep 14 19:43 null
brw-r-----   1 root     disk       1,   1 Sep 14 19:43 ram
crw-------   1 root     root       4,   0 Sep 14 19:44 systty
crw-------   1 root     root       4,   1 Sep 14 19:44 tty1
crw-------   1 root     root       4,   2 Sep 14 19:44 tty2
crw-------   1 root     root       4,   3 Sep 14 19:44 tty3
crw-------   1 root     root       4,   4 Sep 14 19:44 tty4
crw-------   1 root     root       4,   5 Sep 14 19:44 tty5

If not, then nuke the devices and remake them with mknod, chown, chmod.
Some tar programs (IRIX's in particular) screws these up. You can
re-make these devices under Linux/x86 or IRIX - both work fine. If
re-making from under IRIX then 'disk' gid = 6, and 'root' gid = 0 = sys
under IRIX.

Other possibilities are that you're running on hardware not well
supported by HardHat (new kernels are available) or the nfsroot
procedure isn't working well enough. I'm sure other people will have
other failure modes to tell you as well :)

cheers,
robin
+
He'd found that even the people whose job of work was, so to speak, the
Universe, didn't really believe in it and were actually quite proud of not
knowing what it really was or even if it could theoretically exist.
     Robin Humble     /      http://www.maths.monash.edu.au/~rjh/
