Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id DAA129871 for <linux-archive@neteng.engr.sgi.com>; Sun, 11 Jan 1998 03:38:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA21771 for linux-list; Sun, 11 Jan 1998 03:34:46 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA21767 for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 03:34:45 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA26720
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 03:34:44 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-29.uni-koblenz.de [141.26.249.29])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA08023
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 12:34:42 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id LAA02656;
	Sun, 11 Jan 1998 11:32:41 +0100
Message-ID: <19980111113241.08096@uni-koblenz.de>
Date: Sun, 11 Jan 1998 11:32:41 +0100
To: Edwin Hakkennes <E.Hakkennes@ET.TUDelft.NL>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: fdisk for linux-sgi
References: <199801091206.NAA01800@zaphod.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199801091206.NAA01800@zaphod.et.tudelft.nl>; from Edwin Hakkennes on Fri, Jan 09, 1998 at 01:06:46PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jan 09, 1998 at 01:06:46PM +0100, Edwin Hakkennes wrote:

> I'm trying to get an indy running Linux. I downloaded the Getting_started
> stuff, and unpacked it. All seems to be fine, except that I cannot find
> an fdisk program on this file-system. (root-be-0.01.cpio)
> 
> My question is: How do I partition the disk. I have one, empty 2G disk 
> on which only Linux should be installed. 
> 
> Is it neccesary to put the disk in a PC for partioning?

No.  You can use the software included under IRIX.  If the disk you are
connecting is not the bootdisk, means sash & the kernel don't reside on
it you can also partition the disk on a pc.  This may be handy for
data exchange.

  Ralf
