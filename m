Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2009 03:18:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42963 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493301AbZHEBRz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Aug 2009 03:17:55 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n751IMX0017154;
	Wed, 5 Aug 2009 02:18:22 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n751IL51017153;
	Wed, 5 Aug 2009 02:18:21 +0100
Date:	Wed, 5 Aug 2009 02:18:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Allow kernel use of ll/sc to be separate
	from the presence of ll/sc.
Message-ID: <20090805011820.GA16950@linux-mips.org>
References: <1247508920-29153-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1247508920-29153-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 13, 2009 at 11:15:19AM -0700, David Daney wrote:

> On some CPUs, it is more efficient to disable and enable interrupts in
> the kernel rather than use ll/sc for atomic operations.  But if we
> were to set cpu_has_llsc to false, we would break the userspace futex
> interface (in asm/futex.h).
> 
> We separate the two concepts, with a new predicate kernel_uses_llsc,
> that lets us disable the kernel's use of ll/sc while still allowing
> the futex code to use it.
> 
> Also there were a couple of cases in bitops.h where we were using
> ll/sc unconditionally even if cpu_has_llsc were false.  There are
> several places in assembly code where the configure variable
> CONFIG_CPU_HAS_LLSC is used instead of cpu_has_llsc, so we make
> cpu_has_llsc true if CONFIG_CPU_HAS_LLSC is set, for consistency.

The uses in bitops.h you mentioned were not bugs; they were wrapped in
#ifdef CONFIG_CPU_MIPSR2 and MIPS R2 implies having LL/SC.  So for sane
setups there just is no point in bothering.

As discussed on IRC - this patch adds one more use of CONFIG_CPU_HAS_LLSC
which really should die.  So I turned the remaining CONFIG_CPU_HAS_LLSC
users further upside down, removed CONFIG_CPU_HAS_LLSC and applied your
patch with the necessary adjustments on top.

Thanks!

  Ralf
