Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA82268 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Mar 1999 16:51:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA63978
	for linux-list;
	Fri, 26 Mar 1999 16:50:47 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA72497
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Mar 1999 16:50:45 -0800 (PST)
	mail_from (tau@cubicsky.com)
Received: from kotetsu.cubicsky.com (kotetsu.cubicsky.com [208.207.21.114]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA01299
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Mar 1999 16:50:39 -0800 (PST)
	mail_from (tau@cubicsky.com)
Received: from cubicsky.com (jade.vlan1.cubicsky.com [192.168.1.3])
	by kotetsu.cubicsky.com (8.9.2/8.9.2) with ESMTP id TAA34316
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Mar 1999 19:53:50 -0500 (EST)
	(envelope-from tau@cubicsky.com)
Message-ID: <36FC549B.3FF6607D@cubicsky.com>
Date: Fri, 26 Mar 1999 19:46:35 -0800
From: Steve Martin <tau@cubicsky.com>
Organization: Axial
X-Mailer: Mozilla 4.5 [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Re: Port to R3000 Indigo
References: <36FBEFA3.A6ADB8F0@norden1.com> <9903261648250V.04692@vulture> <36FC3841.71061373@hol.gr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Theodoros Nikitopoulos wrote:

> tom wrote:
>
> > And I know a group at KSC that's getting rid of a bunch of O2s.  We'd love to
> > grab them and make a nice little Beowulf cluster out of them :-).
> > Unfortunately, we don't have the time at work to do a port :-(
> >
> > On Fri, 26 Mar 1999, Jeremy Parsons wrote:
> > ? I think it would be very relevant.  My company recently sold around 30
> > ? of the R3000 Indigo's.  Just about every person who bought one of these
> > ? was interested in the SGI/Linux project and wanted to know if they would
> > ? some day be able to run Linux on it.
> > ?
> > ? Jeremy Parsons
> > --

>
>
> I have a feeling that someone hasn't any chance to port Linux in the O2 or
> Indigo2 platform unless Sillicon Graphics wants too. In other words, by
> giving a great deal of information in public for building the appropriate
> drivers. Am I wrong about it ?

Well, regading the O2, several things come into factor if they were to release
info:
    1) They still support IRIX on the O2, and are still making money off of that.
 People that might get a new IRIX release or dev tools in the future
    might start using linux which would cost them money, and right now SGI can't
afford to lose any money at all.
    2) The O2 is still relatively new technology.  The software algorithms behind
the display mechanisms and such to support UMA and the various
    specialized components of the O2 are points of innovative technology,
releasing source(or even detailed information about the processes used)
    to the public might not be a wise thing to do.
    3)  Linux could surpass IRIX on the O2 easily, because the IRIX implementation
on the O2 is *crap*(relative to what I've seen on previous
    machines such as the Indy, Indigo2, Crimson, Indigo, etc..).  It has more bugs
regarding the graphics than I've seen since Windows 95 was
    first released.  I ended up spending half my time trying to avoid getting
kernel panics(note that in 6.3 things were bad, but in 6.5 things were
    better, although I had some problems with it and certain OpenGL applications.
(I had posted about the bug with a picture and such in
    comp.sys.sgi.bugs a while back as well.  An image of the screen is at
http://www.cubicsky.com/~tau/_o2bug.jpeg).  That was with running
    mere apps from the glut demo collection.  I also noticed some considerable
problems with 1600x1200@60hz(I wrote a vfo for that) although
    that is unsupported by SGI, and I can see why.

Overall, I think Linux on the O2 would be a great thing, yet I wonder if it would
be a wise business decision for SGI to support that at this time.
I suppose that the O2 is a previous generation machine, but then I look at the
VisualPC and see no real "workstation-calibur" software(regarding Windows NT), so
perhaps the O2 is the newest low-end "true workstation" by SGI, and thus SGI may
not want to release info on that.

We could always run the IRIX kernel and all the graphics stuff through a
dissassembler... :)

----Linux unrelated--
One unrelated sidenote that is a bug I've noticed both on the O2 and
Indigo2(Elan).   This is something you should try, run an app that uses
glPixelZoom(such as "resolution" which is one of the things included with
glut-3.7(I think)).  Move the window to off the screen(but still showing some of
the window area).  Increase the zoom, and notice that the window goes blank(or
displays multiple copies of the viewport within) on the Indigo2, or fills up the
window with lots of trash on the O2.  Is this a well known bug?  (basically a
problem with clipped glPixelZoom operations)
------------------

>
>
> By the way, SGI has officialy report to support Linux on visual
> workstations. Any ideas if they will also transfer the desktop enviroment
> commonly used in IRIX ? This seems to me very likely, in regards of
> providing a common user interface both in IRIX based systems and Linux
> based systems provided by SGI. That could be a great benefeat of the Linux
> community..
>
> Personally I haven't find any Linux user interface more nicely crafted
> than SGI's 4DWM.

Well, you could always try a gtk theme with gnome, and a 4Dwm enlightenment
theme.  I've wanted to see that, make all my PCs look like the Indigo Magic
environment(hehe).  I agree 4Dwm&Indigo Magic are pretty much the best there is,
very innovative(introduced many things
unseen as well thought out as they were in this before).  Too bad I haven't seen
much in that respect lately from SGI... (whatever happened to doing innovative
things that changed computing like they used to?).  I had given a guy on
irc(efnet) some snapshots of some 4Dwm things as well as some desktop shots,
because he was interested in doing an enlightenment theme to make his PCs look
like 4Dwm, perhaps that'll happen.

>
>
> Theodore .

..
Steve Martin
