Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA97074 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Apr 1999 21:39:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA27810
	for linux-list;
	Wed, 14 Apr 1999 21:38:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi.waldorf-gmbh.de ([150.166.40.201])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA26667;
	Wed, 14 Apr 1999 21:38:10 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id VAA01592;
	Wed, 14 Apr 1999 21:37:58 -0700
Message-ID: <19990414213758.D1174@uni-koblenz.de>
Date: Wed, 14 Apr 1999 21:37:58 -0700
From: Ralf Baechle <ralfb@cthulhu.engr.sgi.com>
To: Charles Lepple <clepple@foo.tho.org>, linux@cthulhu.engr.sgi.com
Subject: Re: kernel compilation problem
References: <371568F3.FA1E916A@foo.tho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <371568F3.FA1E916A@foo.tho.org>; from Charles Lepple on Thu, Apr 15, 1999 at 04:20:04AM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 15, 1999 at 04:20:04AM +0000, Charles Lepple wrote:

> Then, while executing 'make dep', I see a bunch of messages about
> 'SOCK_DGRAM' being redefined.
> 
> And when I try 'make zImage', it bombs compiling init/main.c -- there's
> a "parse error" in linux/sched.h, and lots of stuff breaks. I have the
> compile log if anyone can decipher it, but is this just a simple case of
> me overlooking a patch? Or where can I find a preconfigured kernel
> source tree?

Get the kernel from {ftp,www}.linux.sgi.com.

  Ralf
