Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA85723 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Jun 1999 06:33:20 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA27076
	for linux-list;
	Fri, 25 Jun 1999 06:31:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA55425
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 25 Jun 1999 06:30:58 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup145-1-28.swipnet.se [130.244.145.28]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA02862
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jun 1999 06:30:50 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10xW4S-003Lo9C; Fri, 25 Jun 1999 15:31:08 +0200 (CEST)
Date: Fri, 25 Jun 1999 15:31:08 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: File corruption
Message-ID: <19990625153108.A8684@thepuffingroup.com>
Mail-Followup-To: Ralf Baechle <ralf@uni-koblenz.de>,
	linux@cthulhu.engr.sgi.com
References: <19990622032859.B6955@thepuffingroup.com> <19990622152145.A1059@uni-koblenz.de> <19990623014923.A8953@thepuffingroup.com> <19990625002853.D17220@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <19990625002853.D17220@uni-koblenz.de>; from Ralf Baechle on Fri, Jun 25, 1999 at 12:28:53AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > > And under which kernel version did this start to happen?
> > 
> > 2.2.1 I think.
> 
> Are you shure?  The problem Alan is tracking started to hit from 2.2.7 on.  If
> 2.2.1 already starts making these kind of troubles then we probably track two
> different problems.

Probably.  I have a new problem with the 2.3.8 kernel now as well:  Page->owner
becomes -1 at line 1218 in buffer.c, thus forcing an oops.  This happens when I
try to cat a couple of big files into a new file.  This is even reproduceable...

I get some error messages before the oops as well:

attempt to access beyond end of device
08:01: rw=0, want=122156967, limit=929559
attempt to access beyond end of device
08:01: rw=0, want=886680107, limit=929559

> > Unfortunately I don't have IRIX.  However, I have a 133 MHz R4600 CPU with
> > 512 k board cache.  I have two 1 Gb SCSI driver connected.
> 
> Is this a low-mem configuration?  The problem Alan is tracking apparently
> seems to hit low mem systems more often.

Not really, I have 128 Mb RAM, but no swap.

Regards,
Ulf
