Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA07987; Wed, 9 Apr 1997 11:38:07 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA10719 for linux-list; Wed, 9 Apr 1997 11:37:34 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA10708 for <linux@cthulhu.engr.sgi.com>; Wed, 9 Apr 1997 11:37:32 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id LAA21250; Wed, 9 Apr 1997 11:37:30 -0700
Received: (from wje@localhost) by fir.esd.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA27718; Wed, 9 Apr 1997 11:37:30 -0700
Date: Wed, 9 Apr 1997 11:37:30 -0700
Message-Id: <199704091837.LAA27718@fir.esd.sgi.com>
From: "William J. Earl" <wje@fir.esd.sgi.com>
To: Ralf Baechle <ralf@Julia.DE>
Cc: shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com,
        kneedham@ottawa.sgi.com
Subject: Re: It booooooooooots!
In-Reply-To: <199704090525.HAA06508@kernel.panic.julia.de>
References: <199704082337.QAA14690@fir.esd.sgi.com>
	<199704090525.HAA06508@kernel.panic.julia.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > > ...
 > >  > Checking for 'wait' instruction...  unavailable.
 > > ...
 > > 
 > >      This appears to be a bug.  The R5000 does have the wait instruction.
 > 
 > Linux doesn't really check; instead it has encoded which CPU types
 > have a wait instruction.  I add the R500 to that list.

     As far as I know, all QED processors have the "wait" instruction.
All the 0x2???  processor ID values are QED processors.  Here are the current
values:

#define C0_IMP_NEVADA	0x28
#define C0_IMP_RM7000	0x27
#define C0_IMP_MAGIC	0x25
#define C0_IMP_SONIC	0x24
#define	C0_IMP_R5000 	0x23
#define	C0_IMP_R4650 	0x22 
#define	C0_IMP_R4700 	0x21
#define	C0_IMP_R4600 	0x20

I don't know which processors are SONIC, MAGIC, or NEVADA, but I think NEVADA
is the new RM5260 (a low-cost R5000).  
