Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA243209 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 09:23:12 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA22107 for linux-list; Thu, 4 Dec 1997 09:18:09 -0800
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA22103 for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 09:18:08 -0800
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id JAA08770; Thu, 4 Dec 1997 09:17:40 -0800
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9712040917.ZM8768@xtp.engr.sgi.com>
Date: Thu, 4 Dec 1997 09:17:39 -0800
In-Reply-To: Alex deVries <adevries@engsoc.carleton.ca>
        "Re: A question about architecture and byte order with RPMs" (Dec  4, 12:04pm)
References: <Pine.LNX.3.95.971204114636.10196F-100000@lager.engsoc.carleton.ca>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Alex deVries <adevries@engsoc.carleton.ca>, ralf@uni-koblenz.de
Subject: Re: A question about architecture and byte order with RPMs
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>, rpm-list@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Dec 4, 12:04pm, Alex deVries wrote:
> Subject: Re: A question about architecture and byte order with RPMs


> > It requires
> > going through _all_ the kernel code and possibly fixing the byteorder
> > handling.
>
> Nobody wants that.
>

I've been asking the compiler people for a storage class modifier that could
be added to type declarations.  The modifier would indicate whether the
data object is stored in big-endian or little-endian format.
The compiler would generate byte swizzles or not, depending on whether
the native execution mode agrees with the indicated storage class.

Perhaps the GCC world, being somewhat more enlightened, could do something
in this area (or perhaps already is thinking about it?).

g
