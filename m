Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 17:52:30 +0100 (BST)
Received: from p508B6081.dip.t-dialin.net ([IPv6:::ffff:80.139.96.129]:13446
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225207AbTGaQw2>; Thu, 31 Jul 2003 17:52:28 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6VGqRx6010887;
	Thu, 31 Jul 2003 18:52:27 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6VGqQID010886;
	Thu, 31 Jul 2003 18:52:26 +0200
Date: Thu, 31 Jul 2003 18:52:26 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mips64/setup.c
Message-ID: <20030731165225.GA9566@linux-mips.org>
References: <Pine.GSO.4.44.0307311150440.6891-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0307311150440.6891-100000@ares.mmc.atmel.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 31, 2003 at 11:54:15AM -0400, David Kesselring wrote:

> Is the file mips64/setup.c used? I believe that I see two problems in it;
> 1) The Ocelot options in setup_arch have case statements without a switch.

Ocelot 64-bit kernel is currently work in progress.  A first cut of
the patch was posted to this mailing list a few days ago.

> 2) There is no option for Sead but the mips64 build for sead compiles
>    fine.

The fun of when two almost identical files go out of sync.

> Is this some leftovers from some merging that has been talked about?

No.  The big merge thing did only happen in 2.6.  It's way to intrusive
for 2.4.

  Ralf
