Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA08773; Wed, 28 May 1997 12:21:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA21327 for linux-list; Wed, 28 May 1997 12:21:22 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA21307 for <linux@cthulhu.engr.sgi.com>; Wed, 28 May 1997 12:21:18 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA11767 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 12:21:17 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA21271; Wed, 28 May 1997 12:21:15 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA09227; Wed, 28 May 1997 12:21:10 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id PAA31653; Wed, 28 May 1997 15:19:04 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705281919.PAA31653@neon.ingenia.ca>
Subject: Re: hardware independent hinv
In-Reply-To: <199705281912.MAA06609@neteng.engr.sgi.com> from Larry McVoy at "May 28, 97 12:12:22 pm"
To: lm@neteng.engr.sgi.com (Larry McVoy)
Date: Wed, 28 May 1997 15:19:04 -0400 (EDT)
Cc: ariel@sgi.com, linux@yon.engr.sgi.com, olson@anchor.engr.sgi.com,
        scotth@sgi.com, swmgr@swmgr.engr.sgi.com, breyer@swmgr.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Larry McVoy:
> : Just forwarding since it sounds someone hopes that Linux/MIPS
> : will some day have a HW independent hinv... - Ariel
> 
> Here's my first pass at it.  It certainly isn't complete but it is a 
> start.  We could evolve Linux' /proc to fully handle this.

What about a perl (SGI::?)Hinv:: module that would get hinv data from the
appropriate source?  I've been thinking about a clean perl interface
to /proc for a while, and I assume the data's there for the taking on
the Irixen as well, if you know where to look.  (open("hinv|") is all
else fails.)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                 Ignore the man behind the curtain.                  
#>                                                                     
#> "And then I realized that it never should have worked in the first  
#>  place.  Thus, it would not work again until rewritten." --- Anon.  
