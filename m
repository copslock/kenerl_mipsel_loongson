Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA16553; Mon, 16 Jun 1997 05:00:03 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA28974 for linux-list; Mon, 16 Jun 1997 04:59:37 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA28964 for <linux@relay.engr.SGI.COM>; Mon, 16 Jun 1997 04:59:34 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA07918
	for <linux@relay.engr.SGI.COM>; Mon, 16 Jun 1997 04:50:47 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id NAA04650; Mon, 16 Jun 1997 13:42:14 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706161142.NAA04650@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id NAA19534; Mon, 16 Jun 1997 13:42:08 +0200
Subject: Re: gcc for Irix.
To: knobi@munich.sgi.com (Martin Knoblauch)
Date: Mon, 16 Jun 1997 13:42:06 +0200 (MET DST)
Cc: davem@jenolan.rutgers.edu, ariel@sgi.com, carlson@heaven.newport.sgi.com,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <33A4F325.7DE1@munich.sgi.com> from "Martin Knoblauch" at Jun 16, 97 10:02:45 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> >    And finally there's "fix_headers" - the utility that comes with gcc
> >    and fixes headers so they can be used with some gcc conventions and
> >    extensions to C.  Combine this with our multi-standard headers
> >    which I suspect the designers of "fix_headers" never thought of and
> >    you get a pretty cool mess :-)
> > 
> > Which is why in gcc-2.8.0 a completely new fix_headers.irix will
> > exist which handles it all properly...
> 
>  This is why we all eagerly wait to see an official release of 2.8 :-)

Let things settle down a bit.  I tried to install a snapshot some days
ago and had problems to bootstrap the compiler.  The thin is still
pretty buggy.

  Ralf
