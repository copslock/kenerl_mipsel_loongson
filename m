Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA79940 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Mar 1999 13:13:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA10396
	for linux-list;
	Tue, 16 Mar 1999 13:12:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA70286
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Mar 1999 13:11:59 -0800 (PST)
	mail_from (deliverator.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA14043
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Mar 1999 13:11:40 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10N16p-0027TjC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 16 Mar 1999 22:10:43 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10N16h-002OvIC; Tue, 16 Mar 99 22:10 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA02623;
	Tue, 16 Mar 1999 21:52:40 +0100
Message-ID: <19990316215239.C2594@alpha.franken.de>
Date: Tue, 16 Mar 1999 21:52:39 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: eedthwo@eede.ericsson.se
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: initrd is working and new test image
References: <19990313131944.A809@alpha.franken.de> <199903161159.MAA12251@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199903161159.MAA12251@sun168.eu>; from Tom Woelfel on Tue, Mar 16, 1999 at 12:59:52PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 16, 1999 at 12:59:52PM +0100, Tom Woelfel wrote:
> Yesss, this works. After netbooting I find myself in the shell. The
> included prog's are working.

that's great. Now I hope this will also work for the R4400 machines.

> I was furthermore able to create a directory (/mnt) and
> (straightforward) I tried to mount the root-dir from the server. This
> works too, but whith some error-messages (RPC sendmsg returned error
> code 128).

that's normal for a 2.2 kernel without running portmap. One workaround is
to use mount -o nolock, but I'm not sure, if this option is supported by
the mount on the initrd.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
