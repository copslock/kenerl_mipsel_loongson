Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA79172 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Jun 1998 03:58:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA38278
	for linux-list;
	Fri, 26 Jun 1998 03:57:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA46117
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Jun 1998 03:57:57 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id DAA01538
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Jun 1998 03:57:56 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id LAA12960; Fri, 26 Jun 1998 11:57:38 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0ypWIG-000aOoC; Fri, 26 Jun 98 12:03 BST
Message-Id: <m0ypWIG-000aOoC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: possible driver error?
To: mjhsieh@life.nthu.edu.tw (Francis M.J. Hsieh)
Date: Fri, 26 Jun 1998 12:03:48 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19980626184731.09737@life.nthu.edu.tw> from "Francis M.J. Hsieh" at Jun 26, 98 06:47:31 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>   Here is a possible driver error (but seems harmless, I checked it
>   using network managerment hardware, no transmission error occured)

I think someone is shipping old ifconfig tools with Linux/SGI. See if
"cat /proc/net/dev" makes sense
