Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA1346602 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 15:58:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA13033 for linux-list; Fri, 5 Sep 1997 15:58:10 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA13019 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 15:58:08 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA20120; Fri, 5 Sep 1997 15:58:07 -0700
Date: Fri, 5 Sep 1997 15:58:07 -0700
Message-Id: <199709052258.PAA20120@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@fir.engr.sgi.com
Subject: Re: [Q: Linux/SGI] IRIX executable memory map.
In-Reply-To: <199709051842.NAA07307@athena.nuclecu.unam.mx>
References: <199709050245.VAA03103@athena.nuclecu.unam.mx>
	<199709051842.NAA07307@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > IRIX unsolved misteries -- second update.
 > 
 > I said:
 > 
 > >     Ok, it seems our irix_elfmap routine is just fine, I just found
 > > out with a simple test case that the code is trying to access memory
 > > from the location at 0x200000 which is making my IRIX executables
 > > crash (this one is crashing inside usinit ()).
 > 
 > I was debatting this with my bed sheets this morning and I believe
 > that this page may be a special trick for IRIX sproc()ed binaries.
 > Probably I should also turn off the cache on this page.

     No, I think this page should be private to a given thread (sproc
or process), and it can be cached.  
