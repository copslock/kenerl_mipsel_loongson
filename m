Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA53892 for <linux-archive@neteng.engr.sgi.com>; Mon, 19 Oct 1998 12:54:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA36053
	for linux-list;
	Mon, 19 Oct 1998 12:53:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from jibe.engr.sgi.com (jibe.engr.sgi.com [150.166.37.45])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA04316;
	Mon, 19 Oct 1998 12:53:41 -0700 (PDT)
	mail_from (kyriazis@jibe.engr.sgi.com)
Received: (from kyriazis@localhost) by jibe.engr.sgi.com (980427.SGI.8.8.8/960327.SGI.AUTOCF) id MAA90956; Mon, 19 Oct 1998 12:53:41 -0700 (PDT)
Message-Id: <199810191953.MAA90956@jibe.engr.sgi.com>
Subject: Re: XZ
In-Reply-To: <199810190644.IAA17078@link.csem.ch> from "Fernando D. Mato Mira" at "Oct 19, 98 08:44:45 am"
To: matomira@acm.org (Fernando D. Mato Mira)
Date: Mon, 19 Oct 1998 12:53:40 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
From: kyriazis@sgi.com (George Kyriazis)
Reply-To: kyriazis@sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


In a previous episode, Fernando D. Mato Mira claimed:
> At 05:15 PM 10/18/98 -0700, you wrote:
> >    XZ is one of the variants of the Elan/Extreme series of cards,
> >which have one or more geometry engines on the card.  The geometry
> >engines need microcode downloaded for full functionality, and the
> >interfaces are not externally documented, so it is hard to build
> >linux support without access to the IRIX source for reference.
> 
> What about just getting the console running (no X server)?
> How do GR2 (Indigo Elan) and GR3 (Indigo II Elan) differ in terms of
> programming?
> 
I did some asking around.  Here's what I found:

* In order to do anything, you have to download microcode.

* The monitor PROM downloads a mini-microcode that could be used.  I am
  not sure what the entry points look like to the PROM.  I think this
  is the safest bet.

* The full-functioning microcode (that does 3d) is downloaded at boot
  time before the X server initializes.
 
* The people that I asked are not clear about the programming differences
  between GR2 and GR3.  Certainly they are the same for OpenGL-level
  programming.  My guess is that there are differences in the CPU interfacing
  and video back end.  User-level code is the same, but kernel initialization
  and management code may be different.

* Getting things up and running on a GR-type (Express) architecture is 
  definetely more difficult than Newport.

* Documentation will be hard to find.  Documentation for programming the
  microcoded engines, even harder.  You could, of course, use the existing
  microcode.

  --george
-- 
-----------------------------------------------------------------------------
George Kyriazis  | Silicon Graphics, Inc., 8U-590 |  kyriazis@sgi.com
                 | 2011 N. Shoreline Blvd.        |  650-933-2828
                 | Mt. View, CA 94043             | 
