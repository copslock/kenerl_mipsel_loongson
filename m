Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA34993 for <linux-archive@neteng.engr.sgi.com>; Sun, 14 Feb 1999 16:42:57 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA77264
	for linux-list;
	Sun, 14 Feb 1999 16:42:19 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA73488
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 14 Feb 1999 16:42:17 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04581
	for <linux@cthulhu.engr.sgi.com>; Sun, 14 Feb 1999 16:42:16 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10CC73-0027T9C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 15 Feb 1999 01:42:13 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10CC6s-002PP1C; Mon, 15 Feb 99 01:42 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id BAA02923;
	Mon, 15 Feb 1999 01:35:27 +0100
Message-ID: <19990215013527.B2910@alpha.franken.de>
Date: Mon, 15 Feb 1999 01:35:27 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Eric Melville <m_thrope@rigelfore.com>, linux@cthulhu.engr.sgi.com
Subject: Re: problem booting sgi linux
References: <36C76479.62B097D2@rigelfore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <36C76479.62B097D2@rigelfore.com>; from Eric Melville on Sun, Feb 14, 1999 at 04:04:09PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Feb 14, 1999 at 04:04:09PM -0800, Eric Melville wrote:
> then it's stuck... i could write down the "blah blah blah" numbers if
> they would be helpfull. any ideas?

Could give us a hinv of your Indy ?

Have you tried following kernel

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-990212.gz

?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
