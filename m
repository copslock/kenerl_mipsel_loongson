Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA11123; Fri, 30 May 1997 11:08:51 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA25770 for linux-list; Fri, 30 May 1997 11:08:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA25728 for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 11:08:28 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA18142
	for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 11:08:26 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id UAA18639; Fri, 30 May 1997 20:04:39 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199705301804.UAA18639@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id UAA19166; Fri, 30 May 1997 20:04:38 +0200
Subject: Re: ah...
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Fri, 30 May 1997 20:04:37 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199705301743.NAA20046@neon.ingenia.ca> from "Mike Shaver" at May 30, 97 01:43:30 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Thus spake Ralf Baechle:
> > Hurz...  Looks like you either you disabled TCI/IP networking or libc
> > and the kernel use different constants for the arguments of socket(2).
> 
> I've added some more verbosity, and the constants are AF_INET=2,
> SOCK_STREAM=2, IPPROTO_TCP=6.
> 
> TCP is correct, but SOCK_STREAM in my kernel headers is 1, SOCK_DGRAM being
> 2.  That'd explain the UDP thing, anyway.

One of the fun things with SGI...  Long time ago checked two SGI machines
running different OS versions for reference.  In one of them the values
for SOCK_STREAM and SOCK_DGRAM are swapped compared to the other.  I wonder
why.  But anyway, at that time I choose to clone the constants from the
newer one.

> Yup, my test program works if I force SOCK_STREAM to be 1.
> I guess I'll try and find the bogosity in the headers, then.

[...]

No, the kernel and the kernel use different values:
>From asm-mips/socket.h:
/* Types of sockets.  */
enum __socket_type
{
  SOCK_DGRAM = 1,               /* Connectionless, unreliable datagrams
                                   of fixed maximum length.  */
  SOCK_STREAM = 2,              /* Sequenced, reliable, connection-based
                                   byte streams.  */
  SOCK_RAW = 3,                 /* Raw protocol interface.  */
  SOCK_RDM = 4,                 /* Reliably-delivered messages.  */
  SOCK_SEQPACKET = 5,           /* Sequenced, reliable, connection-based,
                                   datagrams of fixed maximum length.  */
  SOCK_PACKET = 10,             /* linux specific way of getting packets at
                                   the dev level.  For writing rarp and
                                   other similar things on the user level.  */
};

Grrr...  I somewhen moved the definitions of these constants from the
generic header files to the machine specific header files and somehow
lost the appropriate change to the library.  I did change this with an
eye into the future (IRIX / ABI compatibility) so we wouldn't need some
stupid conversion routine.  Actually I wonder why I was able to use
bind, so I'll have to enquire my setup a bit closer.

Thanks anyway ...

  Ralf
