Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA83649 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Jun 1999 10:01:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA28693
	for linux-list;
	Fri, 25 Jun 1999 09:58:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA21493
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 25 Jun 1999 09:58:51 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup252-1-52.swipnet.se [130.244.252.52]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA08758
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jun 1999 09:58:48 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10xZJi-003Lo9C; Fri, 25 Jun 1999 18:59:06 +0200 (CEST)
Date: Fri, 25 Jun 1999 18:59:06 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Andrew Linfoot <andy@derfel99.freeserve.co.uk>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: File corruption
Message-ID: <19990625185906.A9050@thepuffingroup.com>
Mail-Followup-To: Andrew Linfoot <andy@derfel99.freeserve.co.uk>,
	linux@cthulhu.engr.sgi.com
References: <19990622032859.B6955@thepuffingroup.com> <19990622152145.A1059@uni-koblenz.de> <19990623014923.A8953@thepuffingroup.com> <19990625002853.D17220@uni-koblenz.de> <002701bebf17$cd9e4fd0$0a02030a@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <002701bebf17$cd9e4fd0$0a02030a@snafu>; from Andrew Linfoot on Fri, Jun 25, 1999 at 03:34:15PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jun 25, 1999 at 03:34:15PM +0100, Andrew Linfoot wrote:
> I have been running 2.2.1 on my indy for about 3 weeks now and have
> encountered problems like this, in fact i am surprised at how stable the box
> is, i have been doing some quite large builds of qt, kde and the like too. If
> this is reproducible then i would be prepared to experiment on one of my
> boxes.

It doesn't crash, only file corruption..

> The only gripe i have is that the scsi driver breaks when i attach external
> devices, any ideas?

I have file corruption without any external devices.  It looks like the problems
appear when more than one SCSI devices are present.  You only have one internal
SCSI drive, right?

Do you mind telling us more exactly what type of file corruption you suffer
from?  It would also help if you could attach an output from hinv, or just tell
us what hardware you have.

Regards,
Ulf
