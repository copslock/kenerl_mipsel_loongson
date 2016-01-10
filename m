Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 15:28:09 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010444AbcAJOVTn7kr8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Jan 2016 15:21:19 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (Postfix) with ESMTPS id 56BC07D;
        Sun, 10 Jan 2016 14:21:15 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0AEL8YI019556;
        Sun, 10 Jan 2016 09:21:08 -0500
Date:   Sun, 10 Jan 2016 16:21:07 +0200
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
        xen-devel@lists.xenproject.org
Subject: [PATCH v3 33/41] virtio_ring: use virt_store_mb
Message-ID: <1452426622-4471-34-git-send-email-mst@redhat.com>
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
X-archive-position: 51030
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

We need a full barrier after writing out event index, using
virt_store_mb there seems better than open-coding.  As usual, we need a
wrapper to account for strong barriers.

It's tempting to use this in vhost as well, for that, we'll
need a variant of smp_store_mb that works on __user pointers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h  | 11 +++++++++++
 drivers/virtio/virtio_ring.c | 15 +++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index f3fa55b..a156e2b 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -45,6 +45,17 @@ static inline void virtio_wmb(bool weak_barriers)
 		wmb();
 }
 
+static inline void virtio_store_mb(bool weak_barriers,
+				   __virtio16 *p, __virtio16 v)
+{
+	if (weak_barriers) {
+		virt_store_mb(*p, v);
+	} else {
+		WRITE_ONCE(*p, v);
+		mb();
+	}
+}
+
 struct virtio_device;
 struct virtqueue;
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ee663c4..e12e385 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -517,10 +517,10 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
-	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
-		vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, vq->last_used_idx);
-		virtio_mb(vq->weak_barriers);
-	}
+	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
+		virtio_store_mb(vq->weak_barriers,
+				&vring_used_event(&vq->vring),
+				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
 
 #ifdef DEBUG
 	vq->last_add_time_valid = false;
@@ -653,8 +653,11 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	}
 	/* TODO: tune this threshold */
 	bufs = (u16)(vq->avail_idx_shadow - vq->last_used_idx) * 3 / 4;
-	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs);
-	virtio_mb(vq->weak_barriers);
+
+	virtio_store_mb(vq->weak_barriers,
+			&vring_used_event(&vq->vring),
+			cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs));
+
 	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->vring.used->idx) - vq->last_used_idx) > bufs)) {
 		END_USE(vq);
 		return false;
-- 
MST
