Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA39443 for <linux-archive@neteng.engr.sgi.com>; Mon, 13 Jul 1998 11:22:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA31135
	for linux-list;
	Mon, 13 Jul 1998 11:21:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA79249;
	Mon, 13 Jul 1998 11:21:16 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA05828; Mon, 13 Jul 1998 11:21:14 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA00737;
	Mon, 13 Jul 1998 14:21:07 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 13 Jul 1998 14:21:07 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Leon Verrall <leon@reading.sgi.com>
cc: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: 5.1 installation fun & games...
In-Reply-To: <Pine.SGI.3.96.980713172049.28090A-100000@wintermute.reading.sgi.com>
Message-ID: <Pine.LNX.3.95.980713141746.22134F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Mon, 13 Jul 1998, Leon Verrall wrote:
> On Thu, 9 Jul 1998, Shrijeet Mukherjee wrote:
> > ->Ah, a chicken and egg thing. You can nfsroot an SG linux box as long as you
> > ->have a linux box to do it from...
> > so do I understand correctly that I cannot boot my Indy for setting linux
> > up from another IRIX box (running 6.5) ... but have to go find a Intel box
> > running Linux ?

Yes, this is uncomfortable, and slightly ridiculous that you'd have to do
this. For now, this is just the way it will be until we get proper initrd
stuff working in the kernel.

> Well, here's a funny thing... 
> I now have a debian Linux box in the office configured for bootp and tftp
> etc. It has the manhattan alpha 1 distribution on it. I bootp():/vmlinuz my
> Indy, the kernel boots fine and then:
>   Warning: unable to open an initial console. 
> Where have we seen this before? 

This is a problem with the install not being able to find the /dev/console
file.  It usually means you don't have the install pointing in the right
place.  I'd suggest looking at tftp and nfs logs closely.

- Alex
