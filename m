Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA691809 for <linux-archive@neteng.engr.sgi.com>; Sun, 17 May 1998 05:19:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA61142
	for linux-list;
	Sun, 17 May 1998 05:18:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA78596
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 17 May 1998 05:18:09 -0700 (PDT)
	mail_from (oliver@web.aec.at)
Received: from aec.at ([195.3.98.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id FAA16209
	for <linux@cthulhu.engr.sgi.com>; Sun, 17 May 1998 05:18:07 -0700 (PDT)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id MAA18209; Sun, 17 May 1998 12:33:36 +0200
Date: Sun, 17 May 1998 12:33:36 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: Alex deVries <adevries@engsoc.carleton.ca>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Initrd stuff...
In-Reply-To: <Pine.LNX.3.95.980516232738.31143E-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.96.980517122752.16103B-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> I've tried all sorts of things, apparantly none are correct.  I thought
> that "scsi(0)disk(1)rdisk(0)partition(8)/initrd" was my best chance, but
> it comes back with PROM_ENODEV also.
>

did you try "dksc(0,1,8)initrd", too? that's what i use to boot sashARCS and fx
from a certain partition at least ("PROM syntax" vs. your "ARCS syntax" afaik).
(0 being the controller, 1 the drive number and 8 the partition) 

anyway "scsi(0)disk(1)rdisk(0)partition(8)" won't work, because you have 
specified a disk and rdisk. shouldn't this read "scsi(0)disk(1)partition(8)"?

-oliver
