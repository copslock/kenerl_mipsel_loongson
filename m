Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA36825 for <linux-archive@neteng.engr.sgi.com>; Mon, 13 Jul 1998 09:28:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA34816
	for linux-list;
	Mon, 13 Jul 1998 09:27:24 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id JAA21870
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 13 Jul 1998 09:27:22 -0700 (PDT)
	mail_from (leon@reading.sgi.com)
Received: from localhost by wintermute.reading.sgi.com via SMTP (950413.SGI.8.6.12/911001.SGI)
	 id RAA28150; Mon, 13 Jul 1998 17:27:17 +0100
Date: Mon, 13 Jul 1998 17:27:17 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
To: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: 5.1 installation fun & games...
In-Reply-To: <Pine.SGI.3.96.980709194408.49036B-100000@tantrik.engr.sgi.com>
Message-ID: <Pine.SGI.3.96.980713172049.28090A-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 9 Jul 1998, Shrijeet Mukherjee wrote:

> ->Ah, a chicken and egg thing. You can nfsroot an SG linux box as long as you
> ->have a linux box to do it from...
> 
> so do I understand correctly that I cannot boot my Indy for setting linux
> up from another IRIX box (running 6.5) ... but have to go find a Intel box
> running Linux ?

Well, here's a funny thing... 

I now have a debian Linux box in the office configured for bootp and tftp
etc. It has the manhattan alpha 1 distribution on it. I bootp():/vmlinuz my
Indy, the kernel boots fine and then:

  Warning: unable to open an initial console. 

Where have we seen this before? 

/etc/exports has :

  /usr/src/sgi/installfs 144.253.75.29(no_root_squash,rw)

I've tried mucking about with permissions on the files in
/usr/src/sgi/installfs/dev but no dice. And the code it stops at is:

  if (open("/dev/console", O_RDWR, 0) < 0)
                printk("Warning: unable to open an initial console.\n");

So nothing complicated happening there. It just plain can't open
/dev/console for read and write... rpc.mountd's debug output doesn't help.
It just says the mount was sucessful. 

I've also tried a few options like nfsroot=/usr/src/sgi/installfs,flags=dev
just to make sure...

Anyone else hitting this? 

Leon

-- 
Leon Verrall - 01189 307734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
