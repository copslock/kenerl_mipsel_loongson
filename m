Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id WAA48711 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Dec 1997 22:45:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA10858 for linux-list; Tue, 2 Dec 1997 22:42:45 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA10843 for <linux@cthulhu.engr.sgi.com>; Tue, 2 Dec 1997 22:42:43 -0800
Received: from ha1.rdc1.occa.home.com (ha1.rdc1.occa.home.com [24.1.128.66]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA12105
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Dec 1997 22:42:40 -0800
	env-from (cwcarlson@home.com)
Received: from home.com ([24.1.132.40]) by ha1.rdc1.occa.home.com
          (Netscape Mail Server v2.02) with ESMTP id AAA3318
          for <linux@cthulhu.engr.sgi.com>; Tue, 2 Dec 1997 22:42:38 -0800
Message-ID: <34850E4A.1075E816@home.com>
Date: Tue, 02 Dec 1997 23:46:20 -0800
From: Chris Carlson <cwcarlson@home.com>
Organization: BeachWare
X-Mailer: Mozilla 4.03 [en] (X11; I; Linux 2.0.30 i486)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
References: <Pine.LNX.3.95.971202161948.10955B-100000@vertigo.cs.indiana.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

cypher wrote:

> Hey,
>
> I've been looking for some information to start working on an O2 port and
> have basically gotten the response that managmement at SGI is not willing
> to release hardware specs for the O2 (a mistake IMHO). Don't get me wrong
> I think it's great that they allowed the Indy hardware specs to go out the
> door, even if in a limitied fashion.
>
> (I ran into the same problem with a Nintendo, but don't you agree that the
>  64 would make a great little "Network Computer"?)
>
> I'm guessing that they're looking at this as if an Indy running Linux
> won't really be that competetive with the O2s runnning IRIX, which I can
> almost understand.
>
> I can speak from my personal experience. I working with various research
> and production departments in a university that uses UNIX heavily. I can
> honestly say that we have several platforms (Alpha, Sparc, and Intel) that
> are running linux in production capacity. Also we have a lot of people
> using linux on there workstations (the above platforms plus a slew of
> others).. I think reallity is that people like Linux because they can get
> it to do usefull things on so many platrforms.
>
> Certain organizations within the school, who run anything from O2s to
> Octanes, to a Cave/Reallity Enginge, and an Origin 2000 (ok that
> probably gave away who I was talking about) are considering Linux on
> high-end Intel boxes as a inexpensive replacement for a $6000 dollar O2
> running IRIX. I think this is partly due to the added cost of OS licenses
> and various other software packages they have to pay for. It would be
> ashamed if SGI lost a share of it's hardware sales (even if it is
> the only in workstation market) market becasue some freeware wasn't
> available to run on it.
>
> I realize that SGI has a vested interest in seeing IRIX succeed, and IRIX
> is probably (it hurts to say this) better than Linux when running 128 (or
> soon 4096) CPUs. Linux however, is great lightweight OS for workstations
> especially. There's even more value added to am SGI running Linux that can
> be introduced into an evironment where multiple high-preformance platform
> type are desired (ie, Sparcs, Ultras, Alphas, SGIs. HPs, etc.) but a
> single operating platform is needed.
>
> This makes perfect sense to me, but I don't know if I'm explaining
> everything in the most effecient manner. I'd be _extremely_ happy to
> discuss this with someone, especially people from SGI that have some sort
> of influence on getting us the specs we need.
>
> Right now I am basically in position (not officially supported by the
> university of course, but there not telling me not to do it either, if you
> know what I mean) where I've been given and Indy and an O2 to work on
> porting Linux while on the clock. I don't know how much better it gets,
> but I'm guessing not much... I won't have the hardware forever,
> unfortunately, but if I can start making some sort of progress I can
> possibly convince them of the need to let me keep it.
>
> I hope we can somehow figure out a way for SGI to help us out on this one.
> ;-)
>

I also would like to see Linux ported to the O2 but also don't expect it to
happen in the near future.  We have to remember that SGI is a "hardware
company" and did not get where it is because of software.  To ask them to
divulge the inner workings of their bread-and-butter product, thus allowing
competitors to reproduce and improve upon the design is asking for disaster.
SGI does not fabricate their own chips and they have done their best to
provide access to their source (as long as it doesn't compromise their
hardware investment).  The only thing they have to sell is their design.
Since MIPS is not faring very well against competitors and there seems to me
a bit of doubt that they can stay ahead, what else does SGI have to sell?
Just their internal architecture and IRIX.

Giving the Linux community access to the internal design of the O2, Octane
and/or Origin would give any competitor the information they need to put SGI
out of business.  I don't blame the company for not wanting Linux on the
newer products until the next generation is released.

--
      +----------------------------------------+
      | Christopher W. Carlson                 |
      | e-mail home:      cwcarlson@home.com   |
      | WWW: http://members.home.net/cwcarlson |
      +----------------------------------------+
