Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA63452; Fri, 18 Jul 1997 11:52:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA25998 for linux-list; Fri, 18 Jul 1997 11:52:09 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA25992 for <linux@engr.sgi.com>; Fri, 18 Jul 1997 11:52:06 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA14600
	for <linux@engr.sgi.com>; Fri, 18 Jul 1997 11:52:05 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id OAA20686; Fri, 18 Jul 1997 14:46:39 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199707181846.OAA20686@neon.ingenia.ca>
Subject: Re: Pointers on how to get started
In-Reply-To: <Pine.LNX.3.95.970718142505.27101O-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jul 18, 97 02:43:30 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 18 Jul 1997 14:46:39 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Alex deVries:
> 1. What's a good kernel to use for this, and can someone tell me where I
> can find a pre-compiled version of it? I suspect until the problems on
> 2.1.45 are fixed, newbies should be using something older.

I use a slightly-out-of-date version of 2.1.43 from the CVS tree.

> 2. Could someone either produce an RPM for an xcompiling gcc host=i386
> target=mips-linux, or send me a tarball?  I'd be happy to make it into an
> RPM.  Same goes for binutils.

Grab the stuff off of neon or linus from the crossdev directory.

> 3. Exactly what hardware will this run on?  All I've heard thus far is
> work on SGI Indy's.

I think that's it.  Whatever Ariel ships you should work, though.

> 4. Can someone tell me about how to configure an Indy to boot via bootp? I
> don't yet have access to manuals.

Configure your bootp server (see the config on neon for details)
correctly, and then:
Hit ESC for maintenance (heh)
5 for boot prompt.

boot -f bootp()blahblah

("blahblah" can be any string...it figures everything out from the
bootp server)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#> Paranoid for money.                            Sarcastic for kicks. 
#>                                                                     
#> "They already *KNOW* I am a whacko, Karen.                          
#>                  That doesn't mean I am *WRONG*." -- mjr@clark.net  
