Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id GAA25651 for <linux-archive@neteng.engr.sgi.com>; Fri, 10 Oct 1997 06:31:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA28552 for linux-list; Fri, 10 Oct 1997 06:30:58 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA28547 for <linux@cthulhu.engr.sgi.com>; Fri, 10 Oct 1997 06:30:57 -0700
Received: from matka.mtl.pl (matka.mtl.pl [195.116.4.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA06127
	for <linux@cthulhu.engr.sgi.com>; Fri, 10 Oct 1997 06:28:16 -0700
	env-from (maciek@cadsys.com.pl)
Received: from cadsys.com.pl (uucp@localhost) by matka.mtl.pl (8.8.6/8.6.12) with UUCP id QAA17988 for linux@cthulhu.engr.sgi.com; Fri, 10 Oct 1997 16:19:30 +0200 (MET DST)
Received: from cadsys.com.pl by cadsys.com.pl via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	for <linux@cthulhu.engr.sgi.com> id PAA12594; Fri, 10 Oct 1997 15:17:14 +0200
Message-ID: <343E2AD9.2984F854@cadsys.com.pl>
Date: Fri, 10 Oct 1997 15:17:14 +0200
From: Maciek Dyczkowski <maciek@cadsys.com.pl>
Reply-To: maciek@cadsys.com.pl
Organization: CADsystem MIASTOPROJEKT
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 5.3 IP22)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Re: Majordomo results: (no subject)
References: <199710070831.BAA21140@cthulhu.engr.sgi.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I was able to get my new OS running over the net. Kernel loads, NFS
mounts root filesystem and .... this is all I can
do. The next step should be :

1. Mount your local disks.... how can I do that? How can I mount disks
on SGI/Linux? Do I need to format my
drive? What tools should I use?

2. Download all RPMS .... done

3. use command ' rpm --root=/mnt -Uvh *rpm ' ..... even I couldn't mount
my drive I checked, whether I could use rpm
command - it just doesn't exist in my root filesystem. Anybody has any
experiences with installing SGI/Linux?

Thank you for ANY help!

--
Maciek Dyczkowski
