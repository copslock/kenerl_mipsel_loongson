Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA38896 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Oct 1997 13:19:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA29977 for linux-list; Thu, 16 Oct 1997 13:19:31 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA29957 for <linux@cthulhu.engr.sgi.com>; Thu, 16 Oct 1997 13:19:30 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA00539
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Oct 1997 13:19:27 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id QAA24444; Thu, 16 Oct 1997 16:16:44 -0400
Date: Thu, 16 Oct 1997 16:16:44 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: eak@detroit.sgi.com, linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: More Linux/SGI status
In-Reply-To: <m0xLvHY-0005G4C@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.971016161554.32057I-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 16 Oct 1997, Alan Cox wrote:
> > Stick your kernel in /, and boot it.  That kernel would have to have the
> > EFS file system enabled so that you could mount a local disk with a Linux
> > image as /.  Then, partition your other disk, and install RPM's to your
> > heart's content.
> NFSroot is another possible way...

But, I believe the problem was that he had no other machine to NFS root
off of.

- Alex
