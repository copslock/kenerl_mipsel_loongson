Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA40179 for <linux-archive@neteng.engr.sgi.com>; Wed, 7 Apr 1999 11:48:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA90056
	for linux-list;
	Wed, 7 Apr 1999 11:45:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA01177
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 7 Apr 1999 11:45:33 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup87-5-14.swipnet.se [130.244.87.78]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA01678
	for <linux@cthulhu.engr.sgi.com>; Wed, 7 Apr 1999 11:45:31 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id UAA01063;
	Wed, 7 Apr 1999 20:27:32 +0200
Date: Wed, 7 Apr 1999 20:27:31 +0200
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: HAL2 driver 0.2
Message-ID: <19990407202731.A1042@bun.falkenberg.se>
Mail-Followup-To: Matthias Kleinschmidt <mkleinschmidt@gmx.de>,
	Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990406221641.A6206@bun.falkenberg.se> <19990407015956.A2584@fmc-container.mach.uni-karlsruhe.de> <19990407122257.D19733@bun.falkenberg.se> <19990407134133.A925@fmc-container.mach.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <19990407134133.A925@fmc-container.mach.uni-karlsruhe.de>; from Matthias Kleinschmidt on Wed, Apr 07, 1999 at 01:41:33PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I had version information activated in the first place. Now I compiled the
> kernel without it and installed alsa...-pre5-2...  but I still have unresolved
> modules. 
> 
> insmod snd.o now gives me
> 
> snd.o: unresolved symbol register_sound_dsp_Rb255d4ae snd.o: unresolved symbol
> register_sound_special_Rdf061e7e

This is a bit strange. I don't have those symbols either. I have the normal
register_sound_dsp and register_sound_special symbols. I'm looking at this
problem and how I'll solve it completely. It's a bit tricky to build modules
which are compatible.

It looks like the rest of the symbols in the kernel are resolved. Maybe you
forgot to rebuild the modules or to install them when you built them?

Anyhow, in the meanwhile you may build your own driver package. There shouldn't
be any problem if you have a kernel installed in /usr/src/linux, just get the
source package of the drivers instead an execute:

rpm --rebuild alsa-driver-0.3.0-pre5-2.src.rpm 

(Please have a bit patiance, you're the first tester)

- Ulf
