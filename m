Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA48107 for <linux-archive@neteng.engr.sgi.com>; Sun, 24 Jan 1999 15:35:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA27503
	for linux-list;
	Sun, 24 Jan 1999 15:34:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgidal.dallas.sgi.com (sgidal.dallas.sgi.com [169.238.80.130])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id PAA75781
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 24 Jan 1999 15:34:47 -0800 (PST)
	mail_from (chad@sgi.com)
Received: from roctane.dallas.sgi.com by sgidal.dallas.sgi.com via ESMTP (950413.SGI.8.6.12/911001.SGI)
	 id RAA01425; Sun, 24 Jan 1999 17:33:02 -0600
Received: from localhost (localhost [127.0.0.1]) by roctane.dallas.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via SMTP id PAA04516; Sun, 24 Jan 1999 15:33:02 -0800 (PST)
Date: Sun, 24 Jan 1999 17:33:02 -0600 (CST)
From: Chad Carlin <chad@sgi.com>
X-Sender: chad@roctane.dallas.sgi.com
To: Alex deVries <adevries@engsoc.carleton.ca>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Precompiled 2.1.131 binaries.
In-Reply-To: <Pine.LNX.3.96.990123203759.16452A-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.SGI.3.94.990124164811.4484A-100000@roctane.dallas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hello All,

Well, I gave the new kernel a try. Now I have new problems and an interesting 
note. The problem is this. "Kernel panic: No init found. Try passing init= 
option to kernel" 

I am following the instructions that call for using "./mke2fs drive" and 
using "boot vmlinux root=/dev/sdb3" to boot the kernel. Are these the correct 
ones or is the bootp server the better way to go? 

In either case I actually tried it the other way (nfsroot=) as well. No 
work-worky that way either. I also tried combining the methods too. Like 
getting the kernel via bootp and setting root=/dev/sda1 (linux disk is scsi 
id 1 and irix is 3). Tried getting the kernel from the local efs fs and 
getting root via nfs from my regular irix Indy. Tried old kernel again too. 

Also note: With the previous kernel I was getting boot information through 
the console port of the indy with nothing being displayed on the gfx monitor. 
Now I only get the "130768+22320+3184+341792+48560d+4604+6816 entry: 
0x8bfa60d0" on the console and the rest on the gfx display.

Questions:
1) Is anyone else using an R4400?
2) Does "VFS: Mounted root (ext2 filesystem) readonly" mean that I guessed 
  the correct disk partition to use?
3) What does init= mean in "Kernel panic: No init found.  Try passing 
  init= option to kernel"?
4) This seems to suggest that the tty0 and tty1 have been discovered OK:
	SGI Zilog8530 serial driver version 1.00
	tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
	tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
 Why then would I get this error message?
	Warning: unable to open an initial console

5) Could someone point me to where I can browse the source for this indy kernel?


All responses appreciated. Even if it's just a "There but for the grace 
of God go I" or "Better you than me".


Regards,
Chad
 


	   -----------------------------------------------------
            Chad Carlin                 	 Special Systems
            Silicon Graphics Inc.	  	    972.205.5911 
            Pager 888.754.1597 		VMail 800.414.7994 X5344
            chad@sgi.com 	     http://reality.sgi.com/chad
           ----------------------------------------------------- 
	 "flying through hyperspace ain't like dusting crops, boy"
 
