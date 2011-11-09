Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 14:11:58 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41208 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903565Ab1KINLw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 14:11:52 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9DBna3010990;
        Wed, 9 Nov 2011 13:11:49 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9DBlpX010975;
        Wed, 9 Nov 2011 13:11:47 GMT
Date:   Wed, 9 Nov 2011 13:11:47 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     "Kevin D. Kissell" <kevink@paralogos.com>,
        linux-mips@linux-mips.org,
        Maksim Rayskiy <maksim.rayskiy@gmail.com>,
        Sergey Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH RESEND 1/9] MIPS: Add local_flush_tlb_all_mm to clear all
 mm contexts on calling cpu
Message-ID: <20111109131147.GB1586@linux-mips.org>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
 <20111108164711.GA13937@linux-mips.org>
 <CAJiQ=7B0Kcd4FnCtFedHqj_69U7Rt2fw4hwmx5WCh5sZZBXSow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJiQ=7B0Kcd4FnCtFedHqj_69U7Rt2fw4hwmx5WCh5sZZBXSow@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7713

On Tue, Nov 08, 2011 at 09:33:52PM -0800, Kevin Cernekee wrote:

> I read through mmu_context.h and the threads from November/December
> 2010 a couple of times, and I'm starting to think Maksim's original
> approach (don't reset asid_cache(cpu) when warm-restarting a CPU)
> makes the most sense.
> 
> The basic issue is that we want to assign unique, strictly increasing
> values to each mm's cpu_context(cpu, mm).  The per-cpu counter starts
> at ASID_FIRST_VERSION (0x100 on R4K), and counts up.  Assigning a new
> mm the same ASID value as an existing mm on the same CPU is illegal.
> Two obvious ways to meet this requirement when hotplugging CPUs are:
> 
> Option #1: Retain the asid_cache(cpu) value across warm restarts.
> This is simple and inexpensive.  We pick up where we left off, and
> whatever existing cpu_context(cpu, mm) values are out there do not
> cause any trouble.
> 
> I believe Maksim's original logic (assign ASID_FIRST_VERSION, a
> nonzero number, if asid_cache(cpu) == 0) would work correctly as
> written, because cpu_data is an array in .bss .  It will be 0 until
> the CPU is booted, and get_new_mmu_context() ensures that it will
> never be 0 again after that.
> 
> Kevin K brought up the idea of a warm restart bitmask so the code
> could tell whether asid_cache(cpu) was valid.  I'm not sure that this
> would be required.

Neither do I.

> I think we can also get away with not explicitly preserving EntryHi,
> since switch_mm() and activate_mm() will set it anyway.
> 
> Option #2: When warm restarting a CPU, set asid_cache(cpu) to
> ASID_FIRST_VERSION again.  And at some point (cpu_up or cpu_down),
> iterate through all processes to set cpu_context(cpu, mm) to something
> that will not conflict with a newly assigned ASID.  This is what the
> most recent patch did.  It gets the job done, but it's more work than
> what is really needed.
> 
> Please let me know your thoughts...

I still like the original patch https://patchwork.linux-mips.org/patch/1797/
I'd apply it right away but I'm going to hold off for a day just to give
Kevin and maybe others a chance to comment.

  Ralf
