Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA49394 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 11:10:21 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA19577
	for linux-list;
	Fri, 17 Jul 1998 11:09:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA09523;
	Fri, 17 Jul 1998 11:09:11 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA29658; Fri, 17 Jul 1998 11:09:09 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id TAA08530; Fri, 17 Jul 1998 19:08:56 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yxF1A-000aOoC; Fri, 17 Jul 98 19:14 BST
Message-Id: <m0yxF1A-000aOoC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: What about...
To: greg@xtp.engr.sgi.com (Greg Chesson)
Date: Fri, 17 Jul 1998 19:14:04 +0100 (BST)
Cc: wje@fir.engr.sgi.com, adevries@engsoc.carleton.ca, anubis@BanjaLuka.NET,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <9807171047.ZM18720@xtp.engr.sgi.com> from "Greg Chesson" at Jul 17, 98 10:47:02 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> many "holes"...  The idea of a simple buddy-system allocator as is
> ingrained in the Linux kernel falls apart completely in the face of
> this kind of architecture.   I suppose you could run a copy of Linux
> on every node, but I consider that an excuse rather than a solution.

Actually the Linux buddy stuff is quite happy with holes. Its still
completely inappropriate. From the above I deduce we'd have to do
mips64 before we even considerd it anyway
