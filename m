Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 19:22:55 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:24110
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225207AbTGaSWw>; Thu, 31 Jul 2003 19:22:52 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id OAA28612;
	Thu, 31 Jul 2003 14:22:46 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id OAA07037;
	Thu, 31 Jul 2003 14:22:45 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Thu, 31 Jul 2003 14:22:45 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: mips64/setup.c
In-Reply-To: <20030731165225.GA9566@linux-mips.org>
Message-ID: <Pine.GSO.4.44.0307311421110.6891-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

On Thu, 31 Jul 2003, Ralf Baechle wrote:

> On Thu, Jul 31, 2003 at 11:54:15AM -0400, David Kesselring wrote:
>
> > Is the file mips64/setup.c used? I believe that I see two problems in it;
> > 1) The Ocelot options in setup_arch have case statements without a switch.
>
> Ocelot 64-bit kernel is currently work in progress.  A first cut of
> the patch was posted to this mailing list a few days ago.
>
> > 2) There is no option for Sead but the mips64 build for sead compiles
> >    fine.
>
> The fun of when two almost identical files go out of sync.
Then do you know what is happening when 64bit sead is configured? Why
doesn't the compile fail?



>
> > Is this some leftovers from some merging that has been talked about?
>
> No.  The big merge thing did only happen in 2.6.  It's way to intrusive
> for 2.4.
>
>   Ralf
>
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
