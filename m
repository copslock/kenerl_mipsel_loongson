Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA697361 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 May 1998 02:15:03 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA26157
	for linux-list;
	Mon, 18 May 1998 02:14:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA24183
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 18 May 1998 02:14:20 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id CAA08353
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 May 1998 02:14:17 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id LAA19820;
	Mon, 18 May 1998 11:12:41 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id LAA18917; Mon, 18 May 1998 11:12:37 +0200
Message-ID: <19980518111237.27765@uni-koblenz.de>
Date: Mon, 18 May 1998 11:12:37 +0200
From: ralf@uni-koblenz.de
To: Leon Verrall <leon@reading.sgi.com>
Cc: Michael Hill <mdhill@interlog.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Evidence of Drive Activity to Report
References: <13661.60018.777703.724185@mdhill.interlog.com> <Pine.SGI.3.96.980518093146.5158B-100000@wintermute.reading.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.SGI.3.96.980518093146.5158B-100000@wintermute.reading.sgi.com>; from Leon Verrall on Mon, May 18, 1998 at 09:35:06AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, May 18, 1998 at 09:35:06AM +0100, Leon Verrall wrote:

> Using root-be.0.03.cpio I had to hack some stuff around. /etc/fstab doesn't
> contain a listing for / so fsck fails in /etc/rc.d/rc.sysinit. I'd add this
> entry in but I also hard coded /dev/sdc2 (my root) into rc.sysinit as the
> mount command in this root-be doesn't seem to like mounting from fstab
> entries....

Ouch, that must be a very obsolete mount binary.

> Boot with vmlinux root=whatever init=/bin/sh
> mount -t ext -n -o remount,rw /dev/myrootdevice /
> vi /etc/rc.sysinit  and /etc/fstab
> logout.
> 
> You may also want to 'touch /fastboot' . This will skip the fsck on boot.
> (probably a dangerous thing ATM :)

I consider the whole /fastboot thing obsolete.  Only fsck knows
if a filesystem is broken or not.  Oh well, the things we do for Minix ...

  Ralf
