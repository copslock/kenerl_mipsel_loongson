Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2015 20:06:47 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:48964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009363AbbLaTGRZCHCk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Dec 2015 20:06:17 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id 46A79C0B7E04;
        Thu, 31 Dec 2015 19:06:13 +0000 (UTC)
Received: from redhat.com (vpn1-7-165.ams2.redhat.com [10.36.7.165])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBVJ659Q003704;
        Thu, 31 Dec 2015 14:06:06 -0500
Date:   Thu, 31 Dec 2015 21:06:05 +0200
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
        xen-devel@lists.xenproject.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH v2 03/32] ia64: rename nop->iosapic_nop
Message-ID: <1451572003-2440-4-git-send-email-mst@redhat.com>
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
X-archive-position: 50777
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

asm-generic/barrier.h defines a nop() macro.
To be able to use this header on ia64, we shouldn't
call local functions/variables nop().

There's one instance where this breaks on ia64:
rename the function to iosapic_nop to avoid the conflict.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Tony Luck <tony.luck@intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/kernel/iosapic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
index d2fae05..90fde5b 100644
--- a/arch/ia64/kernel/iosapic.c
+++ b/arch/ia64/kernel/iosapic.c
@@ -256,7 +256,7 @@ set_rte (unsigned int gsi, unsigned int irq, unsigned int dest, int mask)
 }
 
 static void
-nop (struct irq_data *data)
+iosapic_nop (struct irq_data *data)
 {
 	/* do nothing... */
 }
@@ -415,7 +415,7 @@ iosapic_unmask_level_irq (struct irq_data *data)
 #define iosapic_shutdown_level_irq	mask_irq
 #define iosapic_enable_level_irq	unmask_irq
 #define iosapic_disable_level_irq	mask_irq
-#define iosapic_ack_level_irq		nop
+#define iosapic_ack_level_irq		iosapic_nop
 
 static struct irq_chip irq_type_iosapic_level = {
 	.name =			"IO-SAPIC-level",
@@ -453,7 +453,7 @@ iosapic_ack_edge_irq (struct irq_data *data)
 }
 
 #define iosapic_enable_edge_irq		unmask_irq
-#define iosapic_disable_edge_irq	nop
+#define iosapic_disable_edge_irq	iosapic_nop
 
 static struct irq_chip irq_type_iosapic_edge = {
 	.name =			"IO-SAPIC-edge",
-- 
MST
