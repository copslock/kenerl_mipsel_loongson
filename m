Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA09326 for <linux-archive@neteng.engr.sgi.com>; Sun, 21 Jun 1998 15:45:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA11938
	for linux-list;
	Sun, 21 Jun 1998 15:44:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA94183
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 21 Jun 1998 15:44:46 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id PAA29507
	for <linux@cthulhu.engr.sgi.com>; Sun, 21 Jun 1998 15:44:45 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA02480
	for <linux@cthulhu.engr.sgi.com>; Sun, 21 Jun 1998 18:44:43 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 21 Jun 1998 18:44:43 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Ah, a problem with rpm!
Message-ID: <Pine.LNX.3.95.980621183716.31228B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


So, here I am, trying to figure out why on earth we always get those
errors in the installer for the RH installer.  I've figured it out!

See, the installer has this neato way of figuring out the order to install
packages in.  It's determined by what each package you choose requires.
If the package in question has a %post script or similiar, those elements
are required, and so they end up in the calculation of the install order.

So, I thought it was weird that the %post script of ash required the use
of /usr/bin/[, yet that wasn't included in what the binary required.  That
would throw the whole calculation of install order off.

Now, why would rpm build such an erronous package?  I don't quite know if
it is my build environment, or a genuine bug in RPM.  I'm playing with
that now.

The solution to this is either to fix the build environment or rpm, and
then rebuild pretty much all the packages.  *sigh*

The stuff to look for is:

...
Processing files: hello
Finding provides...
Finding requires...
Prereqs: /bin/sh
Requires: ld-linux.so.2 libc.so.6
Wrote: /usr/src/redhat/SRPMS/hello-0.10-2.src.rpm
Wrote: /usr/src/redhat/RPMS/i386/hello-0.10-2.i386.rpm
...

or similiar.  On my Indy, I _don't_ get the "Requires: " line at all. Do
other people?

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .
