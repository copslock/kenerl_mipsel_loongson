Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA06881; Tue, 8 Apr 1997 17:02:34 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA24761 for linux-list; Tue, 8 Apr 1997 17:02:02 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA24735 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 17:01:59 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id RAA08455 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 17:01:57 -0700
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id TAA04813; Tue, 8 Apr 1997 19:56:31 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199704082356.TAA04813@neon.ingenia.ca>
Subject: Re: It booooooooooots!
In-Reply-To: <9704091148.ZM9065@windy.wellington.sgi.com> from Alistair Lambie at "Apr 9, 97 11:48:25 am"
To: alambie@wellington.sgi.com (Alistair Lambie)
Date: Tue, 8 Apr 1997 19:56:31 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Alistair Lambie:
> I used to have that...you probably haven't got a rarp server set up, so it
> can't find its address.  One of the things David was going to add was that
> ability to read it out of NVRAM...but that wasn't high on the priority list!
>  For now, the only way is to have a rarp server.

Actually, you can do it with
boot -f bootp()server:/vmlinux nfsaddrs=my.ip.ad.dr:nfs.ip.ad.dr

It mounts it now (I have the NFS daemon running with debugging on so
that I can watch) but it just stops after it looks at tty[4123 -- in
that order].

I'm going to see how the SPARC guys did it; I think it's just a matter
of getting the device entries correct.

> Did you get my root filesystem etc off http://reality.sgi.com/ariel/alambie.
> This should give you the bits you need to get multiuser (init), set up
> networking and mount disks.

Yeah, and that's what I'm using for my root filesystem.
It mounts everything and checks out stuff like /var/log/utmp (!), but
then hangs after it looks at the ttys.

Curious...

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>           Resident Linux bigot and kernel hacker. (OOPS!)           
#> `If you get bitten by a bug, tough luck...the one thing I won't do  
#> is feel sorry for you.  In fact, I might ask you to do it all over  
#> again, just to get more information.  I'm a heartless bastard.'     
#>                       -- Linus Torvalds (on development kernels)    
