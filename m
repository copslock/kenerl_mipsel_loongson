Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA448458 for <linux-archive@neteng.engr.sgi.com>; Sun, 18 Jan 1998 09:30:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA15818 for linux-list; Sun, 18 Jan 1998 09:24:38 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA15806; Sun, 18 Jan 1998 09:24:32 -0800
Received: from netexpress.net (shamu.netexpress.net [206.65.64.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA27153; Sun, 18 Jan 1998 09:24:31 -0800
	env-from (drachen@netexpress.net)
Received: from netexpress.net (flexgen-17.netexpress.net [206.65.65.146])
	by netexpress.net (8.8.7/8.8.5) with ESMTP id LAA25931;
	Sun, 18 Jan 1998 11:24:25 -0600
Message-ID: <34C23ACA.83E2E39C@netexpress.net>
Date: Sun, 18 Jan 1998 11:24:27 -0600
From: David Hinkle <drachen@netexpress.net>
X-Mailer: Mozilla 4.04 [en] (Win95; I)
MIME-Version: 1.0
To: Bob Miller <kbob@jogger-egg.engr.sgi.com>
CC: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: My NEC VR4000's
References: <34C10470.6CEEBCBA@netexpress.net>
	    <19980117210232.46452@uni-koblenz.de> <34C17279.5CB286B5@netexpress.net> <199801181512.HAA18031@jogger-egg.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

The system is about a foot and a half tall and about 8-10 inches deep and
wide... (Square bottom rectangular sides...)    Bright blue with a pop-off
front that reveals the hard drives on the right and another panel on the
left... twisting the nob at the top of the left panel couses the panel to drop
forward and the CPU and Video card can be removed.  (The run from top to bottom
with clips on the top and bottom... pull forward on both clips and they slide
out.)

How much does IRIX cost?  And were can I obtain a copy...    I really need to
repartition these drives and start over... Becouse the system can't be shut
down properly becouse you need the root password to preform the shut down....
Consequently it's all messed up.    I plan on mounting it's drives in my
desktop and hoping that Linux can read the filesystem so I can clear the root
password....  Bye the way... Is there an easier way to clear the root
password?    And does anybody know what filesystem IRIX uses?

How do I subscribe to the mailing lists?  (Wow... Lot's of silly questions in
this letter huh? <G>)  Please CC to me becouse I'm not on you'r lists yet.

                Thanks guys, I really apreciate your help.

Bob Miller wrote:

> Ralf wrote:
>
> > Choose between IRIX and IRIX.  Someone else is working on a Linux port to
> > the Indigo.  No results yet, he has just started some days ago.  Since
> > you're interested in Linux for SGI machines you should also subscribe to
> > SGI's mailing list linux@engr.sgi.com via majordomo@engr.sgi.com.
>
> If these are Indigo2 machines, then they have the same motherboard as
> the Indy.  The graphics board is completely different, though.  The
> same IRIX kernel will run on Indy and Indigo2.  Linux probably won't
> run on Indigo2 today because it assumes Indy graphics are present, but
> removing graphics support should be straightforward (?) if you want
> a headless server running Linux.
>
> If the CPU box is a thick pizza box (wide and flat, about 6 inches
> tall), then it's an Indigo2.  If the CPU box is a minitower, then it's
> an original Indigo, and getting Linux running on that would be a much
> bigger project.
>
>                                         K<bob>
