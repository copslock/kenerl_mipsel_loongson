Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA17734 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Mar 1999 20:21:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA15194
	for linux-list;
	Tue, 2 Mar 1999 20:21:11 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA32191
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Mar 1999 20:21:09 -0800 (PST)
	mail_from (milos@insync.net)
Received: from insync.net (vellocet.insync.net [204.253.208.10]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA00116
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Mar 1999 20:21:08 -0800 (PST)
	mail_from (milos@insync.net)
Received: from insync.net (miloshm@209-113-28-35.insync.net [209.113.28.35]) by insync.net (8.9.3/8.7.1) with ESMTP id WAA02381; Tue, 2 Mar 1999 22:21:04 -0600 (CST)
Message-ID: <36DCB8B0.9BA28845@insync.net>
Date: Wed, 03 Mar 1999 04:21:04 +0000
From: Miles Lott <milos@insync.net>
Reply-To: milos@insync.net
Organization: KPRC
X-Mailer: Mozilla 4.5 [en] (X11; U; Linux 2.2.2-ac5 i586)
X-Accept-Language: en, ex-MX
MIME-Version: 1.0
To: chad@sgi.com
CC: linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Build a new kernel?
References: <36DC3354.42E4BAE5@dallas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I can only speak to Intel, as I have yet to get Hardhat
booted.  Generally, I start with the kernel source rather than
an rpm.  Of course, upon install of a new dist, you start with
the dist's packaged version.  But I would replace that asap,
tailoring it based upon what you need.

RedHat separates the kernel into at least two rpms, though
kernel-headers.rpm is most likely a subset of the kernel-src.rpm,
consisting of only include files used for compiling other sources.

Get the 'real' kernel source.  Unpack it in /usr/src as linux/.
cd /usr/include; rm asm linux; ln -s /usr/src/linux/include/linux;
ln -s /usr/src/linux/include/asm; cd /usr/src/linux; read ;)

Menuconfig has quite a bit of online help, plus the Documentation
tree will help you become familiar with the available options.
make xconfig is nice as well, especially for browsing and immediate
recognition of dependencies that some choices enforce.  Other than
that, the Linux Kernel HOWTO, which I guess you have read.

Note that the completed configuration ends up in .config in the
top level of the source tree after make config, make menuconfig,
or make xconfig.  I like to keep a copy of this outside the
tree so that I can maintain some consistency from kernel to
kernel, rather than start over with each new src tree.

After running make (menu/x/)config, always do make dep;make clean;
I then do make zImage;make modules;make modules_install

Enjoy!

Chad Carlin wrote:
> 
> Could someone point me to some documentation on the proceedure
> for building a new linux kernel?
> 
> I need info like; prerequisite rpms, Guidance on what options to
> choose in menuconfig,  How to implement the new kernel, Do I
> need to modify any config files.
> 
> The documentation that I have found for intel-linux has so far
> has been similar but not quite the same. I haven't really looked
> for the "how to build a kernel for MIPS" docs yet.
> 
> I tried to build one on my intel-linux box for practice. It
> didn't go well.
> 
> Chad
> 
> --
>            -----------------------------------------------------
>             Chad Carlin                          Special Systems
>             Silicon Graphics Inc.                   972.205.5911
>             Pager 888.754.1597          VMail 800.414.7994 X5344
>             chad@sgi.com             http://reality.sgi.com/chad
>            -----------------------------------------------------
>         "flying through hyper space ain't like dusting crops, boy"
