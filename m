Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA68713 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 06:51:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA13038
	for linux-list;
	Tue, 2 Feb 1999 06:51:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA14548
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 06:51:02 -0800 (PST)
	mail_from (nachtfalke@usa.net)
Received: from mail.urz.uni-wuppertal.de (mail.urz.uni-wuppertal.de [132.195.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA06545
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Feb 1999 06:51:01 -0800 (PST)
	mail_from (nachtfalke@usa.net)
Received: from ganymede.priv (root@isdn97.dialin.uni-wuppertal.de [132.195.23.97])
	by mail.urz.uni-wuppertal.de (8.9.1a/8.9.1) with ESMTP id PAA21006304
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Feb 1999 15:50:28 +0100 (MET)
Received: (from nachtfalke@localhost)
	by ganymede.priv (8.8.8/8.8.8) id PAA01579
	for linux@cthulhu.engr.sgi.com; Tue, 2 Feb 1999 15:51:47 +0100
From: Alexander Graefe <nachtfalke@usa.net>
Date: Tue, 2 Feb 1999 15:51:47 +0100
To: linux@cthulhu.engr.sgi.com
Subject: What kernel to use to install RH on a R4400 ?
Message-ID: <19990202155147.A1565@ganymede>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95i
X-Goddess: Willow
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi.

I got as far as booting Linux via bootp on my Indy, but after the
remote root-fs is mounted, the kernel dies with an "Aieee" and
something about irq request handler.

I tried booting with the 2.1.131-Kernel from ftp.linux.sgi.com, but
that one doesn't try to mount the root-fs via NFS.

What kernel should I use to actually see a prompt on my Indy ?

Bye,
	LeX, determined to get Linux on there :)
-- 
Quidquid latine dictum sit, altum viditur.
