Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id EAA119633 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Jan 1998 04:10:44 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA16365 for linux-list; Tue, 13 Jan 1998 04:04:53 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA16359 for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 04:04:46 -0800
Received: from mdhill.interlog.com (mdhill.interlog.com [199.212.154.112]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA15665
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 04:04:43 -0800
	env-from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id HAA01401; Tue, 13 Jan 1998 07:01:24 -0500
Date: Tue, 13 Jan 1998 07:01:24 -0500
Message-Id: <199801131201.HAA01401@mdhill.interlog.com>
From: Michael Hill <mdhill@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux@cthulhu.engr.sgi.com
Subject: Hard Drive Problems
X-Mailer: VM 6.34 under 20.3 "Vatican City" XEmacs  Lucid
Reply-To: mdhill@interlog.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

The good news is that Andrew O'Brien's "noL2" kernel gets me all the
way to the SCSI detection phase.  Unfortunately, my chosen hard drive
doesn't seem to want to run while connected to my Indy.  I'll describe 
the symptoms in the hope that someone may recognize something;
otherwise I'll retire the drive to x86 Linux duty, where it seems to
work without complaints.

It's a Quantum ProDrive 1050s, and was the first external drive I
purchased from my SGI dealer (1994).  It worked well under IRIX 5.2
but (and this may be a coincidence) problems started after I upgraded
to 5.3.  I'm now running 6.2 and the problems are the same.  While
starting IRIX, I get the following:

	The system is coming up.
	WARNING: wd93 SCSI Bus=0 ID=3 LUN=0: SCSI cmd=0x12
	timeout after 30 sec.  Resetting SCSI bus
	WARNING: wd93 SCSI Bus=0 ID=3 LUN=0: SCSI cmd=0x1a
	timeout after 60 sec.  Resetting SCSI bus
	WARNING: wd93 SCSI Bus=0 ID=3 LUN=0: SCSI cmd=0x12
	timeout after 60 sec.  Resetting SCSI bus
	WARNING: wd93 SCSI Bus=0 ID=3 LUN=0: SCSI cmd=0x2a
	timeout after 60 sec.  Resetting SCSI bus

at which point I lose patience and power off the drive; IRIX startup
resumes.

I prepared the drive for SGI/Linux, installing root-be-0.00 from x86
Linux.  While booting vmlinux, I get the following:

WD93: Driver version 1.25 compiled on Jan 7 1998 at 14:54:14
 debug_flags=0x00
wd33c93-0: chip=WD33c93B/13 no_sync=0Xff no_dma=0scsi0 : SGI WD93
scsi : 1 host.
 sending SDTR 0103013f0csync_xfer=2c Vendor: SGI Model: IBMDSAS-3540  Rev: S47K
  Type:   Direct-Access                     ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
 sending SDTR -REJ- Vendor: INSITE Model: I325VM          *F Rev: 0387
  Type: Direct-Access                    ANSI SCSI revision: 01 CCS
Detected scsi removable disk sdb at scsi0, channel 0, id 2, lun 0
Unlocked floptical drive.
 sending SDTR 0103013f0csync_xfer=2cscsi : aborting command due to timeout : pid 7, scsi0, channel 0, id 3, lun 0 Inquiry 00 00
scsi0: Aborting connected command 7 - stopping DMA - sending wd33c93 ABORT command - flushing fifo - asr - 20, sr=ff, 16777215 by
 - sending wd33c93 DISCONNECT command - asr = 20, sr=18.

If I can't get the drive to go any further, I'll press it back into
service as my x86 Linux system drive, where it has worked for over a
year.  That leaves me stuck at the moment for an SGI/Linux test drive.

Thanks,

Mike
-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
