Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA17870; Sun, 11 May 1997 16:00:49 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA07057 for linux-list; Sun, 11 May 1997 16:00:26 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA07042 for <linux@relay.engr.SGI.COM>; Sun, 11 May 1997 16:00:20 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.19.100]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA00761
	for <linux@relay.engr.SGI.COM>; Sun, 11 May 1997 16:00:16 -0700
	env-from (davem@caipfs.rutgers.edu)
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id SAA04160;
	Sun, 11 May 1997 18:56:29 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id SAA11246; Sun, 11 May 1997 18:55:08 -0400
Date: Sun, 11 May 1997 18:55:08 -0400
Message-Id: <199705112255.SAA11246@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: shaver@neon.ingenia.ca
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199705112256.SAA11805@neon.ingenia.ca> (message from Mike Shaver
	on Sun, 11 May 1997 18:56:35 -0400 (EDT))
Subject: Re: irix_times
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: Mike Shaver <shaver@neon.ingenia.ca>
   Date: Sun, 11 May 1997 18:56:35 -0400 (EDT)

   gcc tells me, quite rightly, that error may be used without
   initialization, and I'm wondering if the hiding of error in the C<if
   (tbuf)> block is intentional.

   I assume not, but I thought I'd make sure it just wasn't davem
   outsmarting me again. =)

Thats just my stupidity, the obvious fix is the intended code.
