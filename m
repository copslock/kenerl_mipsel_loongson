Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA02475 for <linux-archive@neteng.engr.sgi.com>; Thu, 9 Oct 1997 18:29:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA11772 for linux-list; Thu, 9 Oct 1997 18:29:23 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA11763 for <linux@cthulhu.engr.sgi.com>; Thu, 9 Oct 1997 18:29:22 -0700
Received: from dns.cobaltmicro.com ([209.19.61.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA11593
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Oct 1997 18:29:17 -0700
	env-from (ralf@mail2.cobaltmicro.com)
Received: from dull.cobaltmicro.com (dull.cobaltmicro.com [209.19.61.35])
	by dns.cobaltmicro.com (8.8.5/8.8.5) with ESMTP id SAA10173;
	Thu, 9 Oct 1997 18:30:20 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
Received: (from ralf@localhost)
	by dull.cobaltmicro.com (8.8.5/8.8.5) id SAA10165;
	Thu, 9 Oct 1997 18:27:03 -0700
Message-Id: <199710100127.SAA10165@dull.cobaltmicro.com>
Subject: Re: Arch specific initramdisk?
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 9 Oct 1997 18:27:02 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.971009185152.20315W-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Oct 9, 97 06:57:29 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> I'm trying to do kernel modifications so that initrd is supported, which
> will make installations easier.
> 
> I was a bit surprised that these weren't architecture neutral to begin
> with.  Why is this dependant on the arch? The code I've found for other
> archs is in arch/*/kernel/setup.c.
> 
> How safe is it for me to replicate the code from, say, the sparc port?  Is
> there anything I should be aware of?

The only difference between the architectures is where in memory the
initrd is being stored.  I haven't check how things work on a Sparc but
basically what we need should be at least very similar to for example
the i386 code - as far as setup.c is affected.

  Ralf
