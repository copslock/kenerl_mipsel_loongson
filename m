Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA13758; Tue, 17 Jun 1997 17:01:06 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA22122 for linux-list; Tue, 17 Jun 1997 17:00:53 -0700
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [130.62.16.64]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA22115 for <linux@cthulhu.engr.sgi.com>; Tue, 17 Jun 1997 17:00:52 -0700
Received: from blammo.engr.sgi.com (blammo.engr.sgi.com [130.62.15.51]) by morgaine.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA15835 for <linux@morgaine.engr.sgi.com>; Tue, 17 Jun 1997 17:00:11 -0700
Received: (from jwiede@localhost) by blammo.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA11557 for linux@morgaine; Tue, 17 Jun 1997 17:00:11 -0700
Date: Tue, 17 Jun 1997 17:00:11 -0700
From: jwiede@blammo.engr.sgi.com (John Wiederhirn)
Message-Id: <9706171700.ZM11546@blammo.engr.sgi.com>
In-Reply-To: offer@sgi.com (richard offer)
        "Re: Good news: no more begging for HW" (Jun 17, 10:53am)
References: <199706171710.MAA15321@athena.nuclecu.unam.mx> 
	<9706171053.ZM9344@sgi.com>
X-Face: 'rEN+vrv,h:"?|h{Q,A@Is5T#VUFb=Kp>c]5sK@![sLA$9^UoAtgryPHsqEOv5p&09H\E:p
                 )h:LCq-vz/dWH?Kn#A334hP4mM/**@..@TF($8<2LyeDSJqsnEnZ~O{>`EWm]QQ\>aSm9j,J_t0NF`
                 Rt`td=N-r1R~c2}l+Q^q[bYP0d_bzVWox>.pWNi$75*m,BlJ4-X"Q`x`OUCkz/gg>pIUf|KWs6{r=J
                 zE7[.14o:oq9Du"#C`^(MM_`?#!k:5%P4:Pfpy)5X7@fE|gq0XV(s/jUG?[>#ldY_4tG(Ng$:DRC
X-Mailer: Z-Mail-SGI (3.2S.3 08feb96 MediaMail)
To: linux@morgaine.engr.sgi.com
Subject: Re: Good news: no more begging for HW
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Jun 17, 10:53am, richard offer wrote:
> * $ from miguel@nuclecu.unam.mx at "17-Jun:12:10pm" | sed "1,$s/^/* /"
> *
> * 4. Would it be possible for a free software company to redistribute
> *    the SGI's X server?  In that case, we could concentrate on getting
> *    the IRIX emulation as good as possible and just use the SGI X
> *    server and let Red Hat/Debian/GNU ship the cd with that binary.
>
> This would be my preferred solution, but I've had many an argument on this
> subject that I felt very dubious about bringing it up again.
>
> To me the quickest (and the best) way of getting an X server would be if we
> could simply port the existing Irix X server to Linux/SGI. My suggestion
would
> be, now that we have backing for hardware to get official backing for
software.
> I don't think we should neccesarrily release the source code for the ddx part
> of the X server to the public, but we should at least be able to get backing
to
> release .o files so the user could re-link the X server if they needed to
(Sun
> have done this before).

While this appears to be an ideal solution on the surface, it has some obvious
and immediate problems as well.  Namely, the complete lack of the driver
infrastructure to support the device-dependant layer of the Xsgi server.

Given that it's unlikely we'd release the source code to our gfx drivers, there
is no easily viable way to produce the drivers in the linux kernel image.
 Lacking the drivers, Xsgi would need some _major_ redesigns, which brings us
back to Xfree-porting-level efforts needing to be expended.

There are some very serious issues which come up even getting Xfree to a
moderate level of acceleration.  By the time you've got all the pieces in
place, you are probably looking at the same device-independant ->
device-dependant -> gfx-device layering that Xsgi has in place.  OpenGL adds an
order of magnitude of complexity to the issue.

I realize this comes off as fairly negative, but I'm just trying to explain the
issues involved once gfx gets added to the mix.  There would need to be a
buy-in at a very high level of SGI mgmt. before we could start making the
hardware details of our graphics subsystems available (at least the more modern
ones, such as O2, Impact, etc.).


-- 
John Wiederhirn (DSD, Graphics Kernel MTS)        jwiede@engr.sgi.com
       "Smithers, unleash the human insight and creativity."
