Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA66807 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Jun 1998 19:41:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA22780
	for linux-list;
	Fri, 26 Jun 1998 19:41:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA56373
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Jun 1998 19:41:10 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA00369
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Jun 1998 19:41:08 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id WAA21149;
	Fri, 26 Jun 1998 22:39:21 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 26 Jun 1998 22:39:21 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: "Francis M. J. Hsieh" <mjhsieh@helix.life.nthu.edu.tw>
cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: ssh binaries
In-Reply-To: <19980627015217.A454@helix.life.nthu.edu.tw>
Message-ID: <Pine.LNX.3.95.980626223243.19185B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sat, 27 Jun 1998, Francis M. J. Hsieh wrote:
> On Sun, Jun 14, 1998 at 07:23:46PM +0200, ralf@uni-koblenz.de wrote:
> > I've uploaded ssh binaries, both big endian and little endian,
> > international and us-damaged (read: rsaref) versions to
> > ftp.replay.com:/pub/crypto/incoming/.  The binaries are probably
> > somewhen going to be moved to their final place.
>   I am sorry if it was discussed before. I can't install the client
> and server, rpm told me "libz.so.1" needed even if I downloaded the
> actual file libz.so.1 from ftp.linux.sgi.com.
> How can I fix it up? Thanx for your help.

This is a problem with the zlib RPM that is released with Alpha 1; none of
those libraries have dependancies in them.  The ones in Alpha 2 have this
problem fixed.  So, the 'real' answer is to completely reinstall all the
packages in Alpha 2 (which all have the same versions and releases, for
compatibility and consistancy with RH 5.1/Intel).

- Alex
