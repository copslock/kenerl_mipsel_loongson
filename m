Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA37476 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Apr 1999 14:59:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA65053
	for linux-list;
	Wed, 14 Apr 1999 14:57:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA31112
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Apr 1999 14:57:17 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA09907
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Apr 1999 14:57:16 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10XXr0-0027UfC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 15 Apr 1999 00:09:54 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10XXef-002PNjC; Wed, 14 Apr 99 23:57 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA03230;
	Wed, 14 Apr 1999 23:15:50 +0200
Message-ID: <19990414231550.A3227@alpha.franken.de>
Date: Wed, 14 Apr 1999 23:15:50 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Errors building...
References: <Pine.LNX.3.96.990414015809.15825C-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990414015809.15825C-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Apr 14, 1999 at 02:03:19AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 14, 1999 at 02:03:19AM -0400, Alex deVries wrote:
> And so here I am, dutifully reporting this bug.

what egcs/binutils are you using ? I can't reproduce it here with
a selfbuild egcs 1.0.2 and bintutils 2.8.1 from Rough Cuts.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
