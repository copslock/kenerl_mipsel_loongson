Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA13892 for <linux-archive@neteng.engr.sgi.com>; Wed, 7 Apr 1999 03:35:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA07862
	for linux-list;
	Wed, 7 Apr 1999 03:33:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA40582
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 7 Apr 1999 03:33:07 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup88-11-1.swipnet.se [130.244.88.161]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA08973
	for <linux@cthulhu.engr.sgi.com>; Wed, 7 Apr 1999 03:33:05 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id MAA25694;
	Wed, 7 Apr 1999 12:22:57 -0400
Date: Wed, 7 Apr 1999 12:22:57 -0400
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: HAL2 driver 0.2
Message-ID: <19990407122257.D19733@bun.falkenberg.se>
Mail-Followup-To: Matthias Kleinschmidt <mkleinschmidt@gmx.de>,
	Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990406221641.A6206@bun.falkenberg.se> <19990407015956.A2584@fmc-container.mach.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <19990407015956.A2584@fmc-container.mach.uni-karlsruhe.de>; from Matthias Kleinschmidt on Wed, Apr 07, 1999 at 01:59:56AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I got a new kernel from cvs and compiled with soundcore.o.
> When I try to install alsa-driver-0.3.0-pre5-1.mipseb.rpm I get many errors
> about unresolved symbols. And when I try to load snd.o I get the following
> output:

Oops, sorry. I had compiled the modules with a kernel configured to set version
information on all symbols. I've uploaded a new version, this problem should be
solved now. Please download alsa-driver-0.3.0-pre5-2.mipseb.rpm instead.

- Ulf
