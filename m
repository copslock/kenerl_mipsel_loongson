Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA00164 for <linux-archive@neteng.engr.sgi.com>; Sun, 14 Feb 1999 17:05:48 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA38587
	for linux-list;
	Sun, 14 Feb 1999 17:05:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA74013
	for <linux@engr.sgi.com>;
	Sun, 14 Feb 1999 17:05:07 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA04299
	for <linux@engr.sgi.com>; Sun, 14 Feb 1999 17:05:05 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-15.uni-koblenz.de [141.26.131.15])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA17176
	for <linux@engr.sgi.com>; Mon, 15 Feb 1999 02:04:25 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id BAA22094;
	Mon, 15 Feb 1999 01:41:04 +0100
Message-ID: <19990215014103.D644@uni-koblenz.de>
Date: Mon, 15 Feb 1999 01:41:03 +0100
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: VID_HARDWARE_VINO
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Due to a collission with Linus sources I had to change the value of this
define to 19 in include/linux/videodev.h for the merge.

  Ralf
