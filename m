Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA05549; Fri, 13 Jun 1997 18:54:52 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA15506 for linux-list; Fri, 13 Jun 1997 18:54:25 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA15491; Fri, 13 Jun 1997 18:54:22 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA20105; Fri, 13 Jun 1997 18:54:19 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id TAA19760; Fri, 13 Jun 1997 19:30:37 -0400
Date: Fri, 13 Jun 1997 19:30:37 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ralf Baechle <ralf@Julia.DE>
cc: Larry McVoy <lm@neteng.engr.sgi.com>, ralf@mailhost.uni-koblenz.de,
        shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com
Subject: Re: Userland loader / run time loader
In-Reply-To: <199706132152.XAA04791@kernel.panic.julia.de>
Message-ID: <Pine.LNX.3.95.970613192104.15021E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 13 Jun 1997, Ralf Baechle wrote:
> The development suite is fully useable for bootstrapping itself.  Check
> the little endian rpm packages on my workstation kernel.panic.julia.de;
> they all were built from unchanged RedHat 4.1 source packages and use
> shared libraries.

To begin with, excuse my noviceness in this all. Those are LSB binaries,
whereas the sgi-linux box that I have access to (bogomips.ingenia.com)
will only run MSB. 

As written on this list earlier, we don't have bi-endian support.  So,
which one is it we're going to support to begin with? How is it that Ralf
is able to execute LSB binaries?

Am I missing something big?

Also, there was talk of getting merged up with kernel 2.1.4[234].  Any
luck so far?

- Alex "ready to debug, debug, debug!" deVries
