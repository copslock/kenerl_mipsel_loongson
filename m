Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id HAA1171716 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Dec 1997 07:06:23 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA04287 for linux-list; Fri, 12 Dec 1997 07:05:08 -0800
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA04278 for <linux@cthulhu.engr.sgi.com>; Fri, 12 Dec 1997 07:05:06 -0800
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/930416.SGI)
	 id KAA08867; Fri, 12 Dec 1997 10:04:42 -0500
Received: from cygnus.detroit.sgi.com (localhost [127.0.0.1]) by cygnus.detroit.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id KAA10464; Fri, 12 Dec 1997 10:04:39 -0500
Message-ID: <34915286.EF32CC9D@cygnus.detroit.sgi.com>
Date: Fri, 12 Dec 1997 10:04:38 -0500
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.04C-SGI [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Takeshi Hakamada <hakamada@meteor.nsg.sgi.com>
CC: alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
Subject: Re: Mount ext2 filesystem.
References: <m0xgJdw-0005FsC@lightning.swansea.linux.org.uk> <199712120116.KAA05559@meteor.nsg.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

YES! :)


Takeshi Hakamada wrote:
> 
> > > Thank you. I've converted rpm to cpio and I could have installed rpm binary.
> > > But, I can't boot from local disk yet. If I can boot from local disk, I'd
> > > like to update faq on the www.linux.sgi.com. How do you think about it?
> >
> > In irix, shutdown, restart hit the maintenance button to get to the arc
> > menu, hit command line and do I think its
> >
> > boot /whatever/efs/vmlinux root=/dev/sdb1
> >
> > (first partition disk 2 as root)
> 
> I know this method, my want to boot from local disk is, I've not installed
> all rpm packages on the second disk. I'll do this until tomorrow.
> Do you think anyone wants my installation howto?
> 
> --
> Takeshi Hakamada
> Nihon Silicon Graphics Cray
> E-mail: hakamada@nsg.sgi.com, URL: http://reality.sgi.com/hakamada_nsg/
> Phone: +81-45-682-3712, Fax: +81-45-682-0856
> Voice mail: (internal)822-1300, (external)+81-3-5488-1863-1300

-- 
Eric Kimminau                           System Engineer/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"
	
         "I am the great supportfolio, do you have http?"
