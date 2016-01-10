Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 15:30:15 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:39004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008951AbcAJOWLd0hQ8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Jan 2016 15:22:11 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (Postfix) with ESMTPS id 42BA4C0BF2A7;
        Sun, 10 Jan 2016 14:22:05 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0AELumM032025;
        Sun, 10 Jan 2016 09:21:57 -0500
Date:   Sun, 10 Jan 2016 16:21:56 +0200
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
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien.grall@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Stefano Stabellini <stefano.stabellini@citrix.com>,
        Wei Liu <wei.liu2@citrix.com>
Subject: [PATCH v3 39/41] xen/events: use virt_xxx barriers
Message-ID: <1452426622-4471-40-git-send-email-mst@redhat.com>
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
X-archive-position: 51036
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

drivers/xen/events/events_fifo.c uses rmb() to communicate with the
other side.

For guests compiled with CONFIG_SMP, smp_rmb would be sufficient, so
rmb() here is only needed if a non-SMP guest runs on an SMP host.

Switch to the virt_rmb barrier which serves this exact purpose.

Pull in asm/barrier.h here to make sure the file is self-contained.

Suggested-by: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/xen/events/events_fifo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index 96a1b8d..eff2b88 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -41,6 +41,7 @@
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 
+#include <asm/barrier.h>
 #include <asm/sync_bitops.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/hypervisor.h>
@@ -296,7 +297,7 @@ static void consume_one_event(unsigned cpu,
 	 * control block.
 	 */
 	if (head == 0) {
-		rmb(); /* Ensure word is up-to-date before reading head. */
+		virt_rmb(); /* Ensure word is up-to-date before reading head. */
 		head = control_block->head[priority];
 	}
 
-- 
MST
