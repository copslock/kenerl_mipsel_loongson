Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA09200 for <linux-archive@neteng.engr.sgi.com>; Thu, 8 Oct 1998 11:16:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA96844
	for linux-list;
	Thu, 8 Oct 1998 11:15:12 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA87243;
	Thu, 8 Oct 1998 11:15:09 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA04238; Thu, 8 Oct 1998 11:15:03 -0700
Date: Thu, 8 Oct 1998 11:15:03 -0700
Message-Id: <199810081815.LAA04238@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ulf Carlsson <grim@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: R4600PC upgrade
In-Reply-To: <Pine.LNX.3.96.981008115329.995B-100000@calypso.saturn>
References: <Pine.LNX.3.96.981008115329.995B-100000@calypso.saturn>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson writes:
 > Hi,
 > 
 > I received a R4600PC today (thanks Lukas), and I happily went to my Indy
 > and plugged it in instead of my R4000SC. It failed on the diagnostics test
 > though. 
...
     If your machine is an early R4000SC machine, you may well need a new
PROM to go with the newer processor.  The final PROM, supplied with all
R5000 systems, works with all processors, but a given older PROM generally
does not work with newer processors.  The error message looks like the
result of using an obsolete PROM.
