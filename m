Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA3458271 for <linux-archive@neteng.engr.sgi.com>; Thu, 30 Apr 1998 18:07:33 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA18813841
	for linux-list;
	Thu, 30 Apr 1998 18:05:48 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA18851894;
	Thu, 30 Apr 1998 18:05:45 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id SAA27114; Thu, 30 Apr 1998 18:05:43 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA13443;
	Fri, 1 May 1998 03:05:40 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id DAA01729;
	Fri, 1 May 1998 03:05:16 +0200
Message-ID: <19980501030516.19734@uni-koblenz.de>
Date: Fri, 1 May 1998 03:05:16 +0200
To: Steve Alexander <sca@refugee.engr.sgi.com>
Cc: Alex deVries <adevries@engsoc.carleton.ca>, jrs@world.std.com,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: MIPS/Linux port for strace
References: <199805010037.RAA02450@refugee.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199805010037.RAA02450@refugee.engr.sgi.com>; from Steve Alexander on Thu, Apr 30, 1998 at 05:37:19PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 30, 1998 at 05:37:19PM -0700, Steve Alexander wrote:

> Alex deVries <adevries@engsoc.carleton.ca> writes:
> >Dave Miller, Miguel de Icaza and Ralf Baechle fixed strace for MIPS/Linux
> >and Irix 6.2. I have access to the source tree, and I think it'd be
> >helpful to merge it into the main strace source tree.  Are you interested?
> 
> I don't know whether Rick's interested, but I use strace constantly on IRIX,
> so it would be epic if it were maintained somewhere (but I have no time,
> alas...).

As far as IRIX goes the will probably be some maintenance from the Linux
side since the IRIX and RISC/os syscalls are a subset of the Linux syscall
interface.  This does not necessarily mean that strace will build under
Linux ...

  Ralf
