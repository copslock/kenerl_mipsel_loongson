Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA3226742 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Apr 1998 15:38:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA16414221
	for linux-list;
	Wed, 29 Apr 1998 15:38:07 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA18236412
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Apr 1998 15:38:06 -0700 (PDT)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA15120
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 15:37:29 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id XAA29421; Wed, 29 Apr 1998 23:36:34 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yUfJq-000aNhC; Wed, 29 Apr 98 23:27 BST
Message-Id: <m0yUfJq-000aNhC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Could mounting sdc instead of sdc1 have solved my panics?
To: ralf@uni-koblenz.de
Date: Wed, 29 Apr 1998 23:27:13 +0100 (BST)
Cc: linux-kernel@vger.rutgers.edu, adevries@engsoc.carleton.ca,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <19980430002810.03127@uni-koblenz.de> from "ralf@uni-koblenz.de" at Apr 30, 98 00:28:10 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I don't see any reason why the kernel should crash when using sdc instead of
> a partition.  So I forward this to linux-kernel in the hope anybody knows.

My Indy has always been on /dev/sdb - anyone who has met the SGI command
line disk partitioner can probably guess why. So far its worked ;)
