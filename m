Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA124533 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 13:41:12 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA17161 for linux-list; Thu, 22 Jan 1998 13:37:27 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA17132; Thu, 22 Jan 1998 13:37:24 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA24653; Thu, 22 Jan 1998 13:37:23 -0800
Date: Thu, 22 Jan 1998 13:37:23 -0800
Message-Id: <199801222137.NAA24653@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alistair Lambie <alambie@wellington.sgi.com>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
In-Reply-To: <34C7AE9F.25A38E49@wellington.sgi.com>
References: <Pine.LNX.3.95.980122005800.20627E-100000@lager.engsoc.carleton.ca>
	<34C7AE9F.25A38E49@wellington.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alistair Lambie writes:
 > Alex deVries wrote:
 > > 
 > > On Wed, 21 Jan 1998, Mike Shaver wrote:
 > > > Alex deVries wrote:
 > > > I _must_ start working on EFS again.  I assume I've missed the 2.2
 > > > freeze, but I could still help a lot of people by getting off my a** and
 > > > finishing it.  My apologies to those who are waiting on it.
 > > 
 > > Let me know if I can help.
 > > 
 > > Here's a question:  is it possible to boot off of the local disk without
 > > the image being on an EFS partition? Will I ever be able to have my
 > > machine have no EFS partition? How will ARC find the image?
 > > 
 > Couldn't we just put the vmlinux in the volume header and load it from
 > there....in fact you probably wouldn't even need sash.  Use dvhtool under irix
 > to add the image.  You may need to make a bigger volume header to fit it.  I'm
 > not 100% sure if this will work, but it's worth a try.
...

       vmlinux probably will not fit without repartitioning.  Also, except
for early development, that is pretty tedious.  I would assume that production
Indy linux systems would have just the volume header and linux partitions,
with no IRIX.  
