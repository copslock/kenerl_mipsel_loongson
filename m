Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA215710 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 May 1998 08:27:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA15587918
	for linux-list;
	Thu, 7 May 1998 08:27:29 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA21626336
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 7 May 1998 08:27:27 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA27079
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 May 1998 08:27:08 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id LAA22908;
	Thu, 7 May 1998 11:27:03 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 7 May 1998 11:27:03 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Michael Hill <mdhill@interlog.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Making Progress
In-Reply-To: <13649.32330.450233.955385@mdhill.interlog.com>
Message-ID: <Pine.LNX.3.95.980507112543.20653D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 7 May 1998, Michael Hill wrote:
> Trying to boot the kernel (2.1.90) I can now get beyond the SCSI
> detection stage but now it stops at this point:
> 	Sending BOOTP and RARP requests............. timed out!
> 	IP-Config: Auto-configuration of network failed.
> 	Partition check:

Hm.  The bootup actually stops at that point?  It doesn't identify any
partitions or complain about any errors?  This sounds like a SCSI problem
to me.

In theory, you should be able to boot with 'vmlinux root=/dev/sdb'.

- alex
