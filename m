Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA19021; Sun, 7 Jul 1996 21:27:00 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA04264 for linux-list; Mon, 8 Jul 1996 04:26:56 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA04259 for <linux@cthulhu.engr.sgi.com>; Sun, 7 Jul 1996 21:26:54 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA19016; Sun, 7 Jul 1996 21:26:54 -0700
Date: Sun, 7 Jul 1996 21:26:54 -0700
Message-Id: <199607080426.VAA19016@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: working strace for IRIX6
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I've hacked up the strace source so that it works under IRIX6.*
... took me all of 15 minutes to get working, it is just that I
thought someone else was working on it so I haven't bothered to look
at it until today.  You can snag a binary from:

/hosts/neteng/usr/people/dm/bin/strace

and source from:

/hosts/neteng/usr/people/dm/src/strace-3.0.14

As with anything else, it is being kept under CVS revision control on
tanya.engr.sgi.com:/cvs, source directory name is 'strace' with
version and vendor tag of STRACE_SGI.

Later,
David S. Miller
dm@sgi.com
