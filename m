Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA16650
	for <pstadt@stud.fh-heilbronn.de>; Mon, 12 Jul 1999 23:27:29 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA17420; Mon, 12 Jul 1999 14:23:58 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA47161
	for linux-list;
	Mon, 12 Jul 1999 14:19:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA19124
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 12 Jul 1999 14:19:56 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA03312
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jul 1999 14:19:54 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m113nUH-0027YIC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 12 Jul 1999 23:19:45 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m113nU6-002OzuC; Mon, 12 Jul 99 23:19 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA02020;
	Mon, 12 Jul 1999 22:59:11 +0200
Message-ID: <19990712225911.B1990@alpha.franken.de>
Date: Mon, 12 Jul 1999 22:59:11 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Eric Melville <m_thrope@rigelfore.com>, sgi <linux@cthulhu.engr.sgi.com>
Subject: Re: kernel for r4400 v6.0
References: <3787A053.2FACA65B@rigelfore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <3787A053.2FACA65B@rigelfore.com>; from Eric Melville on Sat, Jul 10, 1999 at 12:34:43PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jul 10, 1999 at 12:34:43PM -0700, Eric Melville wrote:
> could someone please give me a url for the kernel i should be attempting
> to boot on my r4400 v6.0 indy? thanks.

Please try the latest vmlinux-indy-* from 

ftp://ftp.linux.sgi.com/pub/linux/mips/test

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
