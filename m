Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA19717; Mon, 20 May 1996 23:53:05 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA18928 for linux-list; Tue, 21 May 1996 06:53:01 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA18923 for <linux@cthulhu.engr.sgi.com>; Mon, 20 May 1996 23:53:00 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA06446 for <linux@yon.engr.sgi.com>; Mon, 20 May 1996 23:52:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA18918 for <linux@yon.engr.sgi.com>; Mon, 20 May 1996 23:52:58 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id XAA04842; Mon, 20 May 1996 23:52:56 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id CAA29861; Tue, 21 May 1996 02:52:55 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id CAA07073; Tue, 21 May 1996 02:52:55 -0400
Date: Tue, 21 May 1996 02:52:55 -0400
Message-Id: <199605210652.CAA07073@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: wje@fir.esd.sgi.com
CC: linux@yon.engr.sgi.com
In-reply-to: <199605210649.XAA14132@fir.esd.sgi.com> (wje@fir.esd.sgi.com)
Subject: Re: some projections...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Mon, 20 May 1996 23:49:51 -0700
   From: wje@fir.esd.sgi.com (William J. Earl)

       The keyboard and mouse, on the Indy and Indigo2, are driven by
   a PS2-style keyboard and mouse controller.

Good, thanks.

       It will probably be a good idea to boot up on a serial console
   first, since the graphics interface is a bit more complex than a dumb
   frame buffer.  That is how we usually port IRIX to a new system.

Good idea, this will be the direction I go in then.  Although, I can't
wait to have Linux virtual consoles available on an SGI workstation ;-)

Later,
David S. Miller
davem@caip.rutgers.edu
