Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA04387; Thu, 3 Apr 1997 16:24:21 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA05128 for linux-list; Thu, 3 Apr 1997 16:23:48 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA05109 for <linux@relay.engr.SGI.COM>; Thu, 3 Apr 1997 16:23:45 -0800
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA23414 for <linux@relay.engr.SGI.COM>; Thu, 3 Apr 1997 16:23:39 -0800
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id TAA20413; Thu, 3 Apr 1997 19:23:08 -0500
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199704040023.TAA20413@neon.ingenia.ca>
Subject: Re: The Indy has landed...
In-Reply-To: <199704031810.UAA21447@kernel.panic.julia.de> from Ralf Baechle at "Apr 3, 97 08:10:35 pm"
To: ralf@Julia.DE (Ralf Baechle)
Date: Thu, 3 Apr 1997 19:23:08 -0500 (EST)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Ralf Baechle:
> > IRIX (bogomips.ingenia.com)
> 
> (Hope this is R4600 - otherwise BogoMIPS won't be too impressive ...)

bogomips 10# cat /proc/cpuinfo
Cannot open /proc/cpuinfo: No such file or directory
bogomips 11# dmesg | more
dmesg: Command not found.
bogomips 12# man dmesg
No manual entry found for dmesg.
bogomips 13#

Not sure...I _think_ it's an R5K, but the packing bits and the machine
itself are 3 time zones east.

> Assuming you're using a Linux box as TFTP Server here are old versions of
> my config files.  Iff(OS != Linux) while(1){swear();rtfm(damn);swear()} ;-)

Actually (I guess I should have made this clearer...a couple of people
have sent tftp help) I meant tips on what should go in the NFS root
area.  Can I just pull stuff down from davem's private archive and
untar, or have things changed since then?

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Commando Developer - Whatever It Takes
#>                                                                     
#> "See, you not only have to be a good coder to create a system like
#>    Linux, you have to be a sneaky bastard too." - Linus Torvalds
