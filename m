Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA04727; Sat, 10 May 1997 10:41:16 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA06833 for linux-list; Sat, 10 May 1997 10:41:01 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA06814 for <linux@engr.sgi.com>; Sat, 10 May 1997 10:40:59 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA11070
	for <linux@engr.sgi.com>; Sat, 10 May 1997 10:40:30 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id NAA31718; Sat, 10 May 1997 13:49:46 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705101749.NAA31718@neon.ingenia.ca>
Subject: Re: linux-2.1.36 (and update)
In-Reply-To: <199705040129.VAA02925@jenolan.caipgeneral> from "David S. Miller" at "May 3, 97 09:29:07 pm"
To: davem@jenolan.rutgers.edu (David S. Miller)
Date: Sat, 10 May 1997 13:49:45 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake David S. Miller:
> If you go and diff my modified version and the stock version in that
> kernel source tree (probably a 2.0.something, somewhere around there,
> you can check the top level Makefile in my original tree ;-) it should
> be easy to tell what I've changed and what is just reformatting.

I'm going to work from the 2.0.12 stock kernel (that's the version
that's running on bogomips right now, so I know it works).

I haven't heard anything recently about linux.sgi.com, so I'll just
install the CVS tree from private/dm somewhere on neon (my poor box)
and try to extract a diff.  Time to brush up on my CVS skills. =)

My Indy goes away in a week or so, and I want to get the 2.1.36 merge
done before it leaves.  (I have the option, but not the means, to
purchase the Indy in question for $5K CDN. =) )  Hopefully, I'll be
able to work off of linux.sgi.com, when it gets deployed somewhere
visible to me.

Once I get to the point where I can successfully build a kernel and
such, I want to start hacking some of the PROM config-extraction
stuff, mainly so I can boot from the network without typing in 5 lines
of nfs config data. =)

One of my cohorts found a book on MIPS assembly in a local store, so
I'll probably pick that up as well; should cut down on the number of
stupid questions I have to ask.

> If I recally, I placed new comments in the places where logic/code
> changes, and not just reformatting.

Excellent, my liege.

(microupdate: just finished unpacking cvs.tar.gz, and I'm going to
have to shuffle some stuff around so I have space to actually extract
a kernel from the archive... =/ )

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                   Welcome to the technocracy.
#>                                                                     
#> "you'd be so disappointed
#>              to find out that the magic was not
#>                          really meant for you" - OLP
