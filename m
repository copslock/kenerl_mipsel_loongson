Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA06305; Thu, 27 Jun 1996 15:47:51 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA13235 for linux-list; Thu, 27 Jun 1996 22:47:46 GMT
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [155.11.228.1]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA13222 for <linux@cthulhu.engr.sgi.com>; Thu, 27 Jun 1996 15:47:42 -0700
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/940406.SGI)
	 id KAA02245; Fri, 28 Jun 1996 10:47:44 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id KAA04678; Fri, 28 Jun 1996 10:47:43 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9606281047.ZM4676@windy.wellington.sgi.com>
Date: Fri, 28 Jun 1996 10:47:42 +0000
In-Reply-To: "David S. Miller" <dm@neteng.engr.sgi.com>
        "Re: Userland binaries" (Jun 26,  1:44am)
References: <199606251344.GAA06325@neteng.engr.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: dm@sgi.com, alambie@wellington.sgi.com
Subject: Re: Userland binaries
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Jun 26,  1:44am, David S. Miller wrote:
> Subject: Re: Userland binaries
>    From: "Alistair Lambie" <alambie@wellington.sgi.com>
>    Date: Tue, 25 Jun 1996 13:35:33 +0000
>
>    Being miles away in New Zealand it is kind of hard to know who is
>    doing what!
>
> I wasn't far from there last week ;-) (for those who do not know I
> gave two talks in Manchester England last week)
>

Yeah...only another 24 hours flying and you too could have been here.

>    I have been playing around with cross compiling userland binaries.
>    But before I get carried away here are some questions:
>
>    1. Is anyone already doing this?
>
> Not that I know of.
>

Judging by the resounding silence I guess you are correct!

>    2. Should we set up a repository so we don't all spend our time
>    doing the same
>       thing?
>
> Good idea.
>

Can someone point me at a place (I could host here, but it seems crazy for
everyone to try suck everything up a 64k pipe...of course this assumes that
people are actually interested!!).

>    4. If several people are doing this maybe we should coordinate the
>    effort so
>       we don't all do the same packages.
>
> Another good idea. ;-)

So far I've done sh-utils and file-utils.  Next I'm planning on SYSVinit and
whatever packages have getty/login/security.  Then some more shells and an
editor.  I guess after that the next thing might be some of the networking
stuff.

I'm using the RedHat SRPMS for this, and applying their patches unless they are
platform specific.  Does anyone have any wild objections to this?

Also, what format would people prefer for packages...just tar.gz or RPM?
 (guess this also raises the point that I need to do some binaries to deal with
however we package things!)

Cheers, Alistair

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
