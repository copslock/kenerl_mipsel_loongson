Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA16874 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 02:26:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA28705
	for linux-list;
	Mon, 22 Jun 1998 02:25:45 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA24133
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 02:25:44 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id CAA02188
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Jun 1998 02:25:42 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id KAA31844; Mon, 22 Jun 1998 10:25:30 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yo2x5-000aOnC; Mon, 22 Jun 98 10:31 BST
Message-Id: <m0yo2x5-000aOnC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: 5.1 installation fun & games...
To: leon@reading.sgi.com (Leon Verrall)
Date: Mon, 22 Jun 1998 10:31:49 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.SGI.3.96.980622095548.12756A-100000@wintermute.reading.sgi.com> from "Leon Verrall" at Jun 22, 98 10:08:21 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Anyway, this boots the kernel, mounts the root fs and then stops with the
> message:
> 
>   Warning: unable to open an initial console

You don't have a valid "/dev" inside of /scratch/linux/installfs

Tar preserves major/minor numbers which will screw you royally across
NFS (which doesnt). 
