Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA89070 for <linux-archive@neteng.engr.sgi.com>; Thu, 5 Nov 1998 13:23:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA80345
	for linux-list;
	Thu, 5 Nov 1998 13:23:06 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA43944;
	Thu, 5 Nov 1998 13:23:04 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA04011; Thu, 5 Nov 1998 13:23:00 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id VAA21089; Thu, 5 Nov 1998 21:22:49 GMT
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0zbXjg-0007U8C; Thu, 5 Nov 98 22:18 GMT
Message-Id: <m0zbXjg-0007U8C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Halloween doc II
To: ariel@cthulhu.engr.sgi.com
Date: Thu, 5 Nov 1998 22:18:34 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199811052053.MAA55262@oz.engr.sgi.com> from "Ariel Faigon" at Nov 5, 98 12:53:04 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 	1) Automounting a floppy/CD when it is inserted
> 	   (BTW: IRIX mediad has been doing this for quite a while)

Yeah we looked at it, and decided it sucked somewhat. Stephen Tweedie
has a slightly different scheme where you can even be sat in a directory
on a changable volume when itchanges and all is fine - its called
supermount

> 	2) Simpler installation: e.g. rather than asking 30
> 	   questions, provide a menu like:
> 		1) Express install: don't ask me anything,
> 		   just go ahead and fill my disk.
> 		2) Pick and chose: let me select
> 		...

Thats occured a lot

> 	3) XFree86 installation: don't ask me what chipset I have
> 	   and what's the scan rates etc.  Instead have an internal
> 	   mapping table between well known brand names (e.g. ATI Mach64)
> 	   and the details of the card.  People usually know the latter
> 	   (what's written on the box, but rarely the former)

Current installers from RH and I think SuSE ask no questions for PCI
installs barring optional monitor abiklity ones 

> 	4) Simpler Network config:  DHCP client installed by default
> 	   Again saving complex questions to the simple user

Yep

> 	5) Of course, a coherent consistent GUI to manage everything
> 	   from HW devices to access to files etc.  Those who need
> 	   the simplicity, will never be willing to do command line
> 	   stuff.

Have a look at linuxconf, it works, it does the job. The gui just needs a 
major rethink

> 	6) Development tools like VB/VC++ :-)

Cygnus GNUPro ;)

> Someone forward this to Red Hat / Gnome and the XFree86 teams ...

We've all seen it. 

Alan
