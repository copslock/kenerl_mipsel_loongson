Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id BAA17811 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 01:23:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA04340
	for linux-list;
	Fri, 17 Jul 1998 01:23:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA03708
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 01:23:08 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: from helix.life.nthu.edu.tw (helix.life.nthu.edu.tw [140.114.98.34]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA12184
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Jul 1998 01:23:04 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: (from mjhsieh@localhost)
	by helix.life.nthu.edu.tw (8.8.7/8.8.7) id QAA00558;
	Fri, 17 Jul 1998 16:23:01 +0800
Message-ID: <19980717162300.A535@life.nthu.edu.tw>
Date: Fri, 17 Jul 1998 16:23:00 +0800
From: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>
To: Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: apache and other problems (fwd)
References: <199807161853.LAA91562@oz.engr.sgi.com> <Pine.LNX.3.95.980717012901.5792D-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.95.980717012901.5792D-100000@lager.engsoc.carleton.ca>; from Alex deVries on Fri, Jul 17, 1998 at 01:32:29AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jul 17, 1998 at 01:32:29AM -0400, Alex deVries wrote:
> On Thu, 16 Jul 1998, "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw> wrote:
> > I got some problem here.
> > - apache httpd is still buggy (can't deliver text/html correctly)
> 
> I don't know what that problem is; mine works fine.  Does it accept a TCP
> connection properly? 

oh, it fixed in vmlinux-2.1.100

> > - mouse doesn't work?
> In the HH install, there's a package called 'kernel-2.1.100-2'.  If you
> install this, you'll have something like /boot/vmlinux-2.1.100.  That
> kernel (2.1.100) should have mouse support in it.  you'll have to make a
> symbolic link from /dev/psaux to /dev/mouse.

well, how can I get gpm work? I had ln -s it, and it didn't work.
