Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA17805 for <linux-archive@neteng.engr.sgi.com>; Wed, 26 May 1999 13:20:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA86459
	for linux-list;
	Wed, 26 May 1999 13:19:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA74770
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 26 May 1999 13:19:36 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.de [195.78.161.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA06166
	for <linux@cthulhu.engr.sgi.com>; Wed, 26 May 1999 13:19:34 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port39.koeln.ivm.de [195.247.239.39])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id WAA11477;
	Wed, 26 May 1999 22:19:20 +0200
X-To: linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.990526222220.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <4.1.19990526115716.03f65930@mail>
Date: Wed, 26 May 1999 22:22:20 +0200 (MEST)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To: Robert Keller <rck@corp.home.net>
Subject: RE: after the kernel seems to live
Cc: linux@cthulhu.engr.sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Robert,

On 26-May-99 Robert Keller wrote:
> 
> It looks like I've finally been able to get the 2.2.1 kernel booting
> and trying to access its root filesystem over NFS on an NEC
> DDB-VRC5074 development board.  I'm at the point where the
> kernel is trying to run /sbin/init and things die because of illegal
> instructions in init (I'm using the little endian mips root from
> linux.sgi.com)
> 
> Where do I get the code for init, ld.so and all those vital root 
> filesystem friends so that I can be sure that they are compiled
> the way I want them?

this is probably not the right place to ask this question,
linux-mips@fnet.fr would have been better, but I'll try to answer your
question anyway :-)

You may want to give
ftp://ftp.linux.sgi.com/pub/linux/mips/mipsel-linux/root/declinuxroot-99051
8.tgz
a try.

This rootimage is known to work on R3000 and R4000 DECstations and should
in theory work on all little endian MIPS boxen.
---
Regards,
Harald
