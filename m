Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA06797 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 07:08:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA23942
	for linux-list;
	Mon, 22 Jun 1998 07:07:57 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA94233
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 07:07:56 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id HAA01108
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Jun 1998 07:07:54 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id PAA04954; Mon, 22 Jun 1998 15:07:47 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yo7MG-000aOnC; Mon, 22 Jun 98 15:14 BST
Message-Id: <m0yo7MG-000aOnC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: 5.1 installation fun & games...
To: leon@reading.sgi.com (Leon Verrall)
Date: Mon, 22 Jun 1998 15:14:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.SGI.3.96.980622145123.18802A-100000@wintermute.reading.sgi.com> from "Leon Verrall" at Jun 22, 98 02:53:21 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Hmmm. ALl of the dev devices were major/minor 0 0 so I've put them right
> using the kernel device numbers list. If nfs is not passing device numbers
> how exactly does this work (as it apparently does) or is this an SGI
> specific NFS thing...

Linux device numbers are major<<8|minor, SGI ones are split on a 
different boundary. NFSv2 doesnt indicate the boundary - so device
2,0 on linux may appear as 0,512 on Irix.

Alan
