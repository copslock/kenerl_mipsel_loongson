Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Aug 2016 18:59:12 +0200 (CEST)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:41057 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992093AbcH1Q7FkpOAF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Aug 2016 18:59:05 +0200
Received: from resomta-ch2-14v.sys.comcast.net ([69.252.207.110])
        by resqmta-ch2-09v.sys.comcast.net with SMTP
        id e3Q1bLol41XXBe3QAbTHMd; Sun, 28 Aug 2016 16:58:58 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-14v.sys.comcast.net with SMTP
        id e3Q9biqplWW8pe3Q9botMh; Sun, 28 Aug 2016 16:58:58 +0000
Subject: Re: SGI Octane && Bridge DMA bug
To:     linux-mips@linux-mips.org
References: <034a1d88-bdf2-8724-6e04-5ae0ba3aef62@gentoo.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <21a02eff-9bd0-c3b9-9845-21b302b8d5ca@gentoo.org>
Date:   Sun, 28 Aug 2016 12:58:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <034a1d88-bdf2-8724-6e04-5ae0ba3aef62@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE4X5eq3tPGTD2Whrz6rsl89NTC5P80jbXy5jqvRzjc3deyLwaqUw07GwVz/cPA154XsvbXzqJPCAE3yyOzGttQ8gfoCin5luIWs96pnHQjaICsaaMvj
 6pxM1Knak9SgqGn9gs8JvUcH/tzsHXGi/hdNoq07dJMOJUQE0XwxZSGj
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54825
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

On 08/28/2016 08:01, Joshua Kinard wrote:
> Trying to tackle the bug on SGI Octane systems where the machine misbehaves if
> the amount of installed RAM is >2GB.  Reading some hints from the OpenBSD
> xbridge.c driver, it seems Octane's (and maybe IP27's?) Bridge IOMMU is weird
> in that, it cannot translate DMA addresses that go over 0x7fffffff (1ULL <<
> 31).  Which is complicated by the fact that Octane's physical memory is offset
> by 512MB, so I think the real DMA limits need to be 0x20000000 to 0x9fffffff.
> 
> Been messing around in the dma-coherence.h header for Octane, and so far, with
> 4GB of RAM installed, it gets all the way down to bringing up the MD raid
> stuff, then throws an instruction bus error for address 0xffffffffa0013ea0.  I
> can't make a determination if that's a DMA address or something else.  It's
> sign-extended, so it's not any valid 64-bit address (including Crosstalk or
> something attached to HEART).  It's very consistent, though, as it's in the EPC
> register after each crash.
> 
> The problem with Linux's DMA code is it is basically rigged to handle DMA for
> PCI devices.  This includes the MIPS-specific DMA stuff.  The Impact video
> board in an Octane is not a PCI device, but rather a pure Crosstalk device, and
> it has no issues with DMA (as far as I know).  So I need to find a way to limit
> DMA addresses for the Bridge driver only, but not mangle Impact DMA addresses.
> 
> Ideas?

I think the 0xffffffffa0013ea0 address I keep hitting from multiple, unrelated
*alloc*() functions is, by virtue of being in CKSEG1 space, an exception
handler.  Or was.  Seems like those are getting blown away somehow when
something triggers an Oops -- seems the disk layer (MD, XFS, or qla1280), doing
a DMA function and probably (though not confirmed) running into that Bridge
issue of limited DMA addressing.

Cause it seems that when the Oops happens, the MIPS trap code dumps the stack
and registers, but when it goes to print the code trace, that trips up an
instruction bus error on 0xffffffffa0013ea0, followed by one or more data bus
errors.

Seems to be the only explanation that I can think of.  Is it likely I'll have
to write Octane-specific DMA alloc functions instead of the default-dma.c
versions?  It seems dma-coherence.h is for dealing with addresses that have
already been allocated, when I think I'll have to intercept the DMA calls and
make sure nothing over 0x7fffffff in physmem for Bridge gets allocated.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
