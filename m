Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id RAA1355826 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 17:34:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA12884 for linux-list; Fri, 5 Sep 1997 17:33:32 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA12856 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 17:33:28 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id RAA20529; Fri, 5 Sep 1997 17:33:20 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA12810; Fri, 5 Sep 1997 17:33:19 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA06743; Fri, 5 Sep 1997 17:33:16 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id CAA11262; Sat, 6 Sep 1997 02:33:08 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199709060033.CAA11262@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id CAA07341; Sat, 6 Sep 1997 02:33:06 +0200
Subject: Re: [Q: Linux/SGI] IRIX executable memory map.
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Sat, 6 Sep 1997 02:33:05 +0200 (MET DST)
Cc: miguel@nuclecu.unam.mx, linux@fir.engr.sgi.com
In-Reply-To: <199709052251.PAA20078@fir.engr.sgi.com> from "William J. Earl" at Sep 5, 97 03:51:00 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

>      The library is fetching the PID from t_pid instead of calling getpid()
> for performance reasons.

Byte Benchmarks ;-)

  Ralf
