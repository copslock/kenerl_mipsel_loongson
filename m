Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA25452; Mon, 10 Jun 1996 10:03:13 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA16904 for linux-list; Mon, 10 Jun 1996 17:03:05 GMT
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA16889; Mon, 10 Jun 1996 10:03:04 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id KAA22379; Mon, 10 Jun 1996 10:03:01 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id KAA28690; Mon, 10 Jun 1996 10:02:50 -0700
Date: Mon, 10 Jun 1996 10:02:50 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199606101702.KAA28690@fir.esd.sgi.com>
To: ariel@cthulhu.engr.sgi.com
Cc: dm@neteng.engr.sgi.com (David S. Miller), linux@cthulhu.engr.sgi.com
Subject: Re: Are you satisfied now Mr. McVoy? ;-)
In-Reply-To: <199606081822.LAA01539@yon.engr.sgi.com>
References: <199606081123.EAA07860@neteng.engr.sgi.com>
	<199606081822.LAA01539@yon.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon writes:
 > >
 > >
 > >Calibrating delay loop.. ok - 91.96 BogoMIPS
 > >
 > Will a Triton CPU (R5000) make this better ? :-)

     An R5000 should scale with clock rate, relative to the 133 MHZ R4600
David is using.  The 180 MHZ R5000 would then be 124.46.

 > For those who are not familiar with bogomips, my Pentium-100
 > at home does 39.94 bogomips. And the best number I've seen
 > for a desktop is almost 300 bogomips for an  Alpha 21064
 > overclocked to 300MHz. The 91.96 number for a 150MHz Indy
 > sounds pretty good. 

     I think the 150 MHZ R4400 is in David's host machine, with the
133 MHZ R4600 in his target machine, so the 91.96 should be for the latter.
