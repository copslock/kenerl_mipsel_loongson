Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA20735; Mon, 16 Jun 1997 07:42:30 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA17881 for linux-list; Mon, 16 Jun 1997 07:41:13 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA17855 for <linux@engr.sgi.com>; Mon, 16 Jun 1997 07:41:09 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA03421
	for <linux@engr.sgi.com>; Mon, 16 Jun 1997 07:39:32 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id QAA03690; Mon, 16 Jun 1997 16:28:22 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706161428.QAA03690@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id QAA20906; Mon, 16 Jun 1997 16:28:18 +0200
Subject: GCC 2.7.2-4
Date: Mon, 16 Jun 1997 16:28:16 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Apparently-To: <linux@cthulhu.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

GCC 2.7.2 does not build and install the files crtbegin{S}.o / crtend{S}.o
that GNU libc 2.0.4 needs.  I'll post a new GCC patch rsn.

  Ralf
