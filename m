Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id DAA14093 for <linux-archive@neteng.engr.sgi.com>; Tue, 23 Sep 1997 03:49:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA24829 for linux-list; Tue, 23 Sep 1997 03:48:39 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA24818 for <linux@cthulhu.engr.sgi.com>; Tue, 23 Sep 1997 03:48:36 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id DAA07935 for <linux@fir.engr.sgi.com>; Tue, 23 Sep 1997 03:48:34 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id GAA18850; Tue, 23 Sep 1997 06:48:23 -0400
Message-ID: <34279E77.E01AED70@cygnus.detroit.sgi.com>
Date: Tue, 23 Sep 1997 06:48:23 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.03C-SGI [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Ralf Baechle <ralf@cobaltmicro.com>
CC: linux-mips@fnet.fr, miguel@nuclecu.unam.mx, linux@fir.engr.sgi.com
Subject: Re: Task list --preliminary list
References: <199709230409.VAA15154@dns.cobaltmicro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> > PRI 10
> > Howto updated so it show how to take a system currently running IRIX and
> > get it to a point where it is running Linux. I know it isn't truly
> > development work, but Ive been stuck with a non-functional Indy for most
> > of a month.My problems seem to be related to trying to NFS boot off of a
> > remote XFS file system but I could be wrong. I haven't grabbed the
> > latest kernel to try so that could resolve my issue.
> 
> This issues might have been resolved by Miguel's latest CVS commit.
> Your NFS problems might also have been cause by the VFS rewrite which
> was essentially turning the filesystems into an inferno for a limited
> time.
> 
>   Ralf

Agreed. Im going to re-try boot later this afternoon with the new
kernel.

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
