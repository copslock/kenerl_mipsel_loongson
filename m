Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA58786 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Jul 1998 16:33:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA80589
	for linux-list;
	Wed, 15 Jul 1998 16:33:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA39801
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Jul 1998 16:33:30 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA06839
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 16:33:28 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA13546;
	Wed, 15 Jul 1998 19:33:24 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 15 Jul 1998 19:33:24 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Dong Liu <dliu@npiww.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: libpthread of hard hat still doesn't work
In-Reply-To: <199807152348.TAA00114@pluto.npiww.com>
Message-ID: <Pine.LNX.3.95.980715193313.22020K-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


What were you doing to produce this error?

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .



On Wed, 15 Jul 1998, Dong Liu wrote:

> Date: Wed, 15 Jul 1998 19:48:43 -0400
> From: Dong Liu <dliu@npiww.com>
> To: linux@cthulhu.engr.sgi.com
> Subject: libpthread of hard hat still doesn't work
> 
> 
> This is what I got
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
> 
> Thanks!
> 
> Dong.
> 
