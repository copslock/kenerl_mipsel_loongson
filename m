Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA44145 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 10:20:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA64235
	for linux-list;
	Tue, 2 Feb 1999 10:19:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA92417
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 10:19:02 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA01999
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Feb 1999 10:19:00 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA09032;
	Tue, 2 Feb 1999 13:21:08 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 2 Feb 1999 13:21:08 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Alexander Graefe <nachtfalke@usa.net>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
In-Reply-To: <19990202155147.A1565@ganymede>
Message-ID: <Pine.LNX.3.96.990202131924.8932B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 2 Feb 1999, Alexander Graefe wrote:
> I got as far as booting Linux via bootp on my Indy, but after the
> remote root-fs is mounted, the kernel dies with an "Aieee" and
> something about irq request handler.
> I tried booting with the 2.1.131-Kernel from ftp.linux.sgi.com, but
> that one doesn't try to mount the root-fs via NFS.

I should rebuild that kernel to have root nfs in it, although my kernel
tree's currently wrapped up with gross graphics.o modularization stuff.

I'll see what I can do.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
