Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA146389; Sat, 9 Aug 1997 15:59:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA08414 for linux-list; Sat, 9 Aug 1997 15:58:48 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA08398 for <linux@cthulhu.engr.sgi.com>; Sat, 9 Aug 1997 15:58:44 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA02591
	for <linux@cthulhu.engr.sgi.com>; Sat, 9 Aug 1997 15:58:43 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id SAA17511; Sat, 9 Aug 1997 18:53:58 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708092253.SAA17511@neon.ingenia.ca>
Subject: Re: your mail
In-Reply-To: <Pine.LNX.3.95.970809214814.29239A-100000@odin.waw.com> from Vincent Renardias at "Aug 9, 97 10:05:02 pm"
To: vincent@waw.com (Vincent Renardias)
Date: Sat, 9 Aug 1997 18:53:58 -0400 (EDT)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Vincent Renardias:
> % mips-linux-gcc  -o pwgen pwgen.o -lm
> /usr/local/mips-linux/lib/libc.a: could not read symbols: Archive has no
> index; run ranlib to add one
> 
> running mips-linux-ranlib on the given file does not change anything.
> (ie: still getting the same message)

Did you use mips-linux-ar to create the archive?
Many packages, I've discovered, don't listen to $AR in the
environment, and I used to get that error all the time.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>            Chief System Architect and Herder of Bits                
#>                                                                     
#> "Yoda say, `Just slap a little public key crypto into it' does not  
#>      a secure system make." -- Marcus J. Ranum (mjr@clark.net)      
