Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA50799 for <linux-archive@neteng.engr.sgi.com>; Mon, 3 May 1999 20:56:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA56113
	for linux-list;
	Mon, 3 May 1999 20:54:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA50605;
	Mon, 3 May 1999 20:54:28 -0700 (PDT)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id UAA16791; Mon, 3 May 1999 20:54:28 -0700 (PDT)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199905040354.UAA16791@anchor.engr.sgi.com>
Subject: Re: building an elf64 R10k kernel
In-Reply-To: <372E6AA0.505A6071@foo.tho.org> from Charles Lepple at "May 4, 99 03:33:52 am"
To: clepple@foo.tho.org (Charles Lepple)
Date: Mon, 3 May 1999 20:54:28 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Charles Lepple wrote: 
|  Hey all,
|  Does anyone out there know any details on building elf64 objects? I was
|  all happy about seeing Andrew's Indigo2 patches, and decided that I
|  _had_ to try and make it work on an Indigo2 Impact 10000... Suffice it
|  to say that it isn't straightforward.

For r10k Indigo2 to work, you will need to hack the compiler,
for various reasons (the way the r10k works, plus the fact that
indigo2 doesn't have i/o cache coherency, interact in some "interesting"
ways.  I would suggest not attempting this port, unless you have a *lot*
of spare time.

Dave Olson, Silicon Graphics
http://reality.sgi.com/olson   olson@sgi.com
