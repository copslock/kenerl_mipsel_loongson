Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2002 22:41:01 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:65029 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122978AbSIBUlA>; Mon, 2 Sep 2002 22:41:00 +0200
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g82KerX28367;
	Mon, 2 Sep 2002 13:40:53 -0700
Date: Mon, 2 Sep 2002 13:40:53 -0700
From: Matthew Dharm <mdharm@momenco.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: PATCH: linux_2_4: add support for the Ocelot-G board
Message-ID: <20020902134053.A28347@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIKEJOCIAA.mdharm@momenco.com> <20020902190038.F15618@linux-mips.org> <20020902123850.A28171@momenco.com> <20020902224615.A17378@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020902224615.A17378@linux-mips.org>; from ralf@linux-mips.org on Mon, Sep 02, 2002 at 10:46:15PM +0200
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Return-Path: <mdharm@host099.momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

Hrm... okay... first question, where do I get the 64-bit toolchain?  Right
now, I'm using HJ's toolchain RPMs (from over a year ago -- I should update
those).

Second, what about all those nifty extras?  Things like the fact that
kseg0/1 (well, their 64-bit equivalents) are now larger (how big are they,
anyway) so they can map all of my SDRAM as well as most (all?) of my
I/O space... I guess for that I need to reprogram all my address decoders,
and then that sort of thing must be what the arch/mips64/* stuff is for.
Yes? No?  Or am I smoking something too strong again?

The 64/32 mixed-mode linux is certainly of some interest to our customers,
but full 64-bit is really where the demand is.  Is there anything that a
non-compiler guy can do to help the effort along?

Matt

On Mon, Sep 02, 2002 at 10:46:15PM +0200, Ralf Baechle wrote:
> On Mon, Sep 02, 2002 at 12:38:50PM -0700, Matthew Dharm wrote:
> 
> > Oh, I agree that a 64-bit kernel makes sense.  I'm just not sure what is
> > needed to get from where I am now to where I want to be.
> > 
> > There is _much_ interest from our customers for 64-bit linux.  Especially
> > if the toolchain catches up so that we can have 64-bit userspace.
> 
> The toolchain stuff is being worked on.  Hold your breath but cheat every
> once in a while when your face turns blue ;-)
> 
> > Anyone have some quick pointers on how to get from here to there?
> 
> The basic receipe is easy.  The 64-bit kernel has a binary compatibility
> layer that allows you to use 32-bit software with no changes.  Just use
> a 64-bit compiler, for now that's probably still the egcs 1.1.2 /
> binutils 2.9.5 based mips64-linux / mips64el-linux tool chain.  Using your
> old .config file do a "make ARCH=mips64 oldconfig" etc.  The resulting
> binary file will be a 32-bit ELF file so you can just feed that to your
> firmware for booting as usual.  Problems may be hit along the way ;-)
> 
>   Ralf

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
