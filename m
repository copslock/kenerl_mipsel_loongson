Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id EAA1093937 for <linux-archive@neteng.engr.sgi.com>; Sat, 13 Dec 1997 04:34:35 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA09958 for linux-list; Sat, 13 Dec 1997 04:34:07 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA09941 for <linux@engr.sgi.com>; Sat, 13 Dec 1997 04:34:00 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA22899
	for <linux@engr.sgi.com>; Sat, 13 Dec 1997 04:33:58 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-08.uni-koblenz.de [141.26.249.8])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id NAA02269
	for <linux@engr.sgi.com>; Sat, 13 Dec 1997 13:33:27 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id NAA07234;
	Sat, 13 Dec 1997 13:30:06 +0100
Message-ID: <19971213133006.53892@uni-koblenz.de>
Date: Sat, 13 Dec 1997 13:30:06 +0100
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: Re: crtbegin.o
References: <19971212011157.53174@uni-koblenz.de> <Pine.LNX.3.95.971212213052.17729A-100000@ravage.labs.gmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.971212213052.17729A-100000@ravage.labs.gmu.edu>; from Ryan on Fri, Dec 12, 1997 at 09:35:21PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

While fixing this it turned out that the rpm also didn't contain all
incarnations of libgcc.a - unlike the other Linux targets Linux/MIPS
makes use of GCC's multilib feature and builds multiple libgcc.a.
I've fixed this for the next release, too.

  Ralf
