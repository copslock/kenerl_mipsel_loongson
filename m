Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA29844 for <linux-archive@neteng.engr.sgi.com>; Tue, 1 Sep 1998 08:06:12 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA14473
	for linux-list;
	Tue, 1 Sep 1998 08:05:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA27195
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 1 Sep 1998 08:05:41 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA01033
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Sep 1998 08:05:31 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-23.uni-koblenz.de [141.26.249.23])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id RAA13831
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Sep 1998 17:05:28 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id QAA00473;
	Tue, 1 Sep 1998 16:55:06 +0200
Message-ID: <19980901165505.A456@uni-koblenz.de>
Date: Tue, 1 Sep 1998 16:55:05 +0200
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Carlsson <grim@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: cdrom
References: <Pine.LNX.3.96.980831184941.15439A-100000@calypso.saturn> <19980901001911.30136@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980901001911.30136@alpha.franken.de>; from Thomas Bogendoerfer on Tue, Sep 01, 1998 at 12:19:11AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Sep 01, 1998 at 12:19:11AM +0200, Thomas Bogendoerfer wrote:

> On Mon, Aug 31, 1998 at 06:56:10PM +0200, Ulf Carlsson wrote:
> > Hi,
> > Has someone managed to mount a CD yet?
> 
> my Indy doesn't have a CDrom drive. But it works on my M700. So it's
> probably related to the scsi low level driver. Ralf mentioned some
> problems with DAT, but that could also be a generic problem.
> 
> > scsi: aborting command due to timeout : pid 665, scsi0, channel 0, id4,
> > lun 0 Test Unit Ready 00 00 00 00 00
> 
> and CDrom drive works with IRIX ?

The problems seems to be associated with either sync SCSI or disconnect/
reconnect.  I did a two line modification to sgiwd93.c which disables
sync and disconnect/reconnect.  I now have since about a hour running:

  dd if=/dev/sda of=/dev/zero &
  dd if=/dev/sdb of=/dev/zero &
  dd if=/dev/sdc of=/dev/zero &
  find / /ext -xdev | cpio -o -H crc -F /dev/nst0 --verbose

No problem so far.  (Except that SCSI performance even with only single
disk activity is further converging to zero ...)

  Ralf
