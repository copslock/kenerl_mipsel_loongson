Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2015 20:16:22 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:55960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014588AbbLaTKNNaDsk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Dec 2015 20:10:13 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (Postfix) with ESMTPS id 0D76268E1A;
        Thu, 31 Dec 2015 19:10:09 +0000 (UTC)
Received: from redhat.com (vpn1-7-165.ams2.redhat.com [10.36.7.165])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBVJA16p030278;
        Thu, 31 Dec 2015 14:10:02 -0500
Date:   Thu, 31 Dec 2015 21:10:01 +0200
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
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH v2 33/34] xenbus: use virt_xxx barriers
Message-ID: <1451572003-2440-34-git-send-email-mst@redhat.com>
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
X-archive-position: 50807
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

drivers/xen/xenbus/xenbus_comms.c uses
full memory barriers to communicate with the other side.

For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
would be sufficient, so mb() and wmb() here are only needed if
a non-SMP guest runs on an SMP host.

Switch to virt_xxx barriers which serve this exact purpose.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/xen/xenbus/xenbus_comms.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index fdb0f33..ecdecce 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -123,14 +123,14 @@ int xb_write(const void *data, unsigned len)
 			avail = len;
 
 		/* Must write data /after/ reading the consumer index. */
-		mb();
+		virt_mb();
 
 		memcpy(dst, data, avail);
 		data += avail;
 		len -= avail;
 
 		/* Other side must not see new producer until data is there. */
-		wmb();
+		virt_wmb();
 		intf->req_prod += avail;
 
 		/* Implies mb(): other side will see the updated producer. */
@@ -180,14 +180,14 @@ int xb_read(void *data, unsigned len)
 			avail = len;
 
 		/* Must read data /after/ reading the producer index. */
-		rmb();
+		virt_rmb();
 
 		memcpy(data, src, avail);
 		data += avail;
 		len -= avail;
 
 		/* Other side must not see free space until we've copied out */
-		mb();
+		virt_mb();
 		intf->rsp_cons += avail;
 
 		pr_debug("Finished read of %i bytes (%i to go)\n", avail, len);
-- 
MST
