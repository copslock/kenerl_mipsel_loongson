Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA02388; Tue, 23 Apr 1996 15:27:46 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id PAA09787; Tue, 23 Apr 1996 15:27:40 -0700
Received: from yon.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	 id PAA09782; Tue, 23 Apr 1996 15:27:39 -0700
Received: by yon.engr.sgi.com (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id PAA00323; Tue, 23 Apr 1996 15:27:36 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199604232227.PAA00323@yon.engr.sgi.com>
Subject: Re: What target (was David ...)
To: mikemac@titian.engr.sgi.com (Mike McDonald)
Date: Tue, 23 Apr 1996 15:27:36 -0700 (PDT)
Cc: ariel@cthulhu.engr.sgi.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <199604232054.NAA01434@titian> from "Mike McDonald" at Apr 23, 96 01:54:29 pm
Reply-To: ariel@cthulhu.engr.sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>Mike dijo:
>>yo dijo:
>>
>>P.S.
>>gcc doesn't have support for 64 bit MIPS 27 ISA, I guess, but
>>nobody is stopping us from using our compilers (as well as gcc
>>at our convenience).
>
>  I strongly believe that using our compilers would be a "bad" thing
>for the initial port. Requiring someone to buy IDO inorder to compile
>a free OS seems like the "wrong" thing to me. Now, if we (SGI) decide
>to ship a Linux version, then yes, using our compilers is OK. Let's
>just make sure that the port is dependant on our compilers in any way
>at this point. (I doubt that's what you were suggesting. I just want
>to make it clear before we get started.)
>
>
Bob and I are working separately on making our compilers (actually only
the C one, not Ada :-) be bundled with Irix (and possibly licence enabled
for a nominal fee, which can be done automatically without human
intervention -- surprisingly this may increase revenues because
the cost of handling goes to zero and the potential upside due to
lowering barriers is large). I think we have a very good chance of
acheiving this as soon as our upcoming big software release.

Also, I agree, we should make sure that whatever we do is buildable
by gcc. And we should also be paying Cygnus to do a real supported
full port (including ld), but this is harder to achieve (need $$$
from management) at this point.  However, after we have Linux and it
takes off, everything related to free software would be possible :-)
-- 
Peace, Ariel
