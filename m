Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA25565 for <linux-archive@neteng.engr.sgi.com>; Wed, 2 Jun 1999 10:58:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA38905
	for linux-list;
	Wed, 2 Jun 1999 10:56:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id KAA11402;
	Wed, 2 Jun 1999 10:56:28 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA04212; Wed, 2 Jun 1999 10:56:27 -0700
Date: Wed, 2 Jun 1999 10:56:27 -0700
Message-Id: <199906021756.KAA04212@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: "Robert Keller" <rck@corp.home.net>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux@cthulhu.engr.sgi.com
Subject: Re: after the kernel seems to live
In-Reply-To: <4.1.19990602093023.03e1b5d0@poptart>
References: <4.1.19990527124423.00930cd0@mail>
	<4.1.19990526115716.03f65930@mail>
	<19990527121840.T866@uni-koblenz.de>
	<19990528004632.B608@uni-koblenz.de>
	<4.1.19990602093023.03e1b5d0@poptart>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Robert Keller writes:
 > At 12:46 AM 5/28/99 +0200, Ralf Baechle wrote:
 > >The R5000 is supported and known to work.  You happen to have a
 > >second level cache on that board?
 > 
 > how convinced are people that the VR5000 is supported?  I'm running
 > the latest code off the linux.sgi.com cvs server and I'm getting *very*
 > weird page faulting problems when doing the kernel/user space 
 > hazard shuffle.  Its really hard to describe the problems as they are
 > not deterministic:  sometimes the right thing happens, other times 
 > I get restricted instruction exceptions...  Both of these can happen on
 > the very same kernel binary...

        What sort of system are you using, and what is the hardware configuration
(including caches)?  
