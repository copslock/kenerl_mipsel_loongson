Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA2242007 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Mar 1998 20:53:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id UAA4784528
	for linux-list;
	Fri, 27 Mar 1998 20:52:38 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA3616042
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 27 Mar 1998 20:52:36 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id UAA15375
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Mar 1998 20:52:34 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA29419
	for <linux@cthulhu.engr.sgi.com>; Sat, 28 Mar 1998 05:52:31 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id FAA07338;
	Sat, 28 Mar 1998 05:52:08 +0100
Message-ID: <19980328055201.31189@uni-koblenz.de>
Date: Sat, 28 Mar 1998 05:52:01 +0100
To: Dong Liu <dliu@npiww.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
References: <199803272025.PAA16215@pluto.npiww.com> <19980327220550.50946@uni-koblenz.de> <199803272159.QAA18195@pluto.npiww.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199803272159.QAA18195@pluto.npiww.com>; from Dong Liu on Fri, Mar 27, 1998 at 04:59:26PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Mar 27, 1998 at 04:59:26PM -0500, Dong Liu wrote:

>  > > Another thing it didn't get the right capacity of scsi disk.
>  > 
>  > Are you shure?  Some peopple got fooled by the 1024 vs. 1024 bytes per
>  > kb isue ...  Or are the numbers way off?
> 
> This what I got
> 
> sda: sector size 0 reported, assume 512
> SCSI device sda: hdwr sector= 512 bytes, Sectors=1 [0 MB][0.0 GB]
> 
> :=)

Hmmm...  I speculate we misstreat R4000MC / R4400MC CPUs :-(

>  > There is a command named ``hinv'' under IRIX.  Can you mail me the output?

> FPU: MIPS R4010 Floating Point Chip Revision: 0.0
> CPU: MIPS R4000 Processor Chip Revision: 3.0
> Secondary unified instruction/data cache size: 1 Mbyte

Sigh, was suspecting that.  Actually handling of these CPUs should be
fixed in current kernels ...

  Ralf
