Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA95701 for <linux-archive@neteng.engr.sgi.com>; Fri, 7 May 1999 15:24:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA20277
	for linux-list;
	Fri, 7 May 1999 15:23:12 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA62048
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 7 May 1999 15:23:09 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup85-8-4.swipnet.se [130.244.85.116]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA14515
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 May 1999 15:22:37 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10ft1e-003LopC; Sat, 8 May 1999 00:23:22 +0200 (CEST)
Date: Sat, 8 May 1999 00:23:22 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: Charles Lepple <clepple@foo.tho.org>,
        Linux/SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: CP0_STATUS interrupt mask patch
Message-ID: <19990508002321.A15858@thepuffingroup.com>
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

Ok, you don't have to look at it I think since I just smashed the bug.

I found that indy_sc_wipe corrupted the interrupt mask, and that it relayed on
that it was restored by other functions to a correct state again.

My R4600SC boots fine now with Harald's new patches.

- Ulf
