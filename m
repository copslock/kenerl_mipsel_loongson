Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2018 20:06:37 +0200 (CEST)
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:36759 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994656AbeGDSG0wlG3Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jul 2018 20:06:26 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 125D03F66E;
        Wed,  4 Jul 2018 20:06:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w6X7y9H2RXjo; Wed,  4 Jul 2018 20:06:25 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 6E1DC3F659;
        Wed,  4 Jul 2018 20:06:24 +0200 (CEST)
Date:   Wed, 4 Jul 2018 20:06:23 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Subject: Re: Update PS2 R5900 to kernel 4.x?
Message-ID: <20180704180621.GB2701@localhost.localdomain>
References: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
 <0d0fdd50-929f-da92-dd35-88f2878da8c2@gentoo.org>
 <64C2A7A5-46FD-406C-9B51-5F45AEBA70F0@nocrew.org>
 <b0356404-42b6-6e8b-e15b-57cf98b7d6e6@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0356404-42b6-6e8b-e15b-57cf98b7d6e6@gentoo.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Joshua,

On Thu, Aug 03, 2017 at 10:04:29PM -0400, Joshua Kinard wrote:
> I have one of the PS2 debug machines in a closet somewhere.  Basically a normal
> PS2 with 4x RAM and says "TEST" on the side in the PS2 font.  Can't remember if
> it still works or not.
> 
> And it's insanely way out of date for modern Gentoo (by ~14 years), but I keep
> an archive of the original attempt to run Gentoo on a PS2 from ~2003 here:
> http://dev.gentoo.org/~kumba/mips/ps2/gentoo-ps2/
> 
> The "ps2dev.diff.bz2" patch might be of interest, as it has the changes for the
> toolchain in it.

I now have a modern Gentoo base system with R5900 GCC 7.3.0 and Linux 4.17
running on unmodified PlayStation 2.

The FPU is emulated in software at the moment, and DMA is not yet used for
ATA disks, etc. so there is room for performance improvements. The USB and
the frame buffer are fully functional.

The frame buffer supports resolutions up to 1920x1080p* and is compatible
with HDMI adapters, in addition to various broadcast and VGA modes. The
console driver supports tiles, which are accelerated with texture maps in
Graphics Synthesizer local memory. YWRAP and various other acceleration
techniques are also implemented using hardware.

* The Graphics Synthesizer has 4 MiB of local video memory and 1920x1080p
  at 16 bits per pixel is 4147200 bytes, which leaves 47104 bytes for a
  tiled font which at 8x8 pixels and optimum 4 bits texture with palette
  is at most 1464 characters. The memory is nonlinear making packing
  graphics into it a fun exercise. ;)

Fredrik
