Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA05385; Sat, 14 Jun 1997 10:41:41 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA02586 for linux-list; Sat, 14 Jun 1997 10:41:23 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA02581 for <linux@relay.engr.SGI.COM>; Sat, 14 Jun 1997 10:41:20 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.19.100]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA21663
	for <linux@relay.engr.SGI.COM>; Sat, 14 Jun 1997 10:41:19 -0700
	env-from (davem@caipfs.rutgers.edu)
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id NAA22232;
	Sat, 14 Jun 1997 13:37:32 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id NAA04790; Sat, 14 Jun 1997 13:35:26 -0400
Date: Sat, 14 Jun 1997 13:35:26 -0400
Message-Id: <199706141735.NAA04790@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ariel@sgi.com
CC: carlson@heaven.newport.sgi.com, linux@cthulhu.engr.sgi.com
In-reply-to: <199706141721.KAA12726@yon.engr.sgi.com> (ariel@yon.engr.sgi.com)
Subject: Re: gcc for Irix.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: ariel@yon.engr.sgi.com (Ariel Faigon)
   Date: Sat, 14 Jun 1997 10:21:07 -0700 (PDT)

   And finally there's "fix_headers" - the utility that comes with gcc
   and fixes headers so they can be used with some gcc conventions and
   extensions to C.  Combine this with our multi-standard headers
   which I suspect the designers of "fix_headers" never thought of and
   you get a pretty cool mess :-)

Which is why in gcc-2.8.0 a completely new fix_headers.irix will exist
which handles it all properly...
