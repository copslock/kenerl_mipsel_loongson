Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA18801 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Feb 1999 22:28:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA64967
	for linux-list;
	Tue, 16 Feb 1999 22:27:03 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from kilimanjaro.engr.sgi.com (kilimanjaro.engr.sgi.com [150.166.49.139])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA81075
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Feb 1999 22:27:01 -0800 (PST)
	mail_from (owner-linux@kilimanjaro.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1]) by kilimanjaro.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id WAA09135 for <linux>; Tue, 16 Feb 1999 22:27:00 -0800 (PST)
Message-Id: <199902170627.WAA09135@kilimanjaro.engr.sgi.com>
To: linux@kilimanjaro.engr.sgi.com
Subject: able to bootp/NFS-install/reboot R4400SC Indy
Date: Tue, 16 Feb 99 22:27:00 -0800
From: Joan Eslinger <wombat@kilimanjaro.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

So, I've had an old Indy in my office, waiting for me to try installing
Linux on in my spare time, and today I finally got around to it. Lucky
for me I didn't try before today, because the kernel that finally worked
was the very latest, vmlinux-indy-990212.

After the one in the big hardhat tar.gz file didn't work (no R4400SC
support) I hit the mailing list archive, found the pointer to
vmlinux-2.1.131 (which didn't work because it didn't have NFS), noticed
also vmlinux-sc-indy-2.1.116 (also didn't work, probably also no NFS),
and tried a couple of others while going through the archive.
vmlinux-indy-990205 got a little farther, but complained it couldn't
make a device node in the ram disk or some such thing.

Anyway, vmlinux-indy-990212 was the winner: it booted up into the
installer, I was able to do a complete install (ignoring swap, as web
page says), and it's up and running. I'm sending this out to let those
who've been having trouble with Indy/R4400SC know that it can be done
now!
