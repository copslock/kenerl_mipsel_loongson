Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA96327 for <linux-archive@neteng.engr.sgi.com>; Sat, 1 Aug 1998 05:58:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA58788
	for linux-list;
	Sat, 1 Aug 1998 05:57:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA47432
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 Aug 1998 05:57:57 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA22208
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 Aug 1998 05:57:55 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id NAA19275; Sat, 1 Aug 1998 13:57:36 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0z2bIq-000aNGC; Sat, 1 Aug 98 14:02 BST
Message-Id: <m0z2bIq-000aNGC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: what is this?
To: mjhsieh@helix.life.nthu.edu.tw (Francis M. J. Hsieh)
Date: Sat, 1 Aug 1998 14:02:26 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19980801140032.A1004@helix.life.nthu.edu.tw> from "Francis M. J. Hsieh" at Aug 1, 98 02:00:32 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> okay, I am reporting again.
> 
> I happened to meet this before, maybe it is a rare case.
>   Socket destroy delayed (r=0 w=112)
>   Socket destroy delayed (r=0 w=256)
> 
> Any idea? Had anyone seen that before?

When a socket has buffers charged to it the socket cant be destroyed so
the kernel hangs on to it. It indicates one of several things - a socket
that has some state timeouts left to do that are longer than 10 secs 
after the close, a socket that has buffers queued up with a very constipated
driver, or a leak.

Alan
