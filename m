Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA08153; Tue, 18 Jun 1996 11:39:50 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA13620 for linux-list; Tue, 18 Jun 1996 18:39:45 GMT
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA13610; Tue, 18 Jun 1996 11:39:43 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id LAA07982; Tue, 18 Jun 1996 11:39:41 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id LAA09663; Tue, 18 Jun 1996 11:39:40 -0700
Date: Tue, 18 Jun 1996 11:39:40 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199606181839.LAA09663@fir.esd.sgi.com>
To: ariel@cthulhu.engr.sgi.com
Cc: olson@anchor.engr.sgi.com (Dave Olson), linux@cthulhu.engr.sgi.com
Subject: Re: anyone know if this is true?
In-Reply-To: <199606181721.KAA14883@yon.engr.sgi.com>
References: <199606181711.KAA13973@anchor.engr.sgi.com>
	<199606181721.KAA14883@yon.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon writes:
 > >
 > >It's not true.  All he has to do is install eoe.hdrs and compiler_eoe.hdrs.
 > >
 > Dave, I'm afraid you're misinformed. The problem is real.
 > Customers cannot build anything on 6.2 even if the install the above
 > subsystems, unless they buy our IDO.
 > 
 > I said it many times, to be able to build anything on 6.2
 > they still miss a linker (the GNU linker is not supported in
 > any official GNU or Cygnus releases on any SGI and we don't include 
 > /usr/lib/crt[1n].o with our headers and libraries)

     Those files are included only in dev.sw.lib, not in irix.sw.irix_lib.
I agree that they should be in the latter.  

     ld is shipped in compiler_eoe.sw.lboot, but it is located under
/usr/cpu/sysgen/root/usr/bin/.  
