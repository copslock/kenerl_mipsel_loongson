Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA74686; Fri, 15 Aug 1997 11:49:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA07020 for linux-list; Fri, 15 Aug 1997 11:48:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA07003 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 11:48:42 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA15640
	for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 11:48:37 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id NAA29864;
	Fri, 15 Aug 1997 13:45:06 -0500
Date: Fri, 15 Aug 1997 13:45:06 -0500
Message-Id: <199708151845.NAA29864@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: eak@detroit.sgi.com
CC: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-reply-to: <33F45614.3939AFBA@cygnus.detroit.sgi.com> (message from Eric
	Kimminau on Fri, 15 Aug 1997 09:13:56 -0400)
Subject: Re: Local disk boot HOWTO
X-Info: When in doubt, blame the network
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> Has anyone completed a HOWTO for booting from a second local disk yet?
> 
> Thanks!

No, but if you put your Linux kernel on EFS or XFS, you just need to
go to the sash boot prompt and from there type:

	boot /vmlinux

Miguel.
