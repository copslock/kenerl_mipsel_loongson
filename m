Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2003 20:58:10 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:50072
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225202AbTHKT6I>; Mon, 11 Aug 2003 20:58:08 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id PAA09116;
	Mon, 11 Aug 2003 15:58:00 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id PAA04682;
	Mon, 11 Aug 2003 15:58:00 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Mon, 11 Aug 2003 15:57:59 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: Mike Uhler <uhler@mips.com>
cc: linux-mips@linux-mips.org
Subject: Re: C0 config reg for 5k core
In-Reply-To: <1060630328.1071.20.camel@uhler-linux.mips.com>
Message-ID: <Pine.GSO.4.44.0308111556500.4643-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

Is this reg, supposed to be the same among all processor or does it
differ?

On 11 Aug 2003, Mike Uhler wrote:

> Bit 0 of Config1 is FPU-present.  Bit 4 is "Performance counters
> present".  I guarantee you that the 5K family implements this
> pattern.
>
> /gmu
>
>
> On Mon, 2003-08-11 at 11:28, David Kesselring wrote:
> > Has anyone else built linux 2.4 for a 5k or 5kf core? When comparing cpu.h
> > and the MIPS64 5K Processor Core Family Software Users Manual it doesn't
> > look to me that the c0-config1 reg is defined the same way. Am I reading
> > something wrong? For example in the spec FPU flag is bit0 while in cpu.h
> > it is bit4. Seems pretty basic.
> >
> > David Kesselring
> > Atmel MMC
> > dkesselr@mmc.atmel.com
> > 919-462-6587
> --
>
> Michael Uhler, Chief Technology Officer
> MIPS Technologies, Inc.  Email: uhler@mips.com  Pager:uhler_p@mips.com
> 1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
> Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085
>
>
>
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
