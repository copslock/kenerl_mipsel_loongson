Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA97633 for <linux-archive@neteng.engr.sgi.com>; Sun, 10 May 1998 20:26:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA23003737
	for linux-list;
	Sun, 10 May 1998 20:24:23 -0700 (PDT)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id UAA23019927
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 10 May 1998 20:24:21 -0700 (PDT)
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/930416.SGI)
	 id XAA22594; Sun, 10 May 1998 23:24:19 -0400
Received: from detroit.sgi.com (cx1.detroit.sgi.com [169.238.130.4]) by cygnus.detroit.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA04659; Sun, 10 May 1998 23:24:17 -0400 (EDT)
Message-ID: <35566E3B.109CCAA3@detroit.sgi.com>
Date: Sun, 10 May 1998 23:19:23 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: mdhill@interlog.com
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Evidence of Drive Activity to Report
References: <13652.59663.188834.236218@mdhill.interlog.com> <13653.59491.302730.251578@mdhill.interlog.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I had the exact same problem - I needed to re-make the ext2fs
filesystem on the drive and re-perform the install for it to get
further.

Eric.


Michael Hill wrote:
> 
> Okay, let's say it was just fsck that got hung up, and not the entire
> boot process.  When it stops with '[/sbin/fsck.ext2] fsck.ext2 -a /'
> and I press Ctrl-C, more information comes to light:
> 
> The superblock could not be read or does not describe a correct ext2
> filesystem.  If the device is valid and it really contains an ext2
> filesystem (and not swap or ufs or something else, the the superblock
> is corrupt, and you might try running e2fsck with an alternate superblock:
>     e2fsck -b 8193 <device>
> *** An error occurred during the file system check.
> *** Dropping you to a shell; the system will reboot
> *** when you leave the shell.
> Give root password for maintenance.
> INIT: entering runlevel: 0mal startup):
> while opening UTMP file: No such file or directory
> 
> ...then I get the SGI maintenance screen back.  There's no evidence of
> a shell when it tells me it's dropping me to a shell.  From IRIX I ran
> 'e2fsck -b 8193 drive' on the drive (with no improvement) but I don't
> think that's the appropriate context.  Suggestions?
> 
> Thanks,
> 
> Mike
> --
> Michael Hill
> Toronto, Canada
> mdhill@interlog.com

-- 
---------1---------2---------3---------4---------5---------6---------7
Eric Kimminau                           RTA/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"
	
         "I am the great supportfolio, do you have http?"

        Copyright 1998, Silicon Graphics Computer Systems
        Confidential to Silicon Graphics Computer Systems
                ** -- not for redistribution -- **
