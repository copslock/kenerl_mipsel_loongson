Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA17060; Tue, 8 Apr 1997 16:38:50 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA15512 for linux-list; Tue, 8 Apr 1997 16:38:10 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA15479 for <linux@cthulhu.engr.sgi.com>; Tue, 8 Apr 1997 16:38:07 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id QAA00227; Tue, 8 Apr 1997 16:37:59 -0700
Received: (from wje@localhost) by fir.esd.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id QAA14690; Tue, 8 Apr 1997 16:37:49 -0700
Date: Tue, 8 Apr 1997 16:37:49 -0700
Message-Id: <199704082337.QAA14690@fir.esd.sgi.com>
From: "William J. Earl" <wje@fir.esd.sgi.com>
To: Mike Shaver <shaver@neon.ingenia.ca>
Cc: linux@cthulhu.engr.sgi.com, kneedham@ottawa.sgi.com
Subject: Re: It booooooooooots!
In-Reply-To: <199704082223.SAA03675@neon.ingenia.ca>
References: <199704082223.SAA03675@neon.ingenia.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver writes:
 > >> boot -f bootp()neon.ingenia.ca:/vmlinux
 > Setting $netaddr to 205.207.220.72 (from server neon.ingenia.ca)
 > Obtaining /vmlinux from server neon.ingenia.ca
 > PROMLIB: SGI ARCS firmware Version 1 Revision 10
 > PROMLIB: Total free ram 65208320 bytes (63680K,62MB)
 > Loading R4000 MMU routines.
 > CPU REVISION IS: 00002310
...

    Congratulations -- quick work.

...
 > Checking for 'wait' instruction...  unavailable.
...

     This appears to be a bug.  The R5000 does have the wait instruction.
