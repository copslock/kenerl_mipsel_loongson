Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA552641 for <linux-archive@neteng.engr.sgi.com>; Fri, 24 Oct 1997 17:00:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA26492 for linux-list; Fri, 24 Oct 1997 16:59:09 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA26465 for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 16:59:06 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA22643
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 16:59:03 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from ozzy.uni-koblenz.de (946@ozzy.uni-koblenz.de [141.26.5.8]) by informatik.uni-koblenz.de (8.8.7/8.6.9) with ESMTP id BAA19922; Sat, 25 Oct 1997 01:59:01 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199710242359.BAA19922@informatik.uni-koblenz.de>
Received: by ozzy.uni-koblenz.de (8.8.5/KO-2.0)
	id BAA04876; Sat, 25 Oct 1997 01:57:24 +0200
Subject: Re: Step by step, cont'd
To: mgix@nothingreal.com (Emmanuel Mogenet)
Date: Sat, 25 Oct 1997 01:57:24 +0200 (MEST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <34512C2B.41C6@nothingreal.com> from "Emmanuel Mogenet" at Oct 24, 97 04:15:55 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> Today, I tried to boot Linux on my Indy with an NFS mounted
> root. Failed again. Here's what I did:
> 
> 1. Installed the root tree on machine 192.0.2.15, in /disk4
> 2. Configured bootp on machine 192.0.2.3 so that it could inform
>    my machine that it's address is 192.0.2.2.
> 3. Rebooted my machine
> 4. Went to sash.
> 5 Typed:
> 
> scsi(0)disk(1)rdisk(0)partition(0)/vmlinux nfsroot=192.0.2.15:/disk4
> 
> So far, so good.
> 
> 5. The linux kernel booted, and said:
> 
> Root-NFS: Got BOOTP answer from 192.0.2.3, my address is 192.0.2.2
> Root-NFS: Adding default route failed!
> Root-NFS: Unable to contact server ...
> 
> 
> Anybody knows why it couldn't add a route ?
> I'm using the following kernel:
> 
> 	vmlinux-970916-efs
> 
> I'm going to try an older one.

I've you've got a working crosscompiler, try building one of the most
current ones.  The bug you're reporting is fixed in current kernels.

  Ralf
