Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id HAA136611; Sat, 16 Aug 1997 07:23:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA00146 for linux-list; Sat, 16 Aug 1997 07:22:23 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA00120 for <linux@cthulhu.engr.sgi.com>; Sat, 16 Aug 1997 07:22:12 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA05346
	for <linux@cthulhu.engr.sgi.com>; Sat, 16 Aug 1997 07:22:10 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id KAA31361; Sat, 16 Aug 1997 10:15:49 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708161415.KAA31361@neon.ingenia.ca>
Subject: Re: boot linux - wish
In-Reply-To: <m0wzheO-0005FiC@lightning.swansea.linux.org.uk> from Alan Cox at "Aug 16, 97 01:08:12 pm"
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 16 Aug 1997 10:15:48 -0400 (EDT)
Cc: miguel@nuclecu.unam.mx, ariel@sgi.com, linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Alan Cox:
> > If I stick all the RH stuff in an initrd and then they do FTP install,
> > then they should be able to use it via boot /vmlinux or boot -f
> > bootp()..., no?
> 
> 2.1.4x blows up with an initrd - hopefully fixed in 2.1.50/soon but that
> means the SGI one will corrupt and explode atm

I thought Ijust saw something from Bill Hawes cross the list that
addressed that, actually.  Regardless, they've got at least a week to
get 2.1.x playing nicely with initrds before I'll get a chance to use
it on the Indy. The initrd stuff is the trivial part, and should
operate identically to having it mounted via NFS-root.

Thanks for the warning, though.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>      Chief System Architect -- will tame sendmail(8) for food       
#>                                                                     
#> "You are a very perverse individual, and I think I'd like to get to 
#>  know you better." --- eric@reference.com                           
