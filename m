Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA26290; Thu, 30 May 1996 02:50:03 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA17002 for linux-list; Thu, 30 May 1996 09:49:59 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA16997 for <linux@cthulhu.engr.sgi.com>; Thu, 30 May 1996 02:49:58 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA26286; Thu, 30 May 1996 02:49:57 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA16992; Thu, 30 May 1996 02:49:56 -0700
Received: from snowcrash.cymru.net by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id CAA16808; Thu, 30 May 1996 02:49:53 -0700
Received: (from alan@localhost) by snowcrash.cymru.net (8.7.1/8.7.1) id KAA24198; Thu, 30 May 1996 10:46:48 +0100
From: Alan Cox <alan@cymru.net>
Message-Id: <199605300946.KAA24198@snowcrash.cymru.net>
Subject: Re: linux needs bsd networking stack
To: dm@neteng.engr.sgi.com (David S. Miller)
Date: Thu, 30 May 1996 10:46:46 +0100 (BST)
Cc: nn@lanta.engr.sgi.com, torvalds@cs.helsinki.fi, alan@cymru.net,
        sparclinux-cvs@caipfs.rutgers.edu, lmlinux@neteng.engr.sgi.com
In-Reply-To: <199605292250.PAA03268@neteng.engr.sgi.com> from "David S. Miller" at May 29, 96 03:50:23 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> It has a well defined architecture, I will agree with lm when he
> mentions that it is a jungle of code to sift through in certain
> respects.  It need a mallet to smooth certain aspects and interfaces
> out.

I hope to be working full time on this eventually (like when people are paying me
for it). I've also started documentation at the driver and skbuff level and will
work over it bit by bit - see forthcoming Linux Journal articles then going into the
KHG.

> their entire heart and soul into the Linux networking code.  I believe
> at the very least that the Linux networking stack is superior
> performance wise without any question, and as everyone knows I have
> numbers to prove it ;-)

Before you admire the performance numbers get the pre2.1 code off Pedro Roque. Now he
has added really neat header prediction code it kicks pre2.0's butt even though its
doing a surplus memory alloc we need to tidy up

Alan
