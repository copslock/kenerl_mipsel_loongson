Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA14757 for <linux-archive@neteng.engr.sgi.com>; Tue, 23 Sep 1997 15:41:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA26035 for linux-list; Tue, 23 Sep 1997 15:39:12 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA25993; Tue, 23 Sep 1997 15:39:03 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA24049; Tue, 23 Sep 1997 15:38:49 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id SAA02473; Tue, 23 Sep 1997 18:32:20 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199709232232.SAA02473@neon.ingenia.ca>
Subject: Re: Task list --preliminary list
In-Reply-To: <199709230305.UAA09789@oz.engr.sgi.com> from Ariel Faigon at "Sep 22, 97 08:05:26 pm"
To: ariel@cthulhu.engr.sgi.com
Date: Tue, 23 Sep 1997 18:32:19 -0400 (EDT)
Cc: miguel@nuclecu.unam.mx, linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Ariel Faigon:
> [5] Verify that the latest source tree on Llinus compiles and boots
>     (maybe automate this with a daily build that gets tested)

Boots on?
We'll need to define a set of known-tested/supported systems, at least
for now.

> [4] Utility to boot Linux from IRIX (both locally and over net)

Stay tuned.
I'm going to be incommunicado for about a week while I move to
Mountain View, but I only have one bug[*] keeping me from being able
to boot off of an EFS partition, etc.  That should make things a lot
easier.

[*] Yes, it's embarrassingly true: I still can't get indirect extents
right.  I'll check my code in tomorrow, in case someone smarter than
me wants to take a crack at it.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>           Resident Linux bigot and kernel hacker. (OOPS!)           
#> `If you get bitten by a bug, tough luck...the one thing I won't do  
#> is feel sorry for you.  In fact, I might ask you to do it all over  
#> again, just to get more information.  I'm a heartless bastard.'     
#>                       -- Linus Torvalds (on development kernels)    
