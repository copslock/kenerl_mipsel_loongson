Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id HAA14617; Thu, 7 Aug 1997 07:52:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA28180 for linux-list; Thu, 7 Aug 1997 07:51:56 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA28148 for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 07:51:45 -0700
Received: from cygnus by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id KAA26202; Thu, 7 Aug 1997 10:51:29 -0400
Message-ID: <33E9E0F1.BEBC7A4C@cygnus.detroit.sgi.com>
Date: Thu, 07 Aug 1997 10:51:29 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.01b6C [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Mike Shaver <shaver@neon.ingenia.ca>
CC: eak@detroit.sgi.com, chadm@sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: Challenge S
X-Priority: 3 (Normal)
References: <199708071435.KAA25462@neon.ingenia.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver wrote:
> 
> Thus spake Eric Kimminau:
> > I think it would be a great application but Linux is sorely missing a
> > very important piece - lockd for NFS.
> 
> Or, perhaps not:
> 
> [shaver@neon fs]$ pwd
> /usr/src/linux/fs
> [shaver@neon fs]$ ls -l lockd
> total 99
> -rw-r--r--   1 shaver   users         513 Apr  4 14:06 Makefile
> -rw-r--r--   1 shaver   users        4721 Apr  4 14:06 clntlock.c
> -rw-r--r--   1 shaver   users       13087 Apr  7 21:43 clntproc.c
> -rw-r--r--   1 shaver   users        7941 Apr 16 00:47 host.c
> -rw-r--r--   1 shaver   users         873 Apr  4 14:06 lockd_syms.c
> -rw-r--r--   1 shaver   users        4890 Apr  4 15:21 mon.c
> -rw-r--r--   1 shaver   users        6472 Apr 16 00:47 svc.c
> -rw-r--r--   1 shaver   users       16741 Apr  4 15:21 svclock.c
> -rw-r--r--   1 shaver   users       14254 Apr  4 14:06 svcproc.c
> -rw-r--r--   1 shaver   users        2549 Apr  4 14:06 svcshare.c
> -rw-r--r--   1 shaver   users        6680 May 12 13:35 svcsubs.c
> -rw-r--r--   1 shaver   users       13785 Apr  4 14:06 xdr.c
> [shaver@neon fs]$
> 
> =)
> 
> Mike

Cool!!!!!!!!

Thanks Mike!


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
