Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA16998 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 16:10:24 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA13046 for linux-list; Wed, 14 Jan 1998 16:10:03 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA13038 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 16:10:01 -0800
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA27544
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 16:07:40 -0800
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.7/8.8.7) id RAA07990;
	Wed, 14 Jan 1998 17:59:27 -0600
Date: Wed, 14 Jan 1998 17:59:27 -0600
Message-Id: <199801142359.RAA07990@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: tsbogend@alpha.franken.de
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <19980114215847.36294@alpha.franken.de> (message from Thomas
	Bogendoerfer on Wed, 14 Jan 1998 21:58:47 +0100)
Subject: Re: The world's worst RPM
X-Windows: A terminal disease.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> hmm, to do this with only one src.rpm, we need a little support from
> rpm. At the moment mips is defined for mipsel and mipseb. I would suggest,
> that for .spec execution mips is defined for bot mipsel and mipseb, because 
> there are changes, which work for both and we only need to seperate changes 
> like that needed by ncompress.  Comments ? Does anybody how to do this ?

The code should be fixed to autoconfigure itself by using the
__LITTLE_ENDIAN and __BIG_ENDIAN macros that are defined somewhere in
/usr/include.  And ship the patch with this.

Miguel. 
