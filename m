Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA260340; Thu, 10 Jul 1997 15:03:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA04361 for linux-list; Thu, 10 Jul 1997 15:03:26 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA03975 for <linux@cthulhu.engr.sgi.com>; Thu, 10 Jul 1997 15:02:05 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA24075 for linux@engr.sgi.com; Thu, 10 Jul 1997 15:02:03 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199707102202.PAA24075@oz.engr.sgi.com>
Subject: Re: How to get the masses (IRIX<->Linux) (fwd)
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Thu, 10 Jul 1997 15:02:03 -0700 (PDT)
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[I'm forwarding this very helpful hint from Christian to the list
 not sure if all our audience, especially those outside SGI are aware
 of all these options.]

Now since after setting nvram it'll always boot Linux ;-)
the question is how to toggle two different (Linux/IRIX)
nvram settings in a friendly trivial way...

Looks like a SILO option after the wakup/reboot would be the best.

	Press 1 to boot IRIX [default]
	Press 2 to boot Linux

----- Forwarded message from Christian Reisch -----

>From creisch@esd.sgi.com  Thu Jul 10 14:52:45 1997
Sender: creisch@esd.sgi.com
Date: Thu, 10 Jul 1997 14:52:39 -0700
From: Christian Reisch <creisch@esd.sgi.com>
To: Ariel Faigon <ariel@sgi.com>
Subject: Re: How to get the masses (IRIX<->Linux)

Ariel Faigon wrote:

>         % su
>         # at 5am July 3
>         /usr/sbin/wakeupat 6pm Thursday
>         /etc/shutdown -y
>         <Ctl-d> (control - d)  This will submit the job.
>         # exit
> 
> If we could rewrite wakeupat or reboot to take some
> extra boot options or alternatively run some Linux loader
> (SILO/MILO) from IRIX then 2) should be easy.
> 
>

	I think irix decides where to boot from from these nvram variable...

SystemPartition=pci(0)scsi(0)disk(1)rdisk(0)partition(8)
OSLoadPartition=pci(0)scsi(0)disk(1)rdisk(0)partition(0)
OSLoader=sash
OSLoadFilename=/unix
OSLoadOptions=auto

You could write a script to fudge them with the nvram command then
shutdown and wake up.  Unfortunately I don't have the disk/time to play
with it at the moment

6

----- End of forwarded message from Christian Reisch -----

-- 
Peace, Ariel
