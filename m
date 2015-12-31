Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2015 20:09:26 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:36540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014252AbbLaTHYhqk-k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Dec 2015 20:07:24 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id 9E4C1C0B932D;
        Thu, 31 Dec 2015 19:07:18 +0000 (UTC)
Received: from redhat.com (vpn1-7-165.ams2.redhat.com [10.36.7.165])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBVJ7B8c004310;
        Thu, 31 Dec 2015 14:07:11 -0500
Date:   Thu, 31 Dec 2015 21:07:10 +0200
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
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 11/32] mips: reuse asm-generic/barrier.h
Message-ID: <1451572003-2440-12-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50785
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

On mips dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
the asm-generic variants exactly. Drop the local definitions and pull in
asm-generic/barrier.h instead.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/barrier.h | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 752e0b8..3eac4b9 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -10,9 +10,6 @@
 
 #include <asm/addrspace.h>
 
-#define read_barrier_depends()		do { } while(0)
-#define smp_read_barrier_depends()	do { } while(0)
-
 #ifdef CONFIG_CPU_HAS_SYNC
 #define __sync()				\
 	__asm__ __volatile__(			\
@@ -87,8 +84,6 @@
 
 #define wmb()		fast_wmb()
 #define rmb()		fast_rmb()
-#define dma_wmb()	fast_wmb()
-#define dma_rmb()	fast_rmb()
 
 #if defined(CONFIG_WEAK_ORDERING) && defined(CONFIG_SMP)
 # ifdef CONFIG_CPU_CAVIUM_OCTEON
@@ -112,9 +107,6 @@
 #define __WEAK_LLSC_MB		"		\n"
 #endif
 
-#define smp_store_mb(var, value) \
-	do { WRITE_ONCE(var, value); smp_mb(); } while (0)
-
 #define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
@@ -129,22 +121,9 @@
 #define nudge_writes() mb()
 #endif
 
-#define smp_store_release(p, v)						\
-do {									\
-	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
-	WRITE_ONCE(*p, v);						\
-} while (0)
-
-#define smp_load_acquire(p)						\
-({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
-	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
-	___p1;								\
-})
-
 #define smp_mb__before_atomic()	smp_mb__before_llsc()
 #define smp_mb__after_atomic()	smp_llsc_mb()
 
+#include <asm-generic/barrier.h>
+
 #endif /* __ASM_BARRIER_H */
-- 
MST
