Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id IAA02438 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Oct 1997 08:39:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA21167 for linux-list; Thu, 16 Oct 1997 08:39:25 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA21158 for <linux@cthulhu.engr.sgi.com>; Thu, 16 Oct 1997 08:39:22 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA20982
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Oct 1997 08:39:20 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id LAA02086; Thu, 16 Oct 1997 11:39:30 -0400
Date: Thu, 16 Oct 1997 11:39:29 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: eak@detroit.sgi.com
cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: More Linux/SGI status
In-Reply-To: <34461176.55EF32BE@cygnus.detroit.sgi.com>
Message-ID: <Pine.LNX.3.95.971016113322.32057A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 16 Oct 1997, Eric Kimminau wrote:

> I am still having problems just getting our Indy to boot linux. I am in
> a completely SGI environment with no PC already running linux to boot
> from. 
> 
> Is there anyone else using this type of environment that has done a
> basic HOWTO for getting up and running? If you have the basics, I
> PROMISE to document it fully with graphics, images, etc. Ill do it in an
> HTML form which will immediately be placed on linus.linux.

I can think of only one way of doing it...

Stick your kernel in /, and boot it.  That kernel would have to have the
EFS file system enabled so that you could mount a local disk with a Linux
image as /.  Then, partition your other disk, and install RPM's to your
heart's content.

The better way of doing this, though, is to stick all the RPM's on a SCSI
disk on an ext2 partition.  Make a Linux ramdisk (no ARC or anything
else... just the usual Linux ramdisk as found in Sparc and i386) with a
base filesystem.  From that, partition your second disk, and install RPMs.

I'm working on the ramdisk stuff... 

- Alex
