Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA05510 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 22:34:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA03767
	for linux-list;
	Thu, 16 Jul 1998 22:34:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA67008;
	Thu, 16 Jul 1998 22:34:19 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA06297; Thu, 16 Jul 1998 22:34:17 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA12926;
	Fri, 17 Jul 1998 01:32:29 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 17 Jul 1998 01:32:29 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw>,
        Ariel Faigon <ariel@cthulhu.engr.sgi.com>
cc: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: apache and other problems (fwd)
In-Reply-To: <199807161853.LAA91562@oz.engr.sgi.com>
Message-ID: <Pine.LNX.3.95.980717012901.5792D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 16 Jul 1998, Ariel Faigon wrote:
> ----- Forwarded message from owner-linux@cthulhu -----
> From: "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw>
> 
> This two files were uploaded in ftp://helix.life.nthu.edu.tw/pub/
> (yes, it is a Linux/SGI machine) for people in Taiwan save their
> download time.

Cool.

> I got some problem here.
> - apache httpd is still buggy (can't deliver text/html correctly)

I don't know what that problem is; mine works fine.  Does it accept a TCP
connection properly? 

> - ifconfig is still buggy, TX packets is 0 (see followed)

Yeah, I think we went over that before although I don't remember what the
solution was.

> - mouse doesn't work?

In the HH install, there's a package called 'kernel-2.1.100-2'.  If you
install this, you'll have something like /boot/vmlinux-2.1.100.  That
kernel (2.1.100) should have mouse support in it.  you'll have to make a
symbolic link from /dev/psaux to /dev/mouse.

For reasons I don't want to get into, the kernel in the install really
sucks, and you should throw it away ASAP and use the packaged one.

- Alex
