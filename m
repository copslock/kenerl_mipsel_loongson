Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA90850 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 May 1998 08:12:01 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA22187517
	for linux-list;
	Fri, 8 May 1998 08:11:52 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA22296392
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 May 1998 08:11:50 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA10976
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 08:11:49 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id LAA26521;
	Fri, 8 May 1998 11:11:44 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 8 May 1998 11:11:44 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Oliver Frommel <oliver@aec.at>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: rs_cons_hook() ?
In-Reply-To: <Pine.LNX.3.96.980508151613.12562A-100000@web.aec.at>
Message-ID: <Pine.LNX.3.95.980508110834.20848O-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 8 May 1998, Oliver Frommel wrote:
> CONFIG_SERIAL_CONSOLE is for i386 only as far as i could figure out ..

Hmmm.  I'm not entirely sure that makes sense.  Shouldn't serial consoles
be architecture independant?

> this is what i have in my -working- kernel:
> # CONFIG_SERIAL_CONSOLE is not set
> CONFIG_SGI_SERIAL=y
> CONFIG_SERIAL=y

... and I get a lot of compile errors when I try to compile with
CONFIG_SGI_SERIAL=y, so I'm forced to turn it off, which is what gives me
errors.

In any case, there's a problem because you should be able to compile a
kernel with enabling SGI_SERIAL.

The problems with sgiserial.c also need to be looked at.  I'll sort this
out... 

- Alex
