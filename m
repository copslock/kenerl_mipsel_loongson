Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA69119 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Oct 1998 12:13:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA57293
	for linux-list;
	Thu, 22 Oct 1998 12:09:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA51578
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Oct 1998 12:09:56 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA02509
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Oct 1998 12:09:51 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zWQ7I-0027w0C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 22 Oct 1998 20:09:48 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zWQ7C-002OwzC; Thu, 22 Oct 98 21:09 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA02034;
	Thu, 22 Oct 1998 21:06:18 +0200
Message-ID: <19981022210618.A2029@alpha.franken.de>
Date: Thu, 22 Oct 1998 21:06:18 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jeff Coffin <jcoffin@sv.usweb.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Partial Success Report
References: <m3vhldwh1w.fsf@lil.sv.usweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <m3vhldwh1w.fsf@lil.sv.usweb.com>; from Jeff Coffin on Wed, Oct 21, 1998 at 05:56:11PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Oct 21, 1998 at 05:56:11PM -0700, Jeff Coffin wrote:
> > Could you please lookup major and minor number of /dev/console on
> > your root filesystem ? It should be major 5 and minor 2 to work
> > properly with the serial console.
> 
> I fixed it, do I need to change systty too perhps?:

no, but I've got major and minor wrong. It's major 5 and minor 1.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
