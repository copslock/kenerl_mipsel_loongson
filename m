Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id RAA235723; Thu, 31 Jul 1997 17:52:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA17586 for linux-list; Thu, 31 Jul 1997 17:51:10 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA17543 for <linux@engr.sgi.com>; Thu, 31 Jul 1997 17:50:59 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA24321
	for <linux@engr.sgi.com>; Thu, 31 Jul 1997 17:41:49 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id CAA18701 for <linux@engr.sgi.com>; Fri, 1 Aug 1997 02:41:42 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708010041.CAA18701@informatik.uni-koblenz.de>
Received: by zaphod (SMI-8.6/KO-2.0)
	id CAA04787; Fri, 1 Aug 1997 02:41:36 +0200
Subject: Re: CVS Update@linus.linux.sgi.com: linux
To: linux@cthulhu.engr.sgi.com
Date: Fri, 1 Aug 1997 02:41:36 +0200 (MET DST)
In-Reply-To: <199707312306.QAA13177@linus.linux.sgi.com> from "Miguel de Icaza" at Jul 31, 97 04:06:36 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 	- Fix the mouse driver, did someone ever got any
> 	information out from /dev/psaux on the SGI port?

Using the ps/2 ouse driver as a module is also broken; the attempt will
result in an Ooops.  Well, it would.  The oops code is broken also.

  Ralf
