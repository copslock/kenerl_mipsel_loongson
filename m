Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA09255; Mon, 2 Jun 1997 00:17:49 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA02866 for linux-list; Mon, 2 Jun 1997 00:17:29 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA02854 for <linux@engr.sgi.com>; Mon, 2 Jun 1997 00:17:22 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id AAA10372
	for <linux@engr.sgi.com>; Mon, 2 Jun 1997 00:16:28 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id JAA07078 for <linux@engr.sgi.com>; Mon, 2 Jun 1997 09:12:24 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706020712.JAA07078@informatik.uni-koblenz.de>
Received: by zaphod (SMI-8.6/KO-2.0)
	id JAA07340; Mon, 2 Jun 1997 09:12:22 +0200
Subject: More FP stuff ...
To: linux@cthulhu.engr.sgi.com
Date: Mon, 2 Jun 1997 09:12:22 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I was finally fed up with the side effects of not having the proper FP
support in the kernel and started to write all the stuff.  Someone else
who has a MIPS IV machine should add the MIPS IV bits.  Software FP,
C64 strikes back ;-)

Can anybody recommend a floating point test suite or applications that
are suitable for verfication of the stuff?

  Ralf
