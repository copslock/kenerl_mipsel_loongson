Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id HAA14533; Thu, 7 Aug 1997 07:39:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA25968 for linux-list; Thu, 7 Aug 1997 07:39:01 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA25960 for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 07:38:58 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA21308
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 07:38:56 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id KAA25462; Thu, 7 Aug 1997 10:35:08 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708071435.KAA25462@neon.ingenia.ca>
Subject: Re: Challenge S
In-Reply-To: <33E9D5B0.18B77AE6@cygnus.detroit.sgi.com> from Eric Kimminau at "Aug 7, 97 10:03:28 am"
To: eak@detroit.sgi.com
Date: Thu, 7 Aug 1997 10:35:08 -0400 (EDT)
Cc: chadm@sgi.com, linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Eric Kimminau:
> I think it would be a great application but Linux is sorely missing a
> very important piece - lockd for NFS.

Or, perhaps not:

[shaver@neon fs]$ pwd  
/usr/src/linux/fs
[shaver@neon fs]$ ls -l lockd
total 99
-rw-r--r--   1 shaver   users         513 Apr  4 14:06 Makefile
-rw-r--r--   1 shaver   users        4721 Apr  4 14:06 clntlock.c
-rw-r--r--   1 shaver   users       13087 Apr  7 21:43 clntproc.c
-rw-r--r--   1 shaver   users        7941 Apr 16 00:47 host.c
-rw-r--r--   1 shaver   users         873 Apr  4 14:06 lockd_syms.c
-rw-r--r--   1 shaver   users        4890 Apr  4 15:21 mon.c
-rw-r--r--   1 shaver   users        6472 Apr 16 00:47 svc.c
-rw-r--r--   1 shaver   users       16741 Apr  4 15:21 svclock.c
-rw-r--r--   1 shaver   users       14254 Apr  4 14:06 svcproc.c
-rw-r--r--   1 shaver   users        2549 Apr  4 14:06 svcshare.c
-rw-r--r--   1 shaver   users        6680 May 12 13:35 svcsubs.c
-rw-r--r--   1 shaver   users       13785 Apr  4 14:06 xdr.c
[shaver@neon fs]$ 

=)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>       Chief System Architect -- Head geek -- System exorcist        
#>                                                                     
#>   "Have you considered a life?  I hear they're quite affordable     
#>          these days." --- shields@tembel.org                        
