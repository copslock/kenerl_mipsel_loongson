Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA02032; Fri, 30 May 1997 04:20:21 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA09564 for linux-list; Fri, 30 May 1997 04:20:00 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA09558 for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 04:19:58 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA28615
	for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 04:19:45 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id NAA17015; Fri, 30 May 1997 13:13:55 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199705301113.NAA17015@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id NAA13730; Fri, 30 May 1997 13:13:53 +0200
Subject: Re: compiling kernels
To: irish@akira.tampa.sgi.com (Liam Irish)
Date: Fri, 30 May 1997 13:13:52 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <9705291410.ZM6206@akira.tampa.sgi.com> from "Liam Irish" at May 29, 97 02:10:42 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> Where are the other importing things, such as includes for gcc, that are needed
> to compile a linux kernel for mips besides gcc and binutils, which I retrieved
> from kernel.panic.

You also need the GNU libc which is also on kernel.panic.  You should
get the libc binaries even if you want to recompile everything.
Bootstrapping just from sources is nice torture due to cyclic dependencies
and other traps.

Btw, someone at SGI is mirroring kernel.panic daily.  So you don't need to
wait for our slow pipe.

  Ralf
