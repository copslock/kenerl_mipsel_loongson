Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA22057; Wed, 25 Jun 1997 21:21:07 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA05107 for linux-list; Wed, 25 Jun 1997 21:20:53 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA05089 for <linux@engr.sgi.com>; Wed, 25 Jun 1997 21:20:47 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA29960
	for <linux@engr.sgi.com>; Wed, 25 Jun 1997 21:20:46 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id AAA15089 for linux@engr.sgi.com; Thu, 26 Jun 1997 00:20:19 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199706260420.AAA15089@neon.ingenia.ca>
Subject: Intel tools suspect, film at 11
To: linux@cthulhu.engr.sgi.com
Date: Thu, 26 Jun 1997 00:20:19 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Well, I can build a (working) kernel with the IRIX-hosted tools, and
not the Intel-hosted ones, so I'm beginning to suspect that it's not
_just_ my incompetence at work.

There are some config bugs (need ISO9660 and NFSD, don't compile in
REMOTE_DEBUG) that I'll commit fixes for once I get the IRIX stuff
talking cvs and ssh.

I'm going to try building native-gcc with the IRIX stuff, since it
kinda-almost worked off Intel in such a way that makes me want to
blame it on the tools. =)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>       Chief System Architect -- Head geek -- System exorcist        
#>                                                                     
#>   "Have you considered a life?  I hear they're quite affordable     
#>          these days." --- shields@tembel.org                        
