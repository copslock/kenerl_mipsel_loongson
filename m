Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA96594 for <linux-archive@neteng.engr.sgi.com>; Wed, 30 Sep 1998 14:31:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA26022
	for linux-list;
	Wed, 30 Sep 1998 14:29:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA38277
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 30 Sep 1998 14:29:49 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07164
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Sep 1998 14:29:44 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-16.uni-koblenz.de [141.26.249.16])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA06542
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Sep 1998 23:29:37 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA01110;
	Wed, 30 Sep 1998 23:29:40 +0200
Message-ID: <19980930232939.E770@uni-koblenz.de>
Date: Wed, 30 Sep 1998 23:29:39 +0200
From: ralf@uni-koblenz.de
To: Richard Hartensveld <richardh@infopact.nl>,
        "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: crosscompiling on debian/i386
References: <36116D45.E34A6FEF@infopact.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <36116D45.E34A6FEF@infopact.nl>; from Richard Hartensveld on Wed, Sep 30, 1998 at 01:29:09AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Sep 30, 1998 at 01:29:09AM +0200, Richard Hartensveld wrote:

> i'm trying to crosscompile a linux/sgi kernel on a debian/i386 machine
> with the binutils and the mips-linux-gcc compiler from the linux-sgi ftp
> site.
> 
> But i keep getting the following  error, does anyone know what i am
> doing wrong.?

The error messages look like you've been attempting to compile a vanilla
kernel from ftp.kernel.org.  Won't work, get a tree from ftp.linux.sgi.com.
You're also passing variables to make which normally isn't necessary.  Did
you've select CONFIG_CROSSCOMPILE when configuring the kernel?  The sources
will then automatically select the right compiler.

   Ralf
