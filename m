Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA66712 for <linux-archive@neteng.engr.sgi.com>; Sat, 27 Feb 1999 06:13:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA51086
	for linux-list;
	Sat, 27 Feb 1999 06:12:38 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA89992
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 27 Feb 1999 06:12:37 -0800 (PST)
	mail_from (milos@insync.net)
Received: from insync.net (vellocet.insync.net [204.253.208.10]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA03155
	for <linux@cthulhu.engr.sgi.com>; Sat, 27 Feb 1999 06:12:26 -0800 (PST)
	mail_from (milos@insync.net)
Received: from localhost (milos@localhost) by insync.net (8.9.3/8.7.1) with ESMTP id HAA23750; Sat, 27 Feb 1999 07:52:08 -0600 (CST)
Date: Sat, 27 Feb 1999 07:52:08 -0600 (CST)
From: Miles Lott <milos@insync.net>
To: Robin Humble <rjh@pixel.maths.monash.edu.au>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: new to list - boot problem
In-Reply-To: <199902271129.WAA18917@pixel.maths.monash.edu.au>
Message-ID: <Pine.SOL.4.10.9902270751040.23512-100000@vellocet.insync.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

OK, after fixing the devs, I no longer get the error message.
However, after loading init and ld.so.2.0.6 from the server, the Indy
hangs.

something simple must be missing... ;)

On Sat, 27 Feb 1999, Robin Humble wrote:

> 
> >the "unable to open initial console" message( read: hang ).
> 
> There are a few things that this can be, but the most obvious is to
> check that the dev/ directory in the HardHat distribution looks like:
> 
> crw-------   1 root     root       4,   0 Sep 14 19:39 console
> crw-rw-rw-   1 root     root       1,   3 Sep 14 19:43 null
> brw-r-----   1 root     disk       1,   1 Sep 14 19:43 ram
> crw-------   1 root     root       4,   0 Sep 14 19:44 systty
> crw-------   1 root     root       4,   1 Sep 14 19:44 tty1
> crw-------   1 root     root       4,   2 Sep 14 19:44 tty2
> crw-------   1 root     root       4,   3 Sep 14 19:44 tty3
> crw-------   1 root     root       4,   4 Sep 14 19:44 tty4
> crw-------   1 root     root       4,   5 Sep 14 19:44 tty5
> 
> If not, then nuke the devices and remake them with mknod, chown, chmod.
> Some tar programs (IRIX's in particular) screws these up. You can
> re-make these devices under Linux/x86 or IRIX - both work fine. If
> re-making from under IRIX then 'disk' gid = 6, and 'root' gid = 0 = sys
> under IRIX.
> 
> Other possibilities are that you're running on hardware not well
> supported by HardHat (new kernels are available) or the nfsroot
> procedure isn't working well enough. I'm sure other people will have
> other failure modes to tell you as well :)
> 
> cheers,
> robin
> +
> He'd found that even the people whose job of work was, so to speak, the
> Universe, didn't really believe in it and were actually quite proud of not
> knowing what it really was or even if it could theoretically exist.
>      Robin Humble     /      http://www.maths.monash.edu.au/~rjh/
> 
