Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id MAA222532 for <linux-archive@neteng.engr.sgi.com>; Sat, 18 Oct 1997 12:45:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA18770 for linux-list; Sat, 18 Oct 1997 12:44:33 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA18762 for <linux@engr.sgi.com>; Sat, 18 Oct 1997 12:44:30 -0700
Received: from jenolan.rutgers.edu (jenolan.rutgers.edu [128.6.111.5]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA03233
	for <linux@engr.sgi.com>; Sat, 18 Oct 1997 12:44:29 -0700
	env-from (davem@jenolan.rutgers.edu)
Received: (from davem@localhost)
	by jenolan.rutgers.edu (8.8.5/8.8.5) id PAA04270;
	Sat, 18 Oct 1997 15:44:09 -0400
Date: Sat, 18 Oct 1997 15:44:09 -0400
Message-Id: <199710181944.PAA04270@jenolan.rutgers.edu>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ralf@cobaltmicro.com
CC: markhe@nextd.demon.co.uk, linux-kernel@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
In-reply-to: <19971018051839.32034@tbird.cobaltmicro.com> (message from Ralf
	Baechle on Sat, 18 Oct 1997 05:18:39 -0700)
Subject: Re: Page Colouring
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


We could pull this off, and I've been keeping this very issue in the
back of my head as I hack on Mark Hemment's changes.

Essentially you'd have to pass into the page allocation the
destination virtual address.  Then in the coloured allocator we put a
macro which can be defined to zero on sane architectures.

	if(page_color_verify(phys_page, virt_page)) {
		free_page(phys_page);
		goto repeat;
	}

Something like this, don't worry I'm thinking about it.

Later,
David "Sparc" Miller
davem@caip.rutgers.edu
