Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA16015; Thu, 7 Aug 1997 10:40:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA19447 for linux-list; Thu, 7 Aug 1997 10:40:34 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA19438 for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 10:40:32 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA10984
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 10:40:30 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id NAA29867; Thu, 7 Aug 1997 13:36:37 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708071736.NAA29867@neon.ingenia.ca>
Subject: Re: Pending fixes
In-Reply-To: <199708071730.MAA21512@athena.nuclecu.unam.mx> from Miguel de Icaza at "Aug 7, 97 12:30:46 pm"
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Thu, 7 Aug 1997 13:36:36 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Miguel de Icaza:
> 	- Look up the semaphore IRIX api from the developers toolbox
> 	  in www.sgi.com, figure out how these C functions use the
> 	  /dev/usema and /dev/usemaclone devices.  
> 
> 	- If you feel like it, implement those devices ;-)

I'm working on these, and will update the projects page appropriately.

(Once they get my ClubDev account straightened out, it'll go a little
faster, but I need to brush up on my driver writing anyway.)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                 UNIX medicine man -- dark magick, cheap!            
#>                                                                     
#>  When the going gets tough, the tough give cryptic error messages.  
#>          "We believe in rough consensus and running code."          
