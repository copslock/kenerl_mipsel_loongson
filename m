Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA260433; Thu, 10 Jul 1997 15:05:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA04867 for linux-list; Thu, 10 Jul 1997 15:05:10 -0700
Received: from sgibos.boston.sgi.com (sgibos.boston.sgi.com [169.238.33.4]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA04495 for <linux@cthulhu.engr.sgi.com>; Thu, 10 Jul 1997 15:03:53 -0700
Received: from tvp.boston.sgi.com by sgibos.boston.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/940406.SGI)
	 id SAA19614; Thu, 10 Jul 1997 18:03:45 -0400
Received: (from wmesard@localhost) by tvp.boston.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA19714; Thu, 10 Jul 1997 18:08:40 -0400
Date: Thu, 10 Jul 1997 18:08:40 -0400
Message-Id: <199707102208.SAA19714@tvp.boston.sgi.com>
From: Wayne Mesard <wmesard@cthulhu.engr.sgi.com>
To: ariel@sgi.com (Ariel Faigon)
Cc: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Subject: How to get the masses (IRIX<->Linux)
In-Reply-To: Ariel Faigon's message of 10 July 1997 14:38:49
References: <199707102138.OAA23929@oz.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon writes:
> If we could rewrite wakeupat or reboot to take some
> extra boot options or alternatively run some Linux loader
> (SILO/MILO) from IRIX then 2) should be easy.

Not necessary.  Use nvram to set SystemPartition (and maybe one or two
other prom variables?) to point at the Linux disk and then just init 6.

Wayne();
617-489-7864
