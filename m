Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA70903 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Jan 1998 22:09:35 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA06564 for linux-list; Wed, 21 Jan 1998 22:04:36 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA06558 for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 22:04:31 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA21317
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 22:04:26 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA06628;
	Thu, 22 Jan 1998 01:04:19 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 22 Jan 1998 01:04:19 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Mike Shaver <shaver@netscape.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
In-Reply-To: <34C64EB7.1FA95A9C@netscape.com>
Message-ID: <Pine.LNX.3.95.980122005800.20627E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 21 Jan 1998, Mike Shaver wrote:
> Alex deVries wrote:
> > I can already see some things that should go into 0.04..
> It would be nice if there was a really minimal root-be with just enough
> to get a network configured and then start pulling stuff down via RPM. 
> That was my goal with the Linux-installer, although we could have two
> versions, too.

I really need a minimalist version of it, too, for the RH-like installer.
I'm working on it.

> I _must_ start working on EFS again.  I assume I've missed the 2.2
> freeze, but I could still help a lot of people by getting off my a** and
> finishing it.  My apologies to those who are waiting on it.

Let me know if I can help.

Here's a question:  is it possible to boot off of the local disk without
the image being on an EFS partition? Will I ever be able to have my
machine have no EFS partition? How will ARC find the image?

> > - make Linux-installer-0.1c with root-be-0.03.tar.gz (with Mike's
> >   permission)
> Sold!

Tomorrow..  I promise.

> > - document all this (damn, I wish I had another SCSI disk to practice
> >   installs)

I'm bidding right now on another SCSI disk, so I should be setup for it
soon.

- Alex
