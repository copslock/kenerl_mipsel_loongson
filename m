Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA249207 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 10:43:57 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA20483 for linux-list; Thu, 4 Dec 1997 10:40:29 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA20441; Thu, 4 Dec 1997 10:40:24 -0800
Received: from terra.Sarnoff.COM (terra.sarnoff.com [130.33.11.203]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA28853; Thu, 4 Dec 1997 10:40:21 -0800
	env-from (rminnich@Sarnoff.COM)
Received: (from rminnich@localhost) by terra.Sarnoff.COM (8.6.12/8.6.12) id NAA08587; Thu, 4 Dec 1997 13:40:16 -0500
Date: Thu, 4 Dec 1997 13:40:15 -0500 (EST)
From: "Ron G. Minnich" <rminnich@Sarnoff.COM>
X-Sender: rminnich@terra
To: Greg Chesson <greg@xtp.engr.sgi.com>
cc: Alex deVries <adevries@engsoc.carleton.ca>, ralf@uni-koblenz.de,
        SGI Linux <linux@cthulhu.engr.sgi.com>, rpm-list@redhat.com
Subject: Re: A question about architecture and byte order with RPMs
In-Reply-To: <9712040917.ZM8768@xtp.engr.sgi.com>
Message-ID: <Pine.SUN.3.91.971204133850.8536D-100000@terra>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I've been asking the compiler people for a storage class modifier that could
> be added to type declarations.  The modifier would indicate whether the
> data object is stored in big-endian or little-endian format.
> The compiler would generate byte swizzles or not, depending on whether
> the native execution mode agrees with the indicated storage class.

or you could always look at the gokhale/minnich paper from 1993 (SEDMS) in
which we built a compiler that did just that, conforming to the IEEE
1596.5 standard (which I helped get going along with David James). It's 
not that hard.

We did a bit more than that, maybe too much more, but still ...

I still think it's a good idea :-)

ron
