Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA65955 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 12:27:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA68980
	for linux-list;
	Tue, 2 Feb 1999 12:26:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA64633
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 12:26:31 -0800 (PST)
	mail_from (jonas@bigblue.frungy.se)
Received: from bigblue.frungy.se (bigblue.frungy.se [193.15.54.140]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08919
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Feb 1999 12:26:29 -0800 (PST)
	mail_from (jonas@bigblue.frungy.se)
Received: from localhost (jonas@localhost)
	by bigblue.frungy.se (8.9.0/8.8.7) with SMTP id VAA00179;
	Tue, 2 Feb 1999 21:26:08 +0100
Date: Tue, 2 Feb 1999 21:26:08 +0100 (CET)
From: Jonas Vis <jonas@bigblue.frungy.se>
To: Chad Carlin <chad@roctane.dallas.sgi.com>
cc: Alexander Graefe <nachtfalke@usa.net>, linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
In-Reply-To: <36B74206.8E63A799@roctane.dallas.sgi.com>
Message-ID: <Pine.LNX.3.96.990202212242.142B-100000@bigblue.frungy.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi

I`m having the same problem on my Indy(R4400). The kernel boots ok, but
after the remote root-nfs is mounted it dies with something about irq
request handler. I`m using a PC running Linux to boot from.


//Jonas

On Tue, 2 Feb 1999, Chad Carlin wrote:

> Alexander,
> 
> I'm having similar problems with my R4400. I was trying to boot from
> another Indy. Now I went and got a PC and loaded linux on it. This
> should put my config as much like everyone elses as I can make it.
> Will try the boot later tonight.
> 
> I've asked this list for anyone else running linux on an R4400. I've
> gotten no responses. You and I may be the only ones.
> 
> Chad
> 
> Alexander Graefe wrote:
> 
> > Hi.
> >
> > I got as far as booting Linux via bootp on my Indy, but after the
> > remote root-fs is mounted, the kernel dies with an "Aieee" and
> > something about irq request handler.
> >
> > I tried booting with the 2.1.131-Kernel from ftp.linux.sgi.com, but
> > that one doesn't try to mount the root-fs via NFS.
> >
> > What kernel should I use to actually see a prompt on my Indy ?
> >
> > Bye,
> >         LeX, determined to get Linux on there :)
> > --
> > Quidquid latine dictum sit, altum viditur.
> 
> --
>            -----------------------------------------------------
>             Chad Carlin                          Special Systems
>             Silicon Graphics Inc.                   972.205.5911
>             Pager 888.754.1597          VMail 800.414.7994 X5344
>             chad@sgi.com             http://reality.sgi.com/chad
>            -----------------------------------------------------
>         "flying through hyper space ain't like dusting crops, boy"
> 
> 
> 
