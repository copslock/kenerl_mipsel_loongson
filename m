Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2015 20:14:30 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:55842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014580AbbLaTJ0SDuhk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Dec 2015 20:09:26 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (Postfix) with ESMTPS id DD3929158B;
        Thu, 31 Dec 2015 19:09:24 +0000 (UTC)
Received: from redhat.com (vpn1-7-165.ams2.redhat.com [10.36.7.165])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBVJ9HDO022839;
        Thu, 31 Dec 2015 14:09:18 -0500
Date:   Thu, 31 Dec 2015 21:09:17 +0200
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
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 27/32] x86: define __smp_xxx
Message-ID: <1451572003-2440-28-git-send-email-mst@redhat.com>
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
X-archive-position: 50801
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

This defines __smp_xxx barriers for x86,
for use by virtualization.

smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/barrier.h | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index cc4c2a7..a584e1c 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -31,17 +31,10 @@
 #endif
 #define dma_wmb()	barrier()
 
-#ifdef CONFIG_SMP
-#define smp_mb()	mb()
-#define smp_rmb()	dma_rmb()
-#define smp_wmb()	barrier()
-#define smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
-#else /* !SMP */
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
-#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); barrier(); } while (0)
-#endif /* SMP */
+#define __smp_mb()	mb()
+#define __smp_rmb()	dma_rmb()
+#define __smp_wmb()	barrier()
+#define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
 
 #if defined(CONFIG_X86_PPRO_FENCE)
 
@@ -50,31 +43,31 @@
  * model and we should fall back to full barriers.
  */
 
-#define smp_store_release(p, v)						\
+#define __smp_store_release(p, v)					\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	__smp_mb();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 
-#define smp_load_acquire(p)						\
+#define __smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	__smp_mb();							\
 	___p1;								\
 })
 
 #else /* regular x86 TSO memory ordering */
 
-#define smp_store_release(p, v)						\
+#define __smp_store_release(p, v)					\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 
-#define smp_load_acquire(p)						\
+#define __smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
@@ -85,8 +78,8 @@ do {									\
 #endif
 
 /* Atomic operations are already serializing on x86 */
-#define smp_mb__before_atomic()	barrier()
-#define smp_mb__after_atomic()	barrier()
+#define __smp_mb__before_atomic()	barrier()
+#define __smp_mb__after_atomic()	barrier()
 
 #include <asm-generic/barrier.h>
 
-- 
MST
