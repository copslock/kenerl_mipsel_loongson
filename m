Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA22847 for <linux-archive@neteng.engr.sgi.com>; Fri, 16 Apr 1999 13:51:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA85038
	for linux-list;
	Fri, 16 Apr 1999 13:50:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi.waldorf-gmbh.de ([150.166.40.201])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA51683;
	Fri, 16 Apr 1999 13:50:13 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id NAA02788;
	Fri, 16 Apr 1999 13:50:00 -0700
Message-ID: <19990416135000.D592@uni-koblenz.de>
Date: Fri, 16 Apr 1999 13:50:00 -0700
From: Ralf Baechle <ralfb@cthulhu.engr.sgi.com>
To: Charles Lepple <clepple@foo.tho.org>, linux@cthulhu.engr.sgi.com
Subject: Re: Boot problems with locally compiled kernel
References: <Pine.LNX.4.04.9904161555520.13259-100000@foo.tho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.4.04.9904161555520.13259-100000@foo.tho.org>; from Charles Lepple on Fri, Apr 16, 1999 at 04:00:53PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Apr 16, 1999 at 04:00:53PM -0400, Charles Lepple wrote:

> Now that I can finally get the kernel compile to finish, I end up with a
> message similar to the folowing after the kernel is loaded (it's still in
> the textport):
> 
> Exception: <vector=UTLB Miss>
> Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
> ...
> 
> This is an R5k machine, and I've tried both the r4x00 and r5000 options,
> in addition to converting the kernel to ECOFF (with the program in
> arch/mips/boot). This is a CVS tree from yesterday or so -- any thoughts
> on this one? (I checked the old archives -- sorry if this is a FAQ and I
> just missed it).

Remove the -N linker option from arch/mips/Makefile and run make again.

  Ralf
