Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id CAA69462 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Dec 1997 02:53:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA14378 for linux-list; Wed, 3 Dec 1997 02:48:41 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA14373 for <linux@engr.sgi.com>; Wed, 3 Dec 1997 02:48:39 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id CAA20789
	for <linux@engr.sgi.com>; Wed, 3 Dec 1997 02:48:38 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-10.uni-koblenz.de [141.26.249.10])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id LAA12493
	for <linux@engr.sgi.com>; Wed, 3 Dec 1997 11:48:36 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id KAA22356;
	Wed, 3 Dec 1997 10:49:23 +0100
Message-ID: <19971203104923.65197@uni-koblenz.de>
Date: Wed, 3 Dec 1997 10:49:23 +0100
To: linux@cthulhu.engr.sgi.com
Subject: wd33c93
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

question: has SGI every shipped machines based on the prototype version
of the wd33c93 (recogniceable by the version "00-04" and the word "proto"
on the chip)?  This particular chip version is pretty buggy; especially
disconnect/reconnect is broken; it has shipped in large quantities on
non-SGI systems, for example various Amiga hostadapters.  If SGI every
shipped system based on that chip then I'd think it'd be a good idea to
disable disconnect/reconnect by default.

  Ralf
