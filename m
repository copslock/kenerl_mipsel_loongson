Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA33396 for <linux-archive@neteng.engr.sgi.com>; Sat, 1 May 1999 17:29:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA13005
	for linux-list;
	Sat, 1 May 1999 17:26:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA18405
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 May 1999 17:25:59 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA00942
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 May 1999 20:25:58 -0400 (EDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10djax-0027SkC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 2 May 1999 01:54:55 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10dk4n-002Q4jC; Sun, 2 May 99 02:25 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id CAA03464;
	Sun, 2 May 1999 02:14:49 +0200
Message-ID: <19990502021449.A3447@alpha.franken.de>
Date: Sun, 2 May 1999 02:14:49 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jeff Coffin <jcoffin@sv.usweb.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Yet Closer
References: <m3n1zouznd.fsf@chuck.sv.usweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <m3n1zouznd.fsf@chuck.sv.usweb.com>; from Jeff Coffin on Sat, May 01, 1999 at 04:40:54PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, May 01, 1999 at 04:40:54PM -0700, Jeff Coffin wrote:
> I think it's something else.  Here's what I get (this is from ralf's
> suggestion, didn't quite work for me) :
[..]
> Freeing prom memory: 0k freed
> Freeing unused kernel memory: 52k freed
> Warning: unable to open an initial console.

Your /dev/console points to major 4 and minor 0 (5,1 is the correct one).
Try the vmlinux-initrd kernel from the test directory. It should drop
you into a single user shell with a ram disk as root. You should be able
to mount your root, and fix what's necessary.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
