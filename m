Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id OAA642297 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Feb 1998 14:58:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA21227 for linux-list; Thu, 26 Feb 1998 14:56:31 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA21214 for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 14:56:29 -0800
Received: from informatik.uni-koblenz.de ([141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA02774
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 14:56:27 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-29.uni-koblenz.de [141.26.249.29])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA26496
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 23:56:24 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA04230;
	Thu, 26 Feb 1998 23:53:00 +0100
Message-ID: <19980226235300.23817@uni-koblenz.de>
Date: Thu, 26 Feb 1998 23:53:00 +0100
To: Ulf Carlsson <grimsy@varberg.se>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
References: <Pine.LNX.3.96.980226095100.2735A-100000@calypso.saturn> <Pine.LNX.3.96.980226112524.2914B-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.96.980226112524.2914B-100000@calypso.saturn>; from Ulf Carlsson on Thu, Feb 26, 1998 at 11:41:26AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Feb 26, 1998 at 11:41:26AM +0100, Ulf Carlsson wrote:

> Hello again.
> 
> I'm getting pretty tired. No progress at all. Is my configuration special
> in any way?
> 
> System: IP22
> Processor: 100 Mhz R4000, with FPU
> Primary I-cache size: 8 kbytes
> Primary d-cache size: 8 kbytes
> Secondary cache size: 1024 Kbytes

So this must be a R4000SC CPU.  The CPU support code for it is buggy, that's
why it it's working.

Fixes probably coming next week; as think are looking I'll have a hell lot
of time again by then.

  Ralf
