Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id WAA131637; Fri, 15 Aug 1997 22:11:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA21481 for linux-list; Fri, 15 Aug 1997 22:10:45 -0700
Received: from motown.detroit.sgi.com (motown.detroit.sgi.com [169.238.128.3]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA21458 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 22:10:42 -0700
Received: from detroit.sgi.com by motown.detroit.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id BAA24055; Sat, 16 Aug 1997 01:10:34 -0400
Message-ID: <33F535E0.7336423F@detroit.sgi.com>
Date: Sat, 16 Aug 1997 01:08:48 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
CC: adevries@engsoc.carleton.ca, ariel@sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: boot linux - wish
References: <199708152146.QAA30833@athena.nuclecu.unam.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza wrote:
> 
> > > Could someone rise to the challenge of writing a utility
> > > that will install Linux on an IRIX machine?
> >
> > I don't mind rising to that challenge, but one huge obstacle is how do we
> > get the utility to partition the Linux drive?
> 
> the fx command is used to partition disks on IRIX.  It took me a while
> to work around the user friendlyness of it, but then, I wanted to keep
> a part of my disk with XFS (because I just LOVE that file system) and
> the rest for my ext2fs.
> 
> > I'm guessing the solution is to write a utility that from within Irix
> > talks directly to the raw SCSI disk to setup the partitions.  I have NO
> > idea how to do this as I doubt the raw disk interface is anything like
> > that in Linux. Clues accepted.
> 
> The only thing you need to do is access the first sector in the disk.
> this one holds the disk label with the current partition definitions.
> Oliver at .at was working on getting Linux FDISK up and running, you
> can probably talk with him.
> 
> > > And give hints like:
> > >     Sorry you don't have the e2fs tools installed on IRIX yet
> > >     should I download them from ftp.linux.sgi.com [y/n]?
> >
> > Er, does such a tool in fact exist?
> 
> Yes.  get the e2fsprogs suite, it is the only thing you need to
> populate a file system.
> 
> Miguel.

Is there ever ANY chance of seeing XFS in Linux? Or a flavor of a really
fast journaled file system?

-- 
Eric Kimminau                             System Engineer
eak@detroit.sgi.com                       Silicon Graphics, Inc
Vox:(810) 848-4455                        39001 West 12mile Road
Fax:(810)848-5600                         Farmington, MI 48331-2903
            "I speak my mind and no one else's."
    http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

-----END PGP PUBLIC KEY BLOCK-----
http://bs.mit.edu:11371/pks/lookup?op=vindex&search=Eric+A.+Kimminau&fingerprint=on
