Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA81230 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Mar 1999 16:40:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA95187
	for linux-list;
	Fri, 26 Mar 1999 16:39:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA73631;
	Fri, 26 Mar 1999 16:39:35 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id QAA24143; Fri, 26 Mar 1999 16:39:34 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199903270039.QAA24143@oz.engr.sgi.com>
Subject: Re: Port to R3000 Indigo
To: neuroinc@unidial.com (root)
Date: Fri, 26 Mar 1999 16:39:34 -0800 (PST)
Cc: ariel@cthulhu.engr.sgi.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <36FC14FD.46F1279E@unidial.com> from "root" at Mar 26, 99 11:15:09 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alan Hoyt said:
:>
:> It won't happen by itself, only if someone devotes serious
:> time to it.  My personal feeling is that Linux on R3000
:> will not happen (there are cheaper and faster old pentium 90's
:> out there) but if someone builds it... I've been wrong before.
:
:Are you saying that the effort necessary to port Linux to R3000
:Indigo would be better placed elsewhere?
:
[Obligatory Disclaimer:
 Everything I write below is personal views, no one appointed me
 to be an official SGI spokeperson]

In a way yes ;-)

For example, I personally would be much happier if the few people
who have the ability to make such port a reality would devote their
time on more attractive, newer machines.

The real scarcity is in talent who can make things happen.  There's
no scarcity in people who just "want" things to happen and voice
their wishes on various mailing lists.

If we could get talent to get involved with the SGI Intel machines
it would be IMHO more valuable; the reasons are simple:

	- We can leverage the thousands of precompiled PRMs out there
	  rather than duplicating work

	- The installed base of these systems is expected to be much
	  larger so the scarcity of talent with access to hardware
	  would likely be less grave.

	- The performance and attractiveness of these machines is
	  much higher.

	- Market realities: SGI as a company may be much more inclined
	  to put resources on something that is not a dead product.
	  and we have to realize that every response even on this
	  friendly mailing list, is in the end paid for by SGI since
	  people work on company time.

There's some work going on (while no one was taking notice, the 2.2.4
kernel just got a /dev/fb implementation from Jeff Newquist) so
we can have X11 (albeit unaccelerated) running on the SGI VisWS!
People are welcome to look at the code and get involved, it is all
completely open on www.linux.sgi.com (in the Intel section).

Regarding MIPS, for similar reasons, having the Indy port 'finished'
(it is not yet really easy to get up and running) or having support
for O2s, seems (at least to me) to be much more attractive than
R3000 Indigos.

Again, It is not that I don't want it to happen.  I'm just
asking myself, what would I (and many others) prefer to put
available talent energies on.   If we don't set priorities,
we run the risk of getting lost in multiple unfinished ports
and dilute our efforts and end results.


:
:The final portion of my original question, is really the most
:important - are the hardware specifications/documentation available
:or are they considered proprietary?
:
:This issue alone is paramount since it substantially affects the "effort"
:necessary to port.
:
I believe Bill Earl tried to locate some very old specs but
couldn't find them (and he can correct me if I'm wrong).  Indy
specs were sent (sorry I only have paper versions) to those
who have shown they are really serious and can make a difference
and asked for them.  The best source for older SGI machines
data is at:

	http://www.geocities.com/SiliconValley/Pines/2258/4dfaq.html

This is the best I could find on anything before my times at SGI...

-- 
Peace, Ariel
