Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA33591 for <linux-archive@neteng.engr.sgi.com>; Sun, 14 Feb 1999 16:43:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA94897
	for linux-list;
	Sun, 14 Feb 1999 16:43:39 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA86416
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 14 Feb 1999 16:43:37 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03817
	for <linux@cthulhu.engr.sgi.com>; Sun, 14 Feb 1999 16:43:36 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10CC75-0027TKC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 15 Feb 1999 01:42:15 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10CC6s-002PP0C; Mon, 15 Feb 99 01:42 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id BAA02914;
	Mon, 15 Feb 1999 01:32:10 +0100
Message-ID: <19990215013210.A2910@alpha.franken.de>
Date: Mon, 15 Feb 1999 01:32:10 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Memory corruption on Indy
References: <19990215002746.C644@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990215002746.C644@uni-koblenz.de>; from ralf@uni-koblenz.de on Mon, Feb 15, 1999 at 12:27:46AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Feb 15, 1999 at 12:27:46AM +0100, ralf@uni-koblenz.de wrote:
>   find / -fstype ext2 -type f | xargs md5sym
> 
> several times and compare the obtained output.  Do they differ in any
> unexplainable way?

do you want, that everybody crash their Indys ? 

Everybody, who wants to run the find, should umount /proc before doing it.
Otherwise the kernel will crash, when the md5sum /proc/kcore happens.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
