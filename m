Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA798906 for <linux-archive@neteng.engr.sgi.com>; Tue, 24 Mar 1998 08:14:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id IAA2384050
	for linux-list;
	Tue, 24 Mar 1998 08:14:19 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA3153755
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 24 Mar 1998 08:14:17 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA20296
	for <linux@cthulhu.engr.sgi.com>; Tue, 24 Mar 1998 08:14:13 -0800 (PST)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id RAA27456
	for <linux@cthulhu.engr.sgi.com>; Tue, 24 Mar 1998 17:13:54 +0100 (MET)
Received: by zaphod (SMI-8.6/KO-2.0)
	id RAA28729; Tue, 24 Mar 1998 17:13:51 +0100
Message-ID: <19980324171351.40801@uni-koblenz.de>
Date: Tue, 24 Mar 1998 17:13:51 +0100
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com
Subject: Re: More fixes
References: <19980323225125.14671@uni-koblenz.de> <Pine.LNX.3.96.980324160922.650B-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Forgot to mention that I fixed the reported reboot problems.  On
reboot / halt the machine now ends in the firmware and does the right
thing.  We still don't powerdown the machine on halt and it would be
nice to support the power button on the front panel, and btw we could
implement uadmin(2) for the IRIX compat shit.  Will have to read
a bit in /unix about how to do that or so, grmpf...

  Ralf
