Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA81080 for <linux-archive@neteng.engr.sgi.com>; Fri, 4 Sep 1998 09:04:40 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA96006
	for linux-list;
	Fri, 4 Sep 1998 09:03:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sguk.reading.sgi.com (sguk.reading.sgi.com [144.253.64.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id JAA87427
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 4 Sep 1998 09:03:53 -0700 (PDT)
	mail_from (leon@reading.sgi.com)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171]) by sguk.reading.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF+cray) via ESMTP id RAA25700 for <@sguk.reading.sgi.com:linux@cthulhu.engr.sgi.com>; Fri, 4 Sep 1998 17:03:52 +0100
Received: from localhost (localhost [127.0.0.1]) by wintermute.reading.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id RAA32592 for <linux@cthulhu.engr.sgi.com>; Fri, 4 Sep 1998 17:03:49 +0100 (BST)
Date: Fri, 4 Sep 1998 17:03:49 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Success at last...
Message-ID: <Pine.SGI.3.96.980904170040.34640A-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


FInally got rid of the "Warning, unable to open console" message. I think I
managed it by not letting IRIX anywhere near the tarball of hard hat.
Downloaded and extracted entirely on Debian Linux.

The installer went without a hitch *applause* and I now have a running
Indy...

The only odd think I've noticed is the console(s) are defaulting to 150
columns and 68 lines (I think) which is way larger than the visible area.
I've fiddles with stty and the likes... Is there something fundamental going
on here?

Leon

-- 
Leon Verrall - 01189 307734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
