Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA2620802 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Apr 1998 13:48:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA6605889
	for linux-list;
	Wed, 1 Apr 1998 13:48:50 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA6625337
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Apr 1998 13:48:49 -0800 (PST)
Received: from calypso.saturn (dialup184-3-49.swipnet.se [130.244.184.177]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA10394
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 13:48:29 -0800 (PST)
	mail_from (grimsy@zigzegv.ml.org)
Received: from localhost (grimsy@localhost)
	by calypso.saturn (8.8.8/8.8.8/Debian/GNU) with SMTP id AAA00617;
	Thu, 2 Apr 1998 00:50:50 +0200
Date: Thu, 2 Apr 1998 00:50:47 +0200 (CEST)
From: Ulf Carlsson <grimsy@zigzegv.ml.org>
X-Sender: grimsy@calypso.saturn
To: ralf@uni-koblenz.de
cc: Oliver Frommel <oliver@aec.at>, linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
In-Reply-To: <19980401223954.56814@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980402004913.599A-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Message-ID: <19980401225047.-ggr4v1ndaYeT-a6rdymFqFOA0pP1zI7nuCAGErjieA@z>

On Wed, 1 Apr 1998 ralf@uni-koblenz.de wrote:

> On Wed, Apr 01, 1998 at 08:54:55PM +0200, Ulf Carlsson wrote:
> 
> > eth0: SGI Seeq8003 08:00:69:07:a8:c7
> > Unable to handle kernel paging request at virtual address 00000008, epc ==
> > 880ce1f4, ra == 880ce1d4
> 
> That one seems to be a pretty nasty one.  What is happening is something
> that looks like the caches are writing the values back with a certain
> delay or not at all.  Not good ...

Isn't this the same old bug we've had for months now? It's atleast the
same error text - 'unable to handle kernel paging request at bla bla..'.

- Ulf
