Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA521474; Mon, 18 Aug 1997 20:29:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA14950 for linux-list; Mon, 18 Aug 1997 20:29:37 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA14942 for <linux@cthulhu.engr.sgi.com>; Mon, 18 Aug 1997 20:29:35 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA03853
	for <linux@relay.engr.sgi.com>; Mon, 18 Aug 1997 20:29:34 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id XAA24544; Mon, 18 Aug 1997 23:29:05 -0400
Date: Mon, 18 Aug 1997 23:29:05 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Stephen Gass <stepheng@zephyr.sydney.sgi.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Current problems.
In-Reply-To: <Pine.LNX.3.95.970818231357.23809A-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.95.970818232719.23809B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 18 Aug 1997, Alex deVries wrote:
> > Hopefully some kind soul will let me know how to either :
> > (a) Extract rpms
> That's not too tough... it's a matter of over-ruling the architecture
> checking of the rpm command line, or rewriting something that uses rpmlib.
> I will hack something together.

Doh!

It's --ignorearch .  No, that's not in the man pages, it's in the source
and "Maximum RPM".

- Alex
