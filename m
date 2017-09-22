Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2017 08:45:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63253 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992366AbdIVGpezhfpc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Sep 2017 08:45:34 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A02DC87BA07FF;
        Fri, 22 Sep 2017 07:45:26 +0100 (IST)
Received: from localhost (10.20.79.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Sep
 2017 07:45:28 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 1/4] MIPS: Search main exception table for data bus errors
Date:   Thu, 21 Sep 2017 23:44:44 -0700
Message-ID: <20170922064447.28728-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170922064447.28728-1-paul.burton@imgtec.com>
References: <20170922064447.28728-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

We have 2 exception tables in MIPS kernels:

  - __ex_table which is the main exception table used in places where
    the kernel might fault accessing a user address.

  - __dbe_table which is used in various platform & driver code that
    expects that it might trigger a bus error exception.

When a data bus error exception occurs we only search __dbe_table, and
thus we have the expectation that access to user addresses will not
trigger bus errors.

Sadly, this expectation is not true - at least not since we began
mapping the GIC user page for use with the VDSO in commit a7f4df4e21dd
("MIPS: VDSO: Add implementations of gettimeofday() and
clock_gettime()"). The GIC user page provides user code with direct
access to a hardware-provided memory mapped register interface, albeit a
very simple one containing a single register. Like many register
interfaces however it has limitations - notably like the rest of the GIC
register interface it requires that accesses to it are either 32 bit or
64 bit. Any smaller accesses generate a data bus error exception. Herein
our bug lies - we have no such restrictions upon kernel access to user
memory, and users can freely cause the kernel to attempt smaller than 32
bit accesses in various ways:

  - Perform an unaligned memory access. In cases where this isn't
    handled by the CPU, such as when accessing uncached memory like the
    GIC register interface, we'll proceed to attempt to emulate the
    unaligned access via do_ade() using byte-sized loads or stores on
    MIPSr6 systems.

  - Cause the kernel to invoke __copy_from_user(), __copy_to_user() or
    one of their variants acting upon uncached memory with either a
    non-32bit-aligned address or size. Similarly this will cause the
    kernel to perform smaller than 32 bit memory accesses. Many syscalls
    will allow this to be triggered.

When the kernel attempts smaller than 32 bit access to the GIC user page
via any of these means, it generates a bus error exception. We then
check __dbe_table for a fixup, find none & call die_if_kernel() from
do_be(). Essentially we allow user code to kill the kernel, or rather to
cause the kernel to kill itself.

This patch fixes this problem rather simply by searching __ex_table for
fixups if we take a data bus error exception which has no fixup in
__dbe_table. All of the vulnerable user memory accesses should already
have entries in __ex_table, and making use of them seems reasonable.

I have marked this for stable backport as far as v4.4 which introduced
the VDSO, and provided users with access to the GIC user page in commit
a7f4df4e21dd ("MIPS: VDSO: Add implementations of gettimeofday() and
clock_gettime()"). Searching __ex_table may have made sense prior to
that, but I'm currently unaware of any other cases in which it could
cause problems.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: a7f4df4e21dd ("MIPS: VDSO: Add implementations of gettimeofday() and clock_gettime()")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable <stable@vger.kernel.org> # v4.4+
---

 arch/mips/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 5669d3b8bd38..e7190e5ae427 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -432,6 +432,8 @@ static const struct exception_table_entry *search_dbe_tables(unsigned long addr)
 			   __stop___dbe_table - __start___dbe_table, addr);
 	if (!e)
 		e = search_module_dbetables(addr);
+	if (!e)
+		e = search_exception_tables(addr);
 	return e;
 }
 
@@ -444,7 +446,6 @@ asmlinkage void do_be(struct pt_regs *regs)
 	enum ctx_state prev_state;
 
 	prev_state = exception_enter();
-	/* XXX For now.	 Fixme, this searches the wrong table ...  */
 	if (data && !user_mode(regs))
 		fixup = search_dbe_tables(exception_epc(regs));
 
-- 
2.14.1
