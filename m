Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA109143; Fri, 8 Aug 1997 15:41:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA17593 for linux-list; Fri, 8 Aug 1997 15:40:38 -0700
Received: from blammo.engr.sgi.com (blammo.engr.sgi.com [130.62.15.51]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA17569; Fri, 8 Aug 1997 15:40:32 -0700
Received: (from jwiede@localhost) by blammo.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA27183; Fri, 8 Aug 1997 15:40:30 -0700
Date: Fri, 8 Aug 1997 15:40:30 -0700
From: jwiede@blammo.engr.sgi.com (John Wiederhirn)
Message-Id: <9708081540.ZM26801@blammo.engr.sgi.com>
In-Reply-To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
        "Re: Linux GGI and Linux/SGI" (Aug  9, 12:20am)
References: <199708082220.AAA02667@informatik.uni-koblenz.de>
X-Face: 'rEN+vrv,h:"?|h{Q,A@Is5T#VUFb=Kp>c]5sK@![sLA$9^UoAtgryPHsqEOv5p&09H\E:p
                   )h:LCq-vz/dWH?Kn#A334hP4mM/**@..@TF($8<2LyeDSJqsnEnZ~O{>`EWm]QQ\>aSm9j,J_t0NF`
                   Rt`td=N-r1R~c2}l+Q^q[bYP0d_bzVWox>.pWNi$75*m,BlJ4-X"Q`x`OUCkz/gg>pIUf|KWs6{r=J
                   zE7[.14o:oq9Du"#C`^(MM_`?#!k:5%P4:Pfpy)5X7@fE|gq0XV(s/jUG?[>#ldY_4tG(Ng$:DRC
X-Mailer: Z-Mail-SGI (3.2S.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: Linux GGI and Linux/SGI
Cc: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Aug 9, 12:20am, Ralf Baechle wrote:
>
> > Are there any plans to move (maybe it's already there) the
> > SGI version of Linux to a GGI-model design?
> > (see http://synergy.foo.net/~ggi/)
>
> Well, we have discussed using GGI.  Last I checkend GGI was still itself
> in a state of flux and the last thing I want to do is to open another
> battle field.  Technical reasons against GGI was mostly that the original
> design was very bloated as far as the kernel is affected.  This has
> been improoved somwhat since.

I'm not so attached to the notion of GGI as much as for gfx
having an in-kernel-space presence in Linux (Linux/SGI is
going to need this, as I suspect is any Linux that attempts
hardware acceleration of OpenGL or other similar APIs).

John

-- 
John Wiederhirn (DSD, Graphics Kernel MTS)        jwiede@engr.sgi.com
       "Smithers, unleash the human insight and creativity."
