Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA60754; Fri, 18 Jul 1997 11:18:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA14564 for linux-list; Fri, 18 Jul 1997 11:18:32 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA14493 for <linux@engr.sgi.com>; Fri, 18 Jul 1997 11:18:22 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA04097
	for <linux@engr.sgi.com>; Fri, 18 Jul 1997 11:18:20 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id OAA20228; Fri, 18 Jul 1997 14:13:13 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199707181813.OAA20228@neon.ingenia.ca>
Subject: Re: Pointers on how to get started
In-Reply-To: <Pine.LNX.3.95.970718132141.27101H-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jul 18, 97 01:32:57 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 18 Jul 1997 14:13:13 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com (Linux/SGI list)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Alex deVries:
> How are things on the native booting front?

I can boot bogomips off of local disk, but I'm seeing some wierdness
with users and groups that I can't explain (via NFS and ext2).  I'd
like to get strace working so I can debug it more.

There are also some moderately serious VFS bugs in 2.1.4[35] that are
blocking some stuff right now.  (Can't boot diskless with .45, for
example.)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com)      Information Warfare Division  
#> Chief Tactical and Strategic Officer         "Saepe fidelis"        
#>                                                                     
#> "I like your game, but we have to change the rules." -- Anon        
#>                                                                     
