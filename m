Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA26894 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 08:14:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA94085
	for linux-list;
	Mon, 22 Jun 1998 08:14:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA73492
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 08:14:11 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id IAA06627
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Jun 1998 08:14:10 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id QAA06542; Mon, 22 Jun 1998 16:14:01 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yo8OL-000aOnC; Mon, 22 Jun 98 16:20 BST
Message-Id: <m0yo8OL-000aOnC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: 5.1 installation fun & games...
To: leon@reading.sgi.com (Leon Verrall)
Date: Mon, 22 Jun 1998 16:20:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.SGI.3.96.980622161123.20040A-100000@wintermute.reading.sgi.com> from "Leon Verrall" at Jun 22, 98 04:12:32 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Ah, a chicken and egg thing. You can nfsroot an SG linux box as long as you
> have a linux box to do it from...

Or can do binary arithmetic on the console null zero and a couple of
other device file numbers (ie on the sgi mknod console c 0 1024 probably
comes out as 4,0 on Linux
