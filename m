Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA34664 for <linux-archive@neteng.engr.sgi.com>; Sun, 22 Mar 1998 21:16:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id VAA2587975
	for linux-list;
	Sun, 22 Mar 1998 21:15:49 -0800 (PST)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id VAA2528440
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 22 Mar 1998 21:15:45 -0800 (PST)
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/930416.SGI)
	 id AAA25984; Mon, 23 Mar 1998 00:15:43 -0500
Received: from detroit.sgi.com (cx1.detroit.sgi.com [169.238.130.4]) by cygnus.detroit.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA26339; Mon, 23 Mar 1998 00:15:40 -0500 (EST)
Message-ID: <3515EEF2.7A9D75A8@detroit.sgi.com>
Date: Mon, 23 Mar 1998 00:11:14 -0500
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: Brendan Black <ratfink@xtra.co.nz>
CC: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: experiences...
References: <3515ECBF.B46B0714@xtra.co.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Brendan Black wrote:
> The disk is id=2, so irix sits on an efs partition on /dev/dsk/s0d2s0,
> swap on /dev/dsk/s0d2s1, with my e2fs partition on /dev/dsk/s0d2s2,
> which all installed without a hitch, once I had learned the vagaries of
> fx first and the installer second. I may have a hardware problem though,
> on first turning the machine on, it tries accessing scsi device (0,1,0)
> on the diagnostics, which as far as I can tell doesn't exist, and then
> fails diagnostics, then if you hit start system, it boots off (0,2,0)
> >:-|
> 
> I am intending on documenting everything I have to do to get this
> machine working, hopefully with a full install, and submit this to the
> project, so - any ideas on the above lockup/errors ??
> 
> cheers

There is a SCSI ID jumper on the back of the disk (I believe) - binary
code (as ar emost SCSI devices). You should be able to move the jumpte
but you will have to boot miniroot, check your nvram settings to reflect
booting off of the correct drive and then probably modify /etc/fstab so
that it mounts the right things (all of this for IRIX).

I don't know about anyone else, but the only way I could get things
working at all was to have Linux on a completely seperate disk from my
IRIX drive. YMMV.

I still haven't gotten past booting with / mounted read only and then
re-mounting it read/write. The current basic root disk is missing rc
scripts and most of the networking stuff so getting it on the net wasn't
possible. Lots of people offered me places to go and grab a full copy of
their installed systems to yank down but Ive been traveling too much
lately to get to it. Maybe this week...

Eric.



-- 
---------1---------2---------3---------4---------5---------6---------7---------8
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
