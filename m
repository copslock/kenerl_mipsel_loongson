Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA26410 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 08:03:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA72686
	for linux-list;
	Fri, 17 Jul 1998 08:02:27 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA76640;
	Fri, 17 Jul 1998 08:01:49 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA11497; Fri, 17 Jul 1998 08:01:47 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id QAA04452; Fri, 17 Jul 1998 16:01:41 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yxC6E-000aOoC; Fri, 17 Jul 98 16:07 BST
Message-Id: <m0yxC6E-000aOoC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: What about...
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Fri, 17 Jul 1998 16:07:04 +0100 (BST)
Cc: adevries@engsoc.carleton.ca, anubis@BanjaLuka.NET,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <199807171411.HAA11412@fir.engr.sgi.com> from "William J. Earl" at Jul 17, 98 07:11:42 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> that giant a project, but it would not be particularly useful.  If there
> were a good linux on some other very large ccNUMA machine, then an Origin
> port would be much simpler.  By "good", I mean a linux which scale well
> for large (greater than 32) processor and I/O count (many I/O buses
> and thousands of disk).  It expect such a linux will happen eventually,
> but not yet.

The obvious starting point would probably be the older (386/486) sequent
boxes. I almost got somewhere with this but one bit of sequent wasnt 
willing to be helpful and counted its bus arbitrators as staying NDA.

That was 2 years ago so I ought to chase them again I guess
