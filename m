Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA2639607 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Apr 1998 15:48:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA18323525
	for linux-list;
	Wed, 29 Apr 1998 15:48:15 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA18088948
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Apr 1998 15:48:14 -0700 (PDT)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA19217
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 15:48:12 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id XAA29656; Wed, 29 Apr 1998 23:47:45 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yUfUg-000aNhC; Wed, 29 Apr 98 23:38 BST
Message-Id: <m0yUfUg-000aNhC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Rex and the Newport.
To: ralf@uni-koblenz.de
Date: Wed, 29 Apr 1998 23:38:25 +0100 (BST)
Cc: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com
In-Reply-To: <19980430003404.02686@uni-koblenz.de> from "ralf@uni-koblenz.de" at Apr 30, 98 00:34:04 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Btw, whe really should switch all MIPS machines to fbcon or will never
> have a kernel with reasonable fast console and support for multiple
> GFX types in kernel binary.

fbcon assumes direct memory access to the display. abscon is probably
what you want.

Alan
