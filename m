Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA06486; Thu, 14 Aug 1997 10:28:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA17097 for linux-list; Thu, 14 Aug 1997 10:27:29 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA16837 for <linux@engr.sgi.com>; Thu, 14 Aug 1997 10:26:44 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA16700
	for <linux@engr.sgi.com>; Thu, 14 Aug 1997 10:26:43 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id NAA05220; Thu, 14 Aug 1997 13:21:27 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708141721.NAA05220@neon.ingenia.ca>
Subject: Re: linus accessible from within SGI
In-Reply-To: <9708141731.ZM8013@wolfi.munich.sgi.com> from Wolfgang Szoecs at "Aug 14, 97 05:31:49 pm"
To: wolfi@wolfi.munich.sgi.com (Wolfgang Szoecs)
Date: Thu, 14 Aug 1997 13:21:27 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com (Linux/SGI list)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Wolfgang Szoecs:
> BTW, i'm searching for a kernel image for booting a linux-NFS-root.
> Does anybody have one, and could give me that ?
> (a root-fs i already have)

Oh yeah, I forgot to tell the list about this:

Miguel gave me his kernel, since I couldn't build one with either my
tools or the ones on linus, and I put it up for Jan at
ftp://ftp.linux.sgi.com/pub/testing/vmlinux-970813-jwr.gz
(You'll need to gunzip it for use.)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>           Resident Linux bigot and kernel hacker. (OOPS!)           
#> `If you get bitten by a bug, tough luck...the one thing I won't do  
#> is feel sorry for you.  In fact, I might ask you to do it all over  
#> again, just to get more information.  I'm a heartless bastard.'     
#>                       -- Linus Torvalds (on development kernels)    
