Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 02:27:21 +0100 (CET)
Received: from shell2.pe.net ([64.38.64.8]:20380 "EHLO shell2.pe.net")
	by linux-mips.org with ESMTP id <S8225254AbSLEB1V>;
	Thu, 5 Dec 2002 02:27:21 +0100
Received: from localhost (dennisn@localhost)
	by shell2.pe.net (8.11.6/8.11.3) with SMTP id gB51RBb15928
	for <linux-mips@linux-mips.org>; Wed, 4 Dec 2002 17:27:12 -0800 (PST)
Date: Wed, 4 Dec 2002 17:27:11 -0800 (PST)
From: Dennis Newbold <dennisn@pe.net>
X-Sender: dennisn@shell2
To: linux-mips@linux-mips.org
Subject: Looking For Profiling Tools
Message-ID: <Pine.GSO.3.96.1021204171653.15843A-100000@shell2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dennisn@pe.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennisn@pe.net
Precedence: bulk
X-list: linux-mips

Dear Linux-Mips Mailing List Members,

     We have an application running under Linux on a Mips processor.
We are currently interested in doing some performance tuning and
bottleneck analysis on this application.  Searching the web turns
up alot of profiling tools of various kinds, but they are almost
universally oriented toward a PC / IA32 architecture.  The more useful
ones generally are tightly coupled to the PC hardware, and specifically
the timer chip.

     I wondered if any of you are aware of any porfiling tools which
can be used on a Linux/Mips OS/Platform, or perhaps someone has written
something for there own use that you'd be willing to share?

Some specific info about our environment:

   1. its a little endian processor using the MIPS IV architecture / IS

   2. the application is written in C, and compiled with the gcc 2.95.2
      C compiler

   3. the Linux kernel is 2.0,xx, mostly because we lack the resources
      to upgrade / port to 2.2 or 2.4.  Someday, hopefully (:

Any suggestions, help you can offer would be appreciated.  Thanks.

Dennis

P.S.  Please respond to my personal email address, as I'm not subscribed
      to the mailing list.

---------------------------------------------
|                                           |
|     The way to be happy is to be good     |
|                                           |
---------------------------------------------
