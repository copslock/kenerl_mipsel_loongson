Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id GAA779935 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Sep 1997 06:44:22 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA29555 for linux-list; Wed, 3 Sep 1997 06:43:42 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA29542 for <linux@cthulhu.engr.sgi.com>; Wed, 3 Sep 1997 06:43:39 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id JAA19245; Wed, 3 Sep 1997 09:43:34 -0400
Message-ID: <340D6986.CAD95422@cygnus.detroit.sgi.com>
Date: Wed, 03 Sep 1997 09:43:34 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Mark Salter <marks@sun470.sun470.rd.qms.com>
CC: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com
Subject: Re: Booting off of sdb1...
References: <199709022201.RAA26782@speedy.rd.qms.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Does anyone have a built kernel with this patch applied?

Thanks!
                  Eric.


Mark Salter wrote:
> 
> > The kernel starts, and it finishes off with:
> 
> > Partition check:
> >  sda: sad1 sda2 sda3 sda4
> >  sdb: sdb1 sdb2 sdb3
> > VFS: Mounted root (ext2 filesystem) readonly.
> > : Can't open
> 
> > And then nothing.
> 
> > What am I missing?
> 
> > - Alex
> 
> >       Alex deVries              Success is realizing
> >   System Administrator          attainable dreams.
> >    The EngSoc Project
> 
> Try this patch to linux/arch/mips/sgi/prom/cmdline.c:
> 
> *** cmdline.c.orig      Tue Sep  2 16:59:26 1997
> --- cmdline.c   Tue Sep  2 15:59:04 1997
> ***************
> *** 52,57 ****
> --- 52,59 ----
>         pic_cont:
>                 actr++;
>         }
> +       if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
> +               --cp;
>         *cp = '\0';
> 
>   #ifdef DEBUG_CMDLINE
> 
> --Mark

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
