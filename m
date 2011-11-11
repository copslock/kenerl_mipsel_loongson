Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 18:20:44 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59754 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903984Ab1KKRUl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 18:20:41 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pABHKd11005608;
        Fri, 11 Nov 2011 17:20:39 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pABHKdvJ005606;
        Fri, 11 Nov 2011 17:20:39 GMT
Date:   Fri, 11 Nov 2011 17:20:39 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2 3/8] MIPS: BMIPS: Add CFLAGS, Makefile entries for
 BMIPS
Message-ID: <20111111172039.GA5200@linux-mips.org>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
 <f130d5d9c038f61fa3176b971526cd5f@localhost>
 <20111111125832.GE28303@linux-mips.org>
 <CAJiQ=7B=BkptJ9YGkEKpA9uXU1ydaGZeQTUrEd=E0Y_QR8_Z1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJiQ=7B=BkptJ9YGkEKpA9uXU1ydaGZeQTUrEd=E0Y_QR8_Z1g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10471

On Fri, Nov 11, 2011 at 08:57:39AM -0800, Kevin Cernekee wrote:

> At a high level, the CONFIG_CPU_BMIPS* settings are used to make
> compile-time decisions that differentiate BMIPS from standard MIPS32,
> and that differentiate the BMIPS CPUs from one another.
> 
> 
> Present and future uses include:
> 
> Figuring out which set of proprietary BMIPS CP0 registers / core
> registers to use, where they are located, bit fields, etc.
> 
> Per-BMIPS SMP operations and capabilities
> 
> Per-BMIPS performance counter access
> 
> cpu-feature-overrides.h
> 
> HIGHMEM, SMP, and other basic features
> 
> eDSP instruction set (different on each BMIPS, and BMIPS-specific)
> 
> Cache architecture and BMIPS-specific cache optimizations
> 
> 
> Some of these could potentially be replaced with a "switch
> (current_cpu_type())" but others are a little trickier (i.e. they show
> up in low-level PM resume code, exception vectors, or other sensitive
> places).
> 
> 
> It is true that BMIPS uses -mips32 for compilation.  If the criteria
> for adding a new CONFIG_CPU_* choice is whether it selects a new
> instruction set or compilation flags, do you think it makes sense to
> remove BMIPS* from the "CPU selection" menu, enable
> CONFIG_CPU_MIPS32_R1 for BMIPS platforms, and call our options
> something different?  e.g.
> 
> CONFIG_BMIPS
> CONFIG_BMIPS3300
> CONFIG_BMIPS4350
> CONFIG_BMIPS4380
> CONFIG_BMIPS5000

Fair enough; sorting that kind of thing will need some effort across
the tree at some point in the future.

I notice there seems to be only CPU core support; are you planning
to submit board support code as well?

  Ralf
