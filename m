Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA247096; Thu, 21 Aug 1997 10:45:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA29697 for linux-list; Thu, 21 Aug 1997 10:44:18 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA29684 for <linux@cthulhu.engr.sgi.com>; Thu, 21 Aug 1997 10:44:15 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id NAA17470; Thu, 21 Aug 1997 13:43:55 -0400
Message-ID: <33FC7E5B.9986898E@cygnus.detroit.sgi.com>
Date: Thu, 21 Aug 1997 13:43:55 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
CC: eak@detroit.sgi.com, oliver@aec.at, linux@cthulhu.engr.sgi.com
Subject: Re: "unable to handle kernel paging request" at boot
References: <199708211605.LAA08758@athena.nuclecu.unam.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza wrote:
> 
> > Ill put $100.00 US that you have an R4000 or R4400 Indy NOT an R4600.
> >
> > The only system we have been able to boot is an R4600 with the kernel we
> > pulled down off ftp.
> 
> Can you both guys fetch this kernel:
> 
>         ftp://ftp.nuclecu.unam.mx/incoming/vmlinux
> 
> and send me the output of the crash?
> 
> Miguel.

Well, when we got word yesterday that 4600's were working, we swapped
the CPU module on linux.detroit to an R400 and we are working that way
towards getting a bootable system.

We are still having problems getting a boot via nfs to work.

Things would be a whole lot simpler if we could mke2fs on a disk while
booting IRIX, mount it and copy all the stuff over before trying to boot
linux.

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
