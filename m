Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 15:07:12 +0000 (GMT)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:16765
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225344AbTJ0PHA>; Mon, 27 Oct 2003 15:07:00 +0000
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA19381;
	Mon, 27 Oct 2003 10:06:53 -0500 (EST)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA19753;
	Mon, 27 Oct 2003 10:06:53 -0500 (EST)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Mon, 27 Oct 2003 10:06:53 -0500 (EST)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-mips@linux-mips.org
Subject: Re: Relocation errors
In-Reply-To: <20031027145803.GA26911@nevyn.them.org>
Message-ID: <Pine.GSO.4.44.0310271002480.19642-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

It is type 8. Any ideas? This is from an intel driver that I've cross
compiled for mips. I used these options;
-mcpu=r4600 -mips2 -mno-abicalls -fno-pic -mlong-calls -Wa,--trap -DMODULE
-pipe -O3 -fomit-frame-pointer -fno-strict-aliasing

Thanks, David

On Mon, 27 Oct 2003, Daniel Jacobowitz wrote:

> On Mon, Oct 27, 2003 at 08:55:19AM -0500, David Kesselring wrote:
> > I'm getting the error "Unhandled relocation of type xx" on insmod. Are the
> > "types" documented somewhere? I am I correct that these "types" are
> > architecture specific?
>
> Yes.  Try an ELF specification - there's a MIPS processor supplement
> (psABI) floating around.  What's the "xx"?
>
> --
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer
>
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
