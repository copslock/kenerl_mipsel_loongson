Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA01529 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Dec 1997 16:48:19 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA28881 for linux-list; Tue, 2 Dec 1997 16:46:15 -0800
Received: from blammo.engr.sgi.com (blammo.engr.sgi.com [130.62.15.51]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA28875 for <linux@cthulhu.engr.sgi.com>; Tue, 2 Dec 1997 16:46:13 -0800
Received: (from jwiede@localhost) by blammo.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA11614 for linux@cthulhu; Tue, 2 Dec 1997 16:46:12 -0800
Date: Tue, 2 Dec 1997 16:46:12 -0800
From: jwiede@blammo.engr.sgi.com (John Wiederhirn)
Message-Id: <9712021646.ZM11626@blammo.engr.sgi.com>
In-Reply-To: alan@lxorguk.ukuu.org.uk (Alan Cox)
        "Re: Linux on the O2" (Dec  3, 12:04am)
References: <m0xd2Iz-0005FsC@lightning.swansea.linux.org.uk>
X-Face: 'rEN+vrv,h:"?|h{Q,A@Is5T#VUFb=Kp>c]5sK@![sLA$9^UoAtgryPHsqEOv5p&09H\E:p
                               )h:LCq-vz/dWH?Kn#A334hP4mM/**@..@TF($8<2LyeDSJqsnEnZ~O{>`EWm]QQ\>aSm9j,J_t0NF`
                               Rt`td=N-r1R~c2}l+Q^q[bYP0d_bzVWox>.pWNi$75*m,BlJ4-X"Q`x`OUCkz/gg>pIUf|KWs6{r=J
                               zE7[.14o:oq9Du"#C`^(MM_`?#!k:5%P4:Pfpy)5X7@fE|gq0XV(s/jUG?[>#ldY_4tG(Ng$:DRC
X-Mailer: Z-Mail-SGI (3.2S.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Dec 3, 12:04am, Alan Cox wrote:
>
> > I'll second Ralf.  Once we have an Indy port that's stable,
> > easy to install and maybe supported by Red-Hat or other
> > Linux distributors. Once we have something that's actually used
> > by many Indy owners (rather than just a handful), and once SGI
> > real customers (who bring SGI real money) seem to like it and
> > talk to their SGI reps about their interest in Linux on SGI,
> > only then, management may be open to opening more HW specs
> > to the public.
>
> Even if they don't its far far easier to reverse engineer the O2 working
> from a stable Indy base than from a wobbly base platform. I don't personally
> believe there is anything SGI could do to stop a Linux hacker making Linux
> run on the O2

As I've commented before, the problem isn't so much in getting the
kernel working (and working quickly).  The problem comes the second
you need to deal with graphics.  Given the O2's onboard multimedia
hardware, the situation only gets more complex.

Right now, there is no effective hardware abstraction mechanism in
Linux for graphics/multimedia.  With the Indy's rather simple gfx
capabilities, that isn't a tremendous hardship.  The hardship comes
when you are managing things like graphics pipelines, or hardware
that has very specific requirements for memory allocation and
alignment (and access).  Many of the necessary pieces simply do not
currently exist in the Linux kernel services.

While it would be possible to move these needs out to the X server
to some extent, not all of them can be handled that way (in specific,
the memory issues).  Further, there isn't really anything like
uniform functionality in Linux X servers for handling things such
as video I/O, genlocking, etc.  They exist in 3rd party servers,
but then the cooperation requirement rises again.

The proposal has come up multiple times to use the IRIX X server on
top of a Linux kernel.  Unfortunately, once again, that gets very
problemmatic on the more advanced gfx platforms such as O2 and Octane.
They both contain hardware-dependant sections of code which RELY on
certain kernel functionalities being present.  Factor in OpenGL and
the whole complexity level rises again.

Now, having said all that, I do believe the problem is solvable.
I think that with some modifications of the Linux kernel, it would
be quite possible to get the necessary abstraction to support
either an IRIX or customized third-party X server.  Further, it
would be nice if something equivalent to the SGI DMedia libraries
were available on Linux (with similar hardware abstraction), since
this is an area where simply put, Linux is FAR behind Windows{95,NT}
and SGI (and others).

Getting Linux on O2 probably isn't too difficult.  Getting USEFUL
O2/Octane/Onyx2 2D/3D graphics and multimedia under Linux would
be god-awful difficult with the current kernel/X situation.

My $0.02.


-- 
John Wiederhirn (DSD, Graphics Kernel MTS)        jwiede@engr.sgi.com
    "I've always said there's nothing an agnostic can't do if he
     really doesn't know whether he believes in anything or not."
