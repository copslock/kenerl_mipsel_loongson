Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA55233 for <linux-archive@neteng.engr.sgi.com>; Tue, 26 Jan 1999 09:02:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA60217
	for linux-list;
	Tue, 26 Jan 1999 09:01:39 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA69147
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 26 Jan 1999 09:01:38 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA09879
	for <linux@cthulhu.engr.sgi.com>; Tue, 26 Jan 1999 09:01:37 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id MAA23754
	for <linux@cthulhu.engr.sgi.com>; Tue, 26 Jan 1999 12:03:08 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 26 Jan 1999 12:03:08 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Parallel port support.
Message-ID: <Pine.LNX.3.96.990126120139.12068J-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I've never seen any documentation of the parallel port that hangs off of
the pbus; does anyone know:
- what kind of chip it is
- how it hangs off of the pbus?

I'm thinking this is a pretty easy device driver to write for testing that
the pbus code works well.  It'd help out with HAL2 support.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
