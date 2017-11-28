Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 11:44:00 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992211AbdK1KnxWCE-- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 11:43:53 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B6ACA73;
        Tue, 28 Nov 2017 10:43:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Deng-Cheng Zhu <dengcheng.zhu@mips.com>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 023/193] MIPS: cmpxchg64() and HAVE_VIRT_CPU_ACCOUNTING_GEN dont work for 32-bit SMP
Date:   Tue, 28 Nov 2017 11:24:30 +0100
Message-Id: <20171128100614.611270137@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171128100613.638270407@linuxfoundation.org>
References: <20171128100613.638270407@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

commit a3f143106596d739e7fbc4b84c96b1475247d876 upstream.

__cmpxchg64_local_generic() is atomic only w.r.t tasks and interrupts
on the same CPU (that's what the 'local' means).  We can't use it to
implement cmpxchg64() in SMP configurations.

So, for 32-bit SMP configurations:

- Don't define cmpxchg64()
- Don't enable HAVE_VIRT_CPU_ACCOUNTING_GEN, which requires it

Fixes: e2093c7b03c1 ("MIPS: Fall back to generic implementation of ...")
Fixes: bb877e96bea1 ("MIPS: Add support for full dynticks CPU time accounting")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Deng-Cheng Zhu <dengcheng.zhu@mips.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17413/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig               |    2 +-
 arch/mips/include/asm/cmpxchg.h |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -65,7 +65,7 @@ config MIPS
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select MODULES_USE_ELF_REL if MODULES
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -204,8 +204,10 @@ static inline unsigned long __cmpxchg(vo
 #else
 #include <asm-generic/cmpxchg-local.h>
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#ifndef CONFIG_SMP
 #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
 #endif
+#endif
 
 #undef __scbeqz
 
