Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA84745 for <linux-archive@neteng.engr.sgi.com>; Fri, 7 May 1999 13:02:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA27483
	for linux-list;
	Fri, 7 May 1999 12:59:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA03302
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 7 May 1999 12:59:54 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup87-4-8.swipnet.se [130.244.87.56]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07382
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 May 1999 15:59:52 -0400 (EDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10fqmx-003LopC; Fri, 7 May 1999 22:00:03 +0200 (CEST)
Date: Fri, 7 May 1999 22:00:03 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: Charles Lepple <clepple@foo.tho.org>,
        Linux/SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: CP0_STATUS interrupt mask patch
Message-ID: <19990507220003.A15826@thepuffingroup.com>
Mail-Followup-To: Ralf Baechle <ralf@uni-koblenz.de>,
	Charles Lepple <clepple@foo.tho.org>,
	Linux/SGI <linux@cthulhu.engr.sgi.com>
References: <Pine.LNX.4.04.9905041342400.30478-100000@foo.tho.org> <372FA277.D3174BF4@foo.tho.org> <19990505174022.B557@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <19990505174022.B557@uni-koblenz.de>; from Ralf Baechle on Wed, May 05, 1999 at 05:40:22PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, May 05, 1999 at 05:40:22PM +0200, Ralf Baechle wrote:
> On Wed, May 05, 1999 at 01:44:23AM +0000, Charles Lepple wrote:
> 
> > Charles Lepple wrote:
> > > I just pulled down the CVS kernel with the patch, and it seems that it
> > > causes a 'keyboard timeout[2]' to be printed on the console after the SCSI
> > 
> > Omitted a critical detail -- it hangs hard-core after this message.
> > Evidently the power button was initialized by this point, because it
> > doesn't turn off immediately, and it doesn't start the LED blinking
> > indicating an impending power-off.
> 
> The power button is handled during interrupts so when the interrupt
> handling is fsck'ed the button won't work, too.
> 
> I'll look at it.

I'm having this problem as well..

- Ulf
