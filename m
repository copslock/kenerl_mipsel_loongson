Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA01321; Thu, 10 Apr 1997 07:55:19 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA05596 for linux-list; Thu, 10 Apr 1997 07:54:43 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA05586 for <linux@relay.engr.SGI.COM>; Thu, 10 Apr 1997 07:54:37 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id HAA07025 for <linux@relay.engr.SGI.COM>; Thu, 10 Apr 1997 07:54:33 -0700
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id KAA21432; Thu, 10 Apr 1997 10:53:19 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199704101453.KAA21432@neon.ingenia.ca>
Subject: Re: all in the family
In-Reply-To: <199704100718.CAA22863@athena.nuclecu.unam.mx> from Miguel de Icaza at "Apr 10, 97 02:18:59 am"
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Thu, 10 Apr 1997 10:53:19 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Miguel de Icaza:
> > Anyone know if the emulation is up to hosting the Linux/Indy
> > cross-compiler?
> 
> Why do you need the emulation for on Linux/SPARC?   You just need to
> run configure on Linux/SPARC with the proper --target option and you
> will get your native cross-compiler in a second.

I was under the impression that building GCC for the Linux/SGI target
was non-trivial.  Ralf made mention of some patches, and since there
are binaries available for Solaris...

If GCC can support it with a --target choice, that'll be great.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Commando Developer - Whatever It Takes
#>                                                                     
#> "See, you not only have to be a good coder to create a system like
#>    Linux, you have to be a sneaky bastard too." - Linus Torvalds
