Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA2947808 for <linux-archive@neteng.engr.sgi.com>; Sat, 4 Apr 1998 06:01:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id GAA7715211
	for linux-list;
	Sat, 4 Apr 1998 06:00:00 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA7798515;
	Sat, 4 Apr 1998 05:59:53 -0800 (PST)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id FAA17218; Sat, 4 Apr 1998 05:59:50 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id OAA07360; Sat, 4 Apr 1998 14:58:59 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yLTN5-000aNnC; Sat, 4 Apr 98 14:52 BST
Message-Id: <m0yLTN5-000aNnC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: EGCS on MIPS
To: ralf@uni-koblenz.de
Date: Sat, 4 Apr 1998 14:52:35 +0100 (BST)
Cc: linux-mips@cthulhu.engr.sgi.com, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
In-Reply-To: <19980404120554.31953@uni-koblenz.de> from "ralf@uni-koblenz.de" at Apr 4, 98 12:05:54 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Experiences, especially reliability?  As I understand the problems people
> have with these compilers on their Linux/i386 machines are only mostly
> caused by the Intel backend?

For 2.8.0 there is a catalog of problems caused by both back and front end
bugs. For 2.8.1 it appears to be a case of bugs in the Linux code where 
gcc 2.8 was able to do some exciting optimisations we really didn't want.

2.8.0 has cases where it doesn't properly honour volatile, 2.8.1 appears
to behave
