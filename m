Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA10602; Tue, 8 Apr 1997 17:08:23 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA27228 for linux-list; Tue, 8 Apr 1997 17:07:52 -0700
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA27088 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 17:07:09 -0700
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (940816.SGI.8.6.9/940406.SGI)
	 id MAA25366; Wed, 9 Apr 1997 12:06:29 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id MAA08867; Wed, 9 Apr 1997 12:06:28 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9704091206.ZM8939@windy.wellington.sgi.com>
Date: Wed, 9 Apr 1997 12:06:27 +0000
In-Reply-To: Mike Shaver <shaver@neon.ingenia.ca>
        "Re: It booooooooooots!" (Apr  9, 11:56am)
References: <199704082356.TAA04813@neon.ingenia.ca>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Mike Shaver <shaver@neon.ingenia.ca>
Subject: Re: It booooooooooots!
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Apr 9, 11:56am, Mike Shaver wrote:
> Subject: Re: It booooooooooots!
> Thus spake Alistair Lambie:
> > I used to have that...you probably haven't got a rarp server set up, so it
> > can't find its address.  One of the things David was going to add was that
> > ability to read it out of NVRAM...but that wasn't high on the priority
list!
> >  For now, the only way is to have a rarp server.
>
> Actually, you can do it with
> boot -f bootp()server:/vmlinux nfsaddrs=my.ip.ad.dr:nfs.ip.ad.dr
>

Forgot that one!!  It all seems so long ago :-)

> It mounts it now (I have the NFS daemon running with debugging on so
> that I can watch) but it just stops after it looks at tty[4123 -- in
> that order].
>

Have you set up the 'init' environment, or are you just using the plain 'root'
package.  If the later, I seem to remeber that the kernel looks for init, but
doesn't look in the correct place for the shell.  There is a boot argument that
I used to use to get the shell...can't remeber what now, but it was real easy
to find in the kernel source....

Even if you are using init, you might want to just boot the shell first to
track down what is happening!

Cheers

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
