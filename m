Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 16:06:45 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:15826 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8224847AbSLDPGo>;
	Wed, 4 Dec 2002 16:06:44 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB4F6TNf023205;
	Wed, 4 Dec 2002 07:06:29 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA18802;
	Wed, 4 Dec 2002 07:06:21 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB4F6Kb27587;
	Wed, 4 Dec 2002 16:06:21 +0100 (MET)
Message-ID: <3DEE19EC.DD007304@mips.com>
Date: Wed, 04 Dec 2002 16:06:20 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: linux-mips@linux-mips.org, dom@mips.com, chris@mips.com,
	kevink@mips.com
Subject: Re: Prefetches in memcpy
References: <3DC7CB8B.E2C1D4E5@mips.com> <20021105163806.A24996@bacchus.dhis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

I would like to open this thread again, since nothing has been done about it.
I think we should get rid of the prefetches until someone comes up with a
version that doesn't prefetch beyond the copy destination/source area.

/Carsten


Ralf Baechle wrote:

> On Tue, Nov 05, 2002 at 02:45:47PM +0100, Carsten Langgaard wrote:
>
> > The problem is the prefetches in the memcpy function in the kernel.
> > There is spread a number of PREF instructions in the memcpy function,
> > but there is no check if we are prefetching out-side the areas we are
> > copying to/from. This is extremely dangerous because we might prefetch
> > out-side the physical memory area, causing e.g. a bus error or something
> > even more nasty.
> >
> > I recently found something even nastier, it could also hit a DMA buffer
> > region, and thereby break the PCI DMA flushing scheme.
> > For example if the kernel is doing a memcpy from an area that's next to
> > a DMA buffer area, we could end up in a situation where, we are
> > prefetching
> > data into the cache from a memory location that is used for DMA transfer
> > and owned by the device, but the DMA transfer has not yet completed.
> > We then end up in a situation, where the memory and cache is out of sync
> > and the cache is containing some old data.
> >
> > So we definitely need to do something about the prefetches in the memcpy
> > function.  We can either get rid of all the prefetches or make sure we
> > don't prefetch out side the "memcpy" area.
>
> We could fix the prefetch into DMA buffer problem with an extra flush but
> that's going to be expensive, I rather think we should avoid prefetches.
> As Kevin explained KSEG1 is a loophole in the spec so we can't really say
> what the behaviour of memcpy will be in KSEG1.
>
> So I think the fix will have to be:
>
>  - Avoid prefetching beyond the end of the copy area in memcpy and memmove.
>  - Introduce a second variant of memcpy that never does prefetching.  This
>    one will be safe to use in KSEG1 / uncached XKPHYS also and will be used
>    for memcpy_fromio, memcpy_toio and friends.
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
