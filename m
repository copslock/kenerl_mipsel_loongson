Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA03083 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 09:52:23 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA05997 for linux-list; Wed, 14 Jan 1998 09:48:44 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA05983; Wed, 14 Jan 1998 09:48:42 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA16843; Wed, 14 Jan 1998 09:48:34 -0800
Date: Wed, 14 Jan 1998 09:48:34 -0800
Message-Id: <199801141748.JAA16843@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: 2.1.72 precompiled with no L2
In-Reply-To: <Pine.LNX.3.95.980114120233.2369F-100000@lager.engsoc.carleton.ca>
References: <Pine.LNX.3.95.980114111306.2369C-100000@lager.engsoc.carleton.ca>
	<Pine.LNX.3.95.980114120233.2369F-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > ftp://ftp.linux.sgi.com/pub/test/vmlinux-indy-noL2-2.1.72.tar.gz
 > is available for your usage and testing.  
 > 
 > This is for machines with no L2 cache.  I can't test it myself, since my
 > machine does have that cache.
 > 
 > Should L2 cache perhaps be a compiling option? Is it possible for the
 > kernel to auto-detect if there's cache or not?

      The L2 cache should absolutely be detected at runtime.  For the R4000
and R4400, the presence of the L2 cache is in the config register
(SC bit == 0 means L2 cache is present).  For the Indy R4600 and R5000
systems, an off-chip secondary cache controller is used, so you have to
probe the address of the controller to tell if it is present, or you
have to read the configuration bits from the EEPROM which contains the
memory controller and processor initialization bits as well.  The EEPROM
contains both an "L2 present" bit and some bits which encode the size
of the L2 cache, which has, however, always been 512 KB.  On O2, the
presence of the L2 cache, for R5000 or R10000, is encoded in the config
register.  (We did not use the R5000's builtin L2 cache controller on
Indy, because the required cache RAMs were not available in time,
and the R4600 L2 cache controller could be reused without change.)
