Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2015 20:10:28 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:50423 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009260AbbLaTHng9DKk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Dec 2015 20:07:43 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (Postfix) with ESMTPS id 597FC1EB24;
        Thu, 31 Dec 2015 19:07:42 +0000 (UTC)
Received: from redhat.com (vpn1-7-165.ams2.redhat.com [10.36.7.165])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBVJ7ZHA029812;
        Thu, 31 Dec 2015 14:07:36 -0500
Date:   Thu, 31 Dec 2015 21:07:35 +0200
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
        xen-devel@lists.xenproject.org
Subject: [PATCH v2 14/32] asm-generic: add __smp_xxx wrappers
Message-ID: <1451572003-2440-15-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50788
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

On !SMP, most architectures define their
barriers as compiler barriers.
On SMP, most need an actual barrier.

Make it possible to remove the code duplication for
!SMP by defining low-level __smp_xxx barriers
which do not depend on the value of SMP, then
use them from asm-generic conditionally.

Besides reducing code duplication, these low level APIs will also be
useful for virtualization, where a barrier is sometimes needed even if
!SMP since we might be talking to another kernel on the same SMP system.

Both virtio and Xen drivers will benefit.

The smp_xxx variants should use __smp_XXX ones or barrier() depending on
SMP, identically for all architectures.

We keep ifndef guards around them for now - once/if all
architectures are converted to use the generic
code, we'll be able to remove these.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/barrier.h | 91 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 987b2e0..8752964 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -54,22 +54,38 @@
 #define read_barrier_depends()		do { } while (0)
 #endif
 
+#ifndef __smp_mb
+#define __smp_mb()	mb()
+#endif
+
+#ifndef __smp_rmb
+#define __smp_rmb()	rmb()
+#endif
+
+#ifndef __smp_wmb
+#define __smp_wmb()	wmb()
+#endif
+
+#ifndef __smp_read_barrier_depends
+#define __smp_read_barrier_depends()	read_barrier_depends()
+#endif
+
 #ifdef CONFIG_SMP
 
 #ifndef smp_mb
-#define smp_mb()	mb()
+#define smp_mb()	__smp_mb()
 #endif
 
 #ifndef smp_rmb
-#define smp_rmb()	rmb()
+#define smp_rmb()	__smp_rmb()
 #endif
 
 #ifndef smp_wmb
-#define smp_wmb()	wmb()
+#define smp_wmb()	__smp_wmb()
 #endif
 
 #ifndef smp_read_barrier_depends
-#define smp_read_barrier_depends()	read_barrier_depends()
+#define smp_read_barrier_depends()	__smp_read_barrier_depends()
 #endif
 
 #else	/* !CONFIG_SMP */
@@ -92,23 +108,78 @@
 
 #endif	/* CONFIG_SMP */
 
+#ifndef __smp_store_mb
+#define __smp_store_mb(var, value)  do { WRITE_ONCE(var, value); __smp_mb(); } while (0)
+#endif
+
+#ifndef __smp_mb__before_atomic
+#define __smp_mb__before_atomic()	__smp_mb()
+#endif
+
+#ifndef __smp_mb__after_atomic
+#define __smp_mb__after_atomic()	__smp_mb()
+#endif
+
+#ifndef __smp_store_release
+#define __smp_store_release(p, v)					\
+do {									\
+	compiletime_assert_atomic_type(*p);				\
+	__smp_mb();							\
+	WRITE_ONCE(*p, v);						\
+} while (0)
+#endif
+
+#ifndef __smp_load_acquire
+#define __smp_load_acquire(p)						\
+({									\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	compiletime_assert_atomic_type(*p);				\
+	__smp_mb();							\
+	___p1;								\
+})
+#endif
+
+#ifdef CONFIG_SMP
+
+#ifndef smp_store_mb
+#define smp_store_mb(var, value)  __smp_store_mb(var, value)
+#endif
+
+#ifndef smp_mb__before_atomic
+#define smp_mb__before_atomic()	__smp_mb__before_atomic()
+#endif
+
+#ifndef smp_mb__after_atomic
+#define smp_mb__after_atomic()	__smp_mb__after_atomic()
+#endif
+
+#ifndef smp_store_release
+#define smp_store_release(p, v) __smp_store_release(p, v)
+#endif
+
+#ifndef smp_load_acquire
+#define smp_load_acquire(p) __smp_load_acquire(p)
+#endif
+
+#else	/* !CONFIG_SMP */
+
 #ifndef smp_store_mb
-#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); smp_mb(); } while (0)
+#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); barrier(); } while (0)
 #endif
 
 #ifndef smp_mb__before_atomic
-#define smp_mb__before_atomic()	smp_mb()
+#define smp_mb__before_atomic()	barrier()
 #endif
 
 #ifndef smp_mb__after_atomic
-#define smp_mb__after_atomic()	smp_mb()
+#define smp_mb__after_atomic()	barrier()
 #endif
 
 #ifndef smp_store_release
 #define smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	barrier();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 #endif
@@ -118,10 +189,12 @@ do {									\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	barrier();							\
 	___p1;								\
 })
 #endif
 
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
-- 
MST
