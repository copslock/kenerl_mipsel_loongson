Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA234117 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 May 1998 11:01:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA21788581
	for linux-list;
	Thu, 7 May 1998 11:00:40 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA14080776
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 7 May 1998 11:00:38 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id LAA06748
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 May 1998 11:00:35 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA28339
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 May 1998 14:00:33 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 7 May 1998 14:00:33 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: rs_cons_hook() ?
Message-ID: <Pine.LNX.3.95.980507134501.20653L-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


in drivers/char/console.c, there's a reference to rs_cons_hook() that
looks like:

#ifdef CONFIG_SGI
    if (serial_console) {
...
        rs_cons_hook(0, 0, serial_console);
        rs_cons_hook(0, 1, serial_console);
...
#endif

... and the final link complains that it can't find rs_cons_hook defined
anywhere.  That's because I'm not compiling in
drivers/sgi/char/sgiserial.c (which has other linking errors, and is
another problem, but you should be able to compile in console support
without having to have compiled in SGI serial support).

So, should that #ifdef in console.c not be SGI_SERIAL?

- Alex

-- 
Alex deVries
"romantic engsoc guy who runs marathons" - csilcock@chat.carleton.ca
http://www.engsoc.carleton.ca/~adevries/ .
