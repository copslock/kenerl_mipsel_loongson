Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA01316; Tue, 4 Jun 1996 10:07:30 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA17723 for linux-list; Tue, 4 Jun 1996 15:52:04 GMT
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA17716 for <linux@cthulhu.engr.sgi.com>; Tue, 4 Jun 1996 08:52:03 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id IAA13771; Tue, 4 Jun 1996 08:52:02 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id IAA14993; Tue, 4 Jun 1996 08:51:52 -0700
Date: Tue, 4 Jun 1996 08:51:52 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199606041551.IAA14993@fir.esd.sgi.com>
To: "David S. Miller" <dm@neteng.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com, mani@fir.esd.sgi.com
Subject: Re: more progress
In-Reply-To: <199606040102.SAA21209@neteng.engr.sgi.com>
References: <199606040102.SAA21209@neteng.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller writes:
...
 > Next I will look into getting the kgdb code functioning.  And after
 > that I will most likely try to get the generic kernel init'ing such
 > that all the generic data structures and non-device code are setup and
 > the kernel attempts to mount root (which it will not be able to). ;)
...

    Please check with Mani Varadarajan (mani@esd.sgi.com) about kgdb.
He has used it with the DMS Moosehead system simulator, although in
that case the simulator acts as the target system monitor, instead of
having a program resident in memory with the kernel.  I don't know if
he had to fix anything for the MIPS architecture; if he did, that
might save you some startup time.
