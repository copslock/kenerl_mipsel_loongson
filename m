Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 15:29:56 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:38953 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010522AbcAJOWALkEd8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Jan 2016 15:22:00 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id EE24CC0BF2A2;
        Sun, 10 Jan 2016 14:21:55 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0AELmnM002780;
        Sun, 10 Jan 2016 09:21:48 -0500
Date:   Sun, 10 Jan 2016 16:21:47 +0200
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
        David Vrabel <david.vrabel@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v3 38/41] xen/io: use virt_xxx barriers
Message-ID: <1452426622-4471-39-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51035
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

include/xen/interface/io/ring.h uses
full memory barriers to communicate with the other side.

For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
would be sufficient, so mb() and wmb() here are only needed if
a non-SMP guest runs on an SMP host.

Switch to virt_xxx barriers which serve this exact purpose.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Vrabel <david.vrabel@citrix.com>
---
 include/xen/interface/io/ring.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
index 7dc685b..21f4fbd 100644
--- a/include/xen/interface/io/ring.h
+++ b/include/xen/interface/io/ring.h
@@ -208,12 +208,12 @@ struct __name##_back_ring {						\
 
 
 #define RING_PUSH_REQUESTS(_r) do {					\
-    wmb(); /* back sees requests /before/ updated producer index */	\
+    virt_wmb(); /* back sees requests /before/ updated producer index */	\
     (_r)->sring->req_prod = (_r)->req_prod_pvt;				\
 } while (0)
 
 #define RING_PUSH_RESPONSES(_r) do {					\
-    wmb(); /* front sees responses /before/ updated producer index */	\
+    virt_wmb(); /* front sees responses /before/ updated producer index */	\
     (_r)->sring->rsp_prod = (_r)->rsp_prod_pvt;				\
 } while (0)
 
@@ -250,9 +250,9 @@ struct __name##_back_ring {						\
 #define RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(_r, _notify) do {		\
     RING_IDX __old = (_r)->sring->req_prod;				\
     RING_IDX __new = (_r)->req_prod_pvt;				\
-    wmb(); /* back sees requests /before/ updated producer index */	\
+    virt_wmb(); /* back sees requests /before/ updated producer index */	\
     (_r)->sring->req_prod = __new;					\
-    mb(); /* back sees new requests /before/ we check req_event */	\
+    virt_mb(); /* back sees new requests /before/ we check req_event */	\
     (_notify) = ((RING_IDX)(__new - (_r)->sring->req_event) <		\
 		 (RING_IDX)(__new - __old));				\
 } while (0)
@@ -260,9 +260,9 @@ struct __name##_back_ring {						\
 #define RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(_r, _notify) do {		\
     RING_IDX __old = (_r)->sring->rsp_prod;				\
     RING_IDX __new = (_r)->rsp_prod_pvt;				\
-    wmb(); /* front sees responses /before/ updated producer index */	\
+    virt_wmb(); /* front sees responses /before/ updated producer index */	\
     (_r)->sring->rsp_prod = __new;					\
-    mb(); /* front sees new responses /before/ we check rsp_event */	\
+    virt_mb(); /* front sees new responses /before/ we check rsp_event */	\
     (_notify) = ((RING_IDX)(__new - (_r)->sring->rsp_event) <		\
 		 (RING_IDX)(__new - __old));				\
 } while (0)
@@ -271,7 +271,7 @@ struct __name##_back_ring {						\
     (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
     if (_work_to_do) break;						\
     (_r)->sring->req_event = (_r)->req_cons + 1;			\
-    mb();								\
+    virt_mb();								\
     (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
 } while (0)
 
@@ -279,7 +279,7 @@ struct __name##_back_ring {						\
     (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
     if (_work_to_do) break;						\
     (_r)->sring->rsp_event = (_r)->rsp_cons + 1;			\
-    mb();								\
+    virt_mb();								\
     (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
 } while (0)
 
-- 
MST
