Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA83711 for <linux-archive@neteng.engr.sgi.com>; Wed, 23 Sep 1998 13:51:33 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA92972
	for linux-list;
	Wed, 23 Sep 1998 13:50:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA97882
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 23 Sep 1998 13:50:46 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from bronx.bizarre.nl (9dyn101.breda.casema.net [195.96.116.101]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA00163
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Sep 1998 13:50:44 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from infopact.nl (root@localhost [127.0.0.1])
	by bronx.bizarre.nl (8.9.0/8.9.0) with ESMTP id WAA01731;
	Wed, 23 Sep 1998 22:54:22 +0200
Message-ID: <36095FFD.F4A33EEC@infopact.nl>
Date: Wed, 23 Sep 1998 22:54:22 +0200
From: Richard Hartensveld <richardh@infopact.nl>
X-Mailer: Mozilla 4.05 [en] (X11; I; Linux 2.0.35 i686)
MIME-Version: 1.0
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: Alex deVries <adevries@engsoc.carleton.ca>, Rob Lembree <lembree@sgi.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
References: <36081982.8D3B6975@infopact.nl> <Pine.LNX.3.96.980922201845.10292B-100000@lager.engsoc.carleton.ca> <19980923212241.01963@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas Bogendoerfer wrote:

> On Tue, Sep 22, 1998 at 08:24:20PM -0400, Alex deVries wrote:
> >       First, I wonder how much of the kernel will actually work on the
> > Challenge S; I'm told there are SCSI controller differences.
>
> looking linus.linux.sgi.com, which is AFAIK a Challenge S, it seems the
> Challenge has a wd33c93 and a wd33c95. The wd33c93 is what we already support.
> As long as the harddisk are attached to it, it should work. The wd33c95
> is a rather strange chip, and from the datasheet I have here, it looks like
> a lot of work to write a driver for it, because besides the kernel code,
> you have to write sequence code for the chip, too.
>
> >       The install kernel you're using (and oh god, is it ever a bad one)
> > is broken in that serial console won't work.  Yes, I should have looked
> > into it way back when.
>
> When I did the new console code, I first made the serial console working.
> As far as I remember I had to do some ugly hacks, but I'll try to clean
> it up and check it in.
>

I'm going to build the cross compiler right now and get myself involved in
linux/sgi porting, i've got
a reasonable amount of sgi's overhere to test on and maybe even get linux to boot
a kernel on a non-indy machine.

Richard
