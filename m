Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA20547; Mon, 16 Jun 1997 18:02:27 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA02687 for linux-list; Mon, 16 Jun 1997 18:01:49 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA02668; Mon, 16 Jun 1997 18:01:43 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA00084; Mon, 16 Jun 1997 18:01:33 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id CAA18692; Tue, 17 Jun 1997 02:57:11 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706170057.CAA18692@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id CAA22488; Tue, 17 Jun 1997 02:57:07 +0200
Subject: Re: A pointed question about endianness...
To: mikemac@titian.engr.sgi.com (Mike McDonald)
Date: Tue, 17 Jun 1997 02:57:04 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199706170033.RAA10832@titian.engr.sgi.com> from "Mike McDonald" at Jun 16, 97 05:32:56 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>   Is anyone working on the Algorithmics boards? We have 5 of them over
> here currently being used with VxWorks (which isn't officially
> supported on these boards). I could cause lots of trouble over here if
> Linux did work on them. :-)

Me, I've got a P4032 donated by Algorithmics here.  The port hasn't yet
reached a state where I'd be pround of it, but bascially it works
diskless.  Some guys from a Silicon Valley company are currently also
porting Linux to that port, supported but otherwise mostly independant
from me.  They're using similar board from Algorithmics which is based
on a R5000 derivate.

Ok, patch 2.1.43 just has been released.  **Input** ...

  Ralf
