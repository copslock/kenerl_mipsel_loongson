Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA15595 for <linux-archive@neteng.engr.sgi.com>; Fri, 7 Aug 1998 14:29:33 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA72878
	for linux-list;
	Fri, 7 Aug 1998 14:28:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA71802
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 7 Aug 1998 14:28:54 -0700 (PDT)
	mail_from (ehlert@anatu.uni-tuebingen.de)
Received: from mx02.uni-tuebingen.de (mx02.uni-tuebingen.de [134.2.3.12]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA13712
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 Aug 1998 14:28:51 -0700 (PDT)
	mail_from (ehlert@anatu.uni-tuebingen.de)
Received: from mail.anatom.uni-tuebingen.de (root@mail.anatom.uni-tuebingen.de [134.2.135.146])
	by mx02.uni-tuebingen.de (8.8.8/8.8.8) with ESMTP id XAA31130
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 Aug 1998 23:28:50 +0200
Received: from localhost by mail.anatom.uni-tuebingen.de
	 with smtp id m0z4u4S-00077WC
	(Debian Smail-3.2 1996-Jul-4 #2); Fri, 7 Aug 1998 23:29:08 +0200 (MET DST)
Date: Fri, 7 Aug 1998 23:29:07 +0200 (MET DST)
From: Alexander Ehlert <ehlert@anatu.uni-tuebingen.de>
X-Sender: ehlert@mail.anatom.uni-tuebingen.de
To: linux@cthulhu.engr.sgi.com
Subject: Install does not work
Message-ID: <Pine.LNX.3.95.980807232026.787D-100000@mail.anatom.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

today I downloaded a hardhat for my Indy. After a few hours of trouble
with tftpd i got the sgi up with linux. But the install program exits
after "Fatal error opening RPM Database" with install exited abnormally -
recieving signal 11.

I partioned the harddisk with fx under irix. The install script is showing
me three partitions. I choose the first one with mountpoint /. Afterwards
I formatted the partition /dev/sdb1 with the install script, changed
nothing in the package selection menu and hoped that everything would run
fine :)

Is there anything I can do ?

Alex.
