Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id GAA46273; Fri, 15 Aug 1997 06:44:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA14108 for linux-list; Fri, 15 Aug 1997 06:42:53 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA14094 for <linux@engr.sgi.com>; Fri, 15 Aug 1997 06:42:50 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA16525
	for <linux@engr.sgi.com>; Fri, 15 Aug 1997 06:42:49 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id JAA20136; Fri, 15 Aug 1997 09:37:25 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708151337.JAA20136@neon.ingenia.ca>
Subject: Re: Local disk boot HOWTO
In-Reply-To: <33F45BBC.84D44D8F@cygnus.detroit.sgi.com> from Eric Kimminau at "Aug 15, 97 09:38:04 am"
To: eak@detroit.sgi.com
Date: Fri, 15 Aug 1997 09:37:25 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com (Linux/SGI list)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Eric Kimminau:
> OK, this IS simple enough. Does anyone have a tar of a functional Linux
> installation I can snag and uncompress on my second disk?

ftp://ftp.linux.sgi.com/pub/mips-linux/root-be-0.00.cpio.gz
should work fine.

(20MB, BTW)

> My assumption would be I would then just modify
> /dev/sdb1/etc/hosts,hostname, etc. for networking and then reboot into
> Linux? 

Something like that.
You can edit them after you reboot, though.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                 UNIX medicine man -- dark magick, cheap!            
#>                                                                     
#>  When the going gets tough, the tough give cryptic error messages.  
#>          "We believe in rough consensus and running code."          
