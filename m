Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2015 20:08:08 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:56383 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013998AbbLaTGsrnoak (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Dec 2015 20:06:48 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (Postfix) with ESMTPS id EDD908F505;
        Thu, 31 Dec 2015 19:06:45 +0000 (UTC)
Received: from redhat.com (vpn1-7-165.ams2.redhat.com [10.36.7.165])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBVJ6cts022341;
        Thu, 31 Dec 2015 14:06:39 -0500
Date:   Thu, 31 Dec 2015 21:06:38 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 07/32] sparc: reuse asm-generic/barrier.h
Message-ID: <1451572003-2440-8-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

On sparc 64 bit dma_rmb, dma_wmb, smp_store_mb, smp_mb, smp_rmb,
smp_wmb, read_barrier_depends and smp_read_barrier_depends match the
asm-generic variants exactly. Drop the local definitions and pull in
asm-generic/barrier.h instead.

nop uses __asm__ __volatile but is otherwise identical to
the generic version, drop that as well.

This is in preparation to refactoring this code area.

Note: nop() was in processor.h and not in barrier.h as on other
architectures. Nothing seems to depend on it being there though.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/include/asm/barrier_32.h |  1 -
 arch/sparc/include/asm/barrier_64.h | 21 ++-------------------
 arch/sparc/include/asm/processor.h  |  3 ---
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/include/asm/barrier_32.h b/arch/sparc/include/asm/barrier_32.h
index ae69eda..8059130 100644
--- a/arch/sparc/include/asm/barrier_32.h
+++ b/arch/sparc/include/asm/barrier_32.h
@@ -1,7 +1,6 @@
 #ifndef __SPARC_BARRIER_H
 #define __SPARC_BARRIER_H
 
-#include <asm/processor.h> /* for nop() */
 #include <asm-generic/barrier.h>
 
 #endif /* !(__SPARC_BARRIER_H) */
diff --git a/arch/sparc/include/asm/barrier_64.h b/arch/sparc/include/asm/barrier_64.h
index 14a9286..26c3f72 100644
--- a/arch/sparc/include/asm/barrier_64.h
+++ b/arch/sparc/include/asm/barrier_64.h
@@ -37,25 +37,6 @@ do {	__asm__ __volatile__("ba,pt	%%xcc, 1f\n\t" \
 #define rmb()	__asm__ __volatile__("":::"memory")
 #define wmb()	__asm__ __volatile__("":::"memory")
 
-#define dma_rmb()	rmb()
-#define dma_wmb()	wmb()
-
-#define smp_store_mb(__var, __value) \
-	do { WRITE_ONCE(__var, __value); membar_safe("#StoreLoad"); } while(0)
-
-#ifdef CONFIG_SMP
-#define smp_mb()	mb()
-#define smp_rmb()	rmb()
-#define smp_wmb()	wmb()
-#else
-#define smp_mb()	__asm__ __volatile__("":::"memory")
-#define smp_rmb()	__asm__ __volatile__("":::"memory")
-#define smp_wmb()	__asm__ __volatile__("":::"memory")
-#endif
-
-#define read_barrier_depends()		do { } while (0)
-#define smp_read_barrier_depends()	do { } while (0)
-
 #define smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
@@ -74,4 +55,6 @@ do {									\
 #define smp_mb__before_atomic()	barrier()
 #define smp_mb__after_atomic()	barrier()
 
+#include <asm-generic/barrier.h>
+
 #endif /* !(__SPARC64_BARRIER_H) */
diff --git a/arch/sparc/include/asm/processor.h b/arch/sparc/include/asm/processor.h
index 2fe99e6..9da9646 100644
--- a/arch/sparc/include/asm/processor.h
+++ b/arch/sparc/include/asm/processor.h
@@ -5,7 +5,4 @@
 #else
 #include <asm/processor_32.h>
 #endif
-
-#define nop() 		__asm__ __volatile__ ("nop")
-
 #endif
-- 
MST
