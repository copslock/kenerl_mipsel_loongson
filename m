Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA15712 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Dec 1997 16:09:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA15701 for linux-list; Tue, 2 Dec 1997 16:08:14 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA15692 for <linux@cthulhu.engr.sgi.com>; Tue, 2 Dec 1997 16:08:12 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA18134
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Dec 1997 16:07:15 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id AAA09622; Wed, 3 Dec 1997 00:07:09 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xd2Na-0005FtC; Wed, 3 Dec 97 00:09 GMT
Message-Id: <m0xd2Na-0005FtC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Linux on the O2
To: cypher@vertigo.cs.indiana.edu (cypher)
Date: Wed, 3 Dec 1997 00:09:26 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.971202161948.10955B-100000@vertigo.cs.indiana.edu> from "cypher" at Dec 2, 97 04:50:40 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I'm guessing that they're looking at this as if an Indy running Linux
> won't really be that competetive with the O2s runnning IRIX, which I can
> almost understand. 

Ah conspiracy theories abound. It could just be they didnt want anyone
cloning their hardware

> I realize that SGI has a vested interest in seeing IRIX succeed, and IRIX
> is probably (it hurts to say this) better than Linux when running 128 (or
> soon 4096) CPUs. Linux however, is great lightweight OS for workstations

Right now Linux scales to about 2-3 CPU's for generic stuff in 2.1.x maybe
4 if the hardware is sane (eg Ultrasparc). To go to 128-4096 CPU's really
involves changing the fundamental rules and building a sort of very tightly
interlinked multicomputer - AP1000+ on steroids as it were. There is some
interest in this from various people, notably in sticking 9 or 10 EBSA285
Digital strongarm boards in a PCI backplane and using PCI bus as the 
backbone network.

Alan
