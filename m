Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA3532075 for <linux-archive@neteng.engr.sgi.com>; Fri, 1 May 1998 12:30:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA19031413
	for linux-list;
	Fri, 1 May 1998 12:29:06 -0700 (PDT)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id MAA17634192;
	Fri, 1 May 1998 12:29:04 -0700 (PDT)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id MAA23116; Fri, 1 May 1998 12:29:04 -0700
Date: Fri, 1 May 1998 12:29:04 -0700
Message-Id: <199805011929.MAA23116@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Hanging.
In-Reply-To: <Pine.LNX.3.95.980501141729.22853C-100000@lager.engsoc.carleton.ca>
References: <Pine.LNX.3.95.980501141729.22853C-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > This is a bit weird.   Once every 30 minutes or so, my Indy just sits
 > there and hangs.  Num lock will work, it'll ping, but there'll be no error
 > messages, and the system's useless.  After about 10 minutes of this, it'll
 > wake up as if nothing had happened.
 > 
 > This is with 2.1.91.
 > 
 > Ideas? My initial suspicion is my SCSI bus, although I'm getting no kernel
 > errors at all. 

     Is this an R4000?  If so, it might be the count/compare erratum, if
the linux kernel does not have the workaround for it yet.  (I haven't
checked the linux sources.)
