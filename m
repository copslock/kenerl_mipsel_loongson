Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 15:16:55 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:59296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008951AbcAJOQrYvHi8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Jan 2016 15:16:47 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (Postfix) with ESMTPS id A60FA8E224;
        Sun, 10 Jan 2016 14:16:44 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0AEGWOd017198;
        Sun, 10 Jan 2016 09:16:33 -0500
Date:   Sun, 10 Jan 2016 16:16:32 +0200
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
        xen-devel@lists.xenproject.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 01/41] lcoking/barriers, arch: Use smp barriers in
 smp_store_release()
Message-ID: <1452426622-4471-2-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50998
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

From: Davidlohr Bueso <dave@stgolabs.net>

With commit b92b8b35a2e ("locking/arch: Rename set_mb() to smp_store_mb()")
it was made clear that the context of this call (and thus set_mb)
is strictly for CPU ordering, as opposed to IO. As such all archs
should use the smp variant of mb(), respecting the semantics and
saving a mandatory barrier on UP.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <linux-arch@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: dave@stgolabs.net
Link: http://lkml.kernel.org/r/1445975631-17047-3-git-send-email-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/include/asm/barrier.h    | 2 +-
 arch/powerpc/include/asm/barrier.h | 2 +-
 arch/s390/include/asm/barrier.h    | 2 +-
 include/asm-generic/barrier.h      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/include/asm/barrier.h b/arch/ia64/include/asm/barrier.h
index df896a1..209c4b8 100644
--- a/arch/ia64/include/asm/barrier.h
+++ b/arch/ia64/include/asm/barrier.h
@@ -77,7 +77,7 @@ do {									\
 	___p1;								\
 })
 
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 
 /*
  * The group barrier in front of the rsm & ssm are necessary to ensure
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 0eca6ef..a7af5fb 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -34,7 +34,7 @@
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 
 #ifdef __SUBARCH_HAS_LWSYNC
 #    define SMPWMB      LWSYNC
diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index d68e11e..7ffd0b1 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -36,7 +36,7 @@
 #define smp_mb__before_atomic()		smp_mb()
 #define smp_mb__after_atomic()		smp_mb()
 
-#define smp_store_mb(var, value)		do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 
 #define smp_store_release(p, v)						\
 do {									\
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index b42afad..0f45f93 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -93,7 +93,7 @@
 #endif	/* CONFIG_SMP */
 
 #ifndef smp_store_mb
-#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); mb(); } while (0)
+#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); smp_mb(); } while (0)
 #endif
 
 #ifndef smp_mb__before_atomic
-- 
MST
