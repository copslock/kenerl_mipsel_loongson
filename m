Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA333436 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 18:45:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA20538 for linux-list; Thu, 4 Dec 1997 18:40:19 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA20296; Thu, 4 Dec 1997 18:39:36 -0800
Received: from terra.Sarnoff.COM (terra.sarnoff.com [130.33.11.203]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA24033; Thu, 4 Dec 1997 18:39:34 -0800
	env-from (rminnich@Sarnoff.COM)
Received: (from rminnich@localhost) by terra.Sarnoff.COM (8.6.12/8.6.12) id VAA11160; Thu, 4 Dec 1997 21:39:14 -0500
Date: Thu, 4 Dec 1997 21:39:14 -0500 (EST)
From: "Ron G. Minnich" <rminnich@Sarnoff.COM>
X-Sender: rminnich@terra
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Greg Chesson <greg@xtp.engr.sgi.com>, adevries@engsoc.carleton.ca,
        ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com, rpm-list@redhat.com
Subject: Re: A question about architecture and byte order with RPMs
In-Reply-To: <m0xdgRS-0005FsC@lightning.swansea.linux.org.uk>
Message-ID: <Pine.SUN.3.91.971204213811.11147A-100000@terra>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 4 Dec 1997, Alan Cox wrote:
> Yeuch ;). Can't you get your guys to put that in the MMU so you can have
> a little endian or big endian page ? I can see how you'd make lcc generate
> such output but not offhand gcc


If it's in the compiler:
1) htonx and ntohx are history
2) xdr is history

not a bad deal in my book. Put it in the MMU? 2^yeuch. :-)
ron
