Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2015 20:08:28 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:46273 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013900AbbLaTGzlPpSk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Dec 2015 20:06:55 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (Postfix) with ESMTPS id 750B842E5D8;
        Thu, 31 Dec 2015 19:06:54 +0000 (UTC)
Received: from redhat.com (vpn1-7-165.ams2.redhat.com [10.36.7.165])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBVJ6kNh029643;
        Thu, 31 Dec 2015 14:06:47 -0500
Date:   Thu, 31 Dec 2015 21:06:46 +0200
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
        xen-devel@lists.xenproject.org,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 08/32] arm: reuse asm-generic/barrier.h
Message-ID: <1451572003-2440-9-git-send-email-mst@redhat.com>
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
X-archive-position: 50782
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

On arm smp_store_mb, read_barrier_depends, smp_read_barrier_depends,
smp_store_release, smp_load_acquire, smp_mb__before_atomic and
smp_mb__after_atomic match the asm-generic variants exactly. Drop the
local definitions and pull in asm-generic/barrier.h instead.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/barrier.h | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 3ff5642..31152e8 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -70,28 +70,7 @@ extern void arm_heavy_mb(void);
 #define smp_wmb()	dmb(ishst)
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
-#define read_barrier_depends()		do { } while(0)
-#define smp_read_barrier_depends()	do { } while(0)
-
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); smp_mb(); } while (0)
-
-#define smp_mb__before_atomic()	smp_mb()
-#define smp_mb__after_atomic()	smp_mb()
+#include <asm-generic/barrier.h>
 
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_BARRIER_H */
-- 
MST
