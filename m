Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id SAA110927 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 18:46:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA06757 for linux-list; Mon, 12 Jan 1998 18:46:11 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA06731 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 18:46:06 -0800
Received: from dm.cobaltmicro.com (dm.cobaltmicro.com [209.133.34.35]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA02697
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 18:46:01 -0800
	env-from (davem@dm.cobaltmicro.com)
Received: (from davem@localhost)
	by dm.cobaltmicro.com (8.8.7/8.8.7) id SAA00730;
	Mon, 12 Jan 1998 18:41:03 -0800
Date: Mon, 12 Jan 1998 18:41:03 -0800
Message-Id: <199801130241.SAA00730@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: conradp@cse.unsw.edu.au
CC: linux@cthulhu.engr.sgi.com, andrewo@cse.unsw.edu.au
In-reply-to: 
	<Pine.GSO.3.95.980113131216.12841F-100000@l4-00.orchestra.cse.unsw.EDU.AU>
	(conradp@cse.unsw.edu.au)
Subject: Re: lmbench
References:  <Pine.GSO.3.95.980113131216.12841F-100000@l4-00.orchestra.cse.unsw.EDU.AU>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: "K." <conradp@cse.unsw.edu.au>
   Date: Tue, 13 Jan 1998 13:16:25 +1100 (EST)

   does anyone have an rpm or binary of lmbench for r4600 indy to
   share? We had assembly errors when trying to compile it, and do not
   have time to find the problems. Any help would be appreciated,

It's a generic bug in binutils that nobody has fixed yet, it generates
a dynamic relocation from a unconditional jump which is larger than
fits in the normal relocation... anyways I've seen this before and so
nobody has a binary for lat_ctx (which is what did not compile for
you).

A quick hack is to get the latest beta/alpha of lmbench, which does in
fact compile cleanly on mips/linux:

http://reality.sgi.com/employees/lm/lmbench/lmbench2.0-alpha2.tgz

Later,
David S. Miller
davem@dm.cobaltmicro.com
