Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA21281; Thu, 13 Mar 1997 14:25:49 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA23820 for linux-list; Thu, 13 Mar 1997 22:25:23 GMT
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA23798 for <linux@engr.sgi.com>; Thu, 13 Mar 1997 14:25:19 -0800
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (940816.SGI.8.6.9/940406.SGI)
	for <@soyuz.wellington.sgi.com:linux@engr.sgi.com> id KAA07362; Fri, 14 Mar 1997 10:45:35 +1300
Received: (from alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA07710 for linux@engr.sgi.com; Fri, 14 Mar 1997 11:24:41 +1300
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9703141124.ZM7712@windy.wellington.sgi.com>
Date: Fri, 14 Mar 1997 11:24:41 +0000
In-Reply-To: Mike Shaver <shaver@neon.ingenia.ca>
        "Hello world!" (Mar 14, 10:32am)
References: <199703132210.RAA29664@neon.ingenia.ca>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: Hello world!
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mar 14, 10:32am, Mike Shaver wrote:
> Subject: Hello world!
> Looks like I'm getting an Indy when I get back to Ottawa next week, so
> I'd like to hear from others (hello?) as to what kind of work we're
> looking at in the short term.
>
> Since I don't grok assembler (my private shame), I don't know how much
> help I'll be at the low-level system stage.  I'm quite interested in
> working on userland stuff, and will gladly do any kernel mucking that
> I can handle.  (And if someone wants to give me a crash assembly
> course, well... =) )
>
> I understand that we're looking to get a source repository out on the
> 'net, which would be a good start.  What are people planning to start
> with first?  (I suppose talking to disks is a priority... =) )
>

Umm...I'm sure David got the SCSI stuff going....infact let's look back in my
Outgoing mailbox....Yup, here we go:

  WD93:Driver version 1.21 compiled on Jul 11 1996 at 07:19:23
  wd33c93-0: chip-WD22c93B microcode=0d
  scsi0 : SGI WD93
  scsi : 1 host
  Started kswapd v 1.2
    Vendor: SGI       Model: SEAGATE ST31230N  Rev: 0272
    Type:   Direct-Access                      ANSI SCSI revision: 02
  Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
    Vendor: SGI       Model: IBMDSAS-3540      Rev: S47K
    Type:   Direct-Access                      ANSI SCSI revision: 02
  Detected scsi disk sda at scsi0, channel 0, id 2, lun 0
  scsi : detected 2 SCSI disks total
  SCSI device sda: hdwr sector= 512 bytes. Sectors= 2070235 [1010 MB] [1.0 GB]
  SCSI device sdb: hdwr sector= 512 bytes. Sectors= 1070496 [522 MB] [0.5 GB]
  sgiseeq.....
  eth0:......
  Partition check:
   sda: sda1 sda2 sda3 sda4
   sdb: sdb1 sdb2 sdb3 sdb4
  Sending BOOTP.....

It was a little slow the first time, but he fixed that.  It understands SGI
partition tables.

Cheers, Alistair

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
