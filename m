Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA80895; Fri, 15 Aug 1997 11:54:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA09616 for linux-list; Fri, 15 Aug 1997 11:54:38 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA09587 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 11:54:35 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id OAA14860; Fri, 15 Aug 1997 14:54:23 -0400
Message-ID: <33F4A5DE.3EC021BE@cygnus.detroit.sgi.com>
Date: Fri, 15 Aug 1997 14:54:22 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
CC: eak@detroit.sgi.com, ralf@mailhost.uni-koblenz.de,
        linux@cthulhu.engr.sgi.com
Subject: Re: Local disk boot HOWTO
References: <199708151845.NAA29864@athena.nuclecu.unam.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza wrote:
> 
> > Has anyone completed a HOWTO for booting from a second local disk yet?
> >
> > Thanks!
> 
> No, but if you put your Linux kernel on EFS or XFS, you just need to
> go to the sash boot prompt and from there type:
> 
>         boot /vmlinux
> 
> Miguel.

This is incorrect. It will not boot off of a second disk with everything
on an XFS partition. We ar ejust about to finish the restore to an efs
partition and try it that way.


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

Windows 95: n.
    32 bit extensions and a graphical shell for a 16 bit patch to an
    8 bit operating system originally coded for a 4 bit microprocessor,
    written by a 2 bit company that can't stand 1 bit of competition.

    Author unknown.
