Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2002 21:39:02 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:63237 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122978AbSIBTjB>; Mon, 2 Sep 2002 21:39:01 +0200
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g82Jco828191;
	Mon, 2 Sep 2002 12:38:50 -0700
Date: Mon, 2 Sep 2002 12:38:50 -0700
From: Matthew Dharm <mdharm@momenco.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: PATCH: linux_2_4: add support for the Ocelot-G board
Message-ID: <20020902123850.A28171@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIKEJOCIAA.mdharm@momenco.com> <20020902190038.F15618@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020902190038.F15618@linux-mips.org>; from ralf@linux-mips.org on Mon, Sep 02, 2002 at 07:00:38PM +0200
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Return-Path: <mdharm@host099.momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

Oh, I agree that a 64-bit kernel makes sense.  I'm just not sure what is
needed to get from where I am now to where I want to be.

There is _much_ interest from our customers for 64-bit linux.  Especially
if the toolchain catches up so that we can have 64-bit userspace.

Anyone have some quick pointers on how to get from here to there?

Matt

On Mon, Sep 02, 2002 at 07:00:38PM +0200, Ralf Baechle wrote:
> On Tue, Aug 27, 2002 at 04:00:51PM -0700, Matthew Dharm wrote:
> 
> > The attached two patches and small tar archive (I can't figure out how
> > to make CVS do the equivalent of a diff -N) add support to the 2.4
> > branch for the Ocelot-G board (RM7000 processor with GT-64240 bridge).
> > 
> > I've gone ahead and created an linux/arch/mips/momenco directory, as
> > we've got another board almost ready to add to the repository (the
> > Ocelot-C and -CS), and we've got concrete plans to port to our
> > RM9000x2 board (Jaguar), which has at least a couple of varieties.  I
> > figured getting all this organized under one directory would be wise.
> > 
> > Presuming this gets accepted, there are a few more patches in this
> > series... some updates to the MTD probing address for these boards, as
> > well as a new ethernet driver for the GT-64240 on-board ethernet.
> > 
> > Ralf, please apply these to the CVS repository.
> 
> As a note - most boards are now selectable for the 32-bit and 64-bit kernel.
> For a board like the Ocelot having a 64-bit kernel certainly makes sense ...
> 
>    Ralf

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
