Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id MAA55457 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 12:44:44 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA08413 for linux-list; Mon, 12 Jan 1998 12:41:02 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA08367 for <Linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 12:40:56 -0800
Received: from zaphod.et.tudelft.nl (zaphod.et.tudelft.nl [130.161.38.84]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA15836
	for <Linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 12:40:55 -0800
	env-from (ednes@zaphod.et.tudelft.nl)
Received: (from ednes@localhost)
	by zaphod.et.tudelft.nl (8.8.7/8.8.7) id VAA20724;
	Mon, 12 Jan 1998 21:40:53 +0100
Message-Id: <199801122040.VAA20724@zaphod.et.tudelft.nl>
Subject: booting linux
To: Linux@cthulhu.engr.sgi.com
Date: Mon, 12 Jan 1998 21:40:53 +0100 (CET)
Cc: E.Hakkennes@ET.TUDelft.NL (Edwin Hakkennes)
In-Reply-To:  
From: Edwin Hakkennes <E.Hakkennes@ET.TUDelft.NL>
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all

I reinstalled Irix 5.3 on our indy, and put the vmlinux-indy-2.1.67.tar.gz
kernel on the irix root as vmlinux. There is no root-file-system yet. I need 
to bring a disk...

When booting using 
stop for maintainance,
boot
(sash) boot -f /vmlinux /dev/sda1
it starts to boot, but it hangs after the following message:
Got a bus error IRQ, shouldn't happen yet.

This comes just after the serial devices probe and the registering of the
loop device.

Is this something releted to a missing root-file-system? I was expecting
something like
Panic, unable to mount root-fs

I'll bring a disk tomorrow and try to unpack the file-system there, but in 
the meantime, I'm curious what causes this error.

I'm also curious where to fined the installer program which is mentioned in 
Linux-installer.tgz/INSTALL and whether there is a solution to the rpm-binary
that is supposed not to work (as per th INSTALL doc)

Thanks for any insight! and for porting Linux/RedHat 5.0!

Edwin Hakkennes
