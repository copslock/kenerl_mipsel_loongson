Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA40241 for <linux-archive@neteng.engr.sgi.com>; Sun, 18 Oct 1998 07:57:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA85036
	for linux-list;
	Sun, 18 Oct 1998 07:57:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA99445
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 18 Oct 1998 07:56:59 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (dialup168-4-32.swipnet.se [130.244.168.224]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA09989
	for <linux@cthulhu.engr.sgi.com>; Sun, 18 Oct 1998 07:56:54 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: by zigzegv.ml.org
	via sendmail from stdin
	id <m0zUuHr-000w6YC@calypso.saturn> (Debian Smail3.2.0.101)
	for linux@cthulhu.engr.sgi.com; Sun, 18 Oct 1998 16:58:27 +0200 (CEST) 
Message-ID: <19981018165826.A15078@zigzegv.ml.org>
Date: Sun, 18 Oct 1998 16:58:26 +0200
From: Ulf Carlsson <grim@zigzegv.ml.org>
To: btoscano@shell.monmouth.com
Cc: linux@cthulhu.engr.sgi.com
Subject: 2.1.121 with R4[04]00SC support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

For Brian Toscano and everyone else who can't compile their own kernels, I've
compiled a kernel with Ralf's SC fixes (the latest CVS tree) for your needs.
It's available at ftp://ballyhoo.ml.org/sgi-linux/linux-2.1.121.tar.gz.

It has BOOTP, NFS-Root and all the stuff you'll need to install Hardhat.

Have fun!

- Ulf
