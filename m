Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA68080 for <linux-archive@neteng.engr.sgi.com>; Tue, 14 Jul 1998 16:39:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA28155
	for linux-list;
	Tue, 14 Jul 1998 16:38:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA87651
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 14 Jul 1998 16:38:50 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00048
	for <linux@cthulhu.engr.sgi.com>; Tue, 14 Jul 1998 16:38:49 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA28202
	for <linux@cthulhu.engr.sgi.com>; Tue, 14 Jul 1998 19:38:32 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 14 Jul 1998 19:38:32 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: The pre-release of Hard Hat Linux for SGI...
Message-ID: <Pine.LNX.3.95.980714192038.7212G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


The non-alpha, full version of Linux for many Indy's is available at:

ftp://ftp.linux.sgi.com/pub/redhat/hardhat-sgi-5.1.tar.gz

(It is uploading as we speak; please wait until the file size is 267015800
bytes.  Yes, this is big.  Make sure you match the md5sum in
hardhat-sgi-5.1.tar.gz.asc. You can also just wait a few weeks until it is
on CD.) 

If there are any significant problems, I may have an oportunity to fix 
small things before it gets pressed to CD. It would be nice if people
tried installing it before then.  I'm afraid all I have is a 500MB disk to
do installs, so I've never been able to do a full install (which is
something like 650MB).

This has a lot of new features in it:

- many more packages; things like glibc, egcs, gcc, XFree libs, kernel
sources, too many to mention here. 

- a better install that doesn't display funny messages, doesn't complain
about a) broken dependancies [1] b) that certain packages can't install
because they're missing glibc[2] and c) the error that you must have a
swap partition, but offers no way of creating one. 

- fdisk does something, although I'm not sure what.  It is untested.

- a much better kernel that has things like the neato power button and LED
drivers

- glibc updates so that Ralf's up and coming Mozilla will run on it

Stuff that is in there but untested:
- new fdisk from Oliver
- the upgrade feature

Stuff that didn't make it in:
- my initrd stuff; this means you still have to install from another
machine with NFS.  I'm sorry, I know it is painful.
- Mike's graphics fixes.
- gdb
- emacs (sorry, I lost the source RPM)

Enjoy, and let me know if you do have the bandwidth do download and use
it.

Two other significant accomplishments this week that may have not been
touted enough:

- Mike Shaver got some nice coloured bars to display on the screen.  I
have good feelings about this.

- Ralf got Mozilla built, parts of gdb and a lot of other stuff.

Good work, guys!

Also, some thanks to SGI's support for replacing the internal SCSI cable
that was causing me problems on such short notice.

- Alex

[1] Man, was that a pain.  I have a new respect for the packaging folk at
RedHat. Rebuilding things like tetex is a pain.
[2] I rebuilt everything, since the alpha1 packages were built with a
broken rpm.

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .
