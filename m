Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA21228; Sun, 15 Jun 1997 16:21:24 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA01793 for linux-list; Sun, 15 Jun 1997 16:19:21 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA01786 for <linux@relay.engr.SGI.COM>; Sun, 15 Jun 1997 16:19:18 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA21309
	for <linux@relay.engr.SGI.COM>; Sun, 15 Jun 1997 16:19:15 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id SAA02801; Sun, 15 Jun 1997 18:54:36 -0400
Date: Sun, 15 Jun 1997 18:54:36 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
cc: ralf@Julia.DE, Mike Shaver <shaver@engsoc.carleton.ca>
Subject: A pointed question about endianness...
In-Reply-To: <199706140312.WAA17152@athena.nuclecu.unam.mx>
Message-ID: <Pine.LNX.3.95.970615184212.1448A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm going to repeat this question because I still haven't gotten a firm
answer.

As previously discussed, there are good reasons to produce a kernel which
can handle bi-endianness.  But, as Mike says, just not this week...

As we speak, Ralf has produced a batch of MIPS LSB binaries that would be
glorious to be able to run.  The kernel that Mike Shaver and I have is
MSB, as are our kernel, cross-compiler and rudamentary binaries.  I
believe this is because we're branching off of Dave M's work.

But, can we please agree on one endianness?  I don't care which it is, so
long as we all agree. Mike and I are quite willing to give up MSB.

My proposal is to use Ralf's LSB binaries as a launchpad[1], and produce
only LSB binaries until we get bi-endianness going. 

Also, Ralf, could you put up a binary of your kernel and a tar ball of
your root fs?

- Alex

[1] Which are mirrored on ftp://ftp.engsoc.carleton.ca/pub/mips if you're
having problems getting them from .de.  That is, until whatever.sgi.com is
setup.

      Alex deVries           "Alex can cut a mean rug."
  System Administrator       - M. Dittberner <shabby@engsoc.carleton.ca>
   The EngSoc Project     
