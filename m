Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA45868 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 11:14:51 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA25544
	for linux-list;
	Tue, 2 Feb 1999 11:14:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgidal.dallas.sgi.com (sgidal.dallas.sgi.com [169.238.80.130])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA01339
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 11:14:02 -0800 (PST)
	mail_from (chad@roctane.dallas.sgi.com)
Received: from roctane.dallas.sgi.com by sgidal.dallas.sgi.com via ESMTP (950413.SGI.8.6.12/911001.SGI)
	 id NAA03356; Tue, 2 Feb 1999 13:12:07 -0600
Received: from roctane.dallas.sgi.com (localhost [127.0.0.1]) by roctane.dallas.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA17356; Tue, 2 Feb 1999 11:12:06 -0800 (PST)
Message-ID: <36B74E06.D6A6A66@roctane.dallas.sgi.com>
Date: Tue, 02 Feb 1999 13:12:06 -0600
From: Chad Carlin <chad@roctane.dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
CC: chad@sgi.com, Alexander Graefe <nachtfalke@usa.net>,
        linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
References: <Pine.SGI.4.05.9902021026050.3770-100000@tantrik.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Shrijeet,

Have you ever gotten your R4400 to boot *any* Linux kernel? I was starting
think that through some strange conspiracy that the entire linux-mips
community has R4600 CPUs.

As long as we are on the subject of hardware..... There are many different
rev levels of gfx, cpu and prom for Indy. Has anyone ever tracked a
particular problem to harware revision levels?

Chad


Shrijeet Mukherjee wrote:

> On Tue, 2 Feb 1999, Chad Carlin wrote:
>
> ->Alexander,
> ->
> ->I'm having similar problems with my R4400. I was trying to boot from
> ->another Indy. Now I went and got a PC and loaded linux on it. This
> ->should put my config as much like everyone elses as I can make it.
> ->Will try the boot later tonight.
> ->
> ->I've asked this list for anyone else running linux on an R4400. I've
> ->gotten no responses. You and I may be the only ones.
> ->
>
> no siree, me too .. just that I have not gotten around to reporting on my
> attempts ..
>
> yeah the 2.1.131 kernel seemed to detect my SCSI devices and just stop ..
> not being NFS bootable would explain that ..
>
> Shrijeet
>
> he who one day will find the time to build a cross-compile environment
> :-()

--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
        "flying through hyper space ain't like dusting crops, boy"
