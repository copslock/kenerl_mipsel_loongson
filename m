Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA94148 for <linux-archive@neteng.engr.sgi.com>; Tue, 4 May 1999 14:51:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA99396
	for linux-list;
	Tue, 4 May 1999 14:50:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA90066
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 4 May 1999 14:50:08 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA25677
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 May 1999 14:49:34 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-12.uni-koblenz.de [141.26.131.12])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA21965
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 May 1999 23:49:53 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id MAA05070;
	Tue, 4 May 1999 12:59:03 +0200
Message-ID: <19990504125903.G3700@uni-koblenz.de>
Date: Tue, 4 May 1999 12:59:03 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Andrew R. Baker" <andrewb@uab.edu>,
        Ulf Carlsson <ulfc@thepuffingroup.com>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Indigo2 patch
References: <19990502205347.A7346@thepuffingroup.com> <Pine.LNX.3.96.990502202759.15211B-100000@mdk187.tucc.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990502202759.15211B-100000@mdk187.tucc.uab.edu>; from Andrew R. Baker on Sun, May 02, 1999 at 08:31:20PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, May 02, 1999 at 08:31:20PM -0500, Andrew R. Baker wrote:

> Any chance on getting the cross linker fixed?

I'll have the time to work on this soon again.  However just removing -N
does the job; there are no other known kernel build problems with
binutils 2.8.1.

  Ralf
