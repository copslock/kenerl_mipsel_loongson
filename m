Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA28812; Thu, 7 Aug 1997 13:40:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA03678 for linux-list; Thu, 7 Aug 1997 13:40:29 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA03659 for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 13:40:26 -0700
Received: from cygnus by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id QAA08072; Thu, 7 Aug 1997 16:39:50 -0400
Message-ID: <33EA3296.D3CE8D52@cygnus.detroit.sgi.com>
Date: Thu, 07 Aug 1997 16:39:50 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.01b6C [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: eak@detroit.sgi.com, chadm@sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: Challenge S
X-Priority: 3 (Normal)
References: <m0wwZPV-0005FjC@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alan Cox wrote:
> 
> > I think it would be a great application but Linux is sorely missing a
> > very important piece - lockd for NFS.
> 
> Two things
> 
> 1.      Linux 2.1.x does have a lock daemon
> 2.      Most people and tools avoid NFS locking like the plague because
>         its faster to use polls based on the atomic NFS properties you
>         do have and some short sleeps.
> 
> Oh yes and 3. - NFS locking really doesn't seem to have much in the
> security area..
> 
> Alan

Ever tried using microsoft apps over pcnfs without lockd?

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
