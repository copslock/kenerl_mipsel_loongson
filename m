Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA10054 for <linux-archive@neteng.engr.sgi.com>; Thu, 28 Jan 1999 15:05:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA72760
	for linux-list;
	Thu, 28 Jan 1999 15:04:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA72563
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 28 Jan 1999 15:04:07 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA05900
	for <linux@cthulhu.engr.sgi.com>; Thu, 28 Jan 1999 15:04:04 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA08201
	for <linux@cthulhu.engr.sgi.com>; Thu, 28 Jan 1999 18:05:55 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 28 Jan 1999 18:05:54 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: More HAL2 debugging..
Message-ID: <Pine.LNX.3.96.990128180500.25641T-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Here's the latest:

resetting global isr:0018
reset done isr:0000
reactivation done isr:0000
SGI HAL2 Processor, Revision 4.1.0
hal2: checking registers
hal2: waiting isr:0000 idr0:0000 idr1:ffff idr2:0000 idr3:0000
hal2: finished waiting at cnt:1000 isr:0000 idr0:0000 idr1:ffff idr2:0000
idr3:0000
hal2: wrote #1
hal2: waiting isr:0000 idr0:0000 idr1:0000 idr2:0000 idr3:0000
hal2: finished waiting at cnt:1000 isr:0000 idr0:0000 idr1:0000 idr2:0000
idr3:0000
hal2: wrote #2
hal2: waiting isr:0000 idr0:0000 idr1:0000 idr2:0000 idr3:0000
hal2: finished waiting at cnt:1000 isr:0000 idr0:0000 idr1:0000 idr2:0000
idr3:0000
hal2: Didn't pass register check #1 (0000)
sgiaudio: unable to find hal2 subsystem


-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
