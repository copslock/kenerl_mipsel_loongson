Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA01636 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Apr 1999 06:51:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA78180
	for linux-list;
	Mon, 5 Apr 1999 06:36:41 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA81943
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 5 Apr 1999 06:36:39 -0700 (PDT)
	mail_from (milos@insync.net)
Received: from sneety.insync.net (sneety.insync.net [209.113.65.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA03747
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Apr 1999 06:36:38 -0700 (PDT)
	mail_from (milos@insync.net)
Received: from insync.net (209-113-28-242.insync.net [209.113.28.242])
	by sneety.insync.net (8.9.2/8.9.1) with ESMTP id IAA08406;
	Mon, 5 Apr 1999 08:36:34 -0500 (CDT)
Message-ID: <3708BC61.AF904C06@insync.net>
Date: Mon, 05 Apr 1999 08:36:33 -0500
From: Miles Lott <milos@insync.net>
Reply-To: milos@kprc.com
Organization: KPRC
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.5 i686)
X-Accept-Language: en, ex-MX
MIME-Version: 1.0
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: New Indy kernel uploaded
References: <19990329012602.A3227@alpha.franken.de> <199903300743.JAA15859@sun168.eu> <19990330235135.A2991@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This is working for me, too - to a point.  I get stuck
just past the package selection and the message that a log
will be created.  It looks as if it is hanging trying to
mount the linux partition.  So, stupid question.  The 
install instructions say to begin by running fx and setting
up a root partition on the second disk from within IRIX.
So, am I supposed to format ext2 from within the Hardhat setup
program?  Or, rather, at what point is the partition formatted
suitably for the Hardhat install to begin unpacking files on it?
TIA

Thomas Bogendoerfer wrote:
> 
> On Tue, Mar 30, 1999 at 09:43:16AM +0200, Tom Woelfel wrote:
> > Yep, done. Works without problems - Linux is up and running. How do
> > you solve the problems with the ECOFF/ELF thing ? Is there some kind
> > of backwards-compatibility ?
> 
> yes, every newer PROM is also able to boot ECOFF kernels. So I just
> uploaded an ECOFF kernel, which should work with every PROM.
> 
> Thomas.
> 
> --
>    This device has completely bogus header. Compaq scores again :-|
> It's a host bridge, but it should be called ghost bridge instead ;^)
>                                         [Martin `MJ' Mares on linux-kernel]
