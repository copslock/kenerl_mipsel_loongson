Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA12088; Tue, 8 Apr 1997 14:37:38 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA01570 for linux-list; Tue, 8 Apr 1997 14:35:30 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA01555 for <linux@relay.engr.SGI.COM>; Tue, 8 Apr 1997 14:35:28 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA03453 for <linux@relay.engr.SGI.COM>; Tue, 8 Apr 1997 14:35:25 -0700
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id RAA03090; Tue, 8 Apr 1997 17:31:22 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199704082131.RAA03090@neon.ingenia.ca>
Subject: Re: serial consoles, sash and other wonders
In-Reply-To: <199704081948.MAA14047@fir.esd.sgi.com> from "William J. Earl" at "Apr 8, 97 12:48:07 pm"
To: wje@fir.esd.sgi.com (William J. Earl)
Date: Tue, 8 Apr 1997 17:31:21 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com, davem@caip.rutgers.edu (David S. Miller)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake William J. Earl:
> <tanoak#1> dvhtool /dev/rvh
> (d FILE, a UNIX_FILE FILE, c UNIX_FILE FILE, g FILE UNIX_FILE or l)?
> 	g symmon /stand/symmon
> (d FILE, a UNIX_FILE FILE, c UNIX_FILE FILE, g FILE UNIX_FILE or l)?
> 	q
> <tanoak#2> ls /stand/symmon
> -rw-r--r--    1 root     sys       245760 Apr  8 12:26 /stand/symmon

_Cool_.

>  > 2) What exactly does `bootp-able' mean?  If I stick it in
> 
>     See the tftpd man page.  The default directory for IRIX tftpd is
> /var/boot/, so /var/boot/sash and /var/boot/vmlinux would do for boot files.

OK, that's what I thought.  I just wanted to make sure I was on the
right track when I read `bootp-able' as `tftpable in the right dir'.

>     If you don't have the installation CD's, I recommend that you back
> up the disk, perhaps to a second disk (complete with volume header and
> root partitions), so you can recover from any potential failure.  The
> "cp" command in the prom can be used to copy disk to disk to recover.

That I will do.
Will that work with differently-sized drives?

> [if I boot with serial console, will Linux use that?]
>       I believe that David Miller had that working.  How do you tell linux
> to use a serial port as the console (in single-user mode)?

Ugh.
On Intel, you have to use a patch.
On the SPARC, you just have to set things up right in /dev.
I shall hope that it's SPARC-ish on the Indy and poke around for good
instructions on that.  (I shall also hedge my bets and copy DaveM on
this message. =) )

> from sash, all should be well.  Note that you can boot an ELF kernel directly
> from the PROM on an Indy with a newer PROM image (such as the PROM for an 
> Indy R5000 system), so try that first.  If it works, your Indy has the newer
> PROM, and you can forget about sash.

I've got an R5K, so that'll make things easier.

>      For a production linux for the Indy, the most reasonable approach,
> however, would be to make silo or whatever boot program you are using be
> ECOFF, so that old PROMs are supported.

I think that's the plan.

I'm having some trouble with the serial console, though.
I did an `nvram console d' and that took, but I fear that I've got to
set something else, since my serial cable is connected to port 2.  The
getty I'm running on ttyd2 works fine, FWIW.

When I reboot, I get nothing on the serial console until the getty
login: prompt.

(I can't think off the top of my head as to why I'm using that port,
but I think it had something to do with the available cabling.  I'm
not physically with the machine until 1400 EST tomorrow, but Josh
should feel free to step forward and explain it. =) )

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>      Chief System Architect -- will tame sendmail(8) for food       
#>                                                                     
#> "You are a very perverse individual, and I think I'd like to get to 
#>  know you better." --- eric@reference.com                           
