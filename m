Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA540881 for <linux-archive@neteng.engr.sgi.com>; Fri, 24 Oct 1997 16:07:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA09638 for linux-list; Fri, 24 Oct 1997 16:05:19 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA09611 for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 16:05:13 -0700
Received: from dns.cobaltmicro.com ([209.19.61.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA27124
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Oct 1997 16:05:08 -0700
	env-from (ralf@mail2.cobaltmicro.com)
Received: from dull.cobaltmicro.com (dull.cobaltmicro.com [209.19.61.35])
	by dns.cobaltmicro.com (8.8.5/8.8.5) with ESMTP id QAA10215;
	Fri, 24 Oct 1997 16:04:48 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
Received: (from ralf@localhost)
	by dull.cobaltmicro.com (8.8.5/8.8.5) id QAA00534;
	Fri, 24 Oct 1997 16:02:21 -0700
Message-Id: <199710242302.QAA00534@dull.cobaltmicro.com>
Subject: Re: Look what I found in a big cardboard box
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 24 Oct 1997 16:02:08 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <m0xOrfv-0005G0C@lightning.swansea.linux.org.uk> from "Alan Cox" at Oct 24, 97 10:53:47 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> And there was light (actually there was heavy..)

*grin*  And there was big - the box didn't fit into my car ...

> My SGI arrived today. Anyway after the required prelimiaries (Batallion,
> making stupid indycam movies) I had a hack at the ext2fs utils and libs -
> fixed them to compile and run properly under the Indy native cc. I can
> successfully make and then fsck an ext2 partition.

I'll work on a set of standalone utilities for the Indy's ARC (pronounce
arggghh ...) firmware.  That will bring us closer to get the thing
independant from IRIX.  In theory it should be pretty easy, but the
various ARC implementations I saw so far were beyond just completly broken,
at least the old onces which should be supported, too.

> What Im going to do next is chase the work from the Mac68K installer and
> see if I can use that with the ext2fs lib to get the same arrangement working
> (that is an application level toolset for installing tars and the like) from
> Irix. 
> 
> To that goal I'm going to be working on the tool stuff until I've successfully
> bootstrapped Linux that way.

Cool.

  Ralf
