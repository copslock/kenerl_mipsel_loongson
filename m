Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA716007 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Sep 1997 20:52:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA01543 for linux-list; Mon, 22 Sep 1997 20:52:07 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA01539 for <linux@cthulhu.engr.sgi.com>; Mon, 22 Sep 1997 20:52:06 -0700
Received: from motown.detroit.sgi.com (motown.detroit.sgi.com [169.238.128.3]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id UAA26779 for <linux@fir.engr.sgi.com>; Mon, 22 Sep 1997 20:52:04 -0700
Received: from detroit.sgi.com by motown.detroit.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id XAA25272; Mon, 22 Sep 1997 23:51:58 -0400
Message-ID: <34273C4E.9AD0AB2F@detroit.sgi.com>
Date: Mon, 22 Sep 1997 23:49:34 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.03C-SGI [en] (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
CC: linux-mips@fnet.fr, linux@fir.engr.sgi.com
Subject: Re: Task list --preliminary list
References: <199709230232.VAA16659@athena.nuclecu.unam.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

PRI 10
Howto updated so it show how to take a system currently running IRIX and
get it to a point where it is running Linux. I know it isn't truly
development work, but Ive been stuck with a non-functional Indy for most
of a month.My problems seem to be related to trying to NFS boot off of a
remote XFS file system but I could be wrong. I haven't grabbed the
latest kernel to try so that could resolve my issue.

Miguel de Icaza wrote:
> 
> Here is a preliminary task list of things that should be done for a
> complete Linux/MIPS port, right now it includes by personal favorites
> and I am working on some of those bits, but some of the other can be
> done now, I have a copy of this at:
> 
>         http://www.nuclecu.unam.mx/~miguel/mips-task-list.txt
> 
> Priority:
> 
> [9]  Get more userland programs compiled in RPM form
> 
> [9]  Merging the latest GNU libc releases.
> 
> [9]  Get the X libraries compiled.
> 
> [5]  Getting SGI mouse to work.
> 
> [5]  Test the STREAMS implementation of the mouse.
> 
> [6]  Figure why init is setting the sigprocmask to a value different
>      from 0.  This disables the debugger (SIGTRAP is disabled for
>      all child processes).
> 
> [7]  Getting IRIX X server to accept connections.
> 
> Please, send me additions to this list.
> Miguel.

-- 
Eric Kimminau                             System Engineer
eak@detroit.sgi.com                       Silicon Graphics, Inc
Vox:(810) 848-4455                        39001 West 12mile Road
Fax:(810)848-5600                         Farmington, MI 48331-2903
            "I speak my mind and no one else's."
    http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

-----END PGP PUBLIC KEY BLOCK-----
http://bs.mit.edu:11371/pks/lookup?op=vindex&search=Eric+A.+Kimminau&fingerprint=on
