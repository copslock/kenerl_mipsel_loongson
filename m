Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA448755 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Jan 1998 13:40:38 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA12036 for linux-list; Tue, 6 Jan 1998 13:39:37 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA12018 for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 13:39:35 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA29714
	for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 13:39:32 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA23157
	for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 22:39:29 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA05095;
	Tue, 6 Jan 1998 22:36:08 +0100
Message-ID: <19980106223608.05738@uni-koblenz.de>
Date: Tue, 6 Jan 1998 22:36:08 +0100
To: Conrad Parker <conradp@cse.unsw.edu.au>
Cc: linux@cthulhu.engr.sgi.com,
        "Andrew John O'Brien" <andrewo@cse.unsw.edu.au>
Subject: Re: i386 crosscompile problems
References: <Pine.GSO.3.95.980106234535.24128T-100000@bell07.orchestra.cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.GSO.3.95.980106234535.24128T-100000@bell07.orchestra.cse.unsw.EDU.AU>; from Conrad Parker on Wed, Jan 07, 1998 at 12:10:33AM +1100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 07, 1998 at 12:10:33AM +1100, Conrad Parker wrote:

> we're attempting to cross-compile a bootstrap kernel for an r4600 indy
> with no L2 cache, from an i386-linux box. We have had most success so far
> with kernel snapshot 971208 from ftp.linux.sgi.com, patched to work with
> no L2 cache. We have built binutils-2.8.1.0.15 patched with the
> binutils-2.8.1-1 patch, and using the gcc cross compiler 2.7.2-3 binary
> release (rpm).
> 
> When compiling the kernel, we get lots of mips-linux-ld warnings along the
> lines of:
> 
> mips-linux-ld: Warning: type of symbol 'prom_imode' changed from 1 to 2 in
> misc.o

Post 2.8.1 binutils do harder typechecking.  Those messages should actually
be harmless warnings.  Could you mail them to me so that I can fix them,
please?

> for lots of symbols in lots of object files...
> Everything seems to compile fine, without excessive other warnings from
> gcc and the native mips code passes through without a hitch.
> 
> When the resulting kernel is used from bootp, we get the following dump
> immediately:

> ouch. We expect the problem is with our configuration of binutils and/or
> gcc. Can anyone help?

 - apply the patch to the FSF version of binutils 2.8.1 (available from
   ftp.linux.sgi.com or prep.ai.mit.edu).
 - if the problem persists try removing the -N linker flag from -N

  Ralf
