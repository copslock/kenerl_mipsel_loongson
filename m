Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA35071 for <linux-archive@neteng.engr.sgi.com>; Wed, 7 Apr 1999 21:17:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA49697
	for linux-list;
	Wed, 7 Apr 1999 21:15:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA40081
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 7 Apr 1999 21:14:59 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup71-5-11.swipnet.se [130.244.71.75]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA07612
	for <linux@cthulhu.engr.sgi.com>; Wed, 7 Apr 1999 21:14:57 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id GAA05275;
	Thu, 8 Apr 1999 06:14:52 +0200
Date: Thu, 8 Apr 1999 06:14:52 +0200
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: HAL2 driver 0.2
Message-ID: <19990408061452.A5242@bun.falkenberg.se>
Mail-Followup-To: Matthias Kleinschmidt <mkleinschmidt@gmx.de>,
	Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990406221641.A6206@bun.falkenberg.se> <19990407015956.A2584@fmc-container.mach.uni-karlsruhe.de> <19990407122257.D19733@bun.falkenberg.se> <19990407134133.A925@fmc-container.mach.uni-karlsruhe.de> <19990407202731.A1042@bun.falkenberg.se> <19990407171538.A3751@fmc-container.mach.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <19990407171538.A3751@fmc-container.mach.uni-karlsruhe.de>; from Matthias Kleinschmidt on Wed, Apr 07, 1999 at 05:15:38PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Ok, I apologize. I forgot to rebuild soundcore.o. Now I can load the
> modules. But the order in your HOWTO is wrong. I had to load snd-timer
> before snd-pcm1. Playing wavs and mpegs works as well after building the
> ALSA devices.

Ok, this is another thing I forgot. I did a ``make install'' once so my devices
where ok all the time. Maybe I can extract that util which sets up the devices
from ALSA or is it included in the RPM?

I've fixed the HOWTO now.

> Great job!

Thanks :-)

> > rpm --rebuild alsa-driver-0.3.0-pre5-2.src.rpm 
> 
> Unfortunately that did not work. Maybe because all files in that package have
> timestamps Jan xx 2000?

I have set my clock correctly now, I actually did that yesterday. I have also
touched the all the files on my harddrives so I will not end up with any Jan xx
2000 files again. I'll upload correct versions..

- Ulf
