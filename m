Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA23750 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Mar 1999 15:54:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA10608
	for linux-list;
	Thu, 4 Mar 1999 15:53:28 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA07055
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 4 Mar 1999 15:53:26 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from perron-null.patser.net (9dyn72.breda.casema.net [195.96.116.72]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03656
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Mar 1999 15:53:18 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from infopact.nl (indigo2.patser.net [192.168.6.40])
	by perron-null.patser.net (8.9.0/8.9.0) with ESMTP id AAA14420;
	Fri, 5 Mar 1999 00:38:52 +0100
Message-ID: <36DF1E7A.EC9A7F76@infopact.nl>
Date: Fri, 05 Mar 1999 00:59:55 +0100
From: Richard Hartensveld <richard@infopact.nl>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5 IP22)
MIME-Version: 1.0
To: Nico Halpern <nico@ramapo.edu>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: booting linux on a Challenge S
References: <Pine.OSF.4.10.9903041455290.22579-100000@orion.ramapo.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Nico Halpern wrote:

> Scenario:
>         I managed to install the rh-5.1 tarball on a Challenge S. Since I have
> a single disk drive on the machine, I installed linux on a '/' filesystem that
> takes up most of the disk (sda1). I no longer have IRIX on the machine, and I
> would like to boot linux. I have tried the following:
> boot -f vmlinux (error message: file not found... how can I tell the prom to
> boot linux??)

You cannot, because you don't have irix anymore you have no place to store the
kernel locally. At least noton a partition that can be read from the prom.

>
>
> boot bootp():/vmlinux root=/dev/sda1 init=/bin/sh .. Machine loads kernel, and
> stops after the 'Warning: cannot open an initial console'. Theoretically I
> _could_ fix this problem by creating the correct entry with mknod. The catch
> 22 is that I cannot access the hard drive because I have no console.. any
> suggestions?
>

You can also edit /etc/securetty  in the setup-1.9.1-2.noarch.rpm from the
hardhat distribution and add
some secure tty's (ttyp1, ttyp2, etc.) so you can telnet in to your machine as
root.

> oh-- I almost forget. This machine is completely headless, if that makes a
> diference. Also, what it the status of the sound drivers? I have not seen any
> docs on this... maybe I am just looking in all the wrong places.

Euhm, sound drivers on a machine that does not have a sound processor? :)

Richard
