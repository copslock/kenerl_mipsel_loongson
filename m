Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA20614 for <linux-archive@neteng.engr.sgi.com>; Thu, 25 Feb 1999 13:56:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA71417
	for linux-list;
	Thu, 25 Feb 1999 13:55:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA95813
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 Feb 1999 13:55:13 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA01172
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 Feb 1999 13:55:08 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-14.uni-koblenz.de [141.26.131.14])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id WAA01859
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 Feb 1999 22:55:04 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id NAA01984;
	Thu, 25 Feb 1999 13:12:00 +0100
Message-ID: <19990225131200.B656@uni-koblenz.de>
Date: Thu, 25 Feb 1999 13:12:00 +0100
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, gkm@total.net,
        linux@cthulhu.engr.sgi.com
Subject: Re: A few(bunch? :) of questions.
References: <199902241011.FAA26317@bretweir.total.net> <19990224225929.B1972@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990224225929.B1972@alpha.franken.de>; from Thomas Bogendoerfer on Wed, Feb 24, 1999 at 10:59:29PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Feb 24, 1999 at 10:59:29PM +0100, Thomas Bogendoerfer wrote:

> milo doesn't work for the Indy. Ralf told me about another boot stuff, which
> would allow us to get the kernel from an ext2 partition. Ralf any news ?

I've put this project on ice since I've got to get Linux running perfectly
_stable_ on some VME thing before I can work on something else again.  This
is now my ultimate hacking priority due to ``other opportunities''.

In any case, the code to read ext2 filesystems from ARC supported block
devices is mostly done; it'll need to be tested and debugged.  Wrapping
this code with something like an ELF load is going to be simple.

  Ralf
