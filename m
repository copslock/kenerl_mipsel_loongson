Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA06804 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Feb 1999 18:13:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA07374
	for linux-list;
	Wed, 17 Feb 1999 18:11:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA57508
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Feb 1999 18:11:34 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn (dialup71-1-16.swipnet.se [130.244.71.16]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA04050
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Feb 1999 18:11:32 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m10DIwM-00158eC@calypso.saturn> (Debian Smail3.2.0.102)
	for linux@cthulhu.engr.sgi.com; Thu, 18 Feb 1999 03:11:46 +0100 (CET) 
Date: Thu, 18 Feb 1999 03:11:46 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: VID_HARDWARE_VINO
Message-ID: <19990218031146.A19022@bun.falkenberg.se>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, ralf@uni-koblenz.de,
	linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
	linux-mips@vger.rutgers.edu
References: <19990215014103.D644@uni-koblenz.de> <m10CPiv-0007U1C@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <m10CPiv-0007U1C@the-village.bc.nu>; from Alan Cox on Mon, Feb 15, 1999 at 03:14:12PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > Due to a collission with Linus sources I had to change the value of this
> > define to 19 in include/linux/videodev.h for the merge.
> 
> And you'll continue to get collisions until you submit me a patch to add it
> to the master set 8)

Has Ralf already done this or should I do it?

- Ulf
