Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA11217; Mon, 16 Jun 1997 14:23:27 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA27607 for linux-list; Mon, 16 Jun 1997 14:23:06 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA27597; Mon, 16 Jun 1997 14:23:04 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA08606; Mon, 16 Jun 1997 14:22:55 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id XAA08006; Mon, 16 Jun 1997 23:18:50 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706162118.XAA08006@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id XAA22061; Mon, 16 Jun 1997 23:18:43 +0200
Subject: Re: A pointed question about endianness...
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Mon, 16 Jun 1997 23:18:40 +0200 (MET DST)
Cc: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com, ralf@Julia.DE,
        shaver@engsoc.carleton.ca
In-Reply-To: <199706161754.KAA14400@fir.engr.sgi.com> from "William J. Earl" at Jun 16, 97 10:54:16 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>      You probably can't agree on one, unless you can agree on one set
> of systems.  Most MIPS architecture systems, including all SGI
> systems, are big-endian, but all DEC systems and all MIPS Magnum 4000
> systems configured to run NT are little-endian.  (All other MIPS
> systems are big-endian.)

It's worse than that.  SNI RM series is configurable, Algorithmics eval
boards are configurable.  Acer PICA (derived from the Magnum) is le
only, Sony machines are fixed to be, Deskstation MIPS machines are fixed
to le ...

  Ralf
