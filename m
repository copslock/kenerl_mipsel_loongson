Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA20747 for <linux-archive@neteng.engr.sgi.com>; Tue, 14 Jul 1998 06:31:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA47984
	for linux-list;
	Tue, 14 Jul 1998 06:31:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id GAA15798;
	Tue, 14 Jul 1998 06:30:59 -0700 (PDT)
	mail_from (leon@reading.sgi.com)
Received: from localhost by wintermute.reading.sgi.com via SMTP (950413.SGI.8.6.12/911001.SGI)
	 id OAA03348; Tue, 14 Jul 1998 14:30:47 +0100
Date: Tue, 14 Jul 1998 14:30:47 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
cc: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: 5.1 installation fun & games...
In-Reply-To: <Pine.LNX.3.95.980713141746.22134F-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.SGI.3.96.980714142244.3264B-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 13 Jul 1998, Alex deVries wrote:

> On Mon, 13 Jul 1998, Leon Verrall wrote:
>
> > Well, here's a funny thing... 
> > I now have a debian Linux box in the office configured for bootp and tftp
> > etc. It has the manhattan alpha 1 distribution on it. I bootp():/vmlinuz my
> > Indy, the kernel boots fine and then:
> >   Warning: unable to open an initial console. 
> > Where have we seen this before? 
> 
> This is a problem with the install not being able to find the /dev/console
> file.  It usually means you don't have the install pointing in the right
> place.  I'd suggest looking at tftp and nfs logs closely.

This is irritating... rpc.nfsd reports this activity during the boot:

 Jul 14 13:55:59 lab17 mountd[199]: NFS mount of /usr/src/sgi/installfs
 attempted from 144.253.75.29 
 Jul 14 13:55:59 lab17 mountd[199]: /usr/src/sgi/installfs has been mounted
 by 144.253.75.29
 Jul 14 13:55:59 lab17 nfsd[420]: getattr [1 70/1/1 01:00:04 lab29 0.0]
 Jul 14 13:55:59 lab17 nfsd[420]: ^I7200e760 04 708c8eca
 Jul 14 13:55:59 lab17 nfsd[420]: result: 0
 Jul 14 13:55:59 lab17 nfsd[420]: lookup [1 70/1/1 01:00:04 lab29 0.0]
 Jul 14 13:55:59 lab17 nfsd[420]: ^Ifh:/usr/src/sgi/installfs n:dev
 Jul 14 13:55:59 lab17 nfsd[420]: ^Inew_fh = /usr/src/sgi/installfs/dev
 Jul 14 13:55:59 lab17 nfsd[420]: result: 0
 Jul 14 13:55:59 lab17 nfsd[420]: lookup [1 70/1/1 01:00:04 lab29 0.0]
 Jul 14 13:55:59 lab17 nfsd[420]: ^Ifh:/usr/src/sgi/installfs/dev n:console
 Jul 14 13:55:59 lab17 nfsd[420]: ^Inew_fh =
 /usr/src/sgi/installfs/dev/console  
 Jul 14 13:55:59 lab17 nfsd[420]: result: 0                                      

And then goes on to stat init, some libraries and the install2 binary but
still comlians that the console can't be opened. 

OK, I thought perhaps that filesystems is duff. So I exported / on the linux
box and booted with that as my nfsroot. OK it'll fail to find init (which it
did) but it should open /dev/console. Nope, same error. 

As far as I can tell the mount is sucessful and the right files are being
accessed. Presumably the filesystem is properly mounted by the kernel on the
Indy under / so what does that leave...?

Leon

-- 
Leon Verrall - 01189 307734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
