Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id RAA154694 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 17:31:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA27042 for linux-list; Thu, 22 Jan 1998 17:29:51 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA27011 for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 17:29:46 -0800
Received: from mdhill.interlog.com (mdhill.interlog.com [199.212.154.112]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA20492
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 17:29:43 -0800
	env-from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id UAA02293; Thu, 22 Jan 1998 20:28:50 -0500
Date: Thu, 22 Jan 1998 20:28:50 -0500
Message-Id: <199801230128.UAA02293@mdhill.interlog.com>
From: Michael Hill <mdhill@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux@cthulhu.engr.sgi.com
Subject: Re: wd33c93 errors.
In-Reply-To: <Pine.LNX.3.95.980122175054.21753I-100000@lager.engsoc.carleton.ca>
References: <m0xvVCP-0005FsC@lightning.swansea.linux.org.uk>
	<Pine.LNX.3.95.980122175054.21753I-100000@lager.engsoc.carleton.ca>
X-Mailer: VM 6.34 under 20.3 "Vatican City" XEmacs  Lucid
Reply-To: mdhill@interlog.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Alex deVries writes:
 > 
 > On Thu, 22 Jan 1998, Alan Cox wrote:
 > > > repartitioned it from Irix, and mounted it as an EFS partition under Irix
 > > > just fine.  That would seem to indicate that everything is alright with
 > > Including rewriting it ?
 > 
 > Ah, I tried that specifically, and had problems too with Irix.  So, the
 > disk is toast, and it'll go back to the storage room I found it in (along
 > with an AXP).
 > 

The 1 G drive I posted about last week was made visible to IRIX by
modifying wd93_syncenable and wd93_syncperiod in
/var/sysgen/master.d/wd93 before recompiling the IRIX kernel.  Does
anyone know of similar changes to the Linux source that would prevent
the system from hanging on startup with the following message?

 sending SDTR 0103013f0csync_xfer=2cscsi : aborting command due to timeout : pid 7, scsi0, channel 0, id 3, lun 0 Inquiry 00 00
scsi0: Aborting connected command 7 - stopping DMA - sending wd33c93 ABORT command - flushing fifo - asr - 20, sr=ff, 16777215 by
 - sending wd33c93 DISCONNECT command - asr = 20, sr=18.

If this is a bug, as Alan said, maybe there's hope for my drive, as
well as the one Alex has.

Thanks,

Mike
-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
