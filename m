Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA06986; Fri, 30 May 1997 11:00:45 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA23043 for linux-list; Fri, 30 May 1997 11:00:21 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA23015 for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 11:00:15 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA16041
	for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 11:00:14 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id NAA20046; Fri, 30 May 1997 13:43:30 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705301743.NAA20046@neon.ingenia.ca>
Subject: Re: ah...
In-Reply-To: <199705301734.TAA14229@informatik.uni-koblenz.de> from Ralf Baechle at "May 30, 97 07:34:01 pm"
To: ralf@mailhost.uni-koblenz.de (Ralf Baechle)
Date: Fri, 30 May 1997 13:43:30 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Ralf Baechle:
> Hurz...  Looks like you either you disabled TCI/IP networking or libc
> and the kernel use different constants for the arguments of socket(2).

I've added some more verbosity, and the constants are AF_INET=2,
SOCK_STREAM=2, IPPROTO_TCP=6.

TCP is correct, but SOCK_STREAM in my kernel headers is 1, SOCK_DGRAM being
2.  That'd explain the UDP thing, anyway.

Yup, my test program works if I force SOCK_STREAM to be 1.
I guess I'll try and find the bogosity in the headers, then.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>            Chief System Architect and Herder of Bits                
#>                                                                     
#> "Yoda say, `Just slap a little public key crypto into it' does not  
#>      a secure system make." -- Marcus J. Ranum (mjr@clark.net)      
