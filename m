Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA545237 for <linux-archive@neteng.engr.sgi.com>; Fri, 24 Oct 1997 16:19:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA14035 for linux-list; Fri, 24 Oct 1997 16:18:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA13973 for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 16:18:34 -0700
Received: from multi11.netcomi.com (multi11.netcomi.com [204.58.155.211]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA03983
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 16:18:23 -0700
	env-from (mgix@nothingreal.com)
Received: from void (lax-ca50-20.ix.netcom.com [204.30.73.244]) by multi11.netcomi.com (8.8.5/8.7.3) with SMTP id SAA28887 for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 18:18:18 -0500
Message-ID: <34512C2B.41C6@nothingreal.com>
Date: Fri, 24 Oct 1997 16:15:55 -0700
From: Emmanuel Mogenet <mgix@nothingreal.com>
Organization: Nothing Real, LLC
X-Mailer: Mozilla 3.01Gold (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Step by step, cont'd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Today, I tried to boot Linux on my Indy with an NFS mounted
root. Failed again. Here's what I did:

1. Installed the root tree on machine 192.0.2.15, in /disk4
2. Configured bootp on machine 192.0.2.3 so that it could inform
   my machine that it's address is 192.0.2.2.
3. Rebooted my machine
4. Went to sash.
5 Typed:

scsi(0)disk(1)rdisk(0)partition(0)/vmlinux nfsroot=192.0.2.15:/disk4

So far, so good.

5. The linux kernel booted, and said:

Root-NFS: Got BOOTP answer from 192.0.2.3, my address is 192.0.2.2
Root-NFS: Adding default route failed!
Root-NFS: Unable to contact server ...


Anybody knows why it couldn't add a route ?
I'm using the following kernel:

	vmlinux-970916-efs

I'm going to try an older one.

	- Mgix
