Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA99742; Fri, 15 Aug 1997 13:58:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA13839 for linux-list; Fri, 15 Aug 1997 13:58:30 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA13819 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 13:58:28 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA03314
	for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 13:58:27 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id QAA24515; Fri, 15 Aug 1997 16:53:01 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708152053.QAA24515@neon.ingenia.ca>
Subject: Re: boot linux - wish
In-Reply-To: <Pine.LNX.3.95.970815163117.21813A-100000@lager.engsoc.carleton.ca> from Alex deVries at "Aug 15, 97 04:38:14 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 15 Aug 1997 16:53:01 -0400 (EDT)
Cc: ariel@sgi.com, linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Alex deVries:
> I don't mind rising to that challenge, but one huge obstacle is how do we
> get the utility to partition the Linux drive? 

Oliver is working on fdisk, I believe.
Last I heard, he was working on the geometry-query issue.  Oliver?

> > And give hints like:
> > 	Sorry you don't have the e2fs tools installed on IRIX yet
> > 	should I download them from ftp.linux.sgi.com [y/n]?
> 
> Er, does such a tool in fact exist?

Yup.
That's how I made bogomips' ext2 drive initially.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                 Ignore the man behind the curtain.                  
#>                                                                     
#> "And then I realized that it never should have worked in the first  
#>  place.  Thus, it would not work again until rewritten." --- Anon.  
