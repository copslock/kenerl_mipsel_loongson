Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA00409; Tue, 8 Apr 1997 16:49:39 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA19043 for linux-list; Tue, 8 Apr 1997 16:48:55 -0700
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA19031 for <linux@cthulhu.engr.sgi.com>; Tue, 8 Apr 1997 16:48:51 -0700
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (940816.SGI.8.6.9/940406.SGI)
	 id LAA24841; Wed, 9 Apr 1997 11:48:26 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id LAA08913; Wed, 9 Apr 1997 11:48:25 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9704091148.ZM9065@windy.wellington.sgi.com>
Date: Wed, 9 Apr 1997 11:48:25 +0000
In-Reply-To: Mike Shaver <shaver@neon.ingenia.ca>
        "It booooooooooots!" (Apr  9, 10:27am)
References: <199704082223.SAA03675@neon.ingenia.ca>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Mike Shaver <shaver@neon.ingenia.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: It booooooooooots!
Cc: kneedham@ottawa.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Apr 9, 10:27am, Mike Shaver wrote:
> Subject: It booooooooooots!
> Sending BOOTP and RARP requests............
>
> Doesn't seem to want to find the server again for the NFS root thing,
> but that's probably a config problem.
>

I used to have that...you probably haven't got a rarp server set up, so it
can't find its address.  One of the things David was going to add was that
ability to read it out of NVRAM...but that wasn't high on the priority list!
 For now, the only way is to have a rarp server.  The other way is to have the
root file system on hard disk....but to do that you need to boot linux and copy
it across.
Kind of the chicken and the egg situation!

> _Now_ we're ready to rock...
>

Did you get my root filesystem etc off http://reality.sgi.com/ariel/alambie.
This should give you the bits you need to get multiuser (init), set up
networking and mount disks.

Cheers, Alistair

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
