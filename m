Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA67413 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 May 1998 04:38:33 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA22067605
	for linux-list;
	Fri, 8 May 1998 04:37:08 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA11527819
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 May 1998 04:37:06 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id EAA07984
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 04:37:05 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id HAA21746;
	Fri, 8 May 1998 07:36:58 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 8 May 1998 07:36:58 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Michael Hill <mdhill@interlog.com>
cc: linux@cthulhu.engr.sgi.com
Subject: RE: Making Progress
In-Reply-To: <13650.53876.373554.664836@mdhill.interlog.com>
Message-ID: <Pine.LNX.3.95.980508072659.20848E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 8 May 1998, Michael Hill wrote:
> Alex deVries writes:
>  > Hmmm.  Odd.  Can you give us the results of a 'hinv'?
> Iris Audio Processor: version A2 revision 4.1.0
> 1 133 MHZ IP22 Processor
> FPU: MIPS R4600 Floating Point Coprocessor Revision: 2.0
> CPU: MIPS R4600 Processor Chip Revision: 2.0

Hm.  that looks okay to me.

> Here's this morning's result from 'boot /vmlinux root=/dev/sdb
> ip=none':
> [snip]
> scsi : detected 2 SCSI disks total.
> SCSI device sda: hdwr sector= 512 bytes. Sectors= 1070496 [522 MB]
> [0.5 GB]
> SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2400302 [1172 MB]
> [1.2 GB]
> sgiseeq.c: David S. Miller (dm@engr.sgi.com)
> eth0: SGI Seeq8003 08:00:69:07:e3:0d
> Sending BOOTP and RARP requests............. timed out!
> IP-Config: Auto-configuration of network failed.
> Partition check:

It's still doing bootp/rarp, which is weird.  

Can you try the kernel that's in
ftp://ftp.linux.sgi.com/pub/test/vmlinux-indy-2.1.99.tar.gz ?

This doesn't have bootp enabled.

- alex
