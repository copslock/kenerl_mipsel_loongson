Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA06006; Fri, 30 May 1997 07:04:34 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA00522 for linux-list; Fri, 30 May 1997 07:02:33 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA00509 for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 07:02:31 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA19243
	for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 07:02:25 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id JAA12694; Fri, 30 May 1997 09:46:33 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705301346.JAA12694@neon.ingenia.ca>
Subject: Re: userland cometh
In-Reply-To: <199705300847.KAA25091@informatik.uni-koblenz.de> from Ralf Baechle at "May 30, 97 10:47:18 am"
To: ralf@mailhost.uni-koblenz.de (Ralf Baechle)
Date: Fri, 30 May 1997 09:46:33 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Ralf Baechle:
> Take a look at the little endian RPM packages I've published on
> kernel.panic.julia.de.  All these packages were build from the vanilla
> SRPM packages on the RedHat 4.1 package.

Yeah, yeah... =)

Once I get a natively-hosted compiler working, I'll be cranking out
RPMs[*].  In the meantime, convincing some of those packages to
cross-compile is pretty interesting.  Lots of post-./configure
Makefile munging with perl and the like.

Actually, I think it'll be my cohort Alex who'll be building most of
them.  He likes RPM in a way that's a little frightening (hi, Alex!). =)

> I'd like to keep the number of .tar packages as low as possible; the
> root.tar.gz package has proven not to be very updateable.

I can imagine.  I'm not looking to be a distribution (yet). =)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>           Resident Linux bigot and kernel hacker. (OOPS!)           
#> `If you get bitten by a bug, tough luck...the one thing I won't do  
#> is feel sorry for you.  In fact, I might ask you to do it all over  
#> again, just to get more information.  I'm a heartless bastard.'     
#>                       -- Linus Torvalds (on development kernels)    
