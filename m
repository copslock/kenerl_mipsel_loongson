Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA60278 for <linux-archive@neteng.engr.sgi.com>; Wed, 23 Dec 1998 23:57:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA55261
	for linux-list;
	Wed, 23 Dec 1998 23:56:44 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA73532
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 23 Dec 1998 23:56:43 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA03751
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Dec 1998 23:56:41 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-12.uni-koblenz.de [141.26.249.12])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id IAA27727
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Dec 1998 08:56:36 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id FAA07035;
	Wed, 23 Dec 1998 05:50:57 +0100
Message-ID: <19981223055057.G6183@uni-koblenz.de>
Date: Wed, 23 Dec 1998 05:50:57 +0100
From: ralf@uni-koblenz.de
To: Richard Hartensveld <richard@infopact.nl>,
        "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: crosscompiling for r5k.
References: <367FBD86.BEC2F68F@infopact.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <367FBD86.BEC2F68F@infopact.nl>; from Richard Hartensveld on Tue, Dec 22, 1998 at 07:40:54AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Dec 22, 1998 at 07:40:54AM -0800, Richard Hartensveld wrote:

> I'm having problems crosscompiling a kernel for my challenge s (180mhz
> R5000).

> Is it normal that when you configure for a r5k, gcc uses the
> '-mcpu=r8000' option?.

Doesn't matter.  GCC 2.7.2 only knew about TFP but not R5k.  I choose to
pass -mcpu=r8000 because for the one optimization where it matters the R8000
was the best match for the R5000.  Things would be different if we'd use
floating point, but we don't.

> When i compile, i get a kernel, only it won't boot.

> Some of you have come up with a fix the last time, only i haven't got it
> anymore, anyone that
> could help ?

Did you get trapped by the -N option bug in ld?  Just dump that option from
CFLAGS in arch/mips/Makefile.

  Ralf
