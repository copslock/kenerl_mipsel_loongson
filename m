Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA151414; Sat, 9 Aug 1997 19:07:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA00983 for linux-list; Sat, 9 Aug 1997 19:07:32 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA00978 for <linux@engr.sgi.com>; Sat, 9 Aug 1997 19:07:29 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA24189
	for <linux@engr.sgi.com>; Sat, 9 Aug 1997 19:07:22 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id EAA12374 for <linux@engr.sgi.com>; Sun, 10 Aug 1997 04:06:58 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708100206.EAA12374@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id EAA17293; Sun, 10 Aug 1997 04:06:55 +0200
Subject: Bottom half bug
To: linux@cthulhu.engr.sgi.com
Date: Sun, 10 Aug 1997 04:06:54 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

seems Miguel's recently reported problem as well as the feature that
<CTRL>-S locks the machine sometimes for some seconds, sometimes
finally seem to be hidden somewhere in the bottom half handlers.

  Ralf
