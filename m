Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA09482; Thu, 3 Apr 1997 16:58:02 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA12556 for linux-list; Thu, 3 Apr 1997 16:57:30 -0800
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA12543 for <linux@cthulhu.engr.sgi.com>; Thu, 3 Apr 1997 16:57:26 -0800
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (940816.SGI.8.6.9/940406.SGI)
	 id MAA03472; Fri, 4 Apr 1997 12:57:09 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id MAA03039; Fri, 4 Apr 1997 12:57:07 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9704041257.ZM3038@windy.wellington.sgi.com>
Date: Fri, 4 Apr 1997 12:57:06 +0000
In-Reply-To: Mike Shaver <shaver@neon.ingenia.ca>
        "Re: The Indy has landed..." (Apr  4, 12:24pm)
References: <199704040023.TAA20413@neon.ingenia.ca>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Mike Shaver <shaver@neon.ingenia.ca>, ralf@Julia.DE (Ralf Baechle)
Subject: Re: The Indy has landed...
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Apr 4, 12:24pm, Mike Shaver wrote:
> Subject: Re: The Indy has landed...
> Thus spake Ralf Baechle:
> > > IRIX (bogomips.ingenia.com)
> >
> > (Hope this is R4600 - otherwise BogoMIPS won't be too impressive ...)
>
> bogomips 10# cat /proc/cpuinfo
> Cannot open /proc/cpuinfo: No such file or directory
> bogomips 11# dmesg | more
> dmesg: Command not found.
> bogomips 12# man dmesg
> No manual entry found for dmesg.
> bogomips 13#
>
> Not sure...I _think_ it's an R5K, but the packing bits and the machine
> itself are 3 time zones east.
>

I assume it's got Irix running at the moment.  If so, try 'hinv'.

> > Assuming you're using a Linux box as TFTP Server here are old versions of
> > my config files.  Iff(OS != Linux) while(1){swear();rtfm(damn);swear()} ;-)
>
> Actually (I guess I should have made this clearer...a couple of people
> have sent tftp help) I meant tips on what should go in the NFS root
> area.  Can I just pull stuff down from davem's private archive and
> untar, or have things changed since then?
>

Ariel....maybe you should put the tar's on netengr.engr:~/dm/alambie on
ftp://reality.sgi.com/private/dm/ till I get linux.sgi.com sorted out.  There
should be everything you need to get multiuser in there.

Cheers, Alistair

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
