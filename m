Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA35314 for <linux-archive@neteng.engr.sgi.com>; Tue, 1 Sep 1998 11:17:21 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA08992
	for linux-list;
	Tue, 1 Sep 1998 11:16:52 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA47928
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 1 Sep 1998 11:16:51 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA16869
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Sep 1998 11:16:49 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA26167;
	Tue, 1 Sep 1998 14:05:23 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 1 Sep 1998 14:05:23 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ulf Carlsson <grim@zigzegv.ml.org>
cc: ralf@uni-koblenz.de, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: cdrom
In-Reply-To: <Pine.LNX.3.96.980901193416.17758A-100000@calypso.saturn>
Message-ID: <Pine.LNX.3.96.980901140323.25177B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



Not to be a whiner, but I've *always* had a problem with accessing more
than one SCSI device at a time, both with a CDROM and a hard disk.

- Alex


-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .



On Tue, 1 Sep 1998, Ulf Carlsson wrote:

> Date: Tue, 1 Sep 1998 19:50:46 +0200 (CEST)
> From: Ulf Carlsson <grim@zigzegv.ml.org>
> To: ralf@uni-koblenz.de
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
>     linux@cthulhu.engr.sgi.com
> Subject: Re: cdrom
> 
> On Tue, 1 Sep 1998 ralf@uni-koblenz.de wrote:
> 
> > On Tue, Sep 01, 1998 at 12:19:11AM +0200, Thomas Bogendoerfer wrote:
> > 
> > The problems seems to be associated with either sync SCSI or disconnect/
> > reconnect.  I did a two line modification to sgiwd93.c which disables
> > sync and disconnect/reconnect.  I now have since about a hour running:
> > 
> >   dd if=/dev/sda of=/dev/zero &
> >   dd if=/dev/sdb of=/dev/zero &
> >   dd if=/dev/sdc of=/dev/zero &
> >   find / /ext -xdev | cpio -o -H crc -F /dev/nst0 --verbose
> > 
> > No problem so far.  (Except that SCSI performance even with only single
> > disk activity is further converging to zero ...)
> 
> I tried to implement your ideas, I disabled sync, I don't know how you
> disable disconnect/reconnect. Anyway, I don't think that's the problem.
> The problem is the sigsegv in mount the oops causes, do we have something
> like a 'half' mounted device?
> 
> Unable to handle kernel paging request at virtual address 00000000, epc ==
> 88021bcc, ra == 8809414
> Oops: 0000
> ...
> epc   : 88021bcc
> Status: 3004fc02
> Cause : 00000008
> Segmentation fault
> 
> I get those other messages ...
> 
> scsi: aborting command due to timeout ...
> 
> ...  when I try to access the directory where I mounted the CDROM drive.
> Do you think my SC hack is causing this mess?
> 
> - Ulf
> 
