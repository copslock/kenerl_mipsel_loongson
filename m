Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA224716 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 May 1998 10:05:22 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA21426044
	for linux-list;
	Thu, 7 May 1998 10:01:59 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA21632857
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 7 May 1998 10:01:55 -0700 (PDT)
Received: from sagittarius.tor.onramp.ca (sagittarius.tor.onramp.ca [204.225.88.9]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id KAA09075
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 May 1998 10:01:51 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 4669 invoked from network); 7 May 1998 17:01:50 -0000
Received: from onramp.ca (root@204.225.88.3)
  by sagittarius.tor.onramp.ca with SMTP; 7 May 1998 17:01:50 -0000
Received: from bart.hgeng.com(imail.hgeng.com[199.246.72.233]) (1855 bytes) by onramp.ca
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <mikehill@hgeng.com>) 
	id <m0yXU3J-000tRFC@onramp.ca>
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 May 1998 13:01:49 -0400 (EDT)
	(Smail-3.2.0.98 1997-Oct-16 #11 built 1997-Oct-23)
Received: by BART with Internet Mail Service (5.5.1960.3)
	id <KN2FXWKG>; Thu, 7 May 1998 13:11:42 -0400
Message-ID: <60222E63C9F4D011915F00A02435011C126253@BART>
From: Mike Hill <mikehill@hgeng.com>
To: linux@cthulhu.engr.sgi.com
Subject: RE: Making Progress
Date: Thu, 7 May 1998 13:11:41 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.1960.3)
Content-Type: text/plain
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This is booting with /vmlinux root=/dev/sdb.

I'm at work at the moment, so I'm not in front of the Indy.  I didn't
transcribe the rest, but as I recall, hard drive model and size are
reported (correctly) for sda and sdb, followed by a line with Dave
Miller's address.  The three lines I did write out came next.

My previous two boot attempts got hung up before the network detection,
seemingly because of the floptical and CD drives.  I yanked out the
first and switched off the second.

Should I be doing something to partition sdb?

Thanks,

Mike

> -----Original Message-----
> From:	Alex deVries [SMTP:adevries@engsoc.carleton.ca]
> Sent:	Thursday, May 07, 1998 11:27 AM
> To:	Michael Hill
> Cc:	linux@cthulhu.engr.sgi.com
> Subject:	Re: Making Progress
> 
> On Thu, 7 May 1998, Michael Hill wrote:
> > Trying to boot the kernel (2.1.90) I can now get beyond the SCSI
> > detection stage but now it stops at this point:
> > 	Sending BOOTP and RARP requests............. timed out!
> > 	IP-Config: Auto-configuration of network failed.
> > 	Partition check:
> 
> Hm.  The bootup actually stops at that point?  It doesn't identify any
> partitions or complain about any errors?  This sounds like a SCSI
> problem
> to me.
> 
> In theory, you should be able to boot with 'vmlinux root=/dev/sdb'.
> 
> - alex
