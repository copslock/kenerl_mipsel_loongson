Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA255828 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 May 1998 12:38:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA21706448
	for linux-list;
	Thu, 7 May 1998 12:38:11 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA21773454
	for <linux@engr.sgi.com>;
	Thu, 7 May 1998 12:38:10 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA18717
	for <linux@engr.sgi.com>; Thu, 7 May 1998 12:38:08 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (root@pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id VAA07195
	for <linux@engr.sgi.com>; Thu, 7 May 1998 21:38:04 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id MAA05628;
	Thu, 7 May 1998 12:56:02 +0200
Message-ID: <19980507125602.37504@uni-koblenz.de>
Date: Thu, 7 May 1998 12:56:02 +0200
To: mdhill@interlog.com
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Making Progress
References: <13649.32330.450233.955385@mdhill.interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <13649.32330.450233.955385@mdhill.interlog.com>; from Michael Hill on Thu, May 07, 1998 at 05:39:11AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, May 07, 1998 at 05:39:11AM -0400, Michael Hill wrote:

> Trying to boot the kernel (2.1.90) I can now get beyond the SCSI
> detection stage but now it stops at this point:
> 
> 	Sending BOOTP and RARP requests............. timed out!
> 	IP-Config: Auto-configuration of network failed.
> 	Partition check:

Try adding ip=none to your boot commandline.  This should disable the
BOOTP / RARP stuff.  Have you given a root=/dev/foo argument to
indicate your root device?

> I'm not connected to a network; can I bypass the ethernet check?

This happens only because your kernel has been built to autoconfigure
the network stuff and boot from NFS.  If you compiled this kernel yourself,
just disable the respective options.

> My root drive is recognized as sdb, but the installer procedure was
> the only preparation I gave it.  Until now it has been my external
> IRIX drive.  Is there something I need to do first with fx?

Adding a partition wouldn't be bad.

  Ralf
