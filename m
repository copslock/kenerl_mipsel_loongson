Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA44469 for <linux-archive@neteng.engr.sgi.com>; Tue, 22 Jun 1999 16:51:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA67722
	for linux-list;
	Tue, 22 Jun 1999 16:48:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA91528
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 22 Jun 1999 16:48:52 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup88-12-6.swipnet.se [130.244.88.182]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03679
	for <linux@cthulhu.engr.sgi.com>; Tue, 22 Jun 1999 16:48:48 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10waI7-003LoAC; Wed, 23 Jun 1999 01:49:23 +0200 (CEST)
Date: Wed, 23 Jun 1999 01:49:23 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: File corruption
Message-ID: <19990623014923.A8953@thepuffingroup.com>
Mail-Followup-To: Ralf Baechle <ralf@uni-koblenz.de>,
	linux@cthulhu.engr.sgi.com
References: <19990622032859.B6955@thepuffingroup.com> <19990622152145.A1059@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <19990622152145.A1059@uni-koblenz.de>; from Ralf Baechle on Tue, Jun 22, 1999 at 03:21:45PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jun 22, 1999 at 03:21:45PM +0200, Ralf Baechle wrote:
> On Tue, Jun 22, 1999 at 03:29:00AM +0200, Ulf Carlsson wrote:
> 
> > This is *really* annoying, I can't do anything without getting interrupted
> > by some bug on the Indy.  I can't stand this file corruption.  I just lost
> > an entire directory.  This isn't because of crashes, stuff just vanish, or
> > gets corrupted without any reason.  I for example had a gzipped patch, I
> > decompressed it and I got a lot of junk in the middle of the file.
> 
> Question, is this effect repeatable, that is if you decompress the file a
> second time, will you still see the filesystem corruption?  The latter would
> mean that the data decompressed data get corrupted on the fly and the SCSI
> driver isn't involved.  Or does the gzip'ed file itself already contain the
> corrupted data?

Since the file is decompressed without warnings I assume that the scp went fine.
Anyhow, when I had decompressed the file I got corruption in the middle of the
patch.  The corruption affected only a couple of lines, 10 or so.

The problems I experience are not repeatable.  Everything went smooth after a
reboot.  I usually reboot the machine when it's messing with me, that helps.  At
least for a while.

> And under which kernel version did this start to happen?

2.2.1 I think.

> Could you resend me your hinv output?

Unfortunately I don't have IRIX.  However, I have a 133 MHz R4600 CPU with 512 k
board cache.  I have two 1 Gb SCSI driver connected.

> > Earlier today the cached version of /lib/libpam_misc.so.0.64 was corrupted
> > or something, and corrupted ELF headers were reported.  A reboot fixed that
> > one.
> 
> It seems that you observe similar problems like me.  For me however the
> problem has just vanished and was rare anyway.

They're rare for me as well, but I've had a couple in just a few days now.
Maybe the file corruption became heavier since 2.3.6?

> I understand that very well.  Btw, I started to store important stuff on NFS.

I can't stand NFS. Files, or entire directories vanish from ls, but I may still
open them if I specify their names directly.  I think I've been talking to you
about this before.

- Ulf
