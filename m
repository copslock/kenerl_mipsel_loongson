Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA03242; Fri, 30 May 1997 13:04:16 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA26610 for linux-list; Fri, 30 May 1997 13:04:00 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.41]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA26597; Fri, 30 May 1997 13:03:54 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA04356; Fri, 30 May 1997 13:03:53 -0700
Date: Fri, 30 May 1997 13:03:53 -0700
Message-Id: <199705302003.NAA04356@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Cc: shaver@neon.ingenia.ca (Mike Shaver), linux@cthulhu.engr.sgi.com
Subject: Re: ah...
In-Reply-To: <199705301804.UAA18639@informatik.uni-koblenz.de>
References: <199705301743.NAA20046@neon.ingenia.ca>
	<199705301804.UAA18639@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > > Thus spake Ralf Baechle:
 > > > Hurz...  Looks like you either you disabled TCI/IP networking or libc
 > > > and the kernel use different constants for the arguments of socket(2).
 > > 
 > > I've added some more verbosity, and the constants are AF_INET=2,
 > > SOCK_STREAM=2, IPPROTO_TCP=6.
 > > 
 > > TCP is correct, but SOCK_STREAM in my kernel headers is 1, SOCK_DGRAM being
 > > 2.  That'd explain the UDP thing, anyway.
 > 
 > One of the fun things with SGI...  Long time ago checked two SGI machines
 > running different OS versions for reference.  In one of them the values
 > for SOCK_STREAM and SOCK_DGRAM are swapped compared to the other.  I wonder
 > why.  But anyway, at that time I choose to clone the constants from the
 > newer one.
...

      The change was for SVR4 compatibility.  The older numbering (STREAM==1,
DGRAM==2) was the BSD variation; the newer numbering is derived from the TPI
(Transport Provider Interface) constants.  RISC/os had the same thing, except
it supported both (-systype bsd43 for the BSD headers and libraries,
-systype svr4 for the SVR4 headers and libraries).  (The number conflict
was resolved in the system calls, depending on the type of the executable.)
