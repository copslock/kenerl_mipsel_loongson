Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2002 21:46:31 +0200 (CEST)
Received: from p508B7CE7.dip.t-dialin.net ([80.139.124.231]:47749 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122978AbSIBTqb>; Mon, 2 Sep 2002 21:46:31 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g82KkFW18147;
	Mon, 2 Sep 2002 22:46:15 +0200
Date: Mon, 2 Sep 2002 22:46:15 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: PATCH: linux_2_4: add support for the Ocelot-G board
Message-ID: <20020902224615.A17378@linux-mips.org>
References: <NEBBLJGMNKKEEMNLHGAIKEJOCIAA.mdharm@momenco.com> <20020902190038.F15618@linux-mips.org> <20020902123850.A28171@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020902123850.A28171@momenco.com>; from mdharm@momenco.com on Mon, Sep 02, 2002 at 12:38:50PM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 02, 2002 at 12:38:50PM -0700, Matthew Dharm wrote:

> Oh, I agree that a 64-bit kernel makes sense.  I'm just not sure what is
> needed to get from where I am now to where I want to be.
> 
> There is _much_ interest from our customers for 64-bit linux.  Especially
> if the toolchain catches up so that we can have 64-bit userspace.

The toolchain stuff is being worked on.  Hold your breath but cheat every
once in a while when your face turns blue ;-)

> Anyone have some quick pointers on how to get from here to there?

The basic receipe is easy.  The 64-bit kernel has a binary compatibility
layer that allows you to use 32-bit software with no changes.  Just use
a 64-bit compiler, for now that's probably still the egcs 1.1.2 /
binutils 2.9.5 based mips64-linux / mips64el-linux tool chain.  Using your
old .config file do a "make ARCH=mips64 oldconfig" etc.  The resulting
binary file will be a 32-bit ELF file so you can just feed that to your
firmware for booting as usual.  Problems may be hit along the way ;-)

  Ralf
