Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2015 20:15:06 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:36820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014252AbbLaTJnjdFNk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Dec 2015 20:09:43 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id 9176DC0B932D;
        Thu, 31 Dec 2015 19:09:39 +0000 (UTC)
Received: from redhat.com (vpn1-7-165.ams2.redhat.com [10.36.7.165])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBVJ9WhU004808;
        Thu, 31 Dec 2015 14:09:33 -0500
Date:   Thu, 31 Dec 2015 21:09:32 +0200
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
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH v2 29/32] Revert "virtio_ring: Update weak barriers to use
 dma_wmb/rmb"
Message-ID: <1451572003-2440-30-git-send-email-mst@redhat.com>
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
X-archive-position: 50803
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

This reverts commit 9e1a27ea42691429e31f158cce6fc61bc79bb2e9.

While that commit optimizes !CONFIG_SMP, it mixes
up DMA and SMP concepts, making the code hard
to figure out.

A better way to optimize this is with the new __smp_XXX
barriers.

As a first step, go back to full rmb/wmb barriers
for !SMP.
We switch to __smp_XXX barriers in the next patch.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 8e50888..67e06fe 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -21,20 +21,19 @@
  * actually quite cheap.
  */
 
+#ifdef CONFIG_SMP
 static inline void virtio_mb(bool weak_barriers)
 {
-#ifdef CONFIG_SMP
 	if (weak_barriers)
 		smp_mb();
 	else
-#endif
 		mb();
 }
 
 static inline void virtio_rmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		dma_rmb();
+		smp_rmb();
 	else
 		rmb();
 }
@@ -42,10 +41,26 @@ static inline void virtio_rmb(bool weak_barriers)
 static inline void virtio_wmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		dma_wmb();
+		smp_wmb();
 	else
 		wmb();
 }
+#else
+static inline void virtio_mb(bool weak_barriers)
+{
+	mb();
+}
+
+static inline void virtio_rmb(bool weak_barriers)
+{
+	rmb();
+}
+
+static inline void virtio_wmb(bool weak_barriers)
+{
+	wmb();
+}
+#endif
 
 struct virtio_device;
 struct virtqueue;
-- 
MST
