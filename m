Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 17:50:22 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57672 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492630AbZIXPuP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Sep 2009 17:50:15 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8OFpU2A013512;
	Thu, 24 Sep 2009 16:51:30 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8OFpTZX013510;
	Thu, 24 Sep 2009 16:51:29 +0100
Date:	Thu, 24 Sep 2009 16:51:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Randy MacLeod <rwmacleod@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS: [raw_]smp_processor_id uses current_thread_info
Message-ID: <20090924155129.GA11576@linux-mips.org>
References: <21f828e90909231127h70f69047v91b9261226681d53@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f828e90909231127h70f69047v91b9261226681d53@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 23, 2009 at 02:27:26PM -0400, Randy MacLeod wrote:

> I'd like advice on changing the implementation of smp_processor_id on
> Cavium specifically and/or MIPS generally.
> 
> Currently we have: arch/mips/include/asm/smp.h
> #define raw_smp_processor_id() (current_thread_info()->cpu)
> 
> A co-worker has an issue where the current thread pointer is corrupted
> on a Cavium MIPS system running 2.6.14 (but the same code exists in 2.6.31).
> During the resulting panic() the kernel calls smp_processor_id()
> which dereferences the corrupt task pointer again - ouch. I've notice that
> other arches have raw_smp_processor_id() defined to
>  - a platform specific register read, or
>  - a percpu variable or
>  - have a hard_smp_processor_id() defined
> This last one is presumably for times when you don't trust the kernel
> data structures to be
> sane.

Dereferencing current_thread_info()->cpu is fairly likely to hit in the cache
so probably a single cycle operation.  raw_smp_processor_id() is also a
very common operation so you really don't want to change it to something
slower except for a debugging kernel.

If you have a good kernel stack pointer you can compute the thread pointer
from that:

	ori     $28, sp, _THREAD_MASK
	xori    $28, _THREAD_MASK

> I can create a patch that calls cvmx_get_core_num(); for cavium.
> Is there a more generic way to get the cpu number on MIPS?

raw_smp_processor_id() returns the processor ID as counted by Linux.  That
number does not necessarily match the firmware's numbering.

  Ralf
