Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Apr 2017 16:17:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48084 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992214AbdDLOQxnqi2E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Apr 2017 16:16:53 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3CEGqrc026277;
        Wed, 12 Apr 2017 16:16:52 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3CEGql8026276;
        Wed, 12 Apr 2017 16:16:52 +0200
Date:   Wed, 12 Apr 2017 16:16:52 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Cowgill <James.Cowgill@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: avoid BUG warning in arch_check_elf
Message-ID: <20170412141652.GA24957@linux-mips.org>
References: <20170411125108.30107-1-James.Cowgill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411125108.30107-1-James.Cowgill@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57676
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

On Tue, Apr 11, 2017 at 01:51:07PM +0100, James Cowgill wrote:

> arch_check_elf contains a usage of current_cpu_data that will call
> smp_processor_id() with preemption enabled and therefore triggers a
> "BUG: using smp_processor_id() in preemptible" warning when an fpxx
> executable is loaded.
> 
> As a follow-up to commit b244614a60ab ("MIPS: Avoid a BUG warning during
> prctl(PR_SET_FP_MODE, ...)"), apply the same fix to arch_check_elf by
> using raw_current_cpu_data instead. The rationale quoted from the previous
> commit:
> 
> "It is assumed throughout the kernel that if any CPU has an FPU, then
> all CPUs would have an FPU as well, so it is safe to perform the check
> with preemption enabled - change the code to use raw_ variant of the
> check to avoid the warning."

Which really is a bug though.  Multiprocessor systems with discrete CPUs
may use a mix of CPU versions and sometimes the associated FPUs were so
broken the kernel can't use them.  On MT with MIPS_MT_FPAFF there's only a
single FPU which stays associated with CPU 0 and we try to do terribly
clever games to force floating point intensive jobs to be scheduled to CPU 0
and use emulation on all other CPUs.

  Ralf
