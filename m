Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA2759152 for <linux-archive@neteng.engr.sgi.com>; Sun, 5 Apr 1998 03:47:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id DAA8019743
	for linux-list;
	Sun, 5 Apr 1998 03:46:32 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA7865065
	for <linux@engr.sgi.com>;
	Sun, 5 Apr 1998 03:46:30 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id DAA23528
	for <linux@engr.sgi.com>; Sun, 5 Apr 1998 03:46:28 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-10.uni-koblenz.de [141.26.249.10])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA08147
	for <linux@engr.sgi.com>; Sun, 5 Apr 1998 12:46:27 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id MAA03930;
	Sun, 5 Apr 1998 12:13:14 +0200
Message-ID: <19980405121314.01317@uni-koblenz.de>
Date: Sun, 5 Apr 1998 12:13:14 +0200
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Lazy fp switches
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I'm going to commit some more patches in some seconds which will fix a bad
bug in fp context switching and add lazy switching of the fp context.
Finally there is a nice speedup for the signal overhead down to a bit less
than 8us.

Lazy switching needs some more polishing, we could handle fp for signals
more intelligent and we also to port the changes to the R3000.  While I was
in the hope that the changes make a visible impact on the context switching
times this unfortunately isn't measurable.  Whatever, theory says it's
faster, so it stays in.

  Ralf
