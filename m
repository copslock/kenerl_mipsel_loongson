Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA2284570 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Apr 1998 12:40:43 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id MAA6593357
	for linux-list;
	Wed, 1 Apr 1998 12:40:09 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA6581536
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Apr 1998 12:40:07 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA13654
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 12:40:05 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (dali.uni-koblenz.de [141.26.5.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA14491
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 22:40:04 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA06371;
	Wed, 1 Apr 1998 22:39:56 +0200
Message-ID: <19980401223954.56814@uni-koblenz.de>
Date: Wed, 1 Apr 1998 22:39:54 +0200
To: Ulf Carlsson <grimsy@ballyhoo.ml.org>
Cc: Oliver Frommel <oliver@aec.at>, linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
References: <19980401202840.22363@uni-koblenz.de> <Pine.LNX.3.96.980401204441.21805E-100000@ballyhoo.ml.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.96.980401204441.21805E-100000@ballyhoo.ml.org>; from Ulf Carlsson on Wed, Apr 01, 1998 at 08:54:55PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 01, 1998 at 08:54:55PM +0200, Ulf Carlsson wrote:

> eth0: SGI Seeq8003 08:00:69:07:a8:c7
> Unable to handle kernel paging request at virtual address 00000008, epc ==
> 880ce1f4, ra == 880ce1d4

That one seems to be a pretty nasty one.  What is happening is something
that looks like the caches are writing the values back with a certain
delay or not at all.  Not good ...

  Ralf
