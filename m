Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA61939 for <linux-archive@neteng.engr.sgi.com>; Sun, 17 Jan 1999 22:57:57 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA90846
	for linux-list;
	Sun, 17 Jan 1999 22:57:19 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA60828
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 17 Jan 1999 22:57:17 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA09517
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 Jan 1999 01:57:17 -0500 (EST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA07524
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 Jan 1999 01:57:31 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 18 Jan 1999 01:57:31 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Problems getting 2.1.131 to build.
In-Reply-To: <Pine.LNX.3.96.990118011528.30635A-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.96.990118015635.30635G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Mon, 18 Jan 1999, Alex deVries wrote:
> Okay. Here's the log of my build of 2.1.131 from the CVS:
> make[3]: Entering directory `/usr/src/newlinux/linux/fs/proc'
> egcs -D__KERNEL__ -I/usr/src/newlinux/linux/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
> -mcpu=r4600 -mips2 -pipe   -c -o array.o array.c

<snip>

> array.c:1352: warning: implicit declaration of function
> `get_ds1286_status'
> make[3]: *** [array.o] Error 1

Ah, I see.  Just disabled SGI RTC support, and it builds. Binaries
tomorrow.

- Alex
