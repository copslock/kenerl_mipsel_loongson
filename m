Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA118086; Fri, 8 Aug 1997 18:24:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA01433 for linux-list; Fri, 8 Aug 1997 18:24:21 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA01324; Fri, 8 Aug 1997 18:23:58 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA05100; Fri, 8 Aug 1997 18:23:52 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id DAA28961; Sat, 9 Aug 1997 03:23:39 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708090123.DAA28961@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id DAA16102; Sat, 9 Aug 1997 03:23:36 +0200
Subject: Re: Linux GGI and Linux/SGI
To: jwiede@blammo.engr.sgi.com (John Wiederhirn)
Date: Sat, 9 Aug 1997 03:23:35 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <9708081540.ZM26801@blammo.engr.sgi.com> from "John Wiederhirn" at Aug 8, 97 03:40:30 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > Well, we have discussed using GGI.  Last I checkend GGI was still itself
> > in a state of flux and the last thing I want to do is to open another
> > battle field.  Technical reasons against GGI was mostly that the original
> > design was very bloated as far as the kernel is affected.  This has
> > been improoved somwhat since.
> 
> I'm not so attached to the notion of GGI as much as for gfx
> having an in-kernel-space presence in Linux (Linux/SGI is
> going to need this, as I suspect is any Linux that attempts
> hardware acceleration of OpenGL or other similar APIs).

Miguel "Da Newport Man" de Icaza is working on the required kernel stuff.
Since a real native GFX support is a fairly big project currently the
emulation stuff needed for the SGI X server has priority.

  Ralf
