Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA01056 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 02:08:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA78206
	for linux-list;
	Mon, 22 Jun 1998 02:08:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id CAA92802
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 02:08:25 -0700 (PDT)
	mail_from (leon@reading.sgi.com)
Received: from localhost by wintermute.reading.sgi.com via SMTP (950413.SGI.8.6.12/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id KAA12887; Mon, 22 Jun 1998 10:08:22 +0100
Date: Mon, 22 Jun 1998 10:08:21 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: 5.1 installation fun & games...
Message-ID: <Pine.SGI.3.96.980622095548.12756A-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


'lo all,

I've tripped over something trying to install the 5.1 distribution on a
spare indy. I have a second Indy acting as a bootp server for the nfs-root
installation. The nfs-root filesystem came from installfs.tgz on linus.

The machines are both on a segmented network with the netmask 0xffffff80 so
I had to muck about with nfsroot= and nfsaddrs= . The boot command I'm using
is:

  boot bootp():vmlinux nfsroot=/scratch/linux/installfs \
  nfsaddrs=:::0xffffff80:misfit::

Anyway, this boots the kernel, mounts the root fs and then stops with the
message:

  Warning: unable to open an initial console

This turns up if I use any type of console (gfx or vt100 terminal). Perhaps
that was too literal an interpretation but I'd have kicked myself if it was
the problem :)

I suspect my bootp setup could be more robust or nfs root isn't mounting
properly...

BTW, small tip I found useful. Instead of typing:

  boot bootp():vmlinux nfsroot=/scratch/linux/installfs etc. etc. 

everytime to boot, on an SG machine use:

  setenv -p linux "a_very_long_command_its_a_pain_to_keep_typing"

and boot the machine with 

  $linux

at the console prompt :)

Leon

-- 
Leon Verrall - 01189 307734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
