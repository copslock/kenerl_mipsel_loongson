Received:  by oss.sgi.com id <S553778AbRAaWhT>;
	Wed, 31 Jan 2001 14:37:19 -0800
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:43787 "HELO MIT.EDU")
	by oss.sgi.com with SMTP id <S553738AbRAaWhI>;
	Wed, 31 Jan 2001 14:37:08 -0800
Received: from GRAND-CENTRAL-STATION.MIT.EDU by MIT.EDU with SMTP
	id AA13290; Wed, 31 Jan 01 17:35:32 EST
Received: from melbourne-city-street.MIT.EDU (MELBOURNE-CITY-STREET.MIT.EDU [18.69.0.45])
	by grand-central-station.MIT.EDU (8.9.2/8.9.2) with ESMTP id RAA16794
	for <linux-mips@oss.sgi.com>; Wed, 31 Jan 2001 17:36:59 -0500 (EST)
Received: from scrubbing-bubbles.mit.edu (SCRUBBING-BUBBLES.MIT.EDU [18.184.0.32])
	by melbourne-city-street.MIT.EDU (8.9.3/8.9.2) with ESMTP id RAA15468
	for <linux-mips@oss.sgi.com>; Wed, 31 Jan 2001 17:36:55 -0500 (EST)
Received: from localhost (kbarr@localhost) by scrubbing-bubbles.mit.edu (8.9.3) with ESMTP
	id RAA04420; Wed, 31 Jan 2001 17:36:55 -0500 (EST)
Date:   Wed, 31 Jan 2001 17:36:54 -0500 (EST)
From:   Kenneth C Barr <kbarr@MIT.EDU>
To:     <linux-mips@oss.sgi.com>
Subject: netbooting indy
Message-Id: <Pine.GSO.4.30L.0101311648280.22989-100000@home-on-the-dome.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I finally got bootp/tftp to answer my indy's pleas for an image, but get
the following behavior (with my own IP addr and server, obviously):

>> boot bootp():/vmlinux
   73264+592+11520+331680+27848d+3628+5792 entry: 0x8df9a960
   Setting $netaddres to 192.168.1.5 (from server deadmoon)
   Obtaining /vmlinux from server deadmoon

i get a spinning cursor, which becomes the letter "n" and the entire
machine (including keyboard, mouse) locks.

A packet trace with ethereal reveals the indy ack'ing 2730 packets of 512
bytes each (1,397,760) before sending a "TFTP Error Code" packet:

Opcode: Error Code (5)
Error Code: Disk full or allocation exceeded (3)

The server's disks are not full, and my impression was that the indy would
be d/ling the vmlinux image into memory, not disk.  I have 64MB of RAM.

I repeated the process and got the same "n"-freeze a second time.

What does this behavior indicate?  (I didn't see it in HOWTO common
errors)  How can I fix it?

Thanks for your ideas,
Ken
