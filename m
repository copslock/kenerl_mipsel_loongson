Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA208873 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 May 1998 02:41:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA21353442
	for linux-list;
	Thu, 7 May 1998 02:40:16 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA21651377
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 7 May 1998 02:40:14 -0700 (PDT)
Received: from mdhill.interlog.com ([199.212.154.112]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id CAA28257
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 May 1998 02:40:12 -0700 (PDT)
	mail_from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id FAA01315; Thu, 7 May 1998 05:39:12 -0400
From: Michael Hill <mdhill@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu,  7 May 1998 05:39:11 -0400 (EDT)
To: linux@cthulhu.engr.sgi.com
Subject: Making Progress
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <13649.32330.450233.955385@mdhill.interlog.com>
Reply-To: mdhill@interlog.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Trying to boot the kernel (2.1.90) I can now get beyond the SCSI
detection stage but now it stops at this point:

	Sending BOOTP and RARP requests............. timed out!
	IP-Config: Auto-configuration of network failed.
	Partition check:

I'm not connected to a network; can I bypass the ethernet check?

My root drive is recognized as sdb, but the installer procedure was
the only preparation I gave it.  Until now it has been my external
IRIX drive.  Is there something I need to do first with fx?

Thanks,

Mike
-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
