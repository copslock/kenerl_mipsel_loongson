Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA09136; Tue, 23 Apr 1996 13:54:37 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id NAA22502; Tue, 23 Apr 1996 13:54:31 -0700
Received: from titian by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	 id NAA22492; Tue, 23 Apr 1996 13:54:30 -0700
Received: from localhost by titian via SMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id NAA01434; Tue, 23 Apr 1996 13:54:29 -0700
Message-Id: <199604232054.NAA01434@titian>
To: ariel@cthulhu.engr.sgi.com
cc: linux@cthulhu.engr.sgi.com
Subject: Re: What target (was David ...) 
In-reply-to: Your message of "Tue, 23 Apr 1996 13:26:53 PDT."
             <199604232026.NAA00059@yon.engr.sgi.com> 
Date: Tue, 23 Apr 1996 13:54:29 -0700
From: Mike McDonald <mikemac@titian.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>From: ariel@yon (Ariel Faigon)
>Subject: What target (was David ...)
>To: linux@yon
>Date: Tue, 23 Apr 1996 13:26:53 -0700 (PDT)

>P.S.
>gcc doesn't have support for 64 bit MIPS 27 ISA, I guess, but
>nobody is stopping us from using our compilers (as well as gcc
>at our convenience).
>-- 
>Peace, Ariel

  I strongly believe that using our compilers would be a "bad" thing
for the initial port. Requiring someone to buy IDO inorder to compile
a free OS seems like the "wrong" thing to me. Now, if we (SGI) decide
to ship a Linux version, then yes, using our compilers is OK. Let's
just make sure that the port is dependant on our compilers in any way
at this point. (I doubt that's what you were suggesting. I just want
to make it clear before we get started.)

  Mike McDonald
  mikemac@engr.sgi.com
