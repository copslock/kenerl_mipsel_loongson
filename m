Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id DAA31707
	for <pstadt@stud.fh-heilbronn.de>; Wed, 30 Jun 1999 03:07:06 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA3902548; Tue, 29 Jun 1999 18:05:21 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA19191
	for linux-list;
	Tue, 29 Jun 1999 18:02:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id SAA34467;
	Tue, 29 Jun 1999 18:02:03 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA09334; Tue, 29 Jun 1999 18:01:47 -0700
Date: Tue, 29 Jun 1999 18:01:47 -0700
Message-Id: <199906300101.SAA09334@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ulf Carlsson <ulfc@thepuffingroup.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Memory corruption
In-Reply-To: <19990622033931.A7201@thepuffingroup.com>
References: <19990622033931.A7201@thepuffingroup.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson writes:
 > Hi,
 > 
 > The compiler may stop working sometimes on certain files, giving bogus error
 > messages which I don't understand (the compiler is probably not the only
 > application affected).  Running this program I just wrote forces the corrupted
 > caches to be flushed or something and ``fixes'' the problems:
...

      This problem sounds like a cache flushing problem.  Do you also
get SIGILL, SIGBUS, and SIGSEGV failures?  One possibility is that the icache
is not being flushed on a page fault, when a page is read in from disk,
and the icache still has old data in it.  This could lead to a cache line
of bogus instructions being executed.

      What model of CPU do you have in your machine?
