Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA791832 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 May 1998 10:27:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA60519
	for linux-list;
	Mon, 18 May 1998 10:25:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA59744
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 18 May 1998 10:25:35 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id KAA25296
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 May 1998 10:25:34 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA23837;
	Mon, 18 May 1998 13:24:42 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 18 May 1998 13:24:42 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Installer changes...
In-Reply-To: <3.0.3.32.19980519005928.0077ef3c@140.114.98.21>
Message-ID: <Pine.LNX.3.95.980518132010.20171A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 19 May 1998, Francis M. J. Hsieh wrote:
> At 11:13 AM 1998/5/14 -0400, you wrote:
> >Wow.  I really messed it up badly somehow.
> >I suspect it's having a problem writing a file that's 0 bytes long.  Let
> >me repackage it, and make the file 1 byte.
> So, can anybody have time to fix it up? :-) I am new to sgi-linux and
> want to "getting start" :-).

I know this has been a couple of days that I've let this slip... I'll take
care of it (hopefully) tonight.

In the meantime, you can get by with a bit of pain on 0.01d, which is in
the old subdir.  I used that yesterday when I mistakenly reformatted by
entire Linux system.  *sigh*. That was actually the first time I'd used
the installer, which is a bit odd, seeing as how I've been maintaining it. 

There are definite strides in the right direction for never having to use
the installer again, though.  I now understand how the initrd stuff works,
and have a start in puting in prom_initrd stuff. 

The biggest thing we can do to further the project right now is to get
more people onboard with the fewest hassles possible.  Getting a decent
install program is critical to it. initrd (or prom_initrd) is the right
solution to that.

- Alex
