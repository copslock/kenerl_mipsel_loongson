Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA53529 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Feb 1999 16:03:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA86197
	for linux-list;
	Mon, 8 Feb 1999 16:02:59 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA83363
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 8 Feb 1999 16:02:57 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03346
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Feb 1999 16:02:55 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA23607
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Feb 1999 19:06:22 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 8 Feb 1999 19:06:22 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Moving drivers/sgi around
Message-ID: <Pine.LNX.3.96.990208190349.11444F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Are there any objections to me moving drivers/sgi and merging them into
the 'correct' places?  The places in question are:

newport and colsole stuff: drivers/video
hal: drivers/sound
vino: drivers/char (which is there, actually)

Any objections?

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
