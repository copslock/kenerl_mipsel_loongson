Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 15:23:10 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:37943 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009374AbcAJOTXD33Q8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Jan 2016 15:19:23 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (Postfix) with ESMTPS id DE9958DFF5;
        Sun, 10 Jan 2016 14:19:18 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0AEJAIc030920;
        Sun, 10 Jan 2016 09:19:11 -0500
Date:   Sun, 10 Jan 2016 16:19:10 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v3 19/41] ia64: define __smp_xxx
Message-ID: <1452426622-4471-20-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51016
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

This defines __smp_xxx barriers for ia64,
for use by virtualization.

smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

This reduces the amount of arch-specific boiler-plate code.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Tony Luck <tony.luck@intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/asm/barrier.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/include/asm/barrier.h b/arch/ia64/include/asm/barrier.h
index 2f93348..588f161 100644
--- a/arch/ia64/include/asm/barrier.h
+++ b/arch/ia64/include/asm/barrier.h
@@ -42,28 +42,24 @@
 #define dma_rmb()	mb()
 #define dma_wmb()	mb()
 
-#ifdef CONFIG_SMP
-# define smp_mb()	mb()
-#else
-# define smp_mb()	barrier()
-#endif
+# define __smp_mb()	mb()
 
-#define smp_mb__before_atomic()	barrier()
-#define smp_mb__after_atomic()	barrier()
+#define __smp_mb__before_atomic()	barrier()
+#define __smp_mb__after_atomic()	barrier()
 
 /*
  * IA64 GCC turns volatile stores into st.rel and volatile loads into ld.acq no
  * need for asm trickery!
  */
 
-#define smp_store_release(p, v)						\
+#define __smp_store_release(p, v)						\
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
-- 
MST
