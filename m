Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA10418 for <linux-archive@neteng.engr.sgi.com>; Sun, 14 Feb 1999 15:33:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA83599
	for linux-list;
	Sun, 14 Feb 1999 15:32:29 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA73671
	for <linux@engr.sgi.com>;
	Sun, 14 Feb 1999 15:32:25 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00148
	for <linux@engr.sgi.com>; Sun, 14 Feb 1999 15:32:24 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-26.uni-koblenz.de [141.26.131.26])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA18485
	for <linux@engr.sgi.com>; Mon, 15 Feb 1999 00:32:21 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA20228;
	Mon, 15 Feb 1999 00:29:03 +0100
Message-ID: <19990215002746.C644@uni-koblenz.de>
Date: Mon, 15 Feb 1999 00:27:46 +0100
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Memory corruption on Indy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

since quite some time I've tried to find a memory corruption bug on my Indy.
I now suspect that the actual cause is a hardware problem and a recent
IRIX kernel core dump supports that theory.  Just to be on the safe side,
could people running Linux on Indys please run something like

  find / -fstype ext2 -type f | xargs md5sym

several times and compare the obtained output.  Do they differ in any
unexplainable way?

Thanks,

  Ralf
