Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA1141581 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Mar 1998 13:33:31 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA2249661 for linux-list; Thu, 12 Mar 1998 13:32:31 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA823291 for <linux@cthulhu.engr.sgi.com>; Thu, 12 Mar 1998 13:32:29 -0800 (PST)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA04550
	for <linux@cthulhu.engr.sgi.com>; Thu, 12 Mar 1998 13:32:27 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id VAA09293; Thu, 12 Mar 1998 21:15:47 GMT
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yDFLA-000V5iC; Thu, 12 Mar 98 21:16 GMT
Message-Id: <m0yDFLA-000V5iC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Getting Started ..... NOT
To: tonywu@life.nthu.edu.tw (Tony C. Wu)
Date: Thu, 12 Mar 1998 21:16:36 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.GSO.3.96.980313030936.24023A-100000@sparc> from "Tony C. Wu" at Mar 13, 98 03:35:36 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 2.1.72_NOSL: put me in repair fs mode, but i can't change anything.
>              It said it couldn't read superblock on /dev/sdb

Ok. The disk image expects to be /dev/sdb
do


mount -n -o remount,rw /dev/sdb1  /

vi /etc/fstab

change /dev/sdb to /dev/sdb1

exit


Best of luck
