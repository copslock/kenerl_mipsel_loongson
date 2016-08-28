Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Aug 2016 14:01:46 +0200 (CEST)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:47530 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992093AbcH1MBiPZPbD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Aug 2016 14:01:38 +0200
Received: from resomta-ch2-09v.sys.comcast.net ([69.252.207.105])
        by resqmta-ch2-10v.sys.comcast.net with SMTP
        id dymIbtN3xRingdymIbZ0nM; Sun, 28 Aug 2016 12:01:30 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-09v.sys.comcast.net with SMTP
        id dymGbJVV5m47VdymHbHXh0; Sun, 28 Aug 2016 12:01:30 +0000
To:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: SGI Octane && Bridge DMA bug
Message-ID: <034a1d88-bdf2-8724-6e04-5ae0ba3aef62@gentoo.org>
Date:   Sun, 28 Aug 2016 08:01:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDT//rXWUzZoAMJLczvdnUC2VH0m+cVIrLmS0hmiekZecOM6DO7pgJtLx5rJjS+PJQNFOGd5eO0xBC+3v14Hw1NIsqFZVpXJqIyEfBF4YjgprXOMTRWb
 KhDX6HrGMK4aiqYJSDtHcoK9EcGkXl38uImk7H1zMY5/qVSCjI2ctfB2
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

Trying to tackle the bug on SGI Octane systems where the machine misbehaves if
the amount of installed RAM is >2GB.  Reading some hints from the OpenBSD
xbridge.c driver, it seems Octane's (and maybe IP27's?) Bridge IOMMU is weird
in that, it cannot translate DMA addresses that go over 0x7fffffff (1ULL <<
31).  Which is complicated by the fact that Octane's physical memory is offset
by 512MB, so I think the real DMA limits need to be 0x20000000 to 0x9fffffff.

Been messing around in the dma-coherence.h header for Octane, and so far, with
4GB of RAM installed, it gets all the way down to bringing up the MD raid
stuff, then throws an instruction bus error for address 0xffffffffa0013ea0.  I
can't make a determination if that's a DMA address or something else.  It's
sign-extended, so it's not any valid 64-bit address (including Crosstalk or
something attached to HEART).  It's very consistent, though, as it's in the EPC
register after each crash.

The problem with Linux's DMA code is it is basically rigged to handle DMA for
PCI devices.  This includes the MIPS-specific DMA stuff.  The Impact video
board in an Octane is not a PCI device, but rather a pure Crosstalk device, and
it has no issues with DMA (as far as I know).  So I need to find a way to limit
DMA addresses for the Bridge driver only, but not mangle Impact DMA addresses.

Ideas?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
