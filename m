Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA25259; Mon, 10 Jun 1996 10:00:04 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA16313 for linux-list; Mon, 10 Jun 1996 17:00:00 GMT
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA16307 for <linux@cthulhu.engr.sgi.com>; Mon, 10 Jun 1996 09:59:59 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id JAA22242; Mon, 10 Jun 1996 09:59:58 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id JAA28671; Mon, 10 Jun 1996 09:59:47 -0700
Date: Mon, 10 Jun 1996 09:59:47 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199606101659.JAA28671@fir.esd.sgi.com>
To: "David S. Miller" <dm@neteng.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: well it is about time...
In-Reply-To: <199606081219.FAA08535@neteng.engr.sgi.com>
References: <199606081219.FAA08535@neteng.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller writes:
 > 
 > This port is going like a funeral procession, I apologize.

      Not at all--nice work.  Considering some of the messy stuff
you have to deal with, it is going quite well.

..
 > 2) Timers work, I am using the r4k counter/compare register timer
 >    mechanism because of the bug in the i8254 Intel timer chips
 >    on certain INDY's.  The calibration of the compare offsets
 >    needs some work but the working framework is there and needs
 >    a little tweaking, basically my algorithm is:
 > 
 > 	a) setup i8254 counter 0 and counter 2 such that the period
 > 	   of counter 0 is the desired HZ value
 > 	b) poll counter 0 waiting for a value of 1
 > 	c) quickly set CP0_COUNTER to zero
 > 	d) poll counter 0 for value of 1
 > 	e) quickly read CP0_COUNTER value
 > 
 >    This seems to approximate the value I want in it's current form
 >    pretty well.  I have to add some fuzz factors into it and possibly
 >    write the calibration code in assembly to get the accuracy I
 >    want/need.

      When it is time to do R4000 support, I can show you how to work
around the R4000 count/compare bug.  (This does not apply to other processors,
such as the R4600, R5000, or R10000.)
