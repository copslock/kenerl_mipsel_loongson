Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA06419; Mon, 3 Jun 1996 11:09:11 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA27254 for linux-list; Mon, 3 Jun 1996 17:12:28 GMT
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA27240 for <linux@engr.sgi.com>; Mon, 3 Jun 1996 10:12:26 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	for <@ares.esd.sgi.com:linux@engr.sgi.com> id KAA13259; Mon, 3 Jun 1996 10:12:22 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id KAA17639; Mon, 3 Jun 1996 10:12:20 -0700
Date: Mon, 3 Jun 1996 10:12:20 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199606031712.KAA17639@fir.esd.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: mtc0/eret hazard for the R4600, R4700, and R5000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

     We recently noticed an error in the CP0 hazard table for the above
processors.  Specifically, the eret row in the table in Appendix F is
incorrect.  There must be two instructions between an mtc0 which changes
a register read by eret and an eret, not just one.  This is not normally
a problem, but it does mean that one must keep the mtc0 which restores $epc
far enough away from the eret.  
