Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id OAA20153
	for <pstadt@stud.fh-heilbronn.de>; Thu, 23 Sep 1999 14:29:30 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA01045; Thu, 23 Sep 1999 05:25:34 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA74823
	for linux-list;
	Thu, 23 Sep 1999 05:19:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from awesome.engr.sgi.com (awesome.engr.sgi.com [150.166.49.119])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA13795;
	Thu, 23 Sep 1999 05:19:54 -0700 (PDT)
	mail_from (yakker@cthulhu.engr.sgi.com)
Received: from localhost (yakker@localhost) by awesome.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id FAA42419; Thu, 23 Sep 1999 05:19:52 -0700 (PDT)
Date: Thu, 23 Sep 1999 05:19:51 -0700 (PDT)
From: Matt Robinson <yakker@cthulhu.engr.sgi.com>
To: Rory Hunter <roryh@dcs.ed.ac.uk>
cc: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: oddness
In-Reply-To: <37E9D3C8.F665545A@dcs.ed.ac.uk>
Message-ID: <Pine.SGI.3.94.990923051119.40422A-100000@awesome.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 23 Sep 1999, Rory Hunter wrote:
|>Hi,
|>
|>I know the proc is virtual, but it puzzled me that 'df' should list it
|>when linux doesn't... if I can confirm that the partition itself is
|>virtual then I'll happliy ignore it.

If you check out the manual pages for proc(4) under IRIX and proc(5)
under Linux (RedHat 6.0), you'll note that the filesystems are two
different things.  They are not the same.

/proc under IRIX reports process information.  /proc under Linux is
for displaying (and modifying) kernel tunables.

The proc(4) manual page under IRIX specifically states:

     The statfs(2) system call will return valid information concerning the
     proc filesystem.  The total and free blocks as reported by df(1)
     respectively represent the total virtual memory (real memory plus swap
     space) available and currently free.

Since the two filesystems perform different functions, 'df' should not
be expected to perform the same function.

Hope this helps.

--Matt

|>Cheers,
|>
|>Rory Hunter
