Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id GAA534262 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Nov 1997 06:00:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA09169 for linux-list; Fri, 28 Nov 1997 06:00:15 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA09046 for <linux@engr.sgi.com>; Fri, 28 Nov 1997 06:00:03 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA21677
	for <linux@engr.sgi.com>; Fri, 28 Nov 1997 05:59:50 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id OAA12344;
	Fri, 28 Nov 1997 14:59:23 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id OAA12961; Fri, 28 Nov 1997 14:59:14 +0100
Message-ID: <19971128145912.03440@thoma.uni-koblenz.de>
Date: Fri, 28 Nov 1997 14:59:12 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: libg++
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

libg++ is completly broken.  Programs linked with it will die even before
the main function is reached.  This probably means that the problem is
somewhere in the construcors run at initialization time.  Can somebody
look into that?

  Ralf
