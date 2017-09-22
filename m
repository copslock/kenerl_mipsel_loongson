Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2017 11:47:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56134 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990395AbdIVJrdcUYVK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Sep 2017 11:47:33 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v8M9lW5f003732;
        Fri, 22 Sep 2017 11:47:32 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v8M9lRUR003726;
        Fri, 22 Sep 2017 11:47:27 +0200
Date:   Fri, 22 Sep 2017 11:47:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] MIPS: Search main exception table for data bus errors
Message-ID: <20170922094727.GI4851@linux-mips.org>
References: <20170922064447.28728-1-paul.burton@imgtec.com>
 <20170922064447.28728-2-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170922064447.28728-2-paul.burton@imgtec.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60111
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

On Thu, Sep 21, 2017 at 11:44:44PM -0700, Paul Burton wrote:

> We have 2 exception tables in MIPS kernels:
> 
>   - __ex_table which is the main exception table used in places where
>     the kernel might fault accessing a user address.
> 
>   - __dbe_table which is used in various platform & driver code that
>     expects that it might trigger a bus error exception.
> 
> When a data bus error exception occurs we only search __dbe_table, and
> thus we have the expectation that access to user addresses will not
> trigger bus errors.
> 
> Sadly, this expectation is not true - at least not since we began
> mapping the GIC user page for use with the VDSO in commit a7f4df4e21dd
> ("MIPS: VDSO: Add implementations of gettimeofday() and
> clock_gettime()"). The GIC user page provides user code with direct
> access to a hardware-provided memory mapped register interface, albeit a
> very simple one containing a single register. Like many register
> interfaces however it has limitations - notably like the rest of the GIC
> register interface it requires that accesses to it are either 32 bit or
> 64 bit. Any smaller accesses generate a data bus error exception. Herein
> our bug lies - we have no such restrictions upon kernel access to user
> memory, and users can freely cause the kernel to attempt smaller than 32
> bit accesses in various ways:
> 
>   - Perform an unaligned memory access. In cases where this isn't
>     handled by the CPU, such as when accessing uncached memory like the
>     GIC register interface, we'll proceed to attempt to emulate the
>     unaligned access via do_ade() using byte-sized loads or stores on
>     MIPSr6 systems.
> 
>   - Cause the kernel to invoke __copy_from_user(), __copy_to_user() or
>     one of their variants acting upon uncached memory with either a
>     non-32bit-aligned address or size. Similarly this will cause the
>     kernel to perform smaller than 32 bit memory accesses. Many syscalls
>     will allow this to be triggered.
> 
> When the kernel attempts smaller than 32 bit access to the GIC user page
> via any of these means, it generates a bus error exception. We then
> check __dbe_table for a fixup, find none & call die_if_kernel() from
> do_be(). Essentially we allow user code to kill the kernel, or rather to
> cause the kernel to kill itself.
> 
> This patch fixes this problem rather simply by searching __ex_table for
> fixups if we take a data bus error exception which has no fixup in
> __dbe_table. All of the vulnerable user memory accesses should already
> have entries in __ex_table, and making use of them seems reasonable.
> 
> I have marked this for stable backport as far as v4.4 which introduced
> the VDSO, and provided users with access to the GIC user page in commit
> a7f4df4e21dd ("MIPS: VDSO: Add implementations of gettimeofday() and
> clock_gettime()"). Searching __ex_table may have made sense prior to
> that, but I'm currently unaware of any other cases in which it could
> cause problems.

Unfortunately the DBE exception is imprecise.  The EPC might actually point
to the far end of the kernel and have no useful relation at all to the
instruction triggering it.

As a consequence a false fixup might be used resulting in very silly and
probably bad things happening.

So this needs a different solution.

  Ralf
