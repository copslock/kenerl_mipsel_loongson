Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA80719 for <linux-archive@neteng.engr.sgi.com>; Tue, 22 Sep 1998 17:21:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA84487
	for linux-list;
	Tue, 22 Sep 1998 17:20:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA57351
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 22 Sep 1998 17:20:54 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA05838
	for <linux@cthulhu.engr.sgi.com>; Tue, 22 Sep 1998 17:20:52 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id UAA14275;
	Tue, 22 Sep 1998 20:24:20 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 22 Sep 1998 20:24:20 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Richard Hartensveld <richardh@infopact.nl>
cc: Rob Lembree <lembree@sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
In-Reply-To: <36081982.8D3B6975@infopact.nl>
Message-ID: <Pine.LNX.3.96.980922201845.10292B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 22 Sep 1998, Richard Hartensveld wrote:
> Should the default kernel support serial terminal consoles?? My goal is
> to install linux onto the challenge
> (which is headless) using a serial terminal connected to it, is this
> possible by default or should i cross-compile my own kernel on another
> platform?.

Rich,

	First, I wonder how much of the kernel will actually work on the
Challenge S; I'm told there are SCSI controller differences.

	The install kernel you're using (and oh god, is it ever a bad one)
is broken in that serial console won't work.  Yes, I should have looked
into it way back when.  There's two things you can do:

- rebuild a kernel by cross compiling in the correct options (this is
reasonably easy to do)
- wait for me to have my machine moved (finally) and online and I'll whip
up a modern install kernel for you and the others with serial console

Just to reiterate, yes, I *will* be fixing the install.  The initrd stuff
is going to have to make it in, even if it kills me. And I'll be working
on porting Rawhide 1.0 too.

- Alex
