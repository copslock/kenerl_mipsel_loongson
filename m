Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA2827017 for <linux-archive@neteng.engr.sgi.com>; Fri, 3 Apr 1998 11:25:48 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id LAA7366146
	for linux-list;
	Fri, 3 Apr 1998 11:24:45 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA7455043;
	Fri, 3 Apr 1998 11:24:38 -0800 (PST)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id LAA29327; Fri, 3 Apr 1998 11:24:36 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id UAA25660; Fri, 3 Apr 1998 20:24:10 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yLByA-000aNnC; Fri, 3 Apr 98 20:17 BST
Message-Id: <m0yLByA-000aNnC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: VCE exceptions
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Fri, 3 Apr 1998 20:17:41 +0100 (BST)
Cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199804031911.LAA21028@fir.engr.sgi.com> from "William J. Earl" at Apr 3, 98 11:11:15 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>      As soon as I get a chance, I will look at the relevant linux
> code.  Note that physical color allocation can also make a big
> performance difference on direct mapped secondary caches, as on all of

Colouring in Linux isnt going to work without ripping the godawful buddy
allocator out of it. Unfortunately Linus seems quite attached to it at
the moment. Bamboo under the finger nails at Linux Expo perhaps Ralph ?

Whenever we try and do any colouring it fragments the buddy stuff up 
sufficiently badly that we basically break the box. 

Alan
