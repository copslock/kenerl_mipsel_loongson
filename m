Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA532124; Tue, 19 Aug 1997 08:29:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA17449 for linux-list; Tue, 19 Aug 1997 08:29:22 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA17419 for <linux@cthulhu.engr.sgi.com>; Tue, 19 Aug 1997 08:29:19 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA24898
	for <linux@cthulhu.engr.sgi.com>; Tue, 19 Aug 1997 08:29:15 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id KAA22197;
	Tue, 19 Aug 1997 10:25:48 -0500
Date: Tue, 19 Aug 1997 10:25:48 -0500
Message-Id: <199708191525.KAA22197@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: stepheng@zephyr.sydney.sgi.com
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <9708191425.ZM1486@zephyr.sydney.sgi.com>
	(stepheng@zephyr.sydney.sgi.com)
Subject: Re: What works - what doesn't
X-Windows: Live the nightmare.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello Stephen,

>    I have just tested booting linux using nfs on 6 indys. I have the following
> results :
> Error :
> 
> Unable to handle kernel paging request at virtual address 00000008, epc ==
> 880cbc5c , ra == 880cbc3c

Can you tell us which kernel you are using?  Did you compile it
yourself?  In that case, can you look up the epc and ra addresses on
the System.map file and tell us where those addresses fall?

Cheers,
Miguel.
