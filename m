Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA252981; Thu, 21 Aug 1997 11:27:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA18430 for linux-list; Thu, 21 Aug 1997 11:24:42 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA18415 for <linux@cthulhu.engr.sgi.com>; Thu, 21 Aug 1997 11:24:39 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA28165
	for <linux@cthulhu.engr.sgi.com>; Thu, 21 Aug 1997 11:24:37 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id OAA15741; Thu, 21 Aug 1997 14:23:44 -0400
Date: Thu, 21 Aug 1997 14:23:44 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: eak@detroit.sgi.com
cc: Miguel de Icaza <miguel@nuclecu.unam.mx>, oliver@aec.at,
        linux@cthulhu.engr.sgi.com
Subject: Re: "unable to handle kernel paging request" at boot
In-Reply-To: <33FC7E5B.9986898E@cygnus.detroit.sgi.com>
Message-ID: <Pine.LNX.3.95.970821140710.9583A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 21 Aug 1997, Eric Kimminau wrote:
> 
> We are still having problems getting a boot via nfs to work.


What problems are you having, exactly?  These should be pretty easy to
solve.  Mind you, just popping vmlinux on Irix's /, and booting with the
boot monitor with:
vmlinux nfsroot=bl.ea.h:/sgi-linux

works very easily, and saves the whole problem of having to setup
tftpboot, etc.

> Things would be a whole lot simpler if we could mke2fs on a disk while
> booting IRIX, mount it and copy all the stuff over before trying to boot

mke2fs does exist for Irix; check out the e2fs tools that are precompiled
and sitting on ftp.linux.sgi.com.  It's in the misc directory.  Actually
copying them over is a problem, though, since Irix can't read ext2.

I have a ramdisk setup, I just need to test it.  

- Alex
