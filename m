Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA31040 for <linux-archive@neteng.engr.sgi.com>; Sun, 28 Jun 1998 16:48:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA84857
	for linux-list;
	Sun, 28 Jun 1998 16:47:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA36121
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 28 Jun 1998 16:47:35 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA07204
	for <linux@cthulhu.engr.sgi.com>; Sun, 28 Jun 1998 16:47:33 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id AAA05560; Mon, 29 Jun 1998 00:46:33 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yqRFN-000aOnC; Mon, 29 Jun 98 00:52 BST
Message-Id: <m0yqRFN-000aOnC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: hmmmm.... nice job!!
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Mon, 29 Jun 1998 00:52:37 +0100 (BST)
Cc: mjhsieh@life.nthu.edu.tw, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.980628145721.10146B-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Jun 28, 98 02:58:20 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> >  - (sometimes) a strange garbage image, about 1 character size in the
> >    lowerleft corner of the screen
> 
> Yup, that's a console bug, I get that too.

And a few other artifacts. They look like a race on how we handle scrolling,
cursors and other related items. Perhaps its time to go plug into abscon ?
