Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA40014 for <linux-archive@neteng.engr.sgi.com>; Wed, 5 May 1999 16:17:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA02105
	for linux-list;
	Wed, 5 May 1999 16:14:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA27385
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 5 May 1999 16:14:45 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA24717
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 May 1999 16:14:10 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-25.uni-koblenz.de [141.26.131.25])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA07436
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 May 1999 01:14:21 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id RAA00755;
	Wed, 5 May 1999 17:40:22 +0200
Message-ID: <19990505174022.B557@uni-koblenz.de>
Date: Wed, 5 May 1999 17:40:22 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Charles Lepple <clepple@foo.tho.org>,
        Linux/SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: CP0_STATUS interrupt mask patch
References: <Pine.LNX.4.04.9905041342400.30478-100000@foo.tho.org> <372FA277.D3174BF4@foo.tho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <372FA277.D3174BF4@foo.tho.org>; from Charles Lepple on Wed, May 05, 1999 at 01:44:23AM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, May 05, 1999 at 01:44:23AM +0000, Charles Lepple wrote:

> Charles Lepple wrote:
> > I just pulled down the CVS kernel with the patch, and it seems that it
> > causes a 'keyboard timeout[2]' to be printed on the console after the SCSI
> 
> Omitted a critical detail -- it hangs hard-core after this message.
> Evidently the power button was initialized by this point, because it
> doesn't turn off immediately, and it doesn't start the LED blinking
> indicating an impending power-off.

The power button is handled during interrupts so when the interrupt
handling is fsck'ed the button won't work, too.

I'll look at it.

  Ralf
