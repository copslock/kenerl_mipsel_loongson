Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA22234 for <linux-archive@neteng.engr.sgi.com>; Mon, 15 Feb 1999 06:20:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA65697
	for linux-list;
	Mon, 15 Feb 1999 06:20:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA52721
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 15 Feb 1999 06:20:06 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA02169
	for <linux@cthulhu.engr.sgi.com>; Mon, 15 Feb 1999 06:20:05 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id OAA05384; Mon, 15 Feb 1999 14:18:58 GMT
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m10CPiv-0007U1C; Mon, 15 Feb 99 15:14 GMT
Message-Id: <m10CPiv-0007U1C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: VID_HARDWARE_VINO
To: ralf@uni-koblenz.de
Date: Mon, 15 Feb 1999 15:14:12 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
In-Reply-To: <19990215014103.D644@uni-koblenz.de> from "ralf@uni-koblenz.de" at Feb 15, 99 01:41:03 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Due to a collission with Linus sources I had to change the value of this
> define to 19 in include/linux/videodev.h for the merge.

And you'll continue to get collisions until you submit me a patch to add it
to the master set 8)
