Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA37784 for <linux-archive@neteng.engr.sgi.com>; Sun, 24 Jan 1999 13:00:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA04254
	for linux-list;
	Sun, 24 Jan 1999 13:00:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA28833
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 24 Jan 1999 13:00:13 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05746
	for <linux@cthulhu.engr.sgi.com>; Sun, 24 Jan 1999 16:00:07 -0500 (EST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id QAA19261
	for <linux@cthulhu.engr.sgi.com>; Sun, 24 Jan 1999 16:01:19 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 24 Jan 1999 16:01:19 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: HAL2 support.
Message-ID: <Pine.LNX.3.96.990124153515.17852A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


There's a rumour going around that Ulf has had some luck with getting HAL2
support working.  If there's any truth to this,a dn so that we don't
reinvent the wheel, does anyone know where this source might be?

Also, am I right in saying that there's no devices written for HPC3 that
use the pbus?  Looks like the first step to writing a HAL driver is to be
able to write to the pbus.

What else is actually on the pbus on the Indy?  From this HPC
documentation, looks
like:
- fdc (I thought Indy floppies were SCSI though)
- rtc
- prom
- scsi (although not the 33c93)
- int2 (what's this?)
- hal2
- pi1 (what's this?)

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
