Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA50965 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Jun 1998 19:24:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA59027
	for linux-list;
	Wed, 24 Jun 1998 19:23:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA64699
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 Jun 1998 19:23:36 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id TAA08849
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 Jun 1998 19:23:31 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id WAA02028
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 Jun 1998 22:23:27 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 24 Jun 1998 22:23:27 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Some new RPM uploads...
Message-ID: <Pine.LNX.3.95.980624221902.939A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



I've uploaded a lot of new RPMS; most of them are just rebuilds of the
existing RPMS, but now they have dependancy information in them.  I've
redone nearly everything from RH 5.1.

There's still a problem with glibc that prevents me from releasing Alpha 2
of the installation; glibc has too many dependancies that creates a
circular dependancy issue in the installer that can't be resolved without
fixing glibc.

You can find it in
ftp://ftp.linux.sgi.com/pub/redhat/devel/redhat5.1alpha2 or similiar.

I'd work on this, but I'm in NYC on business until at least Friday.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .
