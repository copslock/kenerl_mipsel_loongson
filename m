Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 13:39:40 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:54217
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225072AbTHLMji>; Tue, 12 Aug 2003 13:39:38 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id IAA16529
	for <linux-mips@linux-mips.org>; Tue, 12 Aug 2003 08:39:30 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id IAA05163
	for <linux-mips@linux-mips.org>; Tue, 12 Aug 2003 08:39:30 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Tue, 12 Aug 2003 08:39:30 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: Re: C0 config reg for 5k core
In-Reply-To: <3F38CDA4.40208@mips.com>
Message-ID: <Pine.GSO.4.44.0308120835500.4727-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I see what is going on now. Thanks.

On Tue, 12 Aug 2003, Chris Dearman wrote:

> David Kesselring wrote:
> > Has anyone else built linux 2.4 for a 5k or 5kf core? When comparing cpu.h
>
>    I have :)
>
> > and the MIPS64 5K Processor Core Family Software Users Manual it doesn't
> > look to me that the c0-config1 reg is defined the same way. Am I reading
> > something wrong? For example in the spec FPU flag is bit0 while in cpu.h
> > it is bit4. Seems pretty basic.
>
>    The option bits defined in cpu.h are software flags.  See
> arch/mips/kernel/setup.c where these flags are set for each processor by
> reading appropriate registers.
>
> 	Regards
> 		Chris
>
> --
> Chris Dearman          The Fruit Farm, Ely Road    voice +44 1223 706206
> MIPS Technologies (UK) Chittering, Cambs, CB5 9PH  fax   +44 1223 706250
>
>
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
