Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id DAA03712
	for <pstadt@stud.fh-heilbronn.de>; Fri, 16 Jul 1999 03:12:04 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA5899871; Thu, 15 Jul 1999 18:10:30 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA67326
	for linux-list;
	Thu, 15 Jul 1999 18:05:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA42220
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Jul 1999 18:05:52 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA02685
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jul 1999 18:05:51 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-30.uni-koblenz.de [141.26.131.30])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id DAA21556
	for <linux@cthulhu.engr.sgi.com>; Fri, 16 Jul 1999 03:05:48 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id CAA04119;
	Fri, 16 Jul 1999 02:57:32 +0200
Date: Fri, 16 Jul 1999 02:57:32 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Tim Hockin <thockin@cobaltnet.com>
Cc: linux@cthulhu.engr.sgi.com, cjohnson@cobaltnet.com
Subject: Re: Float / Double issues - solved, perhaps
Message-ID: <19990716025732.B4105@uni-koblenz.de>
References: <378AADF5.96152E0B@cobaltnet.com> <19990714235346.A1231@uni-koblenz.de> <378D36E5.CBF85556@cobaltnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <378D36E5.CBF85556@cobaltnet.com>; from Tim Hockin on Wed, Jul 14, 1999 at 06:18:29PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jul 14, 1999 at 06:18:29PM -0700, Tim Hockin wrote:

> We have the fix, I think.  Not clone.S, but in
> glibc-2.0.7/linuxthreads/internals.h line 86 we need to tell gcc that this
> struct (_pthread_descr_struct - which defines the offset of a thread's stack
> from a well-aligned, malloc() returned addr) be padded to be aligned
> correctly on an 8byte boundary:
> 
> -};
> +} __attribute__ ((aligned(__alignof__(double))));
> 
> It's working for us now.  Please confirm if it works for you folks, too.  A
> bug report has been filed for glibc, though I doubt if anything official
> goes on for 2.0.x, now. Hopefully 2.1.x will fold this in.  A thread's stack
> really should always be well aligned :)  Funny, the doubles were actually
> calculated right,

It's dangerous though.  If the code would have attempted to use a MIPS II
ldc1 / sdc1 instruction to access the floating point number, the code
would have been killed by arch/mips/kernel/unaligned.c.

> but stdio functions use va_arg - which expected double's
> to be aligned, and weren't.  The work got done, but it couldn't tell us!

The MIPS ABI wants a 8 byte alignment for the stack and even 16 byte for
ABI64.  Now we know what can happen if not :-)

Thanks for your fix,

  Ralf
