Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA126372; Fri, 15 Aug 1997 18:12:16 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA24637 for linux-list; Fri, 15 Aug 1997 18:11:46 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA24531 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 18:11:11 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA17697
	for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 18:11:10 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id VAA26202; Fri, 15 Aug 1997 21:05:35 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708160105.VAA26202@neon.ingenia.ca>
Subject: Re: boot linux - wish
In-Reply-To: <199708152147.QAA30844@athena.nuclecu.unam.mx> from Miguel de Icaza at "Aug 15, 97 04:47:24 pm"
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Fri, 15 Aug 1997 21:05:34 -0400 (EDT)
Cc: ariel@sgi.com, linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Miguel de Icaza:
> Agreed.  I really preffer this way of setting up Linux, but this
> basically forces you to have an NFS server with the installation files
> somewhere accessible.

Really?
If I stick all the RH stuff in an initrd and then they do FTP install,
then they should be able to use it via boot /vmlinux or boot -f
bootp()..., no?

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>           Resident Linux bigot and kernel hacker. (OOPS!)           
#> `If you get bitten by a bug, tough luck...the one thing I won't do  
#> is feel sorry for you.  In fact, I might ask you to do it all over  
#> again, just to get more information.  I'm a heartless bastard.'     
#>                       -- Linus Torvalds (on development kernels)    
