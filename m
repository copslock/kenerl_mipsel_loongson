Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA87950 for <linux-archive@neteng.engr.sgi.com>; Sun, 10 May 1998 12:23:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA23163116
	for linux-list;
	Sun, 10 May 1998 12:21:45 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA22302029
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 10 May 1998 12:21:37 -0700 (PDT)
Received: from mdhill.interlog.com (mdhill.interlog.com [199.212.154.112]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id MAA20898
	for <linux@cthulhu.engr.sgi.com>; Sun, 10 May 1998 12:21:34 -0700 (PDT)
	mail_from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA01460; Sun, 10 May 1998 15:20:33 -0400
From: Michael Hill <mdhill@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 10 May 1998 15:20:32 -0400 (EDT)
To: linux@cthulhu.engr.sgi.com
Subject: Re: Evidence of Drive Activity to Report
In-Reply-To: <13652.59663.188834.236218@mdhill.interlog.com>
References: <13652.59663.188834.236218@mdhill.interlog.com>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <13653.59491.302730.251578@mdhill.interlog.com>
Reply-To: mdhill@interlog.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Okay, let's say it was just fsck that got hung up, and not the entire
boot process.  When it stops with '[/sbin/fsck.ext2] fsck.ext2 -a /'
and I press Ctrl-C, more information comes to light:

The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else, the the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>
*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
Give root password for maintenance.
INIT: entering runlevel: 0mal startup):
while opening UTMP file: No such file or directory

...then I get the SGI maintenance screen back.  There's no evidence of
a shell when it tells me it's dropping me to a shell.  From IRIX I ran
'e2fsck -b 8193 drive' on the drive (with no improvement) but I don't
think that's the appropriate context.  Suggestions?

Thanks,

Mike
-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
