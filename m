Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2015 20:14:50 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:49358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014271AbbLaTJdpl-ok (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Dec 2015 20:09:33 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id 5A1C9C00330E;
        Thu, 31 Dec 2015 19:09:32 +0000 (UTC)
Received: from redhat.com (vpn1-7-165.ams2.redhat.com [10.36.7.165])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBVJ9Pef004771;
        Thu, 31 Dec 2015 14:09:26 -0500
Date:   Thu, 31 Dec 2015 21:09:24 +0200
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
        xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 28/32] asm-generic: implement virt_xxx memory barriers
Message-ID: <1451572003-2440-29-git-send-email-mst@redhat.com>
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
X-archive-position: 50802
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

Guests running within virtual machines might be affected by SMP effects even if
the guest itself is compiled without SMP support.  This is an artifact of
interfacing with an SMP host while running an UP kernel.  Using mandatory
barriers for this use-case would be possible but is often suboptimal.

In particular, virtio uses a bunch of confusing ifdefs to work around
this, while xen just uses the mandatory barriers.

To better handle this case, low-level virt_mb() etc macros are made available.
These are implemented trivially using the low-level __smp_xxx macros,
the purpose of these wrappers is to annotate those specific cases.

These have the same effect as smp_mb() etc when SMP is enabled, but generate
identical code for SMP and non-SMP systems. For example, virtual machine guests
should use virt_mb() rather than smp_mb() when synchronizing against a
(possibly SMP) host.

Suggested-by: David Miller <davem@davemloft.net>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/asm-generic/barrier.h     | 11 +++++++++++
 Documentation/memory-barriers.txt | 28 +++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 8752964..1cceca14 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -196,5 +196,16 @@ do {									\
 
 #endif
 
+/* Barriers for virtual machine guests when talking to an SMP host */
+#define virt_mb() __smp_mb()
+#define virt_rmb() __smp_rmb()
+#define virt_wmb() __smp_wmb()
+#define virt_read_barrier_depends() __smp_read_barrier_depends()
+#define virt_store_mb(var, value) __smp_store_mb(var, value)
+#define virt_mb__before_atomic() __smp_mb__before_atomic()
+#define virt_mb__after_atomic()	__smp_mb__after_atomic()
+#define virt_store_release(p, v) __smp_store_release(p, v)
+#define virt_load_acquire(p) __smp_load_acquire(p)
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index aef9487..8f4a93a 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1655,17 +1655,18 @@ macro is a good place to start looking.
 SMP memory barriers are reduced to compiler barriers on uniprocessor compiled
 systems because it is assumed that a CPU will appear to be self-consistent,
 and will order overlapping accesses correctly with respect to itself.
+However, see the subsection on "Virtual Machine Guests" below.
 
 [!] Note that SMP memory barriers _must_ be used to control the ordering of
 references to shared memory on SMP systems, though the use of locking instead
 is sufficient.
 
 Mandatory barriers should not be used to control SMP effects, since mandatory
-barriers unnecessarily impose overhead on UP systems. They may, however, be
-used to control MMIO effects on accesses through relaxed memory I/O windows.
-These are required even on non-SMP systems as they affect the order in which
-memory operations appear to a device by prohibiting both the compiler and the
-CPU from reordering them.
+barriers impose unnecessary overhead on both SMP and UP systems. They may,
+however, be used to control MMIO effects on accesses through relaxed memory I/O
+windows.  These barriers are required even on non-SMP systems as they affect
+the order in which memory operations appear to a device by prohibiting both the
+compiler and the CPU from reordering them.
 
 
 There are some more advanced barrier functions:
@@ -2948,6 +2949,23 @@ The Alpha defines the Linux kernel's memory barrier model.
 
 See the subsection on "Cache Coherency" above.
 
+VIRTUAL MACHINE GUESTS
+-------------------
+
+Guests running within virtual machines might be affected by SMP effects even if
+the guest itself is compiled without SMP support.  This is an artifact of
+interfacing with an SMP host while running an UP kernel.  Using mandatory
+barriers for this use-case would be possible but is often suboptimal.
+
+To handle this case optimally, low-level virt_mb() etc macros are available.
+These have the same effect as smp_mb() etc when SMP is enabled, but generate
+identical code for SMP and non-SMP systems. For example, virtual machine guests
+should use virt_mb() rather than smp_mb() when synchronizing against a
+(possibly SMP) host.
+
+These are equivalent to smp_mb() etc counterparts in all other respects,
+in particular, they do not control MMIO effects: to control
+MMIO effects, use mandatory barriers.
 
 ============
 EXAMPLE USES
-- 
MST
