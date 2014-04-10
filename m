Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 08:59:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51342 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6821191AbaDJG7bPNfdx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Apr 2014 08:59:31 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s3A6xTwF014799;
        Thu, 10 Apr 2014 08:59:29 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s3A6xSMH014796;
        Thu, 10 Apr 2014 08:59:28 +0200
Date:   Thu, 10 Apr 2014 08:59:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
Message-ID: <20140410065928.GW17197@linux-mips.org>
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com>
 <20140409051929.GA29246@localhost>
 <20140409082445.GC1438@pax.zz.de>
 <20140409133229.GA22315@alpha.franken.de>
 <20140409231345.GC8370@localhost>
 <5345DB6A.7060004@gentoo.org>
 <20140410003806.GV17197@linux-mips.org>
 <534609B2.5070808@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534609B2.5070808@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, Apr 09, 2014 at 11:02:10PM -0400, Joshua Kinard wrote:

> Odd, I thought R10K systems were locked to booting 64-bit kernels only.  At
> least the Octane was when it was bootable.  Not sure about IP27.
> 
> Maybe that's another one of ARCS' ingenious features...

No; IP27's address map is huge; a single node can take 2GB RAM.  A full
blown 512 CPU system could have 0.5TB memory.  Your homework for today:
try to use all that efficiently with highmem ;-)

Octane is essentially a specialized, single-node IP27.  It also can take
more memory than addressable in a 32 bit kernel which assumes that all memory
is visible in CKSEG0, all I/O in CKSEG1 - or you need to ioremap to CKSEG2/3.
So 32 bit kernels just don't cut it on Octane either.

Similarly 32 bit kernels don't cut it on other systems such as Sibyte,
SGI O2, Octane.  They may be possible for some configurations but that
that's either too rarely a useful choice or too inefficient.

Let's say 32 bit is slowly running out of juice :-)

> >> Are you configuring for IP22 (Indy, Indigo2 R4x00), or IP28 (R10000)?  Note,
> >> IP26 (R8000) is not supported in Linux.  I think OpenBSD got it working, though.
> > 
> > Wish I'd have a box ....
> 
> They do pop up on eBay from time-to-time.  UPS destroyed the case mine came
> in, though.  I've got it in a closet, with duct tape holding the teal skins
> on.  It does boot to the PROM, but the RTC is probably dead by now.

The common problem.  You can cut it open with a dremel or similar tool,
disconect the internal battery and connect an external battery instead.
There are howtos for this on the web.  I'm also tired of reprogramming
the MAC address again when I use my Indy so I should do this myself ...

  Ralf
