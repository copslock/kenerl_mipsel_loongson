Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA48640 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 10:23:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA63346
	for linux-list;
	Tue, 2 Feb 1999 10:22:45 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgidal.dallas.sgi.com (sgidal.dallas.sgi.com [169.238.80.130])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id KAA93340
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 10:22:43 -0800 (PST)
	mail_from (chad@roctane.dallas.sgi.com)
Received: from roctane.dallas.sgi.com by sgidal.dallas.sgi.com via ESMTP (950413.SGI.8.6.12/911001.SGI)
	 id MAA02105; Tue, 2 Feb 1999 12:20:54 -0600
Received: from roctane.dallas.sgi.com (localhost [127.0.0.1]) by roctane.dallas.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA17250; Tue, 2 Feb 1999 10:20:54 -0800 (PST)
Message-ID: <36B74206.8E63A799@roctane.dallas.sgi.com>
Date: Tue, 02 Feb 1999 12:20:54 -0600
From: Chad Carlin <chad@roctane.dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Graefe <nachtfalke@usa.net>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
References: <19990202155147.A1565@ganymede>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alexander,

I'm having similar problems with my R4400. I was trying to boot from
another Indy. Now I went and got a PC and loaded linux on it. This
should put my config as much like everyone elses as I can make it.
Will try the boot later tonight.

I've asked this list for anyone else running linux on an R4400. I've
gotten no responses. You and I may be the only ones.

Chad

Alexander Graefe wrote:

> Hi.
>
> I got as far as booting Linux via bootp on my Indy, but after the
> remote root-fs is mounted, the kernel dies with an "Aieee" and
> something about irq request handler.
>
> I tried booting with the 2.1.131-Kernel from ftp.linux.sgi.com, but
> that one doesn't try to mount the root-fs via NFS.
>
> What kernel should I use to actually see a prompt on my Indy ?
>
> Bye,
>         LeX, determined to get Linux on there :)
> --
> Quidquid latine dictum sit, altum viditur.

--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
        "flying through hyper space ain't like dusting crops, boy"
