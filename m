Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA19999 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 Aug 1998 10:17:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA85299
	for linux-list;
	Thu, 27 Aug 1998 10:15:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA10203
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Aug 1998 10:15:21 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA02128
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Aug 1998 10:15:22 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA19394;
	Thu, 27 Aug 1998 13:16:44 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 27 Aug 1998 13:16:44 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Arnaud Le Neel <Arnaud.Le.Neel@cyceron.fr>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: boot problem for Indy
In-Reply-To: <35E59FBA.96A1900C@cyceron.fr>
Message-ID: <Pine.LNX.3.96.980827131327.10299B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 27 Aug 1998, Arnaud Le Neel wrote:
> >> boot -f bootp()linux.cyceron.fr:vmlinux
> Setting $netaddr to 192.93.44.35 (for server server.cyceron.fr)
> Obtaining vmlinux from server.cyceron.fr
> Cannot reload bootp()server.cyceron.fr:vmlinux
> Illegal f_magik number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC
> Unable to load bootp()server.cyceron.fr:vmlinux: execute format error
> PS: Here is the description of the Indy i want to boot Linux:
> 	IP22 100MHz R4000 with FPU

Hm.  Sounds to me like a processor thing.  Could that be, Ralf?  I'm not
sure I've seen anyone try on an R4000 before, and if so, wha the
implications of are for its cache.

Either that, or somehow there's a bootloader issue.  I expect the MIPSEB
or MIPSEL Magic is part of the (ecoff?) header; perhaps the image you're
booting from or your version of ARC is somehow incorrect. Ralf?

- Alex
