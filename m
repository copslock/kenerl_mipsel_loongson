Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA16932 for <linux-archive@neteng.engr.sgi.com>; Mon, 28 Sep 1998 17:24:21 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA26474
	for linux-list;
	Mon, 28 Sep 1998 17:23:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA98189
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 28 Sep 1998 17:23:36 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id RAA03322
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Sep 1998 17:23:34 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 27414 invoked from network); 29 Sep 1998 00:23:29 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 29 Sep 1998 00:23:29 -0000
Received: by BART with Internet Mail Service (5.5.1960.3)
	id <SZCQPY5M>; Mon, 28 Sep 1998 20:26:59 -0400
Message-ID: <60222E63C9F4D011915F00A02435011C27B96E@BART>
From: Mike Hill <mikehill@hgeng.com>
To: linux@cthulhu.engr.sgi.com
Subject: Still Installing
Date: Mon, 28 Sep 1998 20:26:58 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.1960.3)
Content-Type: text/plain
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Many thanks to Alex deVries for the on-site service call and the loan of
his hard drive to prove that SGI/Linux will boot on my hardware
(R4600PC, 32 M RAM, 8-bit graphics).  It was quite a thrill to see the
login prompt for the first time.  At the same time Alex was treated
first hand to some bizarre SGI/Linux behaviour that he's only been able
to read about until now.

Installer notes:  I was getting stuck at the point where the root drive
is mounted, with the message "Fatal error opening RPM database" and
signal 11.  Instead of partitioning the drive with fx or from within the
installer, I reran the Linux-installer 0.2 procedure.  After that, the
Hard Hat installer continued into the package installation.  Many
packages (including bash) failed to install with the "script execution
failure" message.  This was also reported by Alexander Ehlert.  The
installer finished and I had a login prompt, but I couldn't log in.
I'll download the testinstall-tree and continue with Alexander's
strategy.

Kernel notes:  I also get the truncated screen reported by Jan Chadima
(and Leon Verrall?); it seems like at least ten lines scrolling out of
view.  When I can compile a kernel I'll try reducing the screen size in
bootinfo.h.

First with the 2.1.116 kernel binary and now with 2.1.121 (thanks
Thomas), I get some streaky turquoise bands across the screen which
obscure the text that scrolls by behind them.  I couldn't reproduce this
for Alex using the installer kernel.

Mike
