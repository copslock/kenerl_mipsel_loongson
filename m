Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id TAA62520 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Jan 1998 19:55:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA19705 for linux-list; Wed, 21 Jan 1998 19:54:42 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA19701 for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 19:54:40 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA20814
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 19:54:37 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id WAA29076;
	Wed, 21 Jan 1998 22:54:24 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 21 Jan 1998 22:54:24 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: Statuses...
In-Reply-To: <199801220344.VAA01227@athena.nuclecu.unam.mx>
Message-ID: <Pine.LNX.3.95.980121224733.20627D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 21 Jan 1998, Miguel de Icaza wrote:
> > > - Exactly what is required to get psaux mice working?  It compiled fine
> > > for me, but doing a "cat /dev/psaux" hung the machine heavily.
> > I guess Miguel must have fixed the problem when working on X.
> 
> strange, I never got an interrupt out of the psaux mouse.

Well, I did.  It froze my machine right up.  It booted just fine, and
everything else worked, but as soon as I knocked the mouse the entire
thing hung.  No network, no num lock, no nothing. 

Uh, is there anything I can help debug with this?

> I am still wondering how it works.

Same here.  The docs that I got (thanks, Ariel!) didn't really spell out
where the mouse actually connects to.  I think I need to re-read things.

- Alex
