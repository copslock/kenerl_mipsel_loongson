Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id BAA707751 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 May 1998 01:36:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA17759
	for linux-list;
	Mon, 18 May 1998 01:35:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id BAA18270
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 18 May 1998 01:35:12 -0700 (PDT)
	mail_from (leon@reading.sgi.com)
Received: from localhost by wintermute.reading.sgi.com via SMTP (950413.SGI.8.6.12/911001.SGI)
	 id JAA05326; Mon, 18 May 1998 09:35:06 +0100
Date: Mon, 18 May 1998 09:35:06 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
To: Michael Hill <mdhill@interlog.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Evidence of Drive Activity to Report
In-Reply-To: <13661.60018.777703.724185@mdhill.interlog.com>
Message-ID: <Pine.SGI.3.96.980518093146.5158B-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, 16 May 1998, Michael Hill wrote:

> ralf@uni-koblenz.de writes:
>  > 
>  > Both cases sound like a bad /etc/fstab.  Try adding init=/bin/sh to your
>  > firmware command like arguments.  You'll get a completly uninitialized
>  > system.   Run e2fsck, then you should be able to remount / rw and fix
>  > the fstab.
>  > 
> 
> What should fstab look like?  Mine has a single entry (with
> root-be-0.03) for /proc.
> 
> I get a bash prompt but e2fsck hangs.

Using root-be.0.03.cpio I had to hack some stuff around. /etc/fstab doesn't
contain a listing for / so fsck fails in /etc/rc.d/rc.sysinit. I'd add this
entry in but I also hard coded /dev/sdc2 (my root) into rc.sysinit as the
mount command in this root-be doesn't seem to like mounting from fstab
entries....

Boot with vmlinux root=whatever init=/bin/sh
mount -t ext -n -o remount,rw /dev/myrootdevice /
vi /etc/rc.sysinit  and /etc/fstab
logout.

You may also want to 'touch /fastboot' . This will skip the fsck on boot.
(probably a dangerous thing ATM :)

Leon

-- 
Leon Verrall - 01189 307734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
