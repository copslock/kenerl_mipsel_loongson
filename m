Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA08600; Tue, 27 May 1997 13:10:14 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA14217 for linux-list; Tue, 27 May 1997 13:09:22 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA14193; Tue, 27 May 1997 13:09:15 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA08172; Tue, 27 May 1997 13:09:10 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id QAA21739; Tue, 27 May 1997 16:01:19 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705272001.QAA21739@neon.ingenia.ca>
Subject: Re: strace/truss equiv?
In-Reply-To: <199705271942.MAA11080@machine.engr.sgi.com> from "John E. Schimmel" at "May 27, 97 12:42:30 pm"
To: jes@machine.engr.sgi.com (John E. Schimmel)
Date: Tue, 27 May 1997 16:01:19 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake John E. Schimmel:
> The equivelant is par.  You may also want to take a look at
> elfdump which will tell you what libraries you are linked with, etc.

par was what I was looking for.

elfdump doesn't seem to tell me anything about the -b mips-linux
stuff.  Oversight on SGI's part, no doubt. =)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>           Resident Linux bigot and kernel hacker. (OOPS!)           
#> `If you get bitten by a bug, tough luck...the one thing I won't do  
#> is feel sorry for you.  In fact, I might ask you to do it all over  
#> again, just to get more information.  I'm a heartless bastard.'     
#>                       -- Linus Torvalds (on development kernels)    
