Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA1034143 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Sep 1997 13:29:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA17999 for linux-list; Thu, 4 Sep 1997 13:29:05 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA17975 for <linux@engr.sgi.com>; Thu, 4 Sep 1997 13:29:02 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA07954
	for <linux@engr.sgi.com>; Thu, 4 Sep 1997 13:28:59 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id QAA08151; Thu, 4 Sep 1997 16:25:44 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199709042025.QAA08151@neon.ingenia.ca>
Subject: Re: Booting off of sdb1...
In-Reply-To: <199709022201.RAA26782@speedy.rd.qms.com> from Mark Salter at "Sep 2, 97 05:01:43 pm"
To: marks@sun470.sun470.rd.qms.com (Mark Salter)
Date: Thu, 4 Sep 1997 16:25:44 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com (Linux/SGI list)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Mark Salter:
> Try this patch to linux/arch/mips/sgi/prom/cmdline.c:

Fixed it for me.  Thanks.

I'll commit that to the tree and put a new kernel up on
ftp.linux.sgi.com.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>      Chief System Architect -- will tame sendmail(8) for food       
#>                                                                     
#> "You are a very perverse individual, and I think I'd like to get to 
#>  know you better." --- eric@reference.com                           
