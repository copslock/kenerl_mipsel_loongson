Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 13:50:29 +0100 (BST)
Received: from pD956212F.dip.t-dialin.net ([IPv6:::ffff:217.86.33.47]:44570
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225214AbUJVMuY>; Fri, 22 Oct 2004 13:50:24 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9MCoM1u003541;
	Fri, 22 Oct 2004 14:50:22 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9MCoJ0l003539;
	Fri, 22 Oct 2004 14:50:19 +0200
Date: Fri, 22 Oct 2004 14:50:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: linux-mips@linux-mips.org, mentre@tcl.ite.mee.com
Subject: Re: Compilation fails with CONFIG_DEBUG_SPINLOCK
Message-ID: <20041022125019.GA642@linux-mips.org>
References: <20041013092057.GQ11236@enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041013092057.GQ11236@enix.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 13, 2004 at 11:20:57AM +0200, Thomas Petazzoni wrote:

> I think this is trivial to fix, but I'm not sure what is the right
> place to declare the spin lock and to initialize it.

atomic_lock is intentionally undefined.  The code using it should ever
be referenced on uni-processor systems that don't have ll/sc and on those
the spinlock code happens to not reference the spinlock_t argument not
at all.  So iow if the compiled code actually references atomic_lock,
something is smelling.  In general the reason is not having an
include/asm-mips/mach-<foo>/cpu-feature-overrides.h file.  If this is
missing the kernel will fallback to runtime detection of cpu_has_llsc
which due to the performance sensitive nature of most atomic_t users is
a bad idea.  So this error is the bomb hidden in the code to alert
users ...

  Ralf
