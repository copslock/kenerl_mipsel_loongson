Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA2187225 for <linux-archive@neteng.engr.sgi.com>; Wed, 22 Apr 1998 14:14:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA15319094
	for linux-list;
	Wed, 22 Apr 1998 14:13:25 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA15203844
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Apr 1998 14:13:23 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id OAA05265
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Apr 1998 14:13:22 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id RAA03599;
	Wed, 22 Apr 1998 17:13:06 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 22 Apr 1998 17:13:06 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Dong Liu <dliu@npiww.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: glibc problem
In-Reply-To: <199804222119.RAA20883@pluto.npiww.com>
Message-ID: <Pine.LNX.3.95.980422171156.31583B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


You can get a functional glibc RPM from the mustang directory (4.9.1 IIRC)
on ftp.linux.sgi.com.

Now, in return, can you point me to a tarball or RPM of a natively built
gcc and binutils?

- a

-- 
Alex deVries
http://www.engsoc.carleton.ca/~adevries/ .
EngSoc, US National Headquarters

On Wed, 22 Apr 1998, Dong Liu wrote:

> Date: Wed, 22 Apr 1998 17:19:13 -0400
> From: Dong Liu <dliu@npiww.com>
> To: linux@cthulhu.engr.sgi.com
> Subject: glibc problem
> 
> Hi,
> 
> I want to try some pthread program on sgi-linux, this is what I got
> 
> /usr/lib/libpthread.so: undefined reference to `__libc_accept'
> /usr/lib/libpthread.so: undefined reference to `__libc_send'
> /usr/lib/libpthread.so: undefined reference to `__libc_recvfrom'
> /usr/lib/libpthread.so: undefined reference to `__libc_recvmsg'
> /usr/lib/libpthread.so: undefined reference to `__libc_sendmsg'
> /usr/lib/libpthread.so: undefined reference to `__libc_recv'
> /usr/lib/libpthread.so: undefined reference to `__libc_sendto'
> /usr/lib/libpthread.so: undefined reference to `__libc_connect'
> 
> my glibc is glibc-2.0.6-1, so I went ftp.redhat.com downloaded
> glibc-2.0.7, but I can't build it. Where can I found sgi-linux
> specific patches for glibc.
> 
> Dong.
> 
