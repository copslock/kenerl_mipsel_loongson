Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA288097; Sat, 19 Jul 1997 11:50:01 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA06972 for linux-list; Sat, 19 Jul 1997 11:49:45 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA06962 for <linux@engr.sgi.com>; Sat, 19 Jul 1997 11:49:42 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA03448
	for <linux@engr.sgi.com>; Sat, 19 Jul 1997 11:49:40 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id OAA02539 for <linux@engr.sgi.com>; Sat, 19 Jul 1997 14:49:21 -0400
Date: Sat, 19 Jul 1997 14:49:21 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: Some updates...
Message-ID: <Pine.LNX.3.95.970719135944.32552B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


1. The SGI-linux FAQ

I've compiled version 0.01 of the FAQ, and it is at
http://www.linux.sgi.com/faq.html .

I fully realize that this document is filled with errors, and has some
pretty large holes in it. Rather than mail me saying "Alex, why do you
even bother?", it'd be _very_ helpful if you'd mail me telling me what's
wrong.  No correction is too small.  The goal here is to have an accurate
FAQ.

Understand that I haven't touched SGI hardware in more than a year, which
brings up item #2...

2. My Indy

Yay!  I got a call from David Kascht from SGI minutes before I left work
yesterday.  Apparantly, my Indy is leaving either yesterday or Monday, and
should be in Boston at the latest on Wednesday.  I've decided that the
best thing is to leave it at work until it boots a little better.  That
means it's behind the firewall (which I could, but won't circumvent).

My first project is to properly document the newbie-installation part of
the FAQ.

3. Installation methods

Right now, as documented in the FAQ, the only way to install it I think is
to boot off a remote system using bootp/tftp/nfs-root, setup your disks,
then install RPMs like crazy.

But, what we want to do is move towards a network-less install. I can see
a few ways to do this:

1. Floppy a la PC/Mac 
Can you actually boot an Indy off of a floppy? This would work well
because we could then allow traditional RH FTP and NFS installs.

2. Bootable CDROM
If so, we'd actually need someone to press bootable CD's.

Are there any other ways?  Perhaps creating a boot image from Irix?

I did look in the documentation library, but I came across nothing when
searching for 'boot'.

- Alex

      Alex deVries              Success is realizing 
  System Administrator          attainable dreams.
   The EngSoc Project     
