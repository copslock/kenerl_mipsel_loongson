Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 18:25:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53247 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006688AbbEVQZP4P4Em (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 May 2015 18:25:15 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4MGPGZq007745;
        Fri, 22 May 2015 18:25:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4MGPFwQ007744;
        Fri, 22 May 2015 18:25:15 +0200
Date:   Fri, 22 May 2015 18:25:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP, Almost there?
Message-ID: <20150522162515.GA6467@linux-mips.org>
References: <55597B21.4010704@gentoo.org>
 <5559D483.905@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5559D483.905@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47569
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

On Mon, May 18, 2015 at 08:01:07AM -0400, Joshua Kinard wrote:

> What is the relationship between the cache-coherency algorithm and SMP?  IP30
> hardware is supposed to be cache-coherent.  A value of '5' sets the processors
> to "cacheable coherent exclusive on write" (per the R10K manual).  But I am not
> sure why things are still flakey.
> 
> --J

For a cache coherent platform with the R10000 you must use CCA 5 for all
RAM access or all hell will break loose.

For a 32 bit kernel this means the CCA bits of c0_config need to be set
to CCA 5.  64 bit kernels such as those on IP30 are running XKPHYS, not
CSEG0 but still need to use CCA 5.  That means the address bits that
select the CCA need to be set to 5.  Which means kernel addresses will
start with 0xa8.

The same holds true for TLB mappings, they also need to use mode 5.

Also, all accesses to a particular page of physical memory need to use the
same CCA.  Mixing modes is undefined and will in all likelyhood set above
mention hell loose.

All SMP systems need to be coherent between their CPUs.  Traditionally
only SMP MIPS systems are coherent will systems that do not support
multiple processors are non-coherent.  Those may use CCA 3 but again
mixing is not permitted.

Finally there's CCA 2 which is uncached.  That is only sensible for
I/O purposes, data structures such rings as ethernet drivers, gfx bitmaps.
Yet again multiple access modes is not permitted.

The kernel's cca command line option is a bit of a hack meant for hardware
testing and debug.  For a 64 bit kernel these lines in <asm/mach-generic/-
spaces.h> select the suitable base address in XKPHYS:

#ifndef CAC_BASE
#ifdef CONFIG_DMA_NONCOHERENT
#define CAC_BASE                _AC(0x9800000000000000, UL)
#else
#define CAC_BASE                _AC(0xa800000000000000, UL)
#endif
#endif

So you simply need to not select DMA_NONCOHERENT for IP30 and the right
value of 0xa800000000000000 will be used for the kernel base address.

Btw, don't tinker with the CCA bits in c0_config; the firmware will have
configured that correctly for your platform.  The kernel reads that
value and uses it for the CCA field for any TLB mappings.

  Ralf
